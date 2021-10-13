//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/AirEffect_LightMap_Reflect(Second Mask)" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_EmissionColor ("Emission Color", Color) = (1,1,1,1)
_Emission ("Emission", Range(1, 100)) = 1
_EmissionFactor ("Emission Factor", Range(0, 1)) = 0
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ReflectMaskTex ("Reflect Mask Tex(R)", 2D) = "white" { }
_SecondReflectMask ("Second Reflect Mask", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
_SecondReflectPower ("Second Reflect Power", Float) = 1
_SecondReflectIntensity ("Second Reflect Intensity", Float) = 1
_SecondReflectFactor ("Reflect Lerp Factor", Range(0, 1)) = 0
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
  GpuProgramID 6960
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD4;
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
  mediump vec2 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_12.xz - ((tmpvar_12.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = cos(_CamRotate);
  cost_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = sin(_CamRotate);
  sint_2 = tmpvar_15;
  highp mat2 tmpvar_16;
  tmpvar_16[0].x = cost_3;
  tmpvar_16[0].y = -(sint_2);
  tmpvar_16[1].x = sint_2;
  tmpvar_16[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_16 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_10 = _glesMultiTexCoord2.xy;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_COLOR1 = tmpvar_17;
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
uniform sampler2D _SecondReflectMask;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float SecondReflectMask_3;
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
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_SecondReflectMask, xlv_TEXCOORD4).x;
  SecondReflectMask_3 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_12;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  SecondReflectMask_3 = (_SecondReflectIntensity * pow (SecondReflectMask_3, _SecondReflectPower));
  mediump float tmpvar_14;
  tmpvar_14 = mix (reflectMask_4, SecondReflectMask_3, _SecondReflectFactor);
  reflectMask_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = textureCube (_EnvTex, tmpvar_13);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_15.xyz * tmpvar_14) * _Reflectivity));
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tex_C_Color_6.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_17;
    tmpvar_17 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_16 * ((tmpvar_17 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD4;
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
  mediump vec2 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_12.xz - ((tmpvar_12.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = cos(_CamRotate);
  cost_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = sin(_CamRotate);
  sint_2 = tmpvar_15;
  highp mat2 tmpvar_16;
  tmpvar_16[0].x = cost_3;
  tmpvar_16[0].y = -(sint_2);
  tmpvar_16[1].x = sint_2;
  tmpvar_16[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_16 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_10 = _glesMultiTexCoord2.xy;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_COLOR1 = tmpvar_17;
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
uniform sampler2D _SecondReflectMask;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float SecondReflectMask_3;
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
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_SecondReflectMask, xlv_TEXCOORD4).x;
  SecondReflectMask_3 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_12;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  SecondReflectMask_3 = (_SecondReflectIntensity * pow (SecondReflectMask_3, _SecondReflectPower));
  mediump float tmpvar_14;
  tmpvar_14 = mix (reflectMask_4, SecondReflectMask_3, _SecondReflectFactor);
  reflectMask_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = textureCube (_EnvTex, tmpvar_13);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_15.xyz * tmpvar_14) * _Reflectivity));
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tex_C_Color_6.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_17;
    tmpvar_17 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_16 * ((tmpvar_17 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD4;
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
  mediump vec2 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_12.xz - ((tmpvar_12.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = cos(_CamRotate);
  cost_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = sin(_CamRotate);
  sint_2 = tmpvar_15;
  highp mat2 tmpvar_16;
  tmpvar_16[0].x = cost_3;
  tmpvar_16[0].y = -(sint_2);
  tmpvar_16[1].x = sint_2;
  tmpvar_16[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_16 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_10 = _glesMultiTexCoord2.xy;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_COLOR1 = tmpvar_17;
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
uniform sampler2D _SecondReflectMask;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float SecondReflectMask_3;
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
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_SecondReflectMask, xlv_TEXCOORD4).x;
  SecondReflectMask_3 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_12;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  SecondReflectMask_3 = (_SecondReflectIntensity * pow (SecondReflectMask_3, _SecondReflectPower));
  mediump float tmpvar_14;
  tmpvar_14 = mix (reflectMask_4, SecondReflectMask_3, _SecondReflectFactor);
  reflectMask_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = textureCube (_EnvTex, tmpvar_13);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_15.xyz * tmpvar_14) * _Reflectivity));
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tex_C_Color_6.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_17;
    tmpvar_17 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_16 * ((tmpvar_17 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD4;
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
  mediump vec2 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_12.xz - ((tmpvar_12.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = cos(_CamRotate);
  cost_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = sin(_CamRotate);
  sint_2 = tmpvar_15;
  highp mat2 tmpvar_16;
  tmpvar_16[0].x = cost_3;
  tmpvar_16[0].y = -(sint_2);
  tmpvar_16[1].x = sint_2;
  tmpvar_16[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_16 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_10 = _glesMultiTexCoord2.xy;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_COLOR1 = tmpvar_17;
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
uniform sampler2D _SecondReflectMask;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float SecondReflectMask_3;
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
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_SecondReflectMask, xlv_TEXCOORD4).x;
  SecondReflectMask_3 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_12;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  SecondReflectMask_3 = (_SecondReflectIntensity * pow (SecondReflectMask_3, _SecondReflectPower));
  mediump float tmpvar_14;
  tmpvar_14 = mix (reflectMask_4, SecondReflectMask_3, _SecondReflectFactor);
  reflectMask_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = textureCube (_EnvTex, tmpvar_13);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_15.xyz * tmpvar_14) * _Reflectivity));
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tex_C_Color_6.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_17;
    tmpvar_17 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_16 * ((tmpvar_17 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD4;
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
  mediump vec2 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_12.xz - ((tmpvar_12.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = cos(_CamRotate);
  cost_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = sin(_CamRotate);
  sint_2 = tmpvar_15;
  highp mat2 tmpvar_16;
  tmpvar_16[0].x = cost_3;
  tmpvar_16[0].y = -(sint_2);
  tmpvar_16[1].x = sint_2;
  tmpvar_16[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_16 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_10 = _glesMultiTexCoord2.xy;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_COLOR1 = tmpvar_17;
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
uniform sampler2D _SecondReflectMask;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float SecondReflectMask_3;
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
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_SecondReflectMask, xlv_TEXCOORD4).x;
  SecondReflectMask_3 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_12;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  SecondReflectMask_3 = (_SecondReflectIntensity * pow (SecondReflectMask_3, _SecondReflectPower));
  mediump float tmpvar_14;
  tmpvar_14 = mix (reflectMask_4, SecondReflectMask_3, _SecondReflectFactor);
  reflectMask_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = textureCube (_EnvTex, tmpvar_13);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_15.xyz * tmpvar_14) * _Reflectivity));
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tex_C_Color_6.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_17;
    tmpvar_17 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_16 * ((tmpvar_17 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD4;
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
  mediump vec2 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_8 = tmpvar_1;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_4.xz = (tmpvar_12.xz - ((tmpvar_12.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12.xyz - adjCamPos_4));
  tmpvar_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = cos(_CamRotate);
  cost_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = sin(_CamRotate);
  sint_2 = tmpvar_15;
  highp mat2 tmpvar_16;
  tmpvar_16[0].x = cost_3;
  tmpvar_16[0].y = -(sint_2);
  tmpvar_16[1].x = sint_2;
  tmpvar_16[1].y = cost_3;
  tmpvar_9.xz = (tmpvar_16 * tmpvar_9.xz);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_10 = _glesMultiTexCoord2.xy;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_COLOR1 = tmpvar_17;
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
uniform sampler2D _SecondReflectMask;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform mediump float _Magnitude;
uniform mediump float _MinValue;
uniform mediump float _Speed;
uniform mediump float _LigthMapIntPingPong;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float SecondReflectMask_3;
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
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_SecondReflectMask, xlv_TEXCOORD4).x;
  SecondReflectMask_3 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_12;
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz * _Color.xyz);
  mediump vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  SecondReflectMask_3 = (_SecondReflectIntensity * pow (SecondReflectMask_3, _SecondReflectPower));
  mediump float tmpvar_14;
  tmpvar_14 = mix (reflectMask_4, SecondReflectMask_3, _SecondReflectFactor);
  reflectMask_4 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = textureCube (_EnvTex, tmpvar_13);
  tex_C_Color_6.xyz = (tex_C_Color_6.xyz + ((tmpvar_15.xyz * tmpvar_14) * _Reflectivity));
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tex_C_Color_6.xyz * ((
    ((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w)
   + 1.0) - tex_S_Color_2.w));
  colorBlendLightMap_1 = tmpvar_16;
  if ((_LigthMapIntPingPong > 0.0)) {
    highp float tmpvar_17;
    tmpvar_17 = abs((fract(
      (_Time.y * _Speed)
    ) - 0.5));
    colorBlendLightMap_1 = (tmpvar_16 * ((tmpvar_17 * _Magnitude) + _MinValue));
  } else {
    colorBlendLightMap_1 = (colorBlendLightMap_1 * _LightMapIntensity);
  };
  outColor_7.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_7.xyz = mix (outColor_7.xyz, emissionColor_5, vec3(_EmissionFactor));
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
}
Fallback "Diffuse"
}