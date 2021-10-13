//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_AirEffect_Reflect(Single Mask)_LightMap" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_EmissionColor ("Emission Color", Color) = (1,1,1,1)
_Emission ("Emission", Range(1, 100)) = 1
_EmissionFactor ("Emission Factor", Range(0, 1)) = 0
_LightMapIntensity ("Light Map Intensity", Float) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ReflectMaskTex ("Reflect Mask Tex(R)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
_CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
[Toggle(INT_PING_PONG)] _LigthMapIntPingPong ("Light Map Intensity Ping Pong", Float) = 0
_Magnitude ("Magnitude Of Ping Pong", Range(0, 5)) = 3
_MinValue ("Min Value Of Ping Pong", Range(0, 2)) = 0.5
_Speed ("Speed Of Ping Pong", Range(0, 3)) = 0.5
[Toggle(HIGH_FOG)] _HighFog ("HighFog", Float) = 0
_HighFogColor ("HighFogColor", Color) = (1,1,1,1)
_FogHighStartDistance ("FogHighStartDistance", Float) = 8.5
_FogHighIntensity ("FogHighIntensity", Float) = 0.03
_FogHighEffectLimit ("FogHighEffectLimit", Float) = 0.7
[Toggle(LUMINANCE)] _Luminance ("Luminance", Float) = 0
_LumiFactor ("Luminance Factor", Float) = 0
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "gray" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (1,1,0,0)
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 62786
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD4;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_7.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_7.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_7.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_7.xyz = tmpvar_26;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD4;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_7.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_7.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_7.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_7.xyz = tmpvar_26;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD4;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_7.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_7.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_7.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_7.xyz = tmpvar_26;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD4;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_7.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_7.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_7.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_7.xyz = tmpvar_26;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD4;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_7.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_7.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_7.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_7.xyz = tmpvar_26;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD4;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_7.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_7.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_7.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_7.xyz = tmpvar_26;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD4;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_7.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_7.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_7.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_7.xyz = tmpvar_26;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD4;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_7.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_7.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_7.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_7.xyz = tmpvar_26;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD4;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_7.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_7.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_7.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_7.xyz = tmpvar_26;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD4;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_7.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_7.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_7.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_7.xyz = tmpvar_26;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD4;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_7.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_7.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_7.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_7.xyz = tmpvar_26;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
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
uniform sampler2D _MainTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_13.w;
  lowp vec4 color_14;
  color_14 = tmpvar_13;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_14.xyz);
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD4;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_7.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_7.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_7.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_7.xyz = tmpvar_26;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
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
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.xyz = mix (outColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD4;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_7.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_7.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_7.xyz = tmpvar_25;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD4;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_7.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_7.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_7.xyz = tmpvar_25;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD4;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_7.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_7.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_7.xyz = tmpvar_25;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD4;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_7.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_7.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_7.xyz = tmpvar_25;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD4;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_7.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_7.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_7.xyz = tmpvar_25;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD4;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_7.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_7.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_7.xyz = tmpvar_25;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD4;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_7.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_7.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_7.xyz = tmpvar_25;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD4;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_7.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_7.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_7.xyz = tmpvar_25;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD4;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_7.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_7.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_7.xyz = tmpvar_25;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD4;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_7.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_7.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_7.xyz = tmpvar_25;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD4;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_7.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_7.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_7.xyz = tmpvar_25;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
uniform mediump vec4 _ShadowTex_ST;
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
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _ReflectMaskTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LumiFactor;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float reflectMask_4;
  mediump vec3 emissionColor_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tex_C_Color_6.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_10;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_12.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((tex_C_Color_6.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_15;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD4;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_7.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_7.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_7.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_7.xyz = tmpvar_25;
  };
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
  outColor_7.xyz = mix (outColor_7.xyz, vec3(dot (outColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_7.w = _BloomFactor;
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