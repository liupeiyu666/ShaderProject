//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/AirEffect_LightMap_Emission" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 63590
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (colorBlendLightMap_1, (_EmissionScaler * colorBlendLightMap_1), tex_C_Color_3.www);
  colorBlendLightMap_1 = tmpvar_7;
  outColor_4.xyz = mix (tmpvar_7, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (colorBlendLightMap_1, (_EmissionScaler * colorBlendLightMap_1), tex_C_Color_3.www);
  colorBlendLightMap_1 = tmpvar_7;
  outColor_4.xyz = mix (tmpvar_7, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (colorBlendLightMap_1, (_EmissionScaler * colorBlendLightMap_1), tex_C_Color_3.www);
  colorBlendLightMap_1 = tmpvar_7;
  outColor_4.xyz = mix (tmpvar_7, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (colorBlendLightMap_1, (_EmissionScaler * colorBlendLightMap_1), tex_C_Color_3.www);
  colorBlendLightMap_1 = tmpvar_7;
  outColor_4.xyz = mix (tmpvar_7, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (colorBlendLightMap_1, (_EmissionScaler * colorBlendLightMap_1), tex_C_Color_3.www);
  colorBlendLightMap_1 = tmpvar_7;
  outColor_4.xyz = mix (tmpvar_7, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (colorBlendLightMap_1, (_EmissionScaler * colorBlendLightMap_1), tex_C_Color_3.www);
  colorBlendLightMap_1 = tmpvar_7;
  outColor_4.xyz = mix (tmpvar_7, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (colorBlendLightMap_1, (_EmissionScaler * colorBlendLightMap_1), tex_C_Color_3.www);
  colorBlendLightMap_1 = tmpvar_7;
  outColor_4.xyz = mix (tmpvar_7, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (colorBlendLightMap_1, (_EmissionScaler * colorBlendLightMap_1), tex_C_Color_3.www);
  colorBlendLightMap_1 = tmpvar_7;
  outColor_4.xyz = mix (tmpvar_7, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (colorBlendLightMap_1, (_EmissionScaler * colorBlendLightMap_1), tex_C_Color_3.www);
  colorBlendLightMap_1 = tmpvar_7;
  outColor_4.xyz = mix (tmpvar_7, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (colorBlendLightMap_1, (_EmissionScaler * colorBlendLightMap_1), tex_C_Color_3.www);
  colorBlendLightMap_1 = tmpvar_7;
  outColor_4.xyz = mix (tmpvar_7, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (colorBlendLightMap_1, (_EmissionScaler * colorBlendLightMap_1), tex_C_Color_3.www);
  colorBlendLightMap_1 = tmpvar_7;
  outColor_4.xyz = mix (tmpvar_7, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (colorBlendLightMap_1, (_EmissionScaler * colorBlendLightMap_1), tex_C_Color_3.www);
  colorBlendLightMap_1 = tmpvar_7;
  outColor_4.xyz = mix (tmpvar_7, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD2 = fogParam_17;
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
uniform mediump float _BloomFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    highp vec3 tmpvar_8;
    tmpvar_8 = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    outColor_1.xyz = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = outColor_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_9, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_10;
  };
  outColor_1.w = _BloomFactor;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD2 = fogParam_17;
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
uniform mediump float _BloomFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    highp vec3 tmpvar_8;
    tmpvar_8 = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    outColor_1.xyz = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = outColor_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_9, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_10;
  };
  outColor_1.w = _BloomFactor;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD2 = fogParam_17;
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
uniform mediump float _BloomFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    highp vec3 tmpvar_8;
    tmpvar_8 = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    outColor_1.xyz = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = outColor_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_9, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_10;
  };
  outColor_1.w = _BloomFactor;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD2 = fogParam_17;
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
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    highp vec3 tmpvar_8;
    tmpvar_8 = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    outColor_1.xyz = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = outColor_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_9, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_10;
  };
  outColor_1.w = _BloomFactor;
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD2 = fogParam_17;
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
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    highp vec3 tmpvar_8;
    tmpvar_8 = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    outColor_1.xyz = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = outColor_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_9, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_10;
  };
  outColor_1.w = _BloomFactor;
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD2 = fogParam_17;
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
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    highp vec3 tmpvar_8;
    tmpvar_8 = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    outColor_1.xyz = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = outColor_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_9, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_10;
  };
  outColor_1.w = _BloomFactor;
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD2 = fogParam_17;
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
uniform mediump float _BloomFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    highp vec3 tmpvar_8;
    tmpvar_8 = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    outColor_1.xyz = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = outColor_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_9, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_10;
  };
  outColor_1.w = _BloomFactor;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD2 = fogParam_17;
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
uniform mediump float _BloomFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    highp vec3 tmpvar_8;
    tmpvar_8 = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    outColor_1.xyz = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = outColor_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_9, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_10;
  };
  outColor_1.w = _BloomFactor;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD2 = fogParam_17;
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
uniform mediump float _BloomFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    highp vec3 tmpvar_8;
    tmpvar_8 = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    outColor_1.xyz = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = outColor_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_9, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_10;
  };
  outColor_1.w = _BloomFactor;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD2 = fogParam_17;
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
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    highp vec3 tmpvar_8;
    tmpvar_8 = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    outColor_1.xyz = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = outColor_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_9, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_10;
  };
  outColor_1.w = _BloomFactor;
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD2 = fogParam_17;
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
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    highp vec3 tmpvar_8;
    tmpvar_8 = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    outColor_1.xyz = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = outColor_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_9, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_10;
  };
  outColor_1.w = _BloomFactor;
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_8;
    tmpvar_8 = max (0.0, (sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStartDistance));
    highp float tmpvar_9;
    tmpvar_9 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_8)
      ) * (_FogIntensity * tmpvar_8))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_8)) * (_FogColorIntensity * tmpvar_8))
    ), 0.0, 1.0)));
    fogColor_6.xyz = tmpvar_10;
    fogColor_6.w = tmpvar_9;
    tmpvar_5 = fogColor_6;
  } else {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    highp float tmpvar_15;
    tmpvar_15 = (_FogEndDistance - _FogStartDistance);
    tmpvar_14 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_13) / max (0.1, tmpvar_15))
    , 0.0, 1.0))));
    fogColor_11.xyz = tmpvar_16;
    fogColor_11.w = tmpvar_14;
    tmpvar_5 = fogColor_11;
  };
  mediump vec3 fogParam_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_20;
  tmpvar_20 = max (0.0, (sqrt(
    dot (tmpvar_19, tmpvar_19)
  ) - _UWFogDistStart));
  highp float tmpvar_21;
  tmpvar_21 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_20)
    ) * (_UWFogDensity * tmpvar_20))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_22;
  tmpvar_22 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_20))
   * 
    (_UWFogColorNFIntensity * tmpvar_20)
  )), 0.0, 1.0);
  fogParam_17.x = tmpvar_22;
  fogParam_17.y = tmpvar_21;
  fogParam_17.z = tmpvar_18.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_5;
  xlv_TEXCOORD2 = fogParam_17;
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
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_2;
    xlat_varinput_2 = xlv_TEXCOORD2;
    mediump vec3 fogParam_3;
    highp float tmpvar_4;
    tmpvar_4 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_5;
    tmpvar_5 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_4))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_6;
    tmpvar_6 = clamp ((_UWFogColorHLIntensity * tmpvar_4), 0.0, 1.0);
    fogParam_3.z = 0.0;
    fogParam_3.y = tmpvar_5;
    fogParam_3.x = tmpvar_6;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_2.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_4 * _UWHeightRatio)));
      highp float tmpvar_7;
      tmpvar_7 = clamp (xlat_varinput_2.y, _UWCriticalRange, 1.0);
      xlat_varinput_2.y = tmpvar_7;
    };
    fogParam_3.z = (1.0 - xlat_varinput_2.y);
    highp vec3 tmpvar_8;
    tmpvar_8 = (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx) * (vec4(1.0, 1.0, 1.0, 1.0) - fogParam_3.zzzz)).xyz;
    outColor_1.xyz = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = outColor_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_3.xxxx), tmpvar_9, fogParam_3.yyyy).xyz;
    outColor_1.xyz = tmpvar_10;
  };
  outColor_1.w = _BloomFactor;
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
}
}
}
Fallback "Diffuse"
}