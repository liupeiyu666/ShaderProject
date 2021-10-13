//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "hidden/Scene/Metal Floor (With Pow) (without reflection)" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "white" { }
_LightMapIntensity ("Light Map Intensity", Float) = 1
_ReflectionTex ("Reflection", 2D) = "white" { }
_ReflectionEmissionAdjust ("Reflection Emission Adjust", Float) = 1
_FresnelParams ("Fresnel Parameters", Vector) = (1,1,0,0)
_BrushedNormalMap ("Brushed Normal Map", 2D) = "green" { }
_BrushScaleX ("Brush Scale X", Range(0, 1)) = 1
_BrushScaleY ("Brush Scale Y", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 732
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
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_8;
  mediump float fogFactor_9;
  mediump vec3 fogColor_10;
  mediump vec3 heightFogColor_11;
  highp float HeightFogFactor_12;
  mediump vec3 atomesphereFogColor_13;
  mediump float h_14;
  highp float linearFogDensity_15;
  mediump float len_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((len_16 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_15 = (tmpvar_18 * (2.0 - tmpvar_18));
  if ((len_16 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_15 = (linearFogDensity_15 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_19;
  tmpvar_19 = min (pow (linearFogDensity_15, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_15 = tmpvar_19;
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_6.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  h_14 = (tmpvar_20 * (2.0 - tmpvar_20));
  highp vec3 tmpvar_22;
  tmpvar_22 = (_HeigtFogColBase.xyz + (h_14 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_13 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = mix (atomesphereFogColor_13, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_16 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_13 = tmpvar_23;
  mediump float tmpvar_24;
  mediump float r_25;
  mediump float f_26;
  mediump float u_27;
  mediump float l_28;
  mediump float fogInt_29;
  fogInt_29 = 1.0;
  highp float tmpvar_30;
  tmpvar_30 = (_HeigtFogParams.x * tmpvar_7.y);
  highp float tmpvar_31;
  tmpvar_31 = abs(tmpvar_30);
  if ((tmpvar_31 > 0.01)) {
    highp float tmpvar_32;
    tmpvar_32 = exp(-(tmpvar_30));
    fogInt_29 = ((1.0 - tmpvar_32) / tmpvar_30);
  };
  highp float tmpvar_33;
  tmpvar_33 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_28 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (l_28 * _HeigtFogParams.y);
  u_27 = tmpvar_34;
  fogInt_29 = (fogInt_29 * u_27);
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((l_28 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  r_25 = (tmpvar_35 * (2.0 - tmpvar_35));
  r_25 = ((r_25 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_26 = ((1.0 - clamp (
    exp2(-(fogInt_29))
  , 0.0, 1.0)) * r_25);
  highp float tmpvar_37;
  tmpvar_37 = min (f_26, _HeigtFogColBase.w);
  tmpvar_24 = tmpvar_37;
  HeightFogFactor_12 = tmpvar_24;
  highp vec3 tmpvar_38;
  tmpvar_38 = _Mihoyo_FogColor.xyz;
  heightFogColor_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((heightFogColor_11 * HeightFogFactor_12) + ((atomesphereFogColor_13 * tmpvar_19) * (1.0 - HeightFogFactor_12)));
  fogColor_10 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = ((1.0 - tmpvar_19) * (1.0 - HeightFogFactor_12));
  fogFactor_9 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = fogColor_10;
  tmpvar_41.w = fogFactor_9;
  tmpvar_8 = tmpvar_41;
  tmpvar_5 = tmpvar_8;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
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
  outColor_4.xyz = (xlv_COLOR1.xyz + (colorBlendLightMap_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_8;
  mediump float fogFactor_9;
  mediump vec3 fogColor_10;
  mediump vec3 heightFogColor_11;
  highp float HeightFogFactor_12;
  mediump vec3 atomesphereFogColor_13;
  mediump float h_14;
  highp float linearFogDensity_15;
  mediump float len_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((len_16 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_15 = (tmpvar_18 * (2.0 - tmpvar_18));
  if ((len_16 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_15 = (linearFogDensity_15 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_19;
  tmpvar_19 = min (pow (linearFogDensity_15, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_15 = tmpvar_19;
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_6.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  h_14 = (tmpvar_20 * (2.0 - tmpvar_20));
  highp vec3 tmpvar_22;
  tmpvar_22 = (_HeigtFogColBase.xyz + (h_14 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_13 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = mix (atomesphereFogColor_13, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_16 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_13 = tmpvar_23;
  mediump float tmpvar_24;
  mediump float r_25;
  mediump float f_26;
  mediump float u_27;
  mediump float l_28;
  mediump float fogInt_29;
  fogInt_29 = 1.0;
  highp float tmpvar_30;
  tmpvar_30 = (_HeigtFogParams.x * tmpvar_7.y);
  highp float tmpvar_31;
  tmpvar_31 = abs(tmpvar_30);
  if ((tmpvar_31 > 0.01)) {
    highp float tmpvar_32;
    tmpvar_32 = exp(-(tmpvar_30));
    fogInt_29 = ((1.0 - tmpvar_32) / tmpvar_30);
  };
  highp float tmpvar_33;
  tmpvar_33 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_28 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (l_28 * _HeigtFogParams.y);
  u_27 = tmpvar_34;
  fogInt_29 = (fogInt_29 * u_27);
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((l_28 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  r_25 = (tmpvar_35 * (2.0 - tmpvar_35));
  r_25 = ((r_25 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_26 = ((1.0 - clamp (
    exp2(-(fogInt_29))
  , 0.0, 1.0)) * r_25);
  highp float tmpvar_37;
  tmpvar_37 = min (f_26, _HeigtFogColBase.w);
  tmpvar_24 = tmpvar_37;
  HeightFogFactor_12 = tmpvar_24;
  highp vec3 tmpvar_38;
  tmpvar_38 = _Mihoyo_FogColor.xyz;
  heightFogColor_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((heightFogColor_11 * HeightFogFactor_12) + ((atomesphereFogColor_13 * tmpvar_19) * (1.0 - HeightFogFactor_12)));
  fogColor_10 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = ((1.0 - tmpvar_19) * (1.0 - HeightFogFactor_12));
  fogFactor_9 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = fogColor_10;
  tmpvar_41.w = fogFactor_9;
  tmpvar_8 = tmpvar_41;
  tmpvar_5 = tmpvar_8;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
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
  outColor_4.xyz = (xlv_COLOR1.xyz + (colorBlendLightMap_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_8;
  mediump float fogFactor_9;
  mediump vec3 fogColor_10;
  mediump vec3 heightFogColor_11;
  highp float HeightFogFactor_12;
  mediump vec3 atomesphereFogColor_13;
  mediump float h_14;
  highp float linearFogDensity_15;
  mediump float len_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((len_16 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_15 = (tmpvar_18 * (2.0 - tmpvar_18));
  if ((len_16 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_15 = (linearFogDensity_15 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_19;
  tmpvar_19 = min (pow (linearFogDensity_15, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_15 = tmpvar_19;
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_6.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  h_14 = (tmpvar_20 * (2.0 - tmpvar_20));
  highp vec3 tmpvar_22;
  tmpvar_22 = (_HeigtFogColBase.xyz + (h_14 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_13 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = mix (atomesphereFogColor_13, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_16 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_13 = tmpvar_23;
  mediump float tmpvar_24;
  mediump float r_25;
  mediump float f_26;
  mediump float u_27;
  mediump float l_28;
  mediump float fogInt_29;
  fogInt_29 = 1.0;
  highp float tmpvar_30;
  tmpvar_30 = (_HeigtFogParams.x * tmpvar_7.y);
  highp float tmpvar_31;
  tmpvar_31 = abs(tmpvar_30);
  if ((tmpvar_31 > 0.01)) {
    highp float tmpvar_32;
    tmpvar_32 = exp(-(tmpvar_30));
    fogInt_29 = ((1.0 - tmpvar_32) / tmpvar_30);
  };
  highp float tmpvar_33;
  tmpvar_33 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_28 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (l_28 * _HeigtFogParams.y);
  u_27 = tmpvar_34;
  fogInt_29 = (fogInt_29 * u_27);
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((l_28 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  r_25 = (tmpvar_35 * (2.0 - tmpvar_35));
  r_25 = ((r_25 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_26 = ((1.0 - clamp (
    exp2(-(fogInt_29))
  , 0.0, 1.0)) * r_25);
  highp float tmpvar_37;
  tmpvar_37 = min (f_26, _HeigtFogColBase.w);
  tmpvar_24 = tmpvar_37;
  HeightFogFactor_12 = tmpvar_24;
  highp vec3 tmpvar_38;
  tmpvar_38 = _Mihoyo_FogColor.xyz;
  heightFogColor_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((heightFogColor_11 * HeightFogFactor_12) + ((atomesphereFogColor_13 * tmpvar_19) * (1.0 - HeightFogFactor_12)));
  fogColor_10 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = ((1.0 - tmpvar_19) * (1.0 - HeightFogFactor_12));
  fogFactor_9 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = fogColor_10;
  tmpvar_41.w = fogFactor_9;
  tmpvar_8 = tmpvar_41;
  tmpvar_5 = tmpvar_8;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
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
  outColor_4.xyz = (xlv_COLOR1.xyz + (colorBlendLightMap_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_8;
  mediump float fogFactor_9;
  mediump vec3 fogColor_10;
  mediump vec3 heightFogColor_11;
  highp float HeightFogFactor_12;
  mediump vec3 atomesphereFogColor_13;
  mediump float h_14;
  highp float linearFogDensity_15;
  mediump float len_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((len_16 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_15 = (tmpvar_18 * (2.0 - tmpvar_18));
  if ((len_16 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_15 = (linearFogDensity_15 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_19;
  tmpvar_19 = min (pow (linearFogDensity_15, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_15 = tmpvar_19;
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_6.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  h_14 = (tmpvar_20 * (2.0 - tmpvar_20));
  highp vec3 tmpvar_22;
  tmpvar_22 = (_HeigtFogColBase2.xyz + (h_14 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_13 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = mix (atomesphereFogColor_13, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_16 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_13 = tmpvar_23;
  mediump float tmpvar_24;
  mediump float r_25;
  mediump float f_26;
  mediump float u_27;
  mediump float l_28;
  mediump float fogInt_29;
  fogInt_29 = 1.0;
  highp float tmpvar_30;
  tmpvar_30 = (_HeigtFogParams2.x * tmpvar_7.y);
  highp float tmpvar_31;
  tmpvar_31 = abs(tmpvar_30);
  if ((tmpvar_31 > 0.01)) {
    highp float tmpvar_32;
    tmpvar_32 = exp(-(tmpvar_30));
    fogInt_29 = ((1.0 - tmpvar_32) / tmpvar_30);
  };
  highp float tmpvar_33;
  tmpvar_33 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_28 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (l_28 * _HeigtFogParams2.y);
  u_27 = tmpvar_34;
  fogInt_29 = (fogInt_29 * u_27);
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((l_28 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  r_25 = (tmpvar_35 * (2.0 - tmpvar_35));
  r_25 = ((r_25 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_26 = ((1.0 - clamp (
    exp2(-(fogInt_29))
  , 0.0, 1.0)) * r_25);
  highp float tmpvar_37;
  tmpvar_37 = min (f_26, _HeigtFogColBase2.w);
  tmpvar_24 = tmpvar_37;
  HeightFogFactor_12 = tmpvar_24;
  highp vec3 tmpvar_38;
  tmpvar_38 = _Mihoyo_FogColor2.xyz;
  heightFogColor_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((heightFogColor_11 * HeightFogFactor_12) + ((atomesphereFogColor_13 * tmpvar_19) * (1.0 - HeightFogFactor_12)));
  fogColor_10 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = ((1.0 - tmpvar_19) * (1.0 - HeightFogFactor_12));
  fogFactor_9 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = fogColor_10;
  tmpvar_41.w = fogFactor_9;
  tmpvar_8 = tmpvar_41;
  highp vec4 tmpvar_42;
  mediump float fogFactor_43;
  mediump vec3 fogColor_44;
  mediump vec3 heightFogColor_45;
  highp float HeightFogFactor_46;
  mediump vec3 atomesphereFogColor_47;
  mediump float h_48;
  highp float linearFogDensity_49;
  mediump float len_50;
  highp float tmpvar_51;
  tmpvar_51 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_50 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (((len_50 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_49 = (tmpvar_52 * (2.0 - tmpvar_52));
  if ((len_50 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_49 = (linearFogDensity_49 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_53;
  tmpvar_53 = min (pow (linearFogDensity_49, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_49 = tmpvar_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_6.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  h_48 = (tmpvar_54 * (2.0 - tmpvar_54));
  highp vec3 tmpvar_56;
  tmpvar_56 = (_HeigtFogColBase3.xyz + (h_48 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_47 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = mix (atomesphereFogColor_47, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_50 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_47 = tmpvar_57;
  mediump float tmpvar_58;
  mediump float r_59;
  mediump float f_60;
  mediump float u_61;
  mediump float l_62;
  mediump float fogInt_63;
  fogInt_63 = 1.0;
  highp float tmpvar_64;
  tmpvar_64 = (_HeigtFogParams3.x * tmpvar_7.y);
  highp float tmpvar_65;
  tmpvar_65 = abs(tmpvar_64);
  if ((tmpvar_65 > 0.01)) {
    highp float tmpvar_66;
    tmpvar_66 = exp(-(tmpvar_64));
    fogInt_63 = ((1.0 - tmpvar_66) / tmpvar_64);
  };
  highp float tmpvar_67;
  tmpvar_67 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_62 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = (l_62 * _HeigtFogParams3.y);
  u_61 = tmpvar_68;
  fogInt_63 = (fogInt_63 * u_61);
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((l_62 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  r_59 = (tmpvar_69 * (2.0 - tmpvar_69));
  r_59 = ((r_59 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_60 = ((1.0 - clamp (
    exp2(-(fogInt_63))
  , 0.0, 1.0)) * r_59);
  highp float tmpvar_71;
  tmpvar_71 = min (f_60, _HeigtFogColBase3.w);
  tmpvar_58 = tmpvar_71;
  HeightFogFactor_46 = tmpvar_58;
  highp vec3 tmpvar_72;
  tmpvar_72 = _Mihoyo_FogColor3.xyz;
  heightFogColor_45 = tmpvar_72;
  highp vec3 tmpvar_73;
  tmpvar_73 = ((heightFogColor_45 * HeightFogFactor_46) + ((atomesphereFogColor_47 * tmpvar_53) * (1.0 - HeightFogFactor_46)));
  fogColor_44 = tmpvar_73;
  highp float tmpvar_74;
  tmpvar_74 = ((1.0 - tmpvar_53) * (1.0 - HeightFogFactor_46));
  fogFactor_43 = tmpvar_74;
  mediump vec4 tmpvar_75;
  tmpvar_75.xyz = fogColor_44;
  tmpvar_75.w = fogFactor_43;
  tmpvar_42 = tmpvar_75;
  highp vec4 tmpvar_76;
  tmpvar_76 = mix (tmpvar_8, tmpvar_42, vec4(_LerpFactor));
  tmpvar_5 = tmpvar_76;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
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
  outColor_4.xyz = (xlv_COLOR1.xyz + (colorBlendLightMap_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_8;
  mediump float fogFactor_9;
  mediump vec3 fogColor_10;
  mediump vec3 heightFogColor_11;
  highp float HeightFogFactor_12;
  mediump vec3 atomesphereFogColor_13;
  mediump float h_14;
  highp float linearFogDensity_15;
  mediump float len_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((len_16 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_15 = (tmpvar_18 * (2.0 - tmpvar_18));
  if ((len_16 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_15 = (linearFogDensity_15 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_19;
  tmpvar_19 = min (pow (linearFogDensity_15, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_15 = tmpvar_19;
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_6.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  h_14 = (tmpvar_20 * (2.0 - tmpvar_20));
  highp vec3 tmpvar_22;
  tmpvar_22 = (_HeigtFogColBase2.xyz + (h_14 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_13 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = mix (atomesphereFogColor_13, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_16 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_13 = tmpvar_23;
  mediump float tmpvar_24;
  mediump float r_25;
  mediump float f_26;
  mediump float u_27;
  mediump float l_28;
  mediump float fogInt_29;
  fogInt_29 = 1.0;
  highp float tmpvar_30;
  tmpvar_30 = (_HeigtFogParams2.x * tmpvar_7.y);
  highp float tmpvar_31;
  tmpvar_31 = abs(tmpvar_30);
  if ((tmpvar_31 > 0.01)) {
    highp float tmpvar_32;
    tmpvar_32 = exp(-(tmpvar_30));
    fogInt_29 = ((1.0 - tmpvar_32) / tmpvar_30);
  };
  highp float tmpvar_33;
  tmpvar_33 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_28 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (l_28 * _HeigtFogParams2.y);
  u_27 = tmpvar_34;
  fogInt_29 = (fogInt_29 * u_27);
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((l_28 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  r_25 = (tmpvar_35 * (2.0 - tmpvar_35));
  r_25 = ((r_25 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_26 = ((1.0 - clamp (
    exp2(-(fogInt_29))
  , 0.0, 1.0)) * r_25);
  highp float tmpvar_37;
  tmpvar_37 = min (f_26, _HeigtFogColBase2.w);
  tmpvar_24 = tmpvar_37;
  HeightFogFactor_12 = tmpvar_24;
  highp vec3 tmpvar_38;
  tmpvar_38 = _Mihoyo_FogColor2.xyz;
  heightFogColor_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((heightFogColor_11 * HeightFogFactor_12) + ((atomesphereFogColor_13 * tmpvar_19) * (1.0 - HeightFogFactor_12)));
  fogColor_10 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = ((1.0 - tmpvar_19) * (1.0 - HeightFogFactor_12));
  fogFactor_9 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = fogColor_10;
  tmpvar_41.w = fogFactor_9;
  tmpvar_8 = tmpvar_41;
  highp vec4 tmpvar_42;
  mediump float fogFactor_43;
  mediump vec3 fogColor_44;
  mediump vec3 heightFogColor_45;
  highp float HeightFogFactor_46;
  mediump vec3 atomesphereFogColor_47;
  mediump float h_48;
  highp float linearFogDensity_49;
  mediump float len_50;
  highp float tmpvar_51;
  tmpvar_51 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_50 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (((len_50 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_49 = (tmpvar_52 * (2.0 - tmpvar_52));
  if ((len_50 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_49 = (linearFogDensity_49 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_53;
  tmpvar_53 = min (pow (linearFogDensity_49, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_49 = tmpvar_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_6.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  h_48 = (tmpvar_54 * (2.0 - tmpvar_54));
  highp vec3 tmpvar_56;
  tmpvar_56 = (_HeigtFogColBase3.xyz + (h_48 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_47 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = mix (atomesphereFogColor_47, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_50 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_47 = tmpvar_57;
  mediump float tmpvar_58;
  mediump float r_59;
  mediump float f_60;
  mediump float u_61;
  mediump float l_62;
  mediump float fogInt_63;
  fogInt_63 = 1.0;
  highp float tmpvar_64;
  tmpvar_64 = (_HeigtFogParams3.x * tmpvar_7.y);
  highp float tmpvar_65;
  tmpvar_65 = abs(tmpvar_64);
  if ((tmpvar_65 > 0.01)) {
    highp float tmpvar_66;
    tmpvar_66 = exp(-(tmpvar_64));
    fogInt_63 = ((1.0 - tmpvar_66) / tmpvar_64);
  };
  highp float tmpvar_67;
  tmpvar_67 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_62 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = (l_62 * _HeigtFogParams3.y);
  u_61 = tmpvar_68;
  fogInt_63 = (fogInt_63 * u_61);
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((l_62 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  r_59 = (tmpvar_69 * (2.0 - tmpvar_69));
  r_59 = ((r_59 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_60 = ((1.0 - clamp (
    exp2(-(fogInt_63))
  , 0.0, 1.0)) * r_59);
  highp float tmpvar_71;
  tmpvar_71 = min (f_60, _HeigtFogColBase3.w);
  tmpvar_58 = tmpvar_71;
  HeightFogFactor_46 = tmpvar_58;
  highp vec3 tmpvar_72;
  tmpvar_72 = _Mihoyo_FogColor3.xyz;
  heightFogColor_45 = tmpvar_72;
  highp vec3 tmpvar_73;
  tmpvar_73 = ((heightFogColor_45 * HeightFogFactor_46) + ((atomesphereFogColor_47 * tmpvar_53) * (1.0 - HeightFogFactor_46)));
  fogColor_44 = tmpvar_73;
  highp float tmpvar_74;
  tmpvar_74 = ((1.0 - tmpvar_53) * (1.0 - HeightFogFactor_46));
  fogFactor_43 = tmpvar_74;
  mediump vec4 tmpvar_75;
  tmpvar_75.xyz = fogColor_44;
  tmpvar_75.w = fogFactor_43;
  tmpvar_42 = tmpvar_75;
  highp vec4 tmpvar_76;
  tmpvar_76 = mix (tmpvar_8, tmpvar_42, vec4(_LerpFactor));
  tmpvar_5 = tmpvar_76;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
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
  outColor_4.xyz = (xlv_COLOR1.xyz + (colorBlendLightMap_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_8;
  mediump float fogFactor_9;
  mediump vec3 fogColor_10;
  mediump vec3 heightFogColor_11;
  highp float HeightFogFactor_12;
  mediump vec3 atomesphereFogColor_13;
  mediump float h_14;
  highp float linearFogDensity_15;
  mediump float len_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((len_16 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_15 = (tmpvar_18 * (2.0 - tmpvar_18));
  if ((len_16 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_15 = (linearFogDensity_15 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_19;
  tmpvar_19 = min (pow (linearFogDensity_15, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_15 = tmpvar_19;
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_6.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  h_14 = (tmpvar_20 * (2.0 - tmpvar_20));
  highp vec3 tmpvar_22;
  tmpvar_22 = (_HeigtFogColBase2.xyz + (h_14 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_13 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = mix (atomesphereFogColor_13, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_16 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_13 = tmpvar_23;
  mediump float tmpvar_24;
  mediump float r_25;
  mediump float f_26;
  mediump float u_27;
  mediump float l_28;
  mediump float fogInt_29;
  fogInt_29 = 1.0;
  highp float tmpvar_30;
  tmpvar_30 = (_HeigtFogParams2.x * tmpvar_7.y);
  highp float tmpvar_31;
  tmpvar_31 = abs(tmpvar_30);
  if ((tmpvar_31 > 0.01)) {
    highp float tmpvar_32;
    tmpvar_32 = exp(-(tmpvar_30));
    fogInt_29 = ((1.0 - tmpvar_32) / tmpvar_30);
  };
  highp float tmpvar_33;
  tmpvar_33 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_28 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (l_28 * _HeigtFogParams2.y);
  u_27 = tmpvar_34;
  fogInt_29 = (fogInt_29 * u_27);
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((l_28 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  r_25 = (tmpvar_35 * (2.0 - tmpvar_35));
  r_25 = ((r_25 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_26 = ((1.0 - clamp (
    exp2(-(fogInt_29))
  , 0.0, 1.0)) * r_25);
  highp float tmpvar_37;
  tmpvar_37 = min (f_26, _HeigtFogColBase2.w);
  tmpvar_24 = tmpvar_37;
  HeightFogFactor_12 = tmpvar_24;
  highp vec3 tmpvar_38;
  tmpvar_38 = _Mihoyo_FogColor2.xyz;
  heightFogColor_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((heightFogColor_11 * HeightFogFactor_12) + ((atomesphereFogColor_13 * tmpvar_19) * (1.0 - HeightFogFactor_12)));
  fogColor_10 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = ((1.0 - tmpvar_19) * (1.0 - HeightFogFactor_12));
  fogFactor_9 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = fogColor_10;
  tmpvar_41.w = fogFactor_9;
  tmpvar_8 = tmpvar_41;
  highp vec4 tmpvar_42;
  mediump float fogFactor_43;
  mediump vec3 fogColor_44;
  mediump vec3 heightFogColor_45;
  highp float HeightFogFactor_46;
  mediump vec3 atomesphereFogColor_47;
  mediump float h_48;
  highp float linearFogDensity_49;
  mediump float len_50;
  highp float tmpvar_51;
  tmpvar_51 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_50 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (((len_50 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_49 = (tmpvar_52 * (2.0 - tmpvar_52));
  if ((len_50 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_49 = (linearFogDensity_49 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_53;
  tmpvar_53 = min (pow (linearFogDensity_49, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_49 = tmpvar_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_6.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  h_48 = (tmpvar_54 * (2.0 - tmpvar_54));
  highp vec3 tmpvar_56;
  tmpvar_56 = (_HeigtFogColBase3.xyz + (h_48 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_47 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = mix (atomesphereFogColor_47, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_50 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_47 = tmpvar_57;
  mediump float tmpvar_58;
  mediump float r_59;
  mediump float f_60;
  mediump float u_61;
  mediump float l_62;
  mediump float fogInt_63;
  fogInt_63 = 1.0;
  highp float tmpvar_64;
  tmpvar_64 = (_HeigtFogParams3.x * tmpvar_7.y);
  highp float tmpvar_65;
  tmpvar_65 = abs(tmpvar_64);
  if ((tmpvar_65 > 0.01)) {
    highp float tmpvar_66;
    tmpvar_66 = exp(-(tmpvar_64));
    fogInt_63 = ((1.0 - tmpvar_66) / tmpvar_64);
  };
  highp float tmpvar_67;
  tmpvar_67 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_62 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = (l_62 * _HeigtFogParams3.y);
  u_61 = tmpvar_68;
  fogInt_63 = (fogInt_63 * u_61);
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((l_62 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  r_59 = (tmpvar_69 * (2.0 - tmpvar_69));
  r_59 = ((r_59 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_60 = ((1.0 - clamp (
    exp2(-(fogInt_63))
  , 0.0, 1.0)) * r_59);
  highp float tmpvar_71;
  tmpvar_71 = min (f_60, _HeigtFogColBase3.w);
  tmpvar_58 = tmpvar_71;
  HeightFogFactor_46 = tmpvar_58;
  highp vec3 tmpvar_72;
  tmpvar_72 = _Mihoyo_FogColor3.xyz;
  heightFogColor_45 = tmpvar_72;
  highp vec3 tmpvar_73;
  tmpvar_73 = ((heightFogColor_45 * HeightFogFactor_46) + ((atomesphereFogColor_47 * tmpvar_53) * (1.0 - HeightFogFactor_46)));
  fogColor_44 = tmpvar_73;
  highp float tmpvar_74;
  tmpvar_74 = ((1.0 - tmpvar_53) * (1.0 - HeightFogFactor_46));
  fogFactor_43 = tmpvar_74;
  mediump vec4 tmpvar_75;
  tmpvar_75.xyz = fogColor_44;
  tmpvar_75.w = fogFactor_43;
  tmpvar_42 = tmpvar_75;
  highp vec4 tmpvar_76;
  tmpvar_76 = mix (tmpvar_8, tmpvar_42, vec4(_LerpFactor));
  tmpvar_5 = tmpvar_76;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
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
  outColor_4.xyz = (xlv_COLOR1.xyz + (colorBlendLightMap_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_8;
  mediump float fogFactor_9;
  mediump vec3 fogColor_10;
  mediump vec3 heightFogColor_11;
  highp float HeightFogFactor_12;
  mediump vec3 atomesphereFogColor_13;
  mediump float h_14;
  highp float linearFogDensity_15;
  mediump float len_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((len_16 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_15 = (tmpvar_18 * (2.0 - tmpvar_18));
  if ((len_16 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_15 = (linearFogDensity_15 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_19;
  tmpvar_19 = min (pow (linearFogDensity_15, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_15 = tmpvar_19;
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_6.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  h_14 = (tmpvar_20 * (2.0 - tmpvar_20));
  highp vec3 tmpvar_22;
  tmpvar_22 = (_HeigtFogColBase.xyz + (h_14 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_13 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = mix (atomesphereFogColor_13, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_16 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_13 = tmpvar_23;
  mediump float tmpvar_24;
  mediump float r_25;
  mediump float f_26;
  mediump float u_27;
  mediump float l_28;
  mediump float fogInt_29;
  fogInt_29 = 1.0;
  highp float tmpvar_30;
  tmpvar_30 = (_HeigtFogParams.x * tmpvar_7.y);
  highp float tmpvar_31;
  tmpvar_31 = abs(tmpvar_30);
  if ((tmpvar_31 > 0.01)) {
    highp float tmpvar_32;
    tmpvar_32 = exp(-(tmpvar_30));
    fogInt_29 = ((1.0 - tmpvar_32) / tmpvar_30);
  };
  highp float tmpvar_33;
  tmpvar_33 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_28 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (l_28 * _HeigtFogParams.y);
  u_27 = tmpvar_34;
  fogInt_29 = (fogInt_29 * u_27);
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((l_28 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  r_25 = (tmpvar_35 * (2.0 - tmpvar_35));
  r_25 = ((r_25 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_26 = ((1.0 - clamp (
    exp2(-(fogInt_29))
  , 0.0, 1.0)) * r_25);
  highp float tmpvar_37;
  tmpvar_37 = min (f_26, _HeigtFogColBase.w);
  tmpvar_24 = tmpvar_37;
  HeightFogFactor_12 = tmpvar_24;
  highp vec3 tmpvar_38;
  tmpvar_38 = _Mihoyo_FogColor.xyz;
  heightFogColor_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((heightFogColor_11 * HeightFogFactor_12) + ((atomesphereFogColor_13 * tmpvar_19) * (1.0 - HeightFogFactor_12)));
  fogColor_10 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = ((1.0 - tmpvar_19) * (1.0 - HeightFogFactor_12));
  fogFactor_9 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = fogColor_10;
  tmpvar_41.w = fogFactor_9;
  tmpvar_8 = tmpvar_41;
  tmpvar_5 = tmpvar_8;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
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
  outColor_4.xyz = (xlv_COLOR1.xyz + (colorBlendLightMap_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_8;
  mediump float fogFactor_9;
  mediump vec3 fogColor_10;
  mediump vec3 heightFogColor_11;
  highp float HeightFogFactor_12;
  mediump vec3 atomesphereFogColor_13;
  mediump float h_14;
  highp float linearFogDensity_15;
  mediump float len_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((len_16 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_15 = (tmpvar_18 * (2.0 - tmpvar_18));
  if ((len_16 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_15 = (linearFogDensity_15 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_19;
  tmpvar_19 = min (pow (linearFogDensity_15, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_15 = tmpvar_19;
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_6.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  h_14 = (tmpvar_20 * (2.0 - tmpvar_20));
  highp vec3 tmpvar_22;
  tmpvar_22 = (_HeigtFogColBase.xyz + (h_14 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_13 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = mix (atomesphereFogColor_13, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_16 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_13 = tmpvar_23;
  mediump float tmpvar_24;
  mediump float r_25;
  mediump float f_26;
  mediump float u_27;
  mediump float l_28;
  mediump float fogInt_29;
  fogInt_29 = 1.0;
  highp float tmpvar_30;
  tmpvar_30 = (_HeigtFogParams.x * tmpvar_7.y);
  highp float tmpvar_31;
  tmpvar_31 = abs(tmpvar_30);
  if ((tmpvar_31 > 0.01)) {
    highp float tmpvar_32;
    tmpvar_32 = exp(-(tmpvar_30));
    fogInt_29 = ((1.0 - tmpvar_32) / tmpvar_30);
  };
  highp float tmpvar_33;
  tmpvar_33 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_28 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (l_28 * _HeigtFogParams.y);
  u_27 = tmpvar_34;
  fogInt_29 = (fogInt_29 * u_27);
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((l_28 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  r_25 = (tmpvar_35 * (2.0 - tmpvar_35));
  r_25 = ((r_25 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_26 = ((1.0 - clamp (
    exp2(-(fogInt_29))
  , 0.0, 1.0)) * r_25);
  highp float tmpvar_37;
  tmpvar_37 = min (f_26, _HeigtFogColBase.w);
  tmpvar_24 = tmpvar_37;
  HeightFogFactor_12 = tmpvar_24;
  highp vec3 tmpvar_38;
  tmpvar_38 = _Mihoyo_FogColor.xyz;
  heightFogColor_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((heightFogColor_11 * HeightFogFactor_12) + ((atomesphereFogColor_13 * tmpvar_19) * (1.0 - HeightFogFactor_12)));
  fogColor_10 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = ((1.0 - tmpvar_19) * (1.0 - HeightFogFactor_12));
  fogFactor_9 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = fogColor_10;
  tmpvar_41.w = fogFactor_9;
  tmpvar_8 = tmpvar_41;
  tmpvar_5 = tmpvar_8;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
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
  outColor_4.xyz = (xlv_COLOR1.xyz + (colorBlendLightMap_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_8;
  mediump float fogFactor_9;
  mediump vec3 fogColor_10;
  mediump vec3 heightFogColor_11;
  highp float HeightFogFactor_12;
  mediump vec3 atomesphereFogColor_13;
  mediump float h_14;
  highp float linearFogDensity_15;
  mediump float len_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((len_16 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_15 = (tmpvar_18 * (2.0 - tmpvar_18));
  if ((len_16 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_15 = (linearFogDensity_15 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_19;
  tmpvar_19 = min (pow (linearFogDensity_15, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_15 = tmpvar_19;
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_6.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  h_14 = (tmpvar_20 * (2.0 - tmpvar_20));
  highp vec3 tmpvar_22;
  tmpvar_22 = (_HeigtFogColBase.xyz + (h_14 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_13 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = mix (atomesphereFogColor_13, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_16 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_13 = tmpvar_23;
  mediump float tmpvar_24;
  mediump float r_25;
  mediump float f_26;
  mediump float u_27;
  mediump float l_28;
  mediump float fogInt_29;
  fogInt_29 = 1.0;
  highp float tmpvar_30;
  tmpvar_30 = (_HeigtFogParams.x * tmpvar_7.y);
  highp float tmpvar_31;
  tmpvar_31 = abs(tmpvar_30);
  if ((tmpvar_31 > 0.01)) {
    highp float tmpvar_32;
    tmpvar_32 = exp(-(tmpvar_30));
    fogInt_29 = ((1.0 - tmpvar_32) / tmpvar_30);
  };
  highp float tmpvar_33;
  tmpvar_33 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_28 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (l_28 * _HeigtFogParams.y);
  u_27 = tmpvar_34;
  fogInt_29 = (fogInt_29 * u_27);
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((l_28 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  r_25 = (tmpvar_35 * (2.0 - tmpvar_35));
  r_25 = ((r_25 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_26 = ((1.0 - clamp (
    exp2(-(fogInt_29))
  , 0.0, 1.0)) * r_25);
  highp float tmpvar_37;
  tmpvar_37 = min (f_26, _HeigtFogColBase.w);
  tmpvar_24 = tmpvar_37;
  HeightFogFactor_12 = tmpvar_24;
  highp vec3 tmpvar_38;
  tmpvar_38 = _Mihoyo_FogColor.xyz;
  heightFogColor_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((heightFogColor_11 * HeightFogFactor_12) + ((atomesphereFogColor_13 * tmpvar_19) * (1.0 - HeightFogFactor_12)));
  fogColor_10 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = ((1.0 - tmpvar_19) * (1.0 - HeightFogFactor_12));
  fogFactor_9 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = fogColor_10;
  tmpvar_41.w = fogFactor_9;
  tmpvar_8 = tmpvar_41;
  tmpvar_5 = tmpvar_8;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
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
  outColor_4.xyz = (xlv_COLOR1.xyz + (colorBlendLightMap_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_8;
  mediump float fogFactor_9;
  mediump vec3 fogColor_10;
  mediump vec3 heightFogColor_11;
  highp float HeightFogFactor_12;
  mediump vec3 atomesphereFogColor_13;
  mediump float h_14;
  highp float linearFogDensity_15;
  mediump float len_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((len_16 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_15 = (tmpvar_18 * (2.0 - tmpvar_18));
  if ((len_16 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_15 = (linearFogDensity_15 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_19;
  tmpvar_19 = min (pow (linearFogDensity_15, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_15 = tmpvar_19;
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_6.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  h_14 = (tmpvar_20 * (2.0 - tmpvar_20));
  highp vec3 tmpvar_22;
  tmpvar_22 = (_HeigtFogColBase2.xyz + (h_14 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_13 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = mix (atomesphereFogColor_13, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_16 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_13 = tmpvar_23;
  mediump float tmpvar_24;
  mediump float r_25;
  mediump float f_26;
  mediump float u_27;
  mediump float l_28;
  mediump float fogInt_29;
  fogInt_29 = 1.0;
  highp float tmpvar_30;
  tmpvar_30 = (_HeigtFogParams2.x * tmpvar_7.y);
  highp float tmpvar_31;
  tmpvar_31 = abs(tmpvar_30);
  if ((tmpvar_31 > 0.01)) {
    highp float tmpvar_32;
    tmpvar_32 = exp(-(tmpvar_30));
    fogInt_29 = ((1.0 - tmpvar_32) / tmpvar_30);
  };
  highp float tmpvar_33;
  tmpvar_33 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_28 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (l_28 * _HeigtFogParams2.y);
  u_27 = tmpvar_34;
  fogInt_29 = (fogInt_29 * u_27);
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((l_28 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  r_25 = (tmpvar_35 * (2.0 - tmpvar_35));
  r_25 = ((r_25 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_26 = ((1.0 - clamp (
    exp2(-(fogInt_29))
  , 0.0, 1.0)) * r_25);
  highp float tmpvar_37;
  tmpvar_37 = min (f_26, _HeigtFogColBase2.w);
  tmpvar_24 = tmpvar_37;
  HeightFogFactor_12 = tmpvar_24;
  highp vec3 tmpvar_38;
  tmpvar_38 = _Mihoyo_FogColor2.xyz;
  heightFogColor_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((heightFogColor_11 * HeightFogFactor_12) + ((atomesphereFogColor_13 * tmpvar_19) * (1.0 - HeightFogFactor_12)));
  fogColor_10 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = ((1.0 - tmpvar_19) * (1.0 - HeightFogFactor_12));
  fogFactor_9 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = fogColor_10;
  tmpvar_41.w = fogFactor_9;
  tmpvar_8 = tmpvar_41;
  highp vec4 tmpvar_42;
  mediump float fogFactor_43;
  mediump vec3 fogColor_44;
  mediump vec3 heightFogColor_45;
  highp float HeightFogFactor_46;
  mediump vec3 atomesphereFogColor_47;
  mediump float h_48;
  highp float linearFogDensity_49;
  mediump float len_50;
  highp float tmpvar_51;
  tmpvar_51 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_50 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (((len_50 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_49 = (tmpvar_52 * (2.0 - tmpvar_52));
  if ((len_50 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_49 = (linearFogDensity_49 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_53;
  tmpvar_53 = min (pow (linearFogDensity_49, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_49 = tmpvar_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_6.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  h_48 = (tmpvar_54 * (2.0 - tmpvar_54));
  highp vec3 tmpvar_56;
  tmpvar_56 = (_HeigtFogColBase3.xyz + (h_48 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_47 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = mix (atomesphereFogColor_47, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_50 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_47 = tmpvar_57;
  mediump float tmpvar_58;
  mediump float r_59;
  mediump float f_60;
  mediump float u_61;
  mediump float l_62;
  mediump float fogInt_63;
  fogInt_63 = 1.0;
  highp float tmpvar_64;
  tmpvar_64 = (_HeigtFogParams3.x * tmpvar_7.y);
  highp float tmpvar_65;
  tmpvar_65 = abs(tmpvar_64);
  if ((tmpvar_65 > 0.01)) {
    highp float tmpvar_66;
    tmpvar_66 = exp(-(tmpvar_64));
    fogInt_63 = ((1.0 - tmpvar_66) / tmpvar_64);
  };
  highp float tmpvar_67;
  tmpvar_67 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_62 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = (l_62 * _HeigtFogParams3.y);
  u_61 = tmpvar_68;
  fogInt_63 = (fogInt_63 * u_61);
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((l_62 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  r_59 = (tmpvar_69 * (2.0 - tmpvar_69));
  r_59 = ((r_59 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_60 = ((1.0 - clamp (
    exp2(-(fogInt_63))
  , 0.0, 1.0)) * r_59);
  highp float tmpvar_71;
  tmpvar_71 = min (f_60, _HeigtFogColBase3.w);
  tmpvar_58 = tmpvar_71;
  HeightFogFactor_46 = tmpvar_58;
  highp vec3 tmpvar_72;
  tmpvar_72 = _Mihoyo_FogColor3.xyz;
  heightFogColor_45 = tmpvar_72;
  highp vec3 tmpvar_73;
  tmpvar_73 = ((heightFogColor_45 * HeightFogFactor_46) + ((atomesphereFogColor_47 * tmpvar_53) * (1.0 - HeightFogFactor_46)));
  fogColor_44 = tmpvar_73;
  highp float tmpvar_74;
  tmpvar_74 = ((1.0 - tmpvar_53) * (1.0 - HeightFogFactor_46));
  fogFactor_43 = tmpvar_74;
  mediump vec4 tmpvar_75;
  tmpvar_75.xyz = fogColor_44;
  tmpvar_75.w = fogFactor_43;
  tmpvar_42 = tmpvar_75;
  highp vec4 tmpvar_76;
  tmpvar_76 = mix (tmpvar_8, tmpvar_42, vec4(_LerpFactor));
  tmpvar_5 = tmpvar_76;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
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
  outColor_4.xyz = (xlv_COLOR1.xyz + (colorBlendLightMap_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_8;
  mediump float fogFactor_9;
  mediump vec3 fogColor_10;
  mediump vec3 heightFogColor_11;
  highp float HeightFogFactor_12;
  mediump vec3 atomesphereFogColor_13;
  mediump float h_14;
  highp float linearFogDensity_15;
  mediump float len_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((len_16 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_15 = (tmpvar_18 * (2.0 - tmpvar_18));
  if ((len_16 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_15 = (linearFogDensity_15 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_19;
  tmpvar_19 = min (pow (linearFogDensity_15, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_15 = tmpvar_19;
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_6.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  h_14 = (tmpvar_20 * (2.0 - tmpvar_20));
  highp vec3 tmpvar_22;
  tmpvar_22 = (_HeigtFogColBase2.xyz + (h_14 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_13 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = mix (atomesphereFogColor_13, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_16 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_13 = tmpvar_23;
  mediump float tmpvar_24;
  mediump float r_25;
  mediump float f_26;
  mediump float u_27;
  mediump float l_28;
  mediump float fogInt_29;
  fogInt_29 = 1.0;
  highp float tmpvar_30;
  tmpvar_30 = (_HeigtFogParams2.x * tmpvar_7.y);
  highp float tmpvar_31;
  tmpvar_31 = abs(tmpvar_30);
  if ((tmpvar_31 > 0.01)) {
    highp float tmpvar_32;
    tmpvar_32 = exp(-(tmpvar_30));
    fogInt_29 = ((1.0 - tmpvar_32) / tmpvar_30);
  };
  highp float tmpvar_33;
  tmpvar_33 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_28 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (l_28 * _HeigtFogParams2.y);
  u_27 = tmpvar_34;
  fogInt_29 = (fogInt_29 * u_27);
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((l_28 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  r_25 = (tmpvar_35 * (2.0 - tmpvar_35));
  r_25 = ((r_25 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_26 = ((1.0 - clamp (
    exp2(-(fogInt_29))
  , 0.0, 1.0)) * r_25);
  highp float tmpvar_37;
  tmpvar_37 = min (f_26, _HeigtFogColBase2.w);
  tmpvar_24 = tmpvar_37;
  HeightFogFactor_12 = tmpvar_24;
  highp vec3 tmpvar_38;
  tmpvar_38 = _Mihoyo_FogColor2.xyz;
  heightFogColor_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((heightFogColor_11 * HeightFogFactor_12) + ((atomesphereFogColor_13 * tmpvar_19) * (1.0 - HeightFogFactor_12)));
  fogColor_10 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = ((1.0 - tmpvar_19) * (1.0 - HeightFogFactor_12));
  fogFactor_9 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = fogColor_10;
  tmpvar_41.w = fogFactor_9;
  tmpvar_8 = tmpvar_41;
  highp vec4 tmpvar_42;
  mediump float fogFactor_43;
  mediump vec3 fogColor_44;
  mediump vec3 heightFogColor_45;
  highp float HeightFogFactor_46;
  mediump vec3 atomesphereFogColor_47;
  mediump float h_48;
  highp float linearFogDensity_49;
  mediump float len_50;
  highp float tmpvar_51;
  tmpvar_51 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_50 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (((len_50 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_49 = (tmpvar_52 * (2.0 - tmpvar_52));
  if ((len_50 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_49 = (linearFogDensity_49 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_53;
  tmpvar_53 = min (pow (linearFogDensity_49, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_49 = tmpvar_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_6.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  h_48 = (tmpvar_54 * (2.0 - tmpvar_54));
  highp vec3 tmpvar_56;
  tmpvar_56 = (_HeigtFogColBase3.xyz + (h_48 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_47 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = mix (atomesphereFogColor_47, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_50 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_47 = tmpvar_57;
  mediump float tmpvar_58;
  mediump float r_59;
  mediump float f_60;
  mediump float u_61;
  mediump float l_62;
  mediump float fogInt_63;
  fogInt_63 = 1.0;
  highp float tmpvar_64;
  tmpvar_64 = (_HeigtFogParams3.x * tmpvar_7.y);
  highp float tmpvar_65;
  tmpvar_65 = abs(tmpvar_64);
  if ((tmpvar_65 > 0.01)) {
    highp float tmpvar_66;
    tmpvar_66 = exp(-(tmpvar_64));
    fogInt_63 = ((1.0 - tmpvar_66) / tmpvar_64);
  };
  highp float tmpvar_67;
  tmpvar_67 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_62 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = (l_62 * _HeigtFogParams3.y);
  u_61 = tmpvar_68;
  fogInt_63 = (fogInt_63 * u_61);
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((l_62 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  r_59 = (tmpvar_69 * (2.0 - tmpvar_69));
  r_59 = ((r_59 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_60 = ((1.0 - clamp (
    exp2(-(fogInt_63))
  , 0.0, 1.0)) * r_59);
  highp float tmpvar_71;
  tmpvar_71 = min (f_60, _HeigtFogColBase3.w);
  tmpvar_58 = tmpvar_71;
  HeightFogFactor_46 = tmpvar_58;
  highp vec3 tmpvar_72;
  tmpvar_72 = _Mihoyo_FogColor3.xyz;
  heightFogColor_45 = tmpvar_72;
  highp vec3 tmpvar_73;
  tmpvar_73 = ((heightFogColor_45 * HeightFogFactor_46) + ((atomesphereFogColor_47 * tmpvar_53) * (1.0 - HeightFogFactor_46)));
  fogColor_44 = tmpvar_73;
  highp float tmpvar_74;
  tmpvar_74 = ((1.0 - tmpvar_53) * (1.0 - HeightFogFactor_46));
  fogFactor_43 = tmpvar_74;
  mediump vec4 tmpvar_75;
  tmpvar_75.xyz = fogColor_44;
  tmpvar_75.w = fogFactor_43;
  tmpvar_42 = tmpvar_75;
  highp vec4 tmpvar_76;
  tmpvar_76 = mix (tmpvar_8, tmpvar_42, vec4(_LerpFactor));
  tmpvar_5 = tmpvar_76;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
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
  outColor_4.xyz = (xlv_COLOR1.xyz + (colorBlendLightMap_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_8;
  mediump float fogFactor_9;
  mediump vec3 fogColor_10;
  mediump vec3 heightFogColor_11;
  highp float HeightFogFactor_12;
  mediump vec3 atomesphereFogColor_13;
  mediump float h_14;
  highp float linearFogDensity_15;
  mediump float len_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_16 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = clamp (((len_16 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_15 = (tmpvar_18 * (2.0 - tmpvar_18));
  if ((len_16 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_15 = (linearFogDensity_15 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_19;
  tmpvar_19 = min (pow (linearFogDensity_15, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_15 = tmpvar_19;
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_6.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  h_14 = (tmpvar_20 * (2.0 - tmpvar_20));
  highp vec3 tmpvar_22;
  tmpvar_22 = (_HeigtFogColBase2.xyz + (h_14 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_13 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = mix (atomesphereFogColor_13, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_16 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_13 = tmpvar_23;
  mediump float tmpvar_24;
  mediump float r_25;
  mediump float f_26;
  mediump float u_27;
  mediump float l_28;
  mediump float fogInt_29;
  fogInt_29 = 1.0;
  highp float tmpvar_30;
  tmpvar_30 = (_HeigtFogParams2.x * tmpvar_7.y);
  highp float tmpvar_31;
  tmpvar_31 = abs(tmpvar_30);
  if ((tmpvar_31 > 0.01)) {
    highp float tmpvar_32;
    tmpvar_32 = exp(-(tmpvar_30));
    fogInt_29 = ((1.0 - tmpvar_32) / tmpvar_30);
  };
  highp float tmpvar_33;
  tmpvar_33 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_28 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (l_28 * _HeigtFogParams2.y);
  u_27 = tmpvar_34;
  fogInt_29 = (fogInt_29 * u_27);
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((l_28 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  r_25 = (tmpvar_35 * (2.0 - tmpvar_35));
  r_25 = ((r_25 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_26 = ((1.0 - clamp (
    exp2(-(fogInt_29))
  , 0.0, 1.0)) * r_25);
  highp float tmpvar_37;
  tmpvar_37 = min (f_26, _HeigtFogColBase2.w);
  tmpvar_24 = tmpvar_37;
  HeightFogFactor_12 = tmpvar_24;
  highp vec3 tmpvar_38;
  tmpvar_38 = _Mihoyo_FogColor2.xyz;
  heightFogColor_11 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = ((heightFogColor_11 * HeightFogFactor_12) + ((atomesphereFogColor_13 * tmpvar_19) * (1.0 - HeightFogFactor_12)));
  fogColor_10 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = ((1.0 - tmpvar_19) * (1.0 - HeightFogFactor_12));
  fogFactor_9 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = fogColor_10;
  tmpvar_41.w = fogFactor_9;
  tmpvar_8 = tmpvar_41;
  highp vec4 tmpvar_42;
  mediump float fogFactor_43;
  mediump vec3 fogColor_44;
  mediump vec3 heightFogColor_45;
  highp float HeightFogFactor_46;
  mediump vec3 atomesphereFogColor_47;
  mediump float h_48;
  highp float linearFogDensity_49;
  mediump float len_50;
  highp float tmpvar_51;
  tmpvar_51 = sqrt(dot (tmpvar_7, tmpvar_7));
  len_50 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (((len_50 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_49 = (tmpvar_52 * (2.0 - tmpvar_52));
  if ((len_50 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_49 = (linearFogDensity_49 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_53;
  tmpvar_53 = min (pow (linearFogDensity_49, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_49 = tmpvar_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_6.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  h_48 = (tmpvar_54 * (2.0 - tmpvar_54));
  highp vec3 tmpvar_56;
  tmpvar_56 = (_HeigtFogColBase3.xyz + (h_48 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_47 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = mix (atomesphereFogColor_47, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_50 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_47 = tmpvar_57;
  mediump float tmpvar_58;
  mediump float r_59;
  mediump float f_60;
  mediump float u_61;
  mediump float l_62;
  mediump float fogInt_63;
  fogInt_63 = 1.0;
  highp float tmpvar_64;
  tmpvar_64 = (_HeigtFogParams3.x * tmpvar_7.y);
  highp float tmpvar_65;
  tmpvar_65 = abs(tmpvar_64);
  if ((tmpvar_65 > 0.01)) {
    highp float tmpvar_66;
    tmpvar_66 = exp(-(tmpvar_64));
    fogInt_63 = ((1.0 - tmpvar_66) / tmpvar_64);
  };
  highp float tmpvar_67;
  tmpvar_67 = sqrt(dot (tmpvar_7, tmpvar_7));
  l_62 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = (l_62 * _HeigtFogParams3.y);
  u_61 = tmpvar_68;
  fogInt_63 = (fogInt_63 * u_61);
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((l_62 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  r_59 = (tmpvar_69 * (2.0 - tmpvar_69));
  r_59 = ((r_59 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_60 = ((1.0 - clamp (
    exp2(-(fogInt_63))
  , 0.0, 1.0)) * r_59);
  highp float tmpvar_71;
  tmpvar_71 = min (f_60, _HeigtFogColBase3.w);
  tmpvar_58 = tmpvar_71;
  HeightFogFactor_46 = tmpvar_58;
  highp vec3 tmpvar_72;
  tmpvar_72 = _Mihoyo_FogColor3.xyz;
  heightFogColor_45 = tmpvar_72;
  highp vec3 tmpvar_73;
  tmpvar_73 = ((heightFogColor_45 * HeightFogFactor_46) + ((atomesphereFogColor_47 * tmpvar_53) * (1.0 - HeightFogFactor_46)));
  fogColor_44 = tmpvar_73;
  highp float tmpvar_74;
  tmpvar_74 = ((1.0 - tmpvar_53) * (1.0 - HeightFogFactor_46));
  fogFactor_43 = tmpvar_74;
  mediump vec4 tmpvar_75;
  tmpvar_75.xyz = fogColor_44;
  tmpvar_75.w = fogFactor_43;
  tmpvar_42 = tmpvar_75;
  highp vec4 tmpvar_76;
  tmpvar_76 = mix (tmpvar_8, tmpvar_42, vec4(_LerpFactor));
  tmpvar_5 = tmpvar_76;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
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
  outColor_4.xyz = (xlv_COLOR1.xyz + (colorBlendLightMap_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
}