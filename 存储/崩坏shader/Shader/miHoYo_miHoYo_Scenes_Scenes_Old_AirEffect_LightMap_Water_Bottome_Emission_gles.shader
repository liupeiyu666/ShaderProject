//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/AirEffect_LightMap_Water_Bottome_Emission" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_VerticalFogColor ("Vertical Fog Color", Color) = (1,1,1,1)
_VerticalFogEmissionScaler ("Vertical Fog Emission Scaler", Float) = 1
_VerticalFogNoise ("Vertical Fog Noise", 2D) = "grey" { }
_VerticalFogNoiseIntensity ("Vertical Fog Noise Intensity", Float) = 0
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 2831
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform mediump vec4 _VerticalFogColor;
uniform mediump float _VerticalFogEmissionScaler;
uniform mediump vec4 _VerticalFogNoise_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 posInWorld_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_11)
      ) * (_FogIntensity * tmpvar_11))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_18;
    tmpvar_18 = (_FogEndDistance - _FogStartDistance);
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_19;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  posInWorld_1 = tmpvar_20;
  posInWorld_1 = (posInWorld_1 / posInWorld_1.w);
  tmpvar_5 = ((_VerticalFogColor * _VerticalFogEmissionScaler) * 2.0);
  tmpvar_6 = ((posInWorld_1.xz * _VerticalFogNoise_ST.xy) + _VerticalFogNoise_ST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _VerticalFogNoise;
uniform mediump float _VerticalFogNoiseIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_VerticalFogNoise, xlv_TEXCOORD4);
  outColor_4.xyz = (outColor_4.xyz + (xlv_TEXCOORD3 * (
    ((tmpvar_7.x - 0.5) * _VerticalFogNoiseIntensity)
   + 0.5)).xyz);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform mediump vec4 _VerticalFogColor;
uniform mediump float _VerticalFogEmissionScaler;
uniform mediump vec4 _VerticalFogNoise_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 posInWorld_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_11)
      ) * (_FogIntensity * tmpvar_11))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_18;
    tmpvar_18 = (_FogEndDistance - _FogStartDistance);
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_19;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  posInWorld_1 = tmpvar_20;
  posInWorld_1 = (posInWorld_1 / posInWorld_1.w);
  tmpvar_5 = ((_VerticalFogColor * _VerticalFogEmissionScaler) * 2.0);
  tmpvar_6 = ((posInWorld_1.xz * _VerticalFogNoise_ST.xy) + _VerticalFogNoise_ST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _VerticalFogNoise;
uniform mediump float _VerticalFogNoiseIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_VerticalFogNoise, xlv_TEXCOORD4);
  outColor_4.xyz = (outColor_4.xyz + (xlv_TEXCOORD3 * (
    ((tmpvar_7.x - 0.5) * _VerticalFogNoiseIntensity)
   + 0.5)).xyz);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform mediump vec4 _VerticalFogColor;
uniform mediump float _VerticalFogEmissionScaler;
uniform mediump vec4 _VerticalFogNoise_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 posInWorld_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_11)
      ) * (_FogIntensity * tmpvar_11))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_18;
    tmpvar_18 = (_FogEndDistance - _FogStartDistance);
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_19;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  posInWorld_1 = tmpvar_20;
  posInWorld_1 = (posInWorld_1 / posInWorld_1.w);
  tmpvar_5 = ((_VerticalFogColor * _VerticalFogEmissionScaler) * 2.0);
  tmpvar_6 = ((posInWorld_1.xz * _VerticalFogNoise_ST.xy) + _VerticalFogNoise_ST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _VerticalFogNoise;
uniform mediump float _VerticalFogNoiseIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_VerticalFogNoise, xlv_TEXCOORD4);
  outColor_4.xyz = (outColor_4.xyz + (xlv_TEXCOORD3 * (
    ((tmpvar_7.x - 0.5) * _VerticalFogNoiseIntensity)
   + 0.5)).xyz);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform mediump vec4 _VerticalFogColor;
uniform mediump float _VerticalFogEmissionScaler;
uniform mediump vec4 _VerticalFogNoise_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 posInWorld_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_11)
      ) * (_FogIntensity * tmpvar_11))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_18;
    tmpvar_18 = (_FogEndDistance - _FogStartDistance);
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_19;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  posInWorld_1 = tmpvar_20;
  posInWorld_1 = (posInWorld_1 / posInWorld_1.w);
  tmpvar_5 = ((_VerticalFogColor * _VerticalFogEmissionScaler) * 2.0);
  tmpvar_6 = ((posInWorld_1.xz * _VerticalFogNoise_ST.xy) + _VerticalFogNoise_ST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _VerticalFogNoise;
uniform mediump float _VerticalFogNoiseIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_VerticalFogNoise, xlv_TEXCOORD4);
  outColor_4.xyz = (outColor_4.xyz + (xlv_TEXCOORD3 * (
    ((tmpvar_7.x - 0.5) * _VerticalFogNoiseIntensity)
   + 0.5)).xyz);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform mediump vec4 _VerticalFogColor;
uniform mediump float _VerticalFogEmissionScaler;
uniform mediump vec4 _VerticalFogNoise_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 posInWorld_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_11)
      ) * (_FogIntensity * tmpvar_11))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_18;
    tmpvar_18 = (_FogEndDistance - _FogStartDistance);
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_19;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  posInWorld_1 = tmpvar_20;
  posInWorld_1 = (posInWorld_1 / posInWorld_1.w);
  tmpvar_5 = ((_VerticalFogColor * _VerticalFogEmissionScaler) * 2.0);
  tmpvar_6 = ((posInWorld_1.xz * _VerticalFogNoise_ST.xy) + _VerticalFogNoise_ST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _VerticalFogNoise;
uniform mediump float _VerticalFogNoiseIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_VerticalFogNoise, xlv_TEXCOORD4);
  outColor_4.xyz = (outColor_4.xyz + (xlv_TEXCOORD3 * (
    ((tmpvar_7.x - 0.5) * _VerticalFogNoiseIntensity)
   + 0.5)).xyz);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform mediump vec4 _VerticalFogColor;
uniform mediump float _VerticalFogEmissionScaler;
uniform mediump vec4 _VerticalFogNoise_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 posInWorld_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_11)
      ) * (_FogIntensity * tmpvar_11))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_18;
    tmpvar_18 = (_FogEndDistance - _FogStartDistance);
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_19;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  posInWorld_1 = tmpvar_20;
  posInWorld_1 = (posInWorld_1 / posInWorld_1.w);
  tmpvar_5 = ((_VerticalFogColor * _VerticalFogEmissionScaler) * 2.0);
  tmpvar_6 = ((posInWorld_1.xz * _VerticalFogNoise_ST.xy) + _VerticalFogNoise_ST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _VerticalFogNoise;
uniform mediump float _VerticalFogNoiseIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_VerticalFogNoise, xlv_TEXCOORD4);
  outColor_4.xyz = (outColor_4.xyz + (xlv_TEXCOORD3 * (
    ((tmpvar_7.x - 0.5) * _VerticalFogNoiseIntensity)
   + 0.5)).xyz);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform mediump vec4 _VerticalFogColor;
uniform mediump float _VerticalFogEmissionScaler;
uniform mediump vec4 _VerticalFogNoise_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 posInWorld_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_11)
      ) * (_FogIntensity * tmpvar_11))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_18;
    tmpvar_18 = (_FogEndDistance - _FogStartDistance);
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_19;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  posInWorld_1 = tmpvar_20;
  posInWorld_1 = (posInWorld_1 / posInWorld_1.w);
  tmpvar_5 = ((_VerticalFogColor * _VerticalFogEmissionScaler) * 2.0);
  tmpvar_6 = ((posInWorld_1.xz * _VerticalFogNoise_ST.xy) + _VerticalFogNoise_ST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _VerticalFogNoise;
uniform mediump float _VerticalFogNoiseIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_VerticalFogNoise, xlv_TEXCOORD4);
  outColor_4.xyz = (outColor_4.xyz + (xlv_TEXCOORD3 * (
    ((tmpvar_7.x - 0.5) * _VerticalFogNoiseIntensity)
   + 0.5)).xyz);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform mediump vec4 _VerticalFogColor;
uniform mediump float _VerticalFogEmissionScaler;
uniform mediump vec4 _VerticalFogNoise_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 posInWorld_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_11)
      ) * (_FogIntensity * tmpvar_11))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_18;
    tmpvar_18 = (_FogEndDistance - _FogStartDistance);
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_19;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  posInWorld_1 = tmpvar_20;
  posInWorld_1 = (posInWorld_1 / posInWorld_1.w);
  tmpvar_5 = ((_VerticalFogColor * _VerticalFogEmissionScaler) * 2.0);
  tmpvar_6 = ((posInWorld_1.xz * _VerticalFogNoise_ST.xy) + _VerticalFogNoise_ST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _VerticalFogNoise;
uniform mediump float _VerticalFogNoiseIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_VerticalFogNoise, xlv_TEXCOORD4);
  outColor_4.xyz = (outColor_4.xyz + (xlv_TEXCOORD3 * (
    ((tmpvar_7.x - 0.5) * _VerticalFogNoiseIntensity)
   + 0.5)).xyz);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform mediump vec4 _VerticalFogColor;
uniform mediump float _VerticalFogEmissionScaler;
uniform mediump vec4 _VerticalFogNoise_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 posInWorld_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_11)
      ) * (_FogIntensity * tmpvar_11))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_18;
    tmpvar_18 = (_FogEndDistance - _FogStartDistance);
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_19;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  posInWorld_1 = tmpvar_20;
  posInWorld_1 = (posInWorld_1 / posInWorld_1.w);
  tmpvar_5 = ((_VerticalFogColor * _VerticalFogEmissionScaler) * 2.0);
  tmpvar_6 = ((posInWorld_1.xz * _VerticalFogNoise_ST.xy) + _VerticalFogNoise_ST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _VerticalFogNoise;
uniform mediump float _VerticalFogNoiseIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_VerticalFogNoise, xlv_TEXCOORD4);
  outColor_4.xyz = (outColor_4.xyz + (xlv_TEXCOORD3 * (
    ((tmpvar_7.x - 0.5) * _VerticalFogNoiseIntensity)
   + 0.5)).xyz);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform mediump vec4 _VerticalFogColor;
uniform mediump float _VerticalFogEmissionScaler;
uniform mediump vec4 _VerticalFogNoise_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 posInWorld_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_11)
      ) * (_FogIntensity * tmpvar_11))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_18;
    tmpvar_18 = (_FogEndDistance - _FogStartDistance);
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_19;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  posInWorld_1 = tmpvar_20;
  posInWorld_1 = (posInWorld_1 / posInWorld_1.w);
  tmpvar_5 = ((_VerticalFogColor * _VerticalFogEmissionScaler) * 2.0);
  tmpvar_6 = ((posInWorld_1.xz * _VerticalFogNoise_ST.xy) + _VerticalFogNoise_ST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _VerticalFogNoise;
uniform mediump float _VerticalFogNoiseIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_VerticalFogNoise, xlv_TEXCOORD4);
  outColor_4.xyz = (outColor_4.xyz + (xlv_TEXCOORD3 * (
    ((tmpvar_7.x - 0.5) * _VerticalFogNoiseIntensity)
   + 0.5)).xyz);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform mediump vec4 _VerticalFogColor;
uniform mediump float _VerticalFogEmissionScaler;
uniform mediump vec4 _VerticalFogNoise_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 posInWorld_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_11)
      ) * (_FogIntensity * tmpvar_11))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_18;
    tmpvar_18 = (_FogEndDistance - _FogStartDistance);
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_19;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  posInWorld_1 = tmpvar_20;
  posInWorld_1 = (posInWorld_1 / posInWorld_1.w);
  tmpvar_5 = ((_VerticalFogColor * _VerticalFogEmissionScaler) * 2.0);
  tmpvar_6 = ((posInWorld_1.xz * _VerticalFogNoise_ST.xy) + _VerticalFogNoise_ST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _VerticalFogNoise;
uniform mediump float _VerticalFogNoiseIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_VerticalFogNoise, xlv_TEXCOORD4);
  outColor_4.xyz = (outColor_4.xyz + (xlv_TEXCOORD3 * (
    ((tmpvar_7.x - 0.5) * _VerticalFogNoiseIntensity)
   + 0.5)).xyz);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform mediump vec4 _VerticalFogColor;
uniform mediump float _VerticalFogEmissionScaler;
uniform mediump vec4 _VerticalFogNoise_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 posInWorld_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_11)
      ) * (_FogIntensity * tmpvar_11))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_18;
    tmpvar_18 = (_FogEndDistance - _FogStartDistance);
    tmpvar_17 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_16) / max (0.1, tmpvar_18))
    , 0.0, 1.0))));
    fogColor_14.xyz = tmpvar_19;
    fogColor_14.w = tmpvar_17;
    tmpvar_8 = fogColor_14;
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  posInWorld_1 = tmpvar_20;
  posInWorld_1 = (posInWorld_1 / posInWorld_1.w);
  tmpvar_5 = ((_VerticalFogColor * _VerticalFogEmissionScaler) * 2.0);
  tmpvar_6 = ((posInWorld_1.xz * _VerticalFogNoise_ST.xy) + _VerticalFogNoise_ST.zw);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _VerticalFogNoise;
uniform mediump float _VerticalFogNoiseIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_VerticalFogNoise, xlv_TEXCOORD4);
  outColor_4.xyz = (outColor_4.xyz + (xlv_TEXCOORD3 * (
    ((tmpvar_7.x - 0.5) * _VerticalFogNoiseIntensity)
   + 0.5)).xyz);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
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
Fallback "Diffuse"
}