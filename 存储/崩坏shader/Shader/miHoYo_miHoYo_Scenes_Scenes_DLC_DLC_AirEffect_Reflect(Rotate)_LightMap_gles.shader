//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_AirEffect_Reflect(Rotate)_LightMap" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
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
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 58296
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
varying highp vec2 xlv_TEXCOORD0;
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
  highp vec2 tmpvar_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_8;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_10.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_11;
  tmpvar_11 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_11.w;
  lowp vec4 color_12;
  color_12 = tmpvar_11;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_14;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  mediump vec3 srcColor_15;
  srcColor_15 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_15, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  highp vec2 tmpvar_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_8;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_10.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_11;
  tmpvar_11 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_11.w;
  lowp vec4 color_12;
  color_12 = tmpvar_11;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_14;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  mediump vec3 srcColor_15;
  srcColor_15 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_15, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  highp vec2 tmpvar_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_8;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_10.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_11;
  tmpvar_11 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_11.w;
  lowp vec4 color_12;
  color_12 = tmpvar_11;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_14;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  mediump vec3 srcColor_15;
  srcColor_15 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_15, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  highp vec2 tmpvar_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_8;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_10.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_11;
  tmpvar_11 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_11.w;
  lowp vec4 color_12;
  color_12 = tmpvar_11;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_14;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  mediump vec3 srcColor_15;
  srcColor_15 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_15, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  highp vec2 tmpvar_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_8;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_10.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_11;
  tmpvar_11 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_11.w;
  lowp vec4 color_12;
  color_12 = tmpvar_11;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_14;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  mediump vec3 srcColor_15;
  srcColor_15 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_15, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  highp vec2 tmpvar_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_8;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_10.xyz * reflectMask_4) * _Reflectivity));
  mediump vec4 tmpvar_11;
  tmpvar_11 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_11.w;
  lowp vec4 color_12;
  color_12 = tmpvar_11;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_12.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_14;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  mediump vec3 srcColor_15;
  srcColor_15 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_15, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  highp vec2 tmpvar_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_8;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_10.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  mediump vec3 srcColor_14;
  srcColor_14 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_14, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  highp vec2 tmpvar_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_8;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_10.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  mediump vec3 srcColor_14;
  srcColor_14 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_14, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  highp vec2 tmpvar_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_8;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_10.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  mediump vec3 srcColor_14;
  srcColor_14 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_14, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  highp vec2 tmpvar_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_8;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_10.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  mediump vec3 srcColor_14;
  srcColor_14 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_14, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  highp vec2 tmpvar_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_8;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_10.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  mediump vec3 srcColor_14;
  srcColor_14 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_14, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  highp vec2 tmpvar_6;
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_4 = tmpvar_8;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_10;
  tmpvar_10 = textureCube (_EnvTex, tmpvar_9);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_10.xyz * reflectMask_4) * _Reflectivity));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * ((
      abs((fract((_Time.y * _Speed)) - 0.5))
     * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  mediump vec3 srcColor_14;
  srcColor_14 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_14, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
}
Fallback "Diffuse"
}