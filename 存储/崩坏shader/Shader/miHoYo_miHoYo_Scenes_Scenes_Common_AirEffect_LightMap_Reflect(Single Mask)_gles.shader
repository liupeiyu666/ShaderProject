//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/AirEffect_LightMap_Reflect(Single Mask)" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_EmissionColor ("Emission Color", Color) = (1,1,1,1)
_Emission ("Emission", Range(1, 100)) = 1
_EmissionFactor ("Emission Factor", Range(0, 1)) = 0
_LightMapIntensity ("Light Map Intensity", Float) = 1
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
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 54642
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
uniform highp vec4 _Color;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _ShadowTex;
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
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float reflectMask_3;
  mediump vec3 emissionColor_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_5.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_10;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_12.xyz * reflectMask_3) * _Reflectivity));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex_C_Color_5.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_14;
    tmpvar_14 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_13 * ((tmpvar_14 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.xyz = mix (outColor_6.xyz, emissionColor_4, vec3(_EmissionFactor));
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
uniform highp vec4 _Color;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _ShadowTex;
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
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float reflectMask_3;
  mediump vec3 emissionColor_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_5.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_10;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_12.xyz * reflectMask_3) * _Reflectivity));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex_C_Color_5.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_14;
    tmpvar_14 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_13 * ((tmpvar_14 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.xyz = mix (outColor_6.xyz, emissionColor_4, vec3(_EmissionFactor));
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
uniform highp vec4 _Color;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _ShadowTex;
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
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float reflectMask_3;
  mediump vec3 emissionColor_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_5.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_10;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_12.xyz * reflectMask_3) * _Reflectivity));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex_C_Color_5.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_14;
    tmpvar_14 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_13 * ((tmpvar_14 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.xyz = mix (outColor_6.xyz, emissionColor_4, vec3(_EmissionFactor));
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
uniform highp vec4 _Color;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _ShadowTex;
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
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float reflectMask_3;
  mediump vec3 emissionColor_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_5.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_10;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_12.xyz * reflectMask_3) * _Reflectivity));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex_C_Color_5.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_14;
    tmpvar_14 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_13 * ((tmpvar_14 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.xyz = mix (outColor_6.xyz, emissionColor_4, vec3(_EmissionFactor));
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
uniform highp vec4 _Color;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _ShadowTex;
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
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float reflectMask_3;
  mediump vec3 emissionColor_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_5.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_10;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_12.xyz * reflectMask_3) * _Reflectivity));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex_C_Color_5.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_14;
    tmpvar_14 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_13 * ((tmpvar_14 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.xyz = mix (outColor_6.xyz, emissionColor_4, vec3(_EmissionFactor));
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
uniform highp vec4 _Color;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _ShadowTex;
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
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float reflectMask_3;
  mediump vec3 emissionColor_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_5.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_10;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_12.xyz * reflectMask_3) * _Reflectivity));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex_C_Color_5.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_14;
    tmpvar_14 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_13 * ((tmpvar_14 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.xyz = mix (outColor_6.xyz, emissionColor_4, vec3(_EmissionFactor));
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
uniform highp vec4 _Color;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _ShadowTex;
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
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float reflectMask_3;
  mediump vec3 emissionColor_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_5.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_10;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_12.xyz * reflectMask_3) * _Reflectivity));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex_C_Color_5.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_14;
    tmpvar_14 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_13 * ((tmpvar_14 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_15;
    xlat_varinput_15 = xlv_TEXCOORD4;
    mediump vec3 fogParam_16;
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_17))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_19;
    tmpvar_19 = clamp ((_UWFogColorHLIntensity * tmpvar_17), 0.0, 1.0);
    fogParam_16.z = 0.0;
    fogParam_16.y = tmpvar_18;
    fogParam_16.x = tmpvar_19;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_15.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_17 * _UWHeightRatio)));
      highp float tmpvar_20;
      tmpvar_20 = clamp (xlat_varinput_15.y, _UWCriticalRange, 1.0);
      xlat_varinput_15.y = tmpvar_20;
    };
    fogParam_16.z = (1.0 - xlat_varinput_15.y);
    mediump vec4 tmpvar_21;
    tmpvar_21.w = 0.0;
    tmpvar_21.xyz = outColor_6.xyz;
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_21, fogParam_16.zzzz).xyz;
    outColor_6.xyz = tmpvar_22;
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_16.xxxx), tmpvar_23, fogParam_16.yyyy).xyz;
    outColor_6.xyz = tmpvar_24;
  };
  outColor_6.xyz = mix (outColor_6.xyz, emissionColor_4, vec3(_EmissionFactor));
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
uniform highp vec4 _Color;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _ShadowTex;
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
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float reflectMask_3;
  mediump vec3 emissionColor_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_5.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_10;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_12.xyz * reflectMask_3) * _Reflectivity));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex_C_Color_5.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_14;
    tmpvar_14 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_13 * ((tmpvar_14 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_15;
    xlat_varinput_15 = xlv_TEXCOORD4;
    mediump vec3 fogParam_16;
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_17))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_19;
    tmpvar_19 = clamp ((_UWFogColorHLIntensity * tmpvar_17), 0.0, 1.0);
    fogParam_16.z = 0.0;
    fogParam_16.y = tmpvar_18;
    fogParam_16.x = tmpvar_19;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_15.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_17 * _UWHeightRatio)));
      highp float tmpvar_20;
      tmpvar_20 = clamp (xlat_varinput_15.y, _UWCriticalRange, 1.0);
      xlat_varinput_15.y = tmpvar_20;
    };
    fogParam_16.z = (1.0 - xlat_varinput_15.y);
    mediump vec4 tmpvar_21;
    tmpvar_21.w = 0.0;
    tmpvar_21.xyz = outColor_6.xyz;
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_21, fogParam_16.zzzz).xyz;
    outColor_6.xyz = tmpvar_22;
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_16.xxxx), tmpvar_23, fogParam_16.yyyy).xyz;
    outColor_6.xyz = tmpvar_24;
  };
  outColor_6.xyz = mix (outColor_6.xyz, emissionColor_4, vec3(_EmissionFactor));
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
uniform highp vec4 _Color;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _ShadowTex;
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
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float reflectMask_3;
  mediump vec3 emissionColor_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_5.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_10;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_12.xyz * reflectMask_3) * _Reflectivity));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex_C_Color_5.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_14;
    tmpvar_14 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_13 * ((tmpvar_14 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_15;
    xlat_varinput_15 = xlv_TEXCOORD4;
    mediump vec3 fogParam_16;
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_17))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_19;
    tmpvar_19 = clamp ((_UWFogColorHLIntensity * tmpvar_17), 0.0, 1.0);
    fogParam_16.z = 0.0;
    fogParam_16.y = tmpvar_18;
    fogParam_16.x = tmpvar_19;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_15.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_17 * _UWHeightRatio)));
      highp float tmpvar_20;
      tmpvar_20 = clamp (xlat_varinput_15.y, _UWCriticalRange, 1.0);
      xlat_varinput_15.y = tmpvar_20;
    };
    fogParam_16.z = (1.0 - xlat_varinput_15.y);
    mediump vec4 tmpvar_21;
    tmpvar_21.w = 0.0;
    tmpvar_21.xyz = outColor_6.xyz;
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_21, fogParam_16.zzzz).xyz;
    outColor_6.xyz = tmpvar_22;
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_16.xxxx), tmpvar_23, fogParam_16.yyyy).xyz;
    outColor_6.xyz = tmpvar_24;
  };
  outColor_6.xyz = mix (outColor_6.xyz, emissionColor_4, vec3(_EmissionFactor));
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
uniform highp vec4 _Color;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _ShadowTex;
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
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float reflectMask_3;
  mediump vec3 emissionColor_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_5.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_10;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_12.xyz * reflectMask_3) * _Reflectivity));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex_C_Color_5.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_14;
    tmpvar_14 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_13 * ((tmpvar_14 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_15;
    xlat_varinput_15 = xlv_TEXCOORD4;
    mediump vec3 fogParam_16;
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_17))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_19;
    tmpvar_19 = clamp ((_UWFogColorHLIntensity * tmpvar_17), 0.0, 1.0);
    fogParam_16.z = 0.0;
    fogParam_16.y = tmpvar_18;
    fogParam_16.x = tmpvar_19;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_15.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_17 * _UWHeightRatio)));
      highp float tmpvar_20;
      tmpvar_20 = clamp (xlat_varinput_15.y, _UWCriticalRange, 1.0);
      xlat_varinput_15.y = tmpvar_20;
    };
    fogParam_16.z = (1.0 - xlat_varinput_15.y);
    mediump vec4 tmpvar_21;
    tmpvar_21.w = 0.0;
    tmpvar_21.xyz = outColor_6.xyz;
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_21, fogParam_16.zzzz).xyz;
    outColor_6.xyz = tmpvar_22;
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_16.xxxx), tmpvar_23, fogParam_16.yyyy).xyz;
    outColor_6.xyz = tmpvar_24;
  };
  outColor_6.xyz = mix (outColor_6.xyz, emissionColor_4, vec3(_EmissionFactor));
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
uniform highp vec4 _Color;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _ShadowTex;
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
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float reflectMask_3;
  mediump vec3 emissionColor_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_5.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_10;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_12.xyz * reflectMask_3) * _Reflectivity));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex_C_Color_5.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_14;
    tmpvar_14 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_13 * ((tmpvar_14 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_15;
    xlat_varinput_15 = xlv_TEXCOORD4;
    mediump vec3 fogParam_16;
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_17))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_19;
    tmpvar_19 = clamp ((_UWFogColorHLIntensity * tmpvar_17), 0.0, 1.0);
    fogParam_16.z = 0.0;
    fogParam_16.y = tmpvar_18;
    fogParam_16.x = tmpvar_19;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_15.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_17 * _UWHeightRatio)));
      highp float tmpvar_20;
      tmpvar_20 = clamp (xlat_varinput_15.y, _UWCriticalRange, 1.0);
      xlat_varinput_15.y = tmpvar_20;
    };
    fogParam_16.z = (1.0 - xlat_varinput_15.y);
    mediump vec4 tmpvar_21;
    tmpvar_21.w = 0.0;
    tmpvar_21.xyz = outColor_6.xyz;
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_21, fogParam_16.zzzz).xyz;
    outColor_6.xyz = tmpvar_22;
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_16.xxxx), tmpvar_23, fogParam_16.yyyy).xyz;
    outColor_6.xyz = tmpvar_24;
  };
  outColor_6.xyz = mix (outColor_6.xyz, emissionColor_4, vec3(_EmissionFactor));
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = _BloomFactor;
  gl_FragData[0] = outColor_6;
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
uniform highp vec4 _Color;
uniform highp vec4 _EmissionColor;
uniform mediump float _Emission;
uniform mediump float _EmissionFactor;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _ShadowTex;
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
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float reflectMask_3;
  mediump vec3 emissionColor_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = ((tex_C_Color_5.xyz * _Emission) * _EmissionColor.xyz);
  emissionColor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_10;
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz * _Color.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_EnvTex, tmpvar_11);
  tex_C_Color_5.xyz = (tex_C_Color_5.xyz + ((tmpvar_12.xyz * reflectMask_3) * _Reflectivity));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex_C_Color_5.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_13;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_14;
    tmpvar_14 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_13 * ((tmpvar_14 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD4.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_15;
    xlat_varinput_15 = xlv_TEXCOORD4;
    mediump vec3 fogParam_16;
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_17))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_19;
    tmpvar_19 = clamp ((_UWFogColorHLIntensity * tmpvar_17), 0.0, 1.0);
    fogParam_16.z = 0.0;
    fogParam_16.y = tmpvar_18;
    fogParam_16.x = tmpvar_19;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_15.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_17 * _UWHeightRatio)));
      highp float tmpvar_20;
      tmpvar_20 = clamp (xlat_varinput_15.y, _UWCriticalRange, 1.0);
      xlat_varinput_15.y = tmpvar_20;
    };
    fogParam_16.z = (1.0 - xlat_varinput_15.y);
    mediump vec4 tmpvar_21;
    tmpvar_21.w = 0.0;
    tmpvar_21.xyz = outColor_6.xyz;
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_21, fogParam_16.zzzz).xyz;
    outColor_6.xyz = tmpvar_22;
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_16.xxxx), tmpvar_23, fogParam_16.yyyy).xyz;
    outColor_6.xyz = tmpvar_24;
  };
  outColor_6.xyz = mix (outColor_6.xyz, emissionColor_4, vec3(_EmissionFactor));
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
}
Fallback "Diffuse"
}