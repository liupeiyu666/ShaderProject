//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "hidden/Scene/Metal Floor(Single Mask)(without reflection)" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_ReflectMaskTex ("Reflect Mask Tex(R)", 2D) = "white" { }
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
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 50601
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_5 = tmpvar_14;
  mediump vec4 tmpvar_15;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_18)
      ) * (_FogIntensity * tmpvar_18))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_18)) * (_FogColorIntensity * tmpvar_18))
    ), 0.0, 1.0)));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_15 = fogColor_16;
  } else {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    highp float tmpvar_25;
    tmpvar_25 = (_FogEndDistance - _FogStartDistance);
    tmpvar_24 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
    , 0.0, 1.0))));
    fogColor_21.xyz = tmpvar_26;
    fogColor_21.w = tmpvar_24;
    tmpvar_15 = fogColor_21;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (diffColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = outColor_4;
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_5 = tmpvar_14;
  mediump vec4 tmpvar_15;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_18)
      ) * (_FogIntensity * tmpvar_18))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_18)) * (_FogColorIntensity * tmpvar_18))
    ), 0.0, 1.0)));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_15 = fogColor_16;
  } else {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    highp float tmpvar_25;
    tmpvar_25 = (_FogEndDistance - _FogStartDistance);
    tmpvar_24 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
    , 0.0, 1.0))));
    fogColor_21.xyz = tmpvar_26;
    fogColor_21.w = tmpvar_24;
    tmpvar_15 = fogColor_21;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (diffColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = outColor_4;
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
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_5 = tmpvar_14;
  mediump vec4 tmpvar_15;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_18)
      ) * (_FogIntensity * tmpvar_18))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_18)) * (_FogColorIntensity * tmpvar_18))
    ), 0.0, 1.0)));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_15 = fogColor_16;
  } else {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    highp float tmpvar_25;
    tmpvar_25 = (_FogEndDistance - _FogStartDistance);
    tmpvar_24 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
    , 0.0, 1.0))));
    fogColor_21.xyz = tmpvar_26;
    fogColor_21.w = tmpvar_24;
    tmpvar_15 = fogColor_21;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (diffColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_5 = tmpvar_14;
  mediump vec4 tmpvar_15;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_18)
      ) * (_FogIntensity * tmpvar_18))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_18)) * (_FogColorIntensity * tmpvar_18))
    ), 0.0, 1.0)));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_15 = fogColor_16;
  } else {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    highp float tmpvar_25;
    tmpvar_25 = (_FogEndDistance - _FogStartDistance);
    tmpvar_24 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
    , 0.0, 1.0))));
    fogColor_21.xyz = tmpvar_26;
    fogColor_21.w = tmpvar_24;
    tmpvar_15 = fogColor_21;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (diffColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_5 = tmpvar_14;
  mediump vec4 tmpvar_15;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_18)
      ) * (_FogIntensity * tmpvar_18))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_18)) * (_FogColorIntensity * tmpvar_18))
    ), 0.0, 1.0)));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_15 = fogColor_16;
  } else {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    highp float tmpvar_25;
    tmpvar_25 = (_FogEndDistance - _FogStartDistance);
    tmpvar_24 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
    , 0.0, 1.0))));
    fogColor_21.xyz = tmpvar_26;
    fogColor_21.w = tmpvar_24;
    tmpvar_15 = fogColor_21;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (diffColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_5 = tmpvar_14;
  mediump vec4 tmpvar_15;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_18)
      ) * (_FogIntensity * tmpvar_18))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_18)) * (_FogColorIntensity * tmpvar_18))
    ), 0.0, 1.0)));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_15 = fogColor_16;
  } else {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    highp float tmpvar_25;
    tmpvar_25 = (_FogEndDistance - _FogStartDistance);
    tmpvar_24 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
    , 0.0, 1.0))));
    fogColor_21.xyz = tmpvar_26;
    fogColor_21.w = tmpvar_24;
    tmpvar_15 = fogColor_21;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (diffColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_12 = tmpvar_13.xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
  mediump vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_18;
  mediump float fogFactor_19;
  mediump vec3 fogColor_20;
  mediump vec3 heightFogColor_21;
  highp float HeightFogFactor_22;
  mediump vec3 atomesphereFogColor_23;
  mediump float h_24;
  highp float linearFogDensity_25;
  mediump float len_26;
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((len_26 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_25 = (tmpvar_28 * (2.0 - tmpvar_28));
  if ((len_26 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_25 = (linearFogDensity_25 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_29;
  tmpvar_29 = min (pow (linearFogDensity_25, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_25 = tmpvar_29;
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((tmpvar_13.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  h_24 = (tmpvar_30 * (2.0 - tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = (_HeigtFogColBase.xyz + (h_24 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_23 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (atomesphereFogColor_23, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_26 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_23 = tmpvar_33;
  mediump float tmpvar_34;
  mediump float r_35;
  mediump float f_36;
  mediump float u_37;
  mediump float l_38;
  mediump float fogInt_39;
  fogInt_39 = 1.0;
  highp float tmpvar_40;
  tmpvar_40 = (_HeigtFogParams.x * tmpvar_17.y);
  highp float tmpvar_41;
  tmpvar_41 = abs(tmpvar_40);
  if ((tmpvar_41 > 0.01)) {
    highp float tmpvar_42;
    tmpvar_42 = exp(-(tmpvar_40));
    fogInt_39 = ((1.0 - tmpvar_42) / tmpvar_40);
  };
  highp float tmpvar_43;
  tmpvar_43 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_38 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (l_38 * _HeigtFogParams.y);
  u_37 = tmpvar_44;
  fogInt_39 = (fogInt_39 * u_37);
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((l_38 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  r_35 = (tmpvar_45 * (2.0 - tmpvar_45));
  r_35 = ((r_35 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_36 = ((1.0 - clamp (
    exp2(-(fogInt_39))
  , 0.0, 1.0)) * r_35);
  highp float tmpvar_47;
  tmpvar_47 = min (f_36, _HeigtFogColBase.w);
  tmpvar_34 = tmpvar_47;
  HeightFogFactor_22 = tmpvar_34;
  highp vec3 tmpvar_48;
  tmpvar_48 = _Mihoyo_FogColor.xyz;
  heightFogColor_21 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = ((heightFogColor_21 * HeightFogFactor_22) + ((atomesphereFogColor_23 * tmpvar_29) * (1.0 - HeightFogFactor_22)));
  fogColor_20 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = ((1.0 - tmpvar_29) * (1.0 - HeightFogFactor_22));
  fogFactor_19 = tmpvar_50;
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = fogColor_20;
  tmpvar_51.w = fogFactor_19;
  tmpvar_18 = tmpvar_51;
  tmpvar_16 = tmpvar_18;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = (xlv_COLOR1.xyz + (diffColor_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_12 = tmpvar_13.xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
  mediump vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_18;
  mediump float fogFactor_19;
  mediump vec3 fogColor_20;
  mediump vec3 heightFogColor_21;
  highp float HeightFogFactor_22;
  mediump vec3 atomesphereFogColor_23;
  mediump float h_24;
  highp float linearFogDensity_25;
  mediump float len_26;
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((len_26 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_25 = (tmpvar_28 * (2.0 - tmpvar_28));
  if ((len_26 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_25 = (linearFogDensity_25 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_29;
  tmpvar_29 = min (pow (linearFogDensity_25, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_25 = tmpvar_29;
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((tmpvar_13.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  h_24 = (tmpvar_30 * (2.0 - tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = (_HeigtFogColBase.xyz + (h_24 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_23 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (atomesphereFogColor_23, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_26 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_23 = tmpvar_33;
  mediump float tmpvar_34;
  mediump float r_35;
  mediump float f_36;
  mediump float u_37;
  mediump float l_38;
  mediump float fogInt_39;
  fogInt_39 = 1.0;
  highp float tmpvar_40;
  tmpvar_40 = (_HeigtFogParams.x * tmpvar_17.y);
  highp float tmpvar_41;
  tmpvar_41 = abs(tmpvar_40);
  if ((tmpvar_41 > 0.01)) {
    highp float tmpvar_42;
    tmpvar_42 = exp(-(tmpvar_40));
    fogInt_39 = ((1.0 - tmpvar_42) / tmpvar_40);
  };
  highp float tmpvar_43;
  tmpvar_43 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_38 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (l_38 * _HeigtFogParams.y);
  u_37 = tmpvar_44;
  fogInt_39 = (fogInt_39 * u_37);
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((l_38 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  r_35 = (tmpvar_45 * (2.0 - tmpvar_45));
  r_35 = ((r_35 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_36 = ((1.0 - clamp (
    exp2(-(fogInt_39))
  , 0.0, 1.0)) * r_35);
  highp float tmpvar_47;
  tmpvar_47 = min (f_36, _HeigtFogColBase.w);
  tmpvar_34 = tmpvar_47;
  HeightFogFactor_22 = tmpvar_34;
  highp vec3 tmpvar_48;
  tmpvar_48 = _Mihoyo_FogColor.xyz;
  heightFogColor_21 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = ((heightFogColor_21 * HeightFogFactor_22) + ((atomesphereFogColor_23 * tmpvar_29) * (1.0 - HeightFogFactor_22)));
  fogColor_20 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = ((1.0 - tmpvar_29) * (1.0 - HeightFogFactor_22));
  fogFactor_19 = tmpvar_50;
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = fogColor_20;
  tmpvar_51.w = fogFactor_19;
  tmpvar_18 = tmpvar_51;
  tmpvar_16 = tmpvar_18;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = (xlv_COLOR1.xyz + (diffColor_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_12 = tmpvar_13.xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
  mediump vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_18;
  mediump float fogFactor_19;
  mediump vec3 fogColor_20;
  mediump vec3 heightFogColor_21;
  highp float HeightFogFactor_22;
  mediump vec3 atomesphereFogColor_23;
  mediump float h_24;
  highp float linearFogDensity_25;
  mediump float len_26;
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((len_26 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_25 = (tmpvar_28 * (2.0 - tmpvar_28));
  if ((len_26 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_25 = (linearFogDensity_25 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_29;
  tmpvar_29 = min (pow (linearFogDensity_25, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_25 = tmpvar_29;
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((tmpvar_13.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  h_24 = (tmpvar_30 * (2.0 - tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = (_HeigtFogColBase.xyz + (h_24 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_23 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (atomesphereFogColor_23, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_26 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_23 = tmpvar_33;
  mediump float tmpvar_34;
  mediump float r_35;
  mediump float f_36;
  mediump float u_37;
  mediump float l_38;
  mediump float fogInt_39;
  fogInt_39 = 1.0;
  highp float tmpvar_40;
  tmpvar_40 = (_HeigtFogParams.x * tmpvar_17.y);
  highp float tmpvar_41;
  tmpvar_41 = abs(tmpvar_40);
  if ((tmpvar_41 > 0.01)) {
    highp float tmpvar_42;
    tmpvar_42 = exp(-(tmpvar_40));
    fogInt_39 = ((1.0 - tmpvar_42) / tmpvar_40);
  };
  highp float tmpvar_43;
  tmpvar_43 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_38 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (l_38 * _HeigtFogParams.y);
  u_37 = tmpvar_44;
  fogInt_39 = (fogInt_39 * u_37);
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((l_38 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  r_35 = (tmpvar_45 * (2.0 - tmpvar_45));
  r_35 = ((r_35 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_36 = ((1.0 - clamp (
    exp2(-(fogInt_39))
  , 0.0, 1.0)) * r_35);
  highp float tmpvar_47;
  tmpvar_47 = min (f_36, _HeigtFogColBase.w);
  tmpvar_34 = tmpvar_47;
  HeightFogFactor_22 = tmpvar_34;
  highp vec3 tmpvar_48;
  tmpvar_48 = _Mihoyo_FogColor.xyz;
  heightFogColor_21 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = ((heightFogColor_21 * HeightFogFactor_22) + ((atomesphereFogColor_23 * tmpvar_29) * (1.0 - HeightFogFactor_22)));
  fogColor_20 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = ((1.0 - tmpvar_29) * (1.0 - HeightFogFactor_22));
  fogFactor_19 = tmpvar_50;
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = fogColor_20;
  tmpvar_51.w = fogFactor_19;
  tmpvar_18 = tmpvar_51;
  tmpvar_16 = tmpvar_18;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = (xlv_COLOR1.xyz + (diffColor_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_12 = tmpvar_13.xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
  mediump vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_18;
  mediump float fogFactor_19;
  mediump vec3 fogColor_20;
  mediump vec3 heightFogColor_21;
  highp float HeightFogFactor_22;
  mediump vec3 atomesphereFogColor_23;
  mediump float h_24;
  highp float linearFogDensity_25;
  mediump float len_26;
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((len_26 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_25 = (tmpvar_28 * (2.0 - tmpvar_28));
  if ((len_26 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_25 = (linearFogDensity_25 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_29;
  tmpvar_29 = min (pow (linearFogDensity_25, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_25 = tmpvar_29;
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((tmpvar_13.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  h_24 = (tmpvar_30 * (2.0 - tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = (_HeigtFogColBase2.xyz + (h_24 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_23 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (atomesphereFogColor_23, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_26 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_23 = tmpvar_33;
  mediump float tmpvar_34;
  mediump float r_35;
  mediump float f_36;
  mediump float u_37;
  mediump float l_38;
  mediump float fogInt_39;
  fogInt_39 = 1.0;
  highp float tmpvar_40;
  tmpvar_40 = (_HeigtFogParams2.x * tmpvar_17.y);
  highp float tmpvar_41;
  tmpvar_41 = abs(tmpvar_40);
  if ((tmpvar_41 > 0.01)) {
    highp float tmpvar_42;
    tmpvar_42 = exp(-(tmpvar_40));
    fogInt_39 = ((1.0 - tmpvar_42) / tmpvar_40);
  };
  highp float tmpvar_43;
  tmpvar_43 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_38 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (l_38 * _HeigtFogParams2.y);
  u_37 = tmpvar_44;
  fogInt_39 = (fogInt_39 * u_37);
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((l_38 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  r_35 = (tmpvar_45 * (2.0 - tmpvar_45));
  r_35 = ((r_35 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_36 = ((1.0 - clamp (
    exp2(-(fogInt_39))
  , 0.0, 1.0)) * r_35);
  highp float tmpvar_47;
  tmpvar_47 = min (f_36, _HeigtFogColBase2.w);
  tmpvar_34 = tmpvar_47;
  HeightFogFactor_22 = tmpvar_34;
  highp vec3 tmpvar_48;
  tmpvar_48 = _Mihoyo_FogColor2.xyz;
  heightFogColor_21 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = ((heightFogColor_21 * HeightFogFactor_22) + ((atomesphereFogColor_23 * tmpvar_29) * (1.0 - HeightFogFactor_22)));
  fogColor_20 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = ((1.0 - tmpvar_29) * (1.0 - HeightFogFactor_22));
  fogFactor_19 = tmpvar_50;
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = fogColor_20;
  tmpvar_51.w = fogFactor_19;
  tmpvar_18 = tmpvar_51;
  highp vec4 tmpvar_52;
  mediump float fogFactor_53;
  mediump vec3 fogColor_54;
  mediump vec3 heightFogColor_55;
  highp float HeightFogFactor_56;
  mediump vec3 atomesphereFogColor_57;
  mediump float h_58;
  highp float linearFogDensity_59;
  mediump float len_60;
  highp float tmpvar_61;
  tmpvar_61 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((len_60 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_59 = (tmpvar_62 * (2.0 - tmpvar_62));
  if ((len_60 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_59 = (linearFogDensity_59 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_63;
  tmpvar_63 = min (pow (linearFogDensity_59, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_59 = tmpvar_63;
  mediump float tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((tmpvar_13.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_64 = tmpvar_65;
  h_58 = (tmpvar_64 * (2.0 - tmpvar_64));
  highp vec3 tmpvar_66;
  tmpvar_66 = (_HeigtFogColBase3.xyz + (h_58 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_57 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (atomesphereFogColor_57, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_60 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_57 = tmpvar_67;
  mediump float tmpvar_68;
  mediump float r_69;
  mediump float f_70;
  mediump float u_71;
  mediump float l_72;
  mediump float fogInt_73;
  fogInt_73 = 1.0;
  highp float tmpvar_74;
  tmpvar_74 = (_HeigtFogParams3.x * tmpvar_17.y);
  highp float tmpvar_75;
  tmpvar_75 = abs(tmpvar_74);
  if ((tmpvar_75 > 0.01)) {
    highp float tmpvar_76;
    tmpvar_76 = exp(-(tmpvar_74));
    fogInt_73 = ((1.0 - tmpvar_76) / tmpvar_74);
  };
  highp float tmpvar_77;
  tmpvar_77 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_72 = tmpvar_77;
  highp float tmpvar_78;
  tmpvar_78 = (l_72 * _HeigtFogParams3.y);
  u_71 = tmpvar_78;
  fogInt_73 = (fogInt_73 * u_71);
  mediump float tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = clamp (((l_72 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_79 = tmpvar_80;
  r_69 = (tmpvar_79 * (2.0 - tmpvar_79));
  r_69 = ((r_69 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_70 = ((1.0 - clamp (
    exp2(-(fogInt_73))
  , 0.0, 1.0)) * r_69);
  highp float tmpvar_81;
  tmpvar_81 = min (f_70, _HeigtFogColBase3.w);
  tmpvar_68 = tmpvar_81;
  HeightFogFactor_56 = tmpvar_68;
  highp vec3 tmpvar_82;
  tmpvar_82 = _Mihoyo_FogColor3.xyz;
  heightFogColor_55 = tmpvar_82;
  highp vec3 tmpvar_83;
  tmpvar_83 = ((heightFogColor_55 * HeightFogFactor_56) + ((atomesphereFogColor_57 * tmpvar_63) * (1.0 - HeightFogFactor_56)));
  fogColor_54 = tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = ((1.0 - tmpvar_63) * (1.0 - HeightFogFactor_56));
  fogFactor_53 = tmpvar_84;
  mediump vec4 tmpvar_85;
  tmpvar_85.xyz = fogColor_54;
  tmpvar_85.w = fogFactor_53;
  tmpvar_52 = tmpvar_85;
  highp vec4 tmpvar_86;
  tmpvar_86 = mix (tmpvar_18, tmpvar_52, vec4(_LerpFactor));
  tmpvar_16 = tmpvar_86;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = (xlv_COLOR1.xyz + (diffColor_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_12 = tmpvar_13.xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
  mediump vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_18;
  mediump float fogFactor_19;
  mediump vec3 fogColor_20;
  mediump vec3 heightFogColor_21;
  highp float HeightFogFactor_22;
  mediump vec3 atomesphereFogColor_23;
  mediump float h_24;
  highp float linearFogDensity_25;
  mediump float len_26;
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((len_26 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_25 = (tmpvar_28 * (2.0 - tmpvar_28));
  if ((len_26 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_25 = (linearFogDensity_25 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_29;
  tmpvar_29 = min (pow (linearFogDensity_25, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_25 = tmpvar_29;
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((tmpvar_13.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  h_24 = (tmpvar_30 * (2.0 - tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = (_HeigtFogColBase2.xyz + (h_24 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_23 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (atomesphereFogColor_23, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_26 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_23 = tmpvar_33;
  mediump float tmpvar_34;
  mediump float r_35;
  mediump float f_36;
  mediump float u_37;
  mediump float l_38;
  mediump float fogInt_39;
  fogInt_39 = 1.0;
  highp float tmpvar_40;
  tmpvar_40 = (_HeigtFogParams2.x * tmpvar_17.y);
  highp float tmpvar_41;
  tmpvar_41 = abs(tmpvar_40);
  if ((tmpvar_41 > 0.01)) {
    highp float tmpvar_42;
    tmpvar_42 = exp(-(tmpvar_40));
    fogInt_39 = ((1.0 - tmpvar_42) / tmpvar_40);
  };
  highp float tmpvar_43;
  tmpvar_43 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_38 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (l_38 * _HeigtFogParams2.y);
  u_37 = tmpvar_44;
  fogInt_39 = (fogInt_39 * u_37);
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((l_38 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  r_35 = (tmpvar_45 * (2.0 - tmpvar_45));
  r_35 = ((r_35 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_36 = ((1.0 - clamp (
    exp2(-(fogInt_39))
  , 0.0, 1.0)) * r_35);
  highp float tmpvar_47;
  tmpvar_47 = min (f_36, _HeigtFogColBase2.w);
  tmpvar_34 = tmpvar_47;
  HeightFogFactor_22 = tmpvar_34;
  highp vec3 tmpvar_48;
  tmpvar_48 = _Mihoyo_FogColor2.xyz;
  heightFogColor_21 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = ((heightFogColor_21 * HeightFogFactor_22) + ((atomesphereFogColor_23 * tmpvar_29) * (1.0 - HeightFogFactor_22)));
  fogColor_20 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = ((1.0 - tmpvar_29) * (1.0 - HeightFogFactor_22));
  fogFactor_19 = tmpvar_50;
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = fogColor_20;
  tmpvar_51.w = fogFactor_19;
  tmpvar_18 = tmpvar_51;
  highp vec4 tmpvar_52;
  mediump float fogFactor_53;
  mediump vec3 fogColor_54;
  mediump vec3 heightFogColor_55;
  highp float HeightFogFactor_56;
  mediump vec3 atomesphereFogColor_57;
  mediump float h_58;
  highp float linearFogDensity_59;
  mediump float len_60;
  highp float tmpvar_61;
  tmpvar_61 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((len_60 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_59 = (tmpvar_62 * (2.0 - tmpvar_62));
  if ((len_60 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_59 = (linearFogDensity_59 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_63;
  tmpvar_63 = min (pow (linearFogDensity_59, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_59 = tmpvar_63;
  mediump float tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((tmpvar_13.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_64 = tmpvar_65;
  h_58 = (tmpvar_64 * (2.0 - tmpvar_64));
  highp vec3 tmpvar_66;
  tmpvar_66 = (_HeigtFogColBase3.xyz + (h_58 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_57 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (atomesphereFogColor_57, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_60 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_57 = tmpvar_67;
  mediump float tmpvar_68;
  mediump float r_69;
  mediump float f_70;
  mediump float u_71;
  mediump float l_72;
  mediump float fogInt_73;
  fogInt_73 = 1.0;
  highp float tmpvar_74;
  tmpvar_74 = (_HeigtFogParams3.x * tmpvar_17.y);
  highp float tmpvar_75;
  tmpvar_75 = abs(tmpvar_74);
  if ((tmpvar_75 > 0.01)) {
    highp float tmpvar_76;
    tmpvar_76 = exp(-(tmpvar_74));
    fogInt_73 = ((1.0 - tmpvar_76) / tmpvar_74);
  };
  highp float tmpvar_77;
  tmpvar_77 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_72 = tmpvar_77;
  highp float tmpvar_78;
  tmpvar_78 = (l_72 * _HeigtFogParams3.y);
  u_71 = tmpvar_78;
  fogInt_73 = (fogInt_73 * u_71);
  mediump float tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = clamp (((l_72 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_79 = tmpvar_80;
  r_69 = (tmpvar_79 * (2.0 - tmpvar_79));
  r_69 = ((r_69 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_70 = ((1.0 - clamp (
    exp2(-(fogInt_73))
  , 0.0, 1.0)) * r_69);
  highp float tmpvar_81;
  tmpvar_81 = min (f_70, _HeigtFogColBase3.w);
  tmpvar_68 = tmpvar_81;
  HeightFogFactor_56 = tmpvar_68;
  highp vec3 tmpvar_82;
  tmpvar_82 = _Mihoyo_FogColor3.xyz;
  heightFogColor_55 = tmpvar_82;
  highp vec3 tmpvar_83;
  tmpvar_83 = ((heightFogColor_55 * HeightFogFactor_56) + ((atomesphereFogColor_57 * tmpvar_63) * (1.0 - HeightFogFactor_56)));
  fogColor_54 = tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = ((1.0 - tmpvar_63) * (1.0 - HeightFogFactor_56));
  fogFactor_53 = tmpvar_84;
  mediump vec4 tmpvar_85;
  tmpvar_85.xyz = fogColor_54;
  tmpvar_85.w = fogFactor_53;
  tmpvar_52 = tmpvar_85;
  highp vec4 tmpvar_86;
  tmpvar_86 = mix (tmpvar_18, tmpvar_52, vec4(_LerpFactor));
  tmpvar_16 = tmpvar_86;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = (xlv_COLOR1.xyz + (diffColor_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_12 = tmpvar_13.xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
  mediump vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_18;
  mediump float fogFactor_19;
  mediump vec3 fogColor_20;
  mediump vec3 heightFogColor_21;
  highp float HeightFogFactor_22;
  mediump vec3 atomesphereFogColor_23;
  mediump float h_24;
  highp float linearFogDensity_25;
  mediump float len_26;
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((len_26 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_25 = (tmpvar_28 * (2.0 - tmpvar_28));
  if ((len_26 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_25 = (linearFogDensity_25 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_29;
  tmpvar_29 = min (pow (linearFogDensity_25, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_25 = tmpvar_29;
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((tmpvar_13.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  h_24 = (tmpvar_30 * (2.0 - tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = (_HeigtFogColBase2.xyz + (h_24 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_23 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (atomesphereFogColor_23, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_26 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_23 = tmpvar_33;
  mediump float tmpvar_34;
  mediump float r_35;
  mediump float f_36;
  mediump float u_37;
  mediump float l_38;
  mediump float fogInt_39;
  fogInt_39 = 1.0;
  highp float tmpvar_40;
  tmpvar_40 = (_HeigtFogParams2.x * tmpvar_17.y);
  highp float tmpvar_41;
  tmpvar_41 = abs(tmpvar_40);
  if ((tmpvar_41 > 0.01)) {
    highp float tmpvar_42;
    tmpvar_42 = exp(-(tmpvar_40));
    fogInt_39 = ((1.0 - tmpvar_42) / tmpvar_40);
  };
  highp float tmpvar_43;
  tmpvar_43 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_38 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (l_38 * _HeigtFogParams2.y);
  u_37 = tmpvar_44;
  fogInt_39 = (fogInt_39 * u_37);
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((l_38 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  r_35 = (tmpvar_45 * (2.0 - tmpvar_45));
  r_35 = ((r_35 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_36 = ((1.0 - clamp (
    exp2(-(fogInt_39))
  , 0.0, 1.0)) * r_35);
  highp float tmpvar_47;
  tmpvar_47 = min (f_36, _HeigtFogColBase2.w);
  tmpvar_34 = tmpvar_47;
  HeightFogFactor_22 = tmpvar_34;
  highp vec3 tmpvar_48;
  tmpvar_48 = _Mihoyo_FogColor2.xyz;
  heightFogColor_21 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = ((heightFogColor_21 * HeightFogFactor_22) + ((atomesphereFogColor_23 * tmpvar_29) * (1.0 - HeightFogFactor_22)));
  fogColor_20 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = ((1.0 - tmpvar_29) * (1.0 - HeightFogFactor_22));
  fogFactor_19 = tmpvar_50;
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = fogColor_20;
  tmpvar_51.w = fogFactor_19;
  tmpvar_18 = tmpvar_51;
  highp vec4 tmpvar_52;
  mediump float fogFactor_53;
  mediump vec3 fogColor_54;
  mediump vec3 heightFogColor_55;
  highp float HeightFogFactor_56;
  mediump vec3 atomesphereFogColor_57;
  mediump float h_58;
  highp float linearFogDensity_59;
  mediump float len_60;
  highp float tmpvar_61;
  tmpvar_61 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((len_60 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_59 = (tmpvar_62 * (2.0 - tmpvar_62));
  if ((len_60 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_59 = (linearFogDensity_59 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_63;
  tmpvar_63 = min (pow (linearFogDensity_59, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_59 = tmpvar_63;
  mediump float tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((tmpvar_13.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_64 = tmpvar_65;
  h_58 = (tmpvar_64 * (2.0 - tmpvar_64));
  highp vec3 tmpvar_66;
  tmpvar_66 = (_HeigtFogColBase3.xyz + (h_58 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_57 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (atomesphereFogColor_57, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_60 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_57 = tmpvar_67;
  mediump float tmpvar_68;
  mediump float r_69;
  mediump float f_70;
  mediump float u_71;
  mediump float l_72;
  mediump float fogInt_73;
  fogInt_73 = 1.0;
  highp float tmpvar_74;
  tmpvar_74 = (_HeigtFogParams3.x * tmpvar_17.y);
  highp float tmpvar_75;
  tmpvar_75 = abs(tmpvar_74);
  if ((tmpvar_75 > 0.01)) {
    highp float tmpvar_76;
    tmpvar_76 = exp(-(tmpvar_74));
    fogInt_73 = ((1.0 - tmpvar_76) / tmpvar_74);
  };
  highp float tmpvar_77;
  tmpvar_77 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_72 = tmpvar_77;
  highp float tmpvar_78;
  tmpvar_78 = (l_72 * _HeigtFogParams3.y);
  u_71 = tmpvar_78;
  fogInt_73 = (fogInt_73 * u_71);
  mediump float tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = clamp (((l_72 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_79 = tmpvar_80;
  r_69 = (tmpvar_79 * (2.0 - tmpvar_79));
  r_69 = ((r_69 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_70 = ((1.0 - clamp (
    exp2(-(fogInt_73))
  , 0.0, 1.0)) * r_69);
  highp float tmpvar_81;
  tmpvar_81 = min (f_70, _HeigtFogColBase3.w);
  tmpvar_68 = tmpvar_81;
  HeightFogFactor_56 = tmpvar_68;
  highp vec3 tmpvar_82;
  tmpvar_82 = _Mihoyo_FogColor3.xyz;
  heightFogColor_55 = tmpvar_82;
  highp vec3 tmpvar_83;
  tmpvar_83 = ((heightFogColor_55 * HeightFogFactor_56) + ((atomesphereFogColor_57 * tmpvar_63) * (1.0 - HeightFogFactor_56)));
  fogColor_54 = tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = ((1.0 - tmpvar_63) * (1.0 - HeightFogFactor_56));
  fogFactor_53 = tmpvar_84;
  mediump vec4 tmpvar_85;
  tmpvar_85.xyz = fogColor_54;
  tmpvar_85.w = fogFactor_53;
  tmpvar_52 = tmpvar_85;
  highp vec4 tmpvar_86;
  tmpvar_86 = mix (tmpvar_18, tmpvar_52, vec4(_LerpFactor));
  tmpvar_16 = tmpvar_86;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = (xlv_COLOR1.xyz + (diffColor_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_5 = tmpvar_14;
  mediump vec4 tmpvar_15;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_18)
      ) * (_FogIntensity * tmpvar_18))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_18)) * (_FogColorIntensity * tmpvar_18))
    ), 0.0, 1.0)));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_15 = fogColor_16;
  } else {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    highp float tmpvar_25;
    tmpvar_25 = (_FogEndDistance - _FogStartDistance);
    tmpvar_24 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
    , 0.0, 1.0))));
    fogColor_21.xyz = tmpvar_26;
    fogColor_21.w = tmpvar_24;
    tmpvar_15 = fogColor_21;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (diffColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_5 = tmpvar_14;
  mediump vec4 tmpvar_15;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_18)
      ) * (_FogIntensity * tmpvar_18))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_18)) * (_FogColorIntensity * tmpvar_18))
    ), 0.0, 1.0)));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_15 = fogColor_16;
  } else {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    highp float tmpvar_25;
    tmpvar_25 = (_FogEndDistance - _FogStartDistance);
    tmpvar_24 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
    , 0.0, 1.0))));
    fogColor_21.xyz = tmpvar_26;
    fogColor_21.w = tmpvar_24;
    tmpvar_15 = fogColor_21;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (diffColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_5 = tmpvar_14;
  mediump vec4 tmpvar_15;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_18)
      ) * (_FogIntensity * tmpvar_18))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_18)) * (_FogColorIntensity * tmpvar_18))
    ), 0.0, 1.0)));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_15 = fogColor_16;
  } else {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    highp float tmpvar_25;
    tmpvar_25 = (_FogEndDistance - _FogStartDistance);
    tmpvar_24 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
    , 0.0, 1.0))));
    fogColor_21.xyz = tmpvar_26;
    fogColor_21.w = tmpvar_24;
    tmpvar_15 = fogColor_21;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (diffColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_5 = tmpvar_14;
  mediump vec4 tmpvar_15;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_18)
      ) * (_FogIntensity * tmpvar_18))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_18)) * (_FogColorIntensity * tmpvar_18))
    ), 0.0, 1.0)));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_15 = fogColor_16;
  } else {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    highp float tmpvar_25;
    tmpvar_25 = (_FogEndDistance - _FogStartDistance);
    tmpvar_24 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
    , 0.0, 1.0))));
    fogColor_21.xyz = tmpvar_26;
    fogColor_21.w = tmpvar_24;
    tmpvar_15 = fogColor_21;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (diffColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_5 = tmpvar_14;
  mediump vec4 tmpvar_15;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_18)
      ) * (_FogIntensity * tmpvar_18))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_18)) * (_FogColorIntensity * tmpvar_18))
    ), 0.0, 1.0)));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_15 = fogColor_16;
  } else {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    highp float tmpvar_25;
    tmpvar_25 = (_FogEndDistance - _FogStartDistance);
    tmpvar_24 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
    , 0.0, 1.0))));
    fogColor_21.xyz = tmpvar_26;
    fogColor_21.w = tmpvar_24;
    tmpvar_15 = fogColor_21;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (diffColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_5 = tmpvar_14;
  mediump vec4 tmpvar_15;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_18)
      ) * (_FogIntensity * tmpvar_18))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_18)) * (_FogColorIntensity * tmpvar_18))
    ), 0.0, 1.0)));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_15 = fogColor_16;
  } else {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    highp float tmpvar_25;
    tmpvar_25 = (_FogEndDistance - _FogStartDistance);
    tmpvar_24 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_23) / max (0.1, tmpvar_25))
    , 0.0, 1.0))));
    fogColor_21.xyz = tmpvar_26;
    fogColor_21.w = tmpvar_24;
    tmpvar_15 = fogColor_21;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (diffColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_12 = tmpvar_13.xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
  mediump vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_18;
  mediump float fogFactor_19;
  mediump vec3 fogColor_20;
  mediump vec3 heightFogColor_21;
  highp float HeightFogFactor_22;
  mediump vec3 atomesphereFogColor_23;
  mediump float h_24;
  highp float linearFogDensity_25;
  mediump float len_26;
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((len_26 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_25 = (tmpvar_28 * (2.0 - tmpvar_28));
  if ((len_26 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_25 = (linearFogDensity_25 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_29;
  tmpvar_29 = min (pow (linearFogDensity_25, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_25 = tmpvar_29;
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((tmpvar_13.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  h_24 = (tmpvar_30 * (2.0 - tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = (_HeigtFogColBase.xyz + (h_24 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_23 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (atomesphereFogColor_23, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_26 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_23 = tmpvar_33;
  mediump float tmpvar_34;
  mediump float r_35;
  mediump float f_36;
  mediump float u_37;
  mediump float l_38;
  mediump float fogInt_39;
  fogInt_39 = 1.0;
  highp float tmpvar_40;
  tmpvar_40 = (_HeigtFogParams.x * tmpvar_17.y);
  highp float tmpvar_41;
  tmpvar_41 = abs(tmpvar_40);
  if ((tmpvar_41 > 0.01)) {
    highp float tmpvar_42;
    tmpvar_42 = exp(-(tmpvar_40));
    fogInt_39 = ((1.0 - tmpvar_42) / tmpvar_40);
  };
  highp float tmpvar_43;
  tmpvar_43 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_38 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (l_38 * _HeigtFogParams.y);
  u_37 = tmpvar_44;
  fogInt_39 = (fogInt_39 * u_37);
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((l_38 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  r_35 = (tmpvar_45 * (2.0 - tmpvar_45));
  r_35 = ((r_35 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_36 = ((1.0 - clamp (
    exp2(-(fogInt_39))
  , 0.0, 1.0)) * r_35);
  highp float tmpvar_47;
  tmpvar_47 = min (f_36, _HeigtFogColBase.w);
  tmpvar_34 = tmpvar_47;
  HeightFogFactor_22 = tmpvar_34;
  highp vec3 tmpvar_48;
  tmpvar_48 = _Mihoyo_FogColor.xyz;
  heightFogColor_21 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = ((heightFogColor_21 * HeightFogFactor_22) + ((atomesphereFogColor_23 * tmpvar_29) * (1.0 - HeightFogFactor_22)));
  fogColor_20 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = ((1.0 - tmpvar_29) * (1.0 - HeightFogFactor_22));
  fogFactor_19 = tmpvar_50;
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = fogColor_20;
  tmpvar_51.w = fogFactor_19;
  tmpvar_18 = tmpvar_51;
  tmpvar_16 = tmpvar_18;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = (xlv_COLOR1.xyz + (diffColor_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_12 = tmpvar_13.xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
  mediump vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_18;
  mediump float fogFactor_19;
  mediump vec3 fogColor_20;
  mediump vec3 heightFogColor_21;
  highp float HeightFogFactor_22;
  mediump vec3 atomesphereFogColor_23;
  mediump float h_24;
  highp float linearFogDensity_25;
  mediump float len_26;
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((len_26 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_25 = (tmpvar_28 * (2.0 - tmpvar_28));
  if ((len_26 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_25 = (linearFogDensity_25 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_29;
  tmpvar_29 = min (pow (linearFogDensity_25, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_25 = tmpvar_29;
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((tmpvar_13.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  h_24 = (tmpvar_30 * (2.0 - tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = (_HeigtFogColBase.xyz + (h_24 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_23 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (atomesphereFogColor_23, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_26 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_23 = tmpvar_33;
  mediump float tmpvar_34;
  mediump float r_35;
  mediump float f_36;
  mediump float u_37;
  mediump float l_38;
  mediump float fogInt_39;
  fogInt_39 = 1.0;
  highp float tmpvar_40;
  tmpvar_40 = (_HeigtFogParams.x * tmpvar_17.y);
  highp float tmpvar_41;
  tmpvar_41 = abs(tmpvar_40);
  if ((tmpvar_41 > 0.01)) {
    highp float tmpvar_42;
    tmpvar_42 = exp(-(tmpvar_40));
    fogInt_39 = ((1.0 - tmpvar_42) / tmpvar_40);
  };
  highp float tmpvar_43;
  tmpvar_43 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_38 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (l_38 * _HeigtFogParams.y);
  u_37 = tmpvar_44;
  fogInt_39 = (fogInt_39 * u_37);
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((l_38 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  r_35 = (tmpvar_45 * (2.0 - tmpvar_45));
  r_35 = ((r_35 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_36 = ((1.0 - clamp (
    exp2(-(fogInt_39))
  , 0.0, 1.0)) * r_35);
  highp float tmpvar_47;
  tmpvar_47 = min (f_36, _HeigtFogColBase.w);
  tmpvar_34 = tmpvar_47;
  HeightFogFactor_22 = tmpvar_34;
  highp vec3 tmpvar_48;
  tmpvar_48 = _Mihoyo_FogColor.xyz;
  heightFogColor_21 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = ((heightFogColor_21 * HeightFogFactor_22) + ((atomesphereFogColor_23 * tmpvar_29) * (1.0 - HeightFogFactor_22)));
  fogColor_20 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = ((1.0 - tmpvar_29) * (1.0 - HeightFogFactor_22));
  fogFactor_19 = tmpvar_50;
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = fogColor_20;
  tmpvar_51.w = fogFactor_19;
  tmpvar_18 = tmpvar_51;
  tmpvar_16 = tmpvar_18;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = (xlv_COLOR1.xyz + (diffColor_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_12 = tmpvar_13.xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
  mediump vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_18;
  mediump float fogFactor_19;
  mediump vec3 fogColor_20;
  mediump vec3 heightFogColor_21;
  highp float HeightFogFactor_22;
  mediump vec3 atomesphereFogColor_23;
  mediump float h_24;
  highp float linearFogDensity_25;
  mediump float len_26;
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((len_26 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_25 = (tmpvar_28 * (2.0 - tmpvar_28));
  if ((len_26 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_25 = (linearFogDensity_25 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_29;
  tmpvar_29 = min (pow (linearFogDensity_25, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_25 = tmpvar_29;
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((tmpvar_13.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  h_24 = (tmpvar_30 * (2.0 - tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = (_HeigtFogColBase.xyz + (h_24 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_23 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (atomesphereFogColor_23, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_26 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_23 = tmpvar_33;
  mediump float tmpvar_34;
  mediump float r_35;
  mediump float f_36;
  mediump float u_37;
  mediump float l_38;
  mediump float fogInt_39;
  fogInt_39 = 1.0;
  highp float tmpvar_40;
  tmpvar_40 = (_HeigtFogParams.x * tmpvar_17.y);
  highp float tmpvar_41;
  tmpvar_41 = abs(tmpvar_40);
  if ((tmpvar_41 > 0.01)) {
    highp float tmpvar_42;
    tmpvar_42 = exp(-(tmpvar_40));
    fogInt_39 = ((1.0 - tmpvar_42) / tmpvar_40);
  };
  highp float tmpvar_43;
  tmpvar_43 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_38 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (l_38 * _HeigtFogParams.y);
  u_37 = tmpvar_44;
  fogInt_39 = (fogInt_39 * u_37);
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((l_38 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  r_35 = (tmpvar_45 * (2.0 - tmpvar_45));
  r_35 = ((r_35 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_36 = ((1.0 - clamp (
    exp2(-(fogInt_39))
  , 0.0, 1.0)) * r_35);
  highp float tmpvar_47;
  tmpvar_47 = min (f_36, _HeigtFogColBase.w);
  tmpvar_34 = tmpvar_47;
  HeightFogFactor_22 = tmpvar_34;
  highp vec3 tmpvar_48;
  tmpvar_48 = _Mihoyo_FogColor.xyz;
  heightFogColor_21 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = ((heightFogColor_21 * HeightFogFactor_22) + ((atomesphereFogColor_23 * tmpvar_29) * (1.0 - HeightFogFactor_22)));
  fogColor_20 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = ((1.0 - tmpvar_29) * (1.0 - HeightFogFactor_22));
  fogFactor_19 = tmpvar_50;
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = fogColor_20;
  tmpvar_51.w = fogFactor_19;
  tmpvar_18 = tmpvar_51;
  tmpvar_16 = tmpvar_18;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = (xlv_COLOR1.xyz + (diffColor_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_12 = tmpvar_13.xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
  mediump vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_18;
  mediump float fogFactor_19;
  mediump vec3 fogColor_20;
  mediump vec3 heightFogColor_21;
  highp float HeightFogFactor_22;
  mediump vec3 atomesphereFogColor_23;
  mediump float h_24;
  highp float linearFogDensity_25;
  mediump float len_26;
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((len_26 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_25 = (tmpvar_28 * (2.0 - tmpvar_28));
  if ((len_26 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_25 = (linearFogDensity_25 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_29;
  tmpvar_29 = min (pow (linearFogDensity_25, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_25 = tmpvar_29;
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((tmpvar_13.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  h_24 = (tmpvar_30 * (2.0 - tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = (_HeigtFogColBase2.xyz + (h_24 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_23 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (atomesphereFogColor_23, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_26 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_23 = tmpvar_33;
  mediump float tmpvar_34;
  mediump float r_35;
  mediump float f_36;
  mediump float u_37;
  mediump float l_38;
  mediump float fogInt_39;
  fogInt_39 = 1.0;
  highp float tmpvar_40;
  tmpvar_40 = (_HeigtFogParams2.x * tmpvar_17.y);
  highp float tmpvar_41;
  tmpvar_41 = abs(tmpvar_40);
  if ((tmpvar_41 > 0.01)) {
    highp float tmpvar_42;
    tmpvar_42 = exp(-(tmpvar_40));
    fogInt_39 = ((1.0 - tmpvar_42) / tmpvar_40);
  };
  highp float tmpvar_43;
  tmpvar_43 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_38 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (l_38 * _HeigtFogParams2.y);
  u_37 = tmpvar_44;
  fogInt_39 = (fogInt_39 * u_37);
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((l_38 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  r_35 = (tmpvar_45 * (2.0 - tmpvar_45));
  r_35 = ((r_35 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_36 = ((1.0 - clamp (
    exp2(-(fogInt_39))
  , 0.0, 1.0)) * r_35);
  highp float tmpvar_47;
  tmpvar_47 = min (f_36, _HeigtFogColBase2.w);
  tmpvar_34 = tmpvar_47;
  HeightFogFactor_22 = tmpvar_34;
  highp vec3 tmpvar_48;
  tmpvar_48 = _Mihoyo_FogColor2.xyz;
  heightFogColor_21 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = ((heightFogColor_21 * HeightFogFactor_22) + ((atomesphereFogColor_23 * tmpvar_29) * (1.0 - HeightFogFactor_22)));
  fogColor_20 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = ((1.0 - tmpvar_29) * (1.0 - HeightFogFactor_22));
  fogFactor_19 = tmpvar_50;
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = fogColor_20;
  tmpvar_51.w = fogFactor_19;
  tmpvar_18 = tmpvar_51;
  highp vec4 tmpvar_52;
  mediump float fogFactor_53;
  mediump vec3 fogColor_54;
  mediump vec3 heightFogColor_55;
  highp float HeightFogFactor_56;
  mediump vec3 atomesphereFogColor_57;
  mediump float h_58;
  highp float linearFogDensity_59;
  mediump float len_60;
  highp float tmpvar_61;
  tmpvar_61 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((len_60 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_59 = (tmpvar_62 * (2.0 - tmpvar_62));
  if ((len_60 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_59 = (linearFogDensity_59 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_63;
  tmpvar_63 = min (pow (linearFogDensity_59, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_59 = tmpvar_63;
  mediump float tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((tmpvar_13.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_64 = tmpvar_65;
  h_58 = (tmpvar_64 * (2.0 - tmpvar_64));
  highp vec3 tmpvar_66;
  tmpvar_66 = (_HeigtFogColBase3.xyz + (h_58 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_57 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (atomesphereFogColor_57, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_60 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_57 = tmpvar_67;
  mediump float tmpvar_68;
  mediump float r_69;
  mediump float f_70;
  mediump float u_71;
  mediump float l_72;
  mediump float fogInt_73;
  fogInt_73 = 1.0;
  highp float tmpvar_74;
  tmpvar_74 = (_HeigtFogParams3.x * tmpvar_17.y);
  highp float tmpvar_75;
  tmpvar_75 = abs(tmpvar_74);
  if ((tmpvar_75 > 0.01)) {
    highp float tmpvar_76;
    tmpvar_76 = exp(-(tmpvar_74));
    fogInt_73 = ((1.0 - tmpvar_76) / tmpvar_74);
  };
  highp float tmpvar_77;
  tmpvar_77 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_72 = tmpvar_77;
  highp float tmpvar_78;
  tmpvar_78 = (l_72 * _HeigtFogParams3.y);
  u_71 = tmpvar_78;
  fogInt_73 = (fogInt_73 * u_71);
  mediump float tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = clamp (((l_72 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_79 = tmpvar_80;
  r_69 = (tmpvar_79 * (2.0 - tmpvar_79));
  r_69 = ((r_69 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_70 = ((1.0 - clamp (
    exp2(-(fogInt_73))
  , 0.0, 1.0)) * r_69);
  highp float tmpvar_81;
  tmpvar_81 = min (f_70, _HeigtFogColBase3.w);
  tmpvar_68 = tmpvar_81;
  HeightFogFactor_56 = tmpvar_68;
  highp vec3 tmpvar_82;
  tmpvar_82 = _Mihoyo_FogColor3.xyz;
  heightFogColor_55 = tmpvar_82;
  highp vec3 tmpvar_83;
  tmpvar_83 = ((heightFogColor_55 * HeightFogFactor_56) + ((atomesphereFogColor_57 * tmpvar_63) * (1.0 - HeightFogFactor_56)));
  fogColor_54 = tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = ((1.0 - tmpvar_63) * (1.0 - HeightFogFactor_56));
  fogFactor_53 = tmpvar_84;
  mediump vec4 tmpvar_85;
  tmpvar_85.xyz = fogColor_54;
  tmpvar_85.w = fogFactor_53;
  tmpvar_52 = tmpvar_85;
  highp vec4 tmpvar_86;
  tmpvar_86 = mix (tmpvar_18, tmpvar_52, vec4(_LerpFactor));
  tmpvar_16 = tmpvar_86;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = (xlv_COLOR1.xyz + (diffColor_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_12 = tmpvar_13.xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
  mediump vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_18;
  mediump float fogFactor_19;
  mediump vec3 fogColor_20;
  mediump vec3 heightFogColor_21;
  highp float HeightFogFactor_22;
  mediump vec3 atomesphereFogColor_23;
  mediump float h_24;
  highp float linearFogDensity_25;
  mediump float len_26;
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((len_26 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_25 = (tmpvar_28 * (2.0 - tmpvar_28));
  if ((len_26 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_25 = (linearFogDensity_25 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_29;
  tmpvar_29 = min (pow (linearFogDensity_25, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_25 = tmpvar_29;
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((tmpvar_13.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  h_24 = (tmpvar_30 * (2.0 - tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = (_HeigtFogColBase2.xyz + (h_24 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_23 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (atomesphereFogColor_23, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_26 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_23 = tmpvar_33;
  mediump float tmpvar_34;
  mediump float r_35;
  mediump float f_36;
  mediump float u_37;
  mediump float l_38;
  mediump float fogInt_39;
  fogInt_39 = 1.0;
  highp float tmpvar_40;
  tmpvar_40 = (_HeigtFogParams2.x * tmpvar_17.y);
  highp float tmpvar_41;
  tmpvar_41 = abs(tmpvar_40);
  if ((tmpvar_41 > 0.01)) {
    highp float tmpvar_42;
    tmpvar_42 = exp(-(tmpvar_40));
    fogInt_39 = ((1.0 - tmpvar_42) / tmpvar_40);
  };
  highp float tmpvar_43;
  tmpvar_43 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_38 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (l_38 * _HeigtFogParams2.y);
  u_37 = tmpvar_44;
  fogInt_39 = (fogInt_39 * u_37);
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((l_38 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  r_35 = (tmpvar_45 * (2.0 - tmpvar_45));
  r_35 = ((r_35 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_36 = ((1.0 - clamp (
    exp2(-(fogInt_39))
  , 0.0, 1.0)) * r_35);
  highp float tmpvar_47;
  tmpvar_47 = min (f_36, _HeigtFogColBase2.w);
  tmpvar_34 = tmpvar_47;
  HeightFogFactor_22 = tmpvar_34;
  highp vec3 tmpvar_48;
  tmpvar_48 = _Mihoyo_FogColor2.xyz;
  heightFogColor_21 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = ((heightFogColor_21 * HeightFogFactor_22) + ((atomesphereFogColor_23 * tmpvar_29) * (1.0 - HeightFogFactor_22)));
  fogColor_20 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = ((1.0 - tmpvar_29) * (1.0 - HeightFogFactor_22));
  fogFactor_19 = tmpvar_50;
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = fogColor_20;
  tmpvar_51.w = fogFactor_19;
  tmpvar_18 = tmpvar_51;
  highp vec4 tmpvar_52;
  mediump float fogFactor_53;
  mediump vec3 fogColor_54;
  mediump vec3 heightFogColor_55;
  highp float HeightFogFactor_56;
  mediump vec3 atomesphereFogColor_57;
  mediump float h_58;
  highp float linearFogDensity_59;
  mediump float len_60;
  highp float tmpvar_61;
  tmpvar_61 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((len_60 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_59 = (tmpvar_62 * (2.0 - tmpvar_62));
  if ((len_60 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_59 = (linearFogDensity_59 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_63;
  tmpvar_63 = min (pow (linearFogDensity_59, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_59 = tmpvar_63;
  mediump float tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((tmpvar_13.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_64 = tmpvar_65;
  h_58 = (tmpvar_64 * (2.0 - tmpvar_64));
  highp vec3 tmpvar_66;
  tmpvar_66 = (_HeigtFogColBase3.xyz + (h_58 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_57 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (atomesphereFogColor_57, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_60 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_57 = tmpvar_67;
  mediump float tmpvar_68;
  mediump float r_69;
  mediump float f_70;
  mediump float u_71;
  mediump float l_72;
  mediump float fogInt_73;
  fogInt_73 = 1.0;
  highp float tmpvar_74;
  tmpvar_74 = (_HeigtFogParams3.x * tmpvar_17.y);
  highp float tmpvar_75;
  tmpvar_75 = abs(tmpvar_74);
  if ((tmpvar_75 > 0.01)) {
    highp float tmpvar_76;
    tmpvar_76 = exp(-(tmpvar_74));
    fogInt_73 = ((1.0 - tmpvar_76) / tmpvar_74);
  };
  highp float tmpvar_77;
  tmpvar_77 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_72 = tmpvar_77;
  highp float tmpvar_78;
  tmpvar_78 = (l_72 * _HeigtFogParams3.y);
  u_71 = tmpvar_78;
  fogInt_73 = (fogInt_73 * u_71);
  mediump float tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = clamp (((l_72 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_79 = tmpvar_80;
  r_69 = (tmpvar_79 * (2.0 - tmpvar_79));
  r_69 = ((r_69 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_70 = ((1.0 - clamp (
    exp2(-(fogInt_73))
  , 0.0, 1.0)) * r_69);
  highp float tmpvar_81;
  tmpvar_81 = min (f_70, _HeigtFogColBase3.w);
  tmpvar_68 = tmpvar_81;
  HeightFogFactor_56 = tmpvar_68;
  highp vec3 tmpvar_82;
  tmpvar_82 = _Mihoyo_FogColor3.xyz;
  heightFogColor_55 = tmpvar_82;
  highp vec3 tmpvar_83;
  tmpvar_83 = ((heightFogColor_55 * HeightFogFactor_56) + ((atomesphereFogColor_57 * tmpvar_63) * (1.0 - HeightFogFactor_56)));
  fogColor_54 = tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = ((1.0 - tmpvar_63) * (1.0 - HeightFogFactor_56));
  fogFactor_53 = tmpvar_84;
  mediump vec4 tmpvar_85;
  tmpvar_85.xyz = fogColor_54;
  tmpvar_85.w = fogFactor_53;
  tmpvar_52 = tmpvar_85;
  highp vec4 tmpvar_86;
  tmpvar_86 = mix (tmpvar_18, tmpvar_52, vec4(_LerpFactor));
  tmpvar_16 = tmpvar_86;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = (xlv_COLOR1.xyz + (diffColor_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_3 = o_9;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_12 = tmpvar_13.xyz;
  tmpvar_4 = tmpvar_12;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
  mediump vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_13.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_18;
  mediump float fogFactor_19;
  mediump vec3 fogColor_20;
  mediump vec3 heightFogColor_21;
  highp float HeightFogFactor_22;
  mediump vec3 atomesphereFogColor_23;
  mediump float h_24;
  highp float linearFogDensity_25;
  mediump float len_26;
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((len_26 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_25 = (tmpvar_28 * (2.0 - tmpvar_28));
  if ((len_26 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_25 = (linearFogDensity_25 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_29;
  tmpvar_29 = min (pow (linearFogDensity_25, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_25 = tmpvar_29;
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((tmpvar_13.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  h_24 = (tmpvar_30 * (2.0 - tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = (_HeigtFogColBase2.xyz + (h_24 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_23 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (atomesphereFogColor_23, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_26 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_23 = tmpvar_33;
  mediump float tmpvar_34;
  mediump float r_35;
  mediump float f_36;
  mediump float u_37;
  mediump float l_38;
  mediump float fogInt_39;
  fogInt_39 = 1.0;
  highp float tmpvar_40;
  tmpvar_40 = (_HeigtFogParams2.x * tmpvar_17.y);
  highp float tmpvar_41;
  tmpvar_41 = abs(tmpvar_40);
  if ((tmpvar_41 > 0.01)) {
    highp float tmpvar_42;
    tmpvar_42 = exp(-(tmpvar_40));
    fogInt_39 = ((1.0 - tmpvar_42) / tmpvar_40);
  };
  highp float tmpvar_43;
  tmpvar_43 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_38 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (l_38 * _HeigtFogParams2.y);
  u_37 = tmpvar_44;
  fogInt_39 = (fogInt_39 * u_37);
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((l_38 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  r_35 = (tmpvar_45 * (2.0 - tmpvar_45));
  r_35 = ((r_35 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_36 = ((1.0 - clamp (
    exp2(-(fogInt_39))
  , 0.0, 1.0)) * r_35);
  highp float tmpvar_47;
  tmpvar_47 = min (f_36, _HeigtFogColBase2.w);
  tmpvar_34 = tmpvar_47;
  HeightFogFactor_22 = tmpvar_34;
  highp vec3 tmpvar_48;
  tmpvar_48 = _Mihoyo_FogColor2.xyz;
  heightFogColor_21 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = ((heightFogColor_21 * HeightFogFactor_22) + ((atomesphereFogColor_23 * tmpvar_29) * (1.0 - HeightFogFactor_22)));
  fogColor_20 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = ((1.0 - tmpvar_29) * (1.0 - HeightFogFactor_22));
  fogFactor_19 = tmpvar_50;
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = fogColor_20;
  tmpvar_51.w = fogFactor_19;
  tmpvar_18 = tmpvar_51;
  highp vec4 tmpvar_52;
  mediump float fogFactor_53;
  mediump vec3 fogColor_54;
  mediump vec3 heightFogColor_55;
  highp float HeightFogFactor_56;
  mediump vec3 atomesphereFogColor_57;
  mediump float h_58;
  highp float linearFogDensity_59;
  mediump float len_60;
  highp float tmpvar_61;
  tmpvar_61 = sqrt(dot (tmpvar_17, tmpvar_17));
  len_60 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((len_60 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_59 = (tmpvar_62 * (2.0 - tmpvar_62));
  if ((len_60 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_59 = (linearFogDensity_59 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_63;
  tmpvar_63 = min (pow (linearFogDensity_59, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_59 = tmpvar_63;
  mediump float tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((tmpvar_13.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_64 = tmpvar_65;
  h_58 = (tmpvar_64 * (2.0 - tmpvar_64));
  highp vec3 tmpvar_66;
  tmpvar_66 = (_HeigtFogColBase3.xyz + (h_58 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_57 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (atomesphereFogColor_57, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_60 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_57 = tmpvar_67;
  mediump float tmpvar_68;
  mediump float r_69;
  mediump float f_70;
  mediump float u_71;
  mediump float l_72;
  mediump float fogInt_73;
  fogInt_73 = 1.0;
  highp float tmpvar_74;
  tmpvar_74 = (_HeigtFogParams3.x * tmpvar_17.y);
  highp float tmpvar_75;
  tmpvar_75 = abs(tmpvar_74);
  if ((tmpvar_75 > 0.01)) {
    highp float tmpvar_76;
    tmpvar_76 = exp(-(tmpvar_74));
    fogInt_73 = ((1.0 - tmpvar_76) / tmpvar_74);
  };
  highp float tmpvar_77;
  tmpvar_77 = sqrt(dot (tmpvar_17, tmpvar_17));
  l_72 = tmpvar_77;
  highp float tmpvar_78;
  tmpvar_78 = (l_72 * _HeigtFogParams3.y);
  u_71 = tmpvar_78;
  fogInt_73 = (fogInt_73 * u_71);
  mediump float tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = clamp (((l_72 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_79 = tmpvar_80;
  r_69 = (tmpvar_79 * (2.0 - tmpvar_79));
  r_69 = ((r_69 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_70 = ((1.0 - clamp (
    exp2(-(fogInt_73))
  , 0.0, 1.0)) * r_69);
  highp float tmpvar_81;
  tmpvar_81 = min (f_70, _HeigtFogColBase3.w);
  tmpvar_68 = tmpvar_81;
  HeightFogFactor_56 = tmpvar_68;
  highp vec3 tmpvar_82;
  tmpvar_82 = _Mihoyo_FogColor3.xyz;
  heightFogColor_55 = tmpvar_82;
  highp vec3 tmpvar_83;
  tmpvar_83 = ((heightFogColor_55 * HeightFogFactor_56) + ((atomesphereFogColor_57 * tmpvar_63) * (1.0 - HeightFogFactor_56)));
  fogColor_54 = tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = ((1.0 - tmpvar_63) * (1.0 - HeightFogFactor_56));
  fogFactor_53 = tmpvar_84;
  mediump vec4 tmpvar_85;
  tmpvar_85.xyz = fogColor_54;
  tmpvar_85.w = fogFactor_53;
  tmpvar_52 = tmpvar_85;
  highp vec4 tmpvar_86;
  tmpvar_86 = mix (tmpvar_18, tmpvar_52, vec4(_LerpFactor));
  tmpvar_16 = tmpvar_86;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_7;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  outColor_4.xyz = (xlv_COLOR1.xyz + (diffColor_1 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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