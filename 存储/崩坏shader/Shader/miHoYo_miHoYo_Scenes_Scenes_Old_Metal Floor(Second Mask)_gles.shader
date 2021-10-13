//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Metal Floor(Second Mask)" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_ReflectMaskTex ("Reflect Mask Tex(R)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "white" { }
_LightMapIntensity ("Light Map Intensity", Float) = 1
_SecondReflectMask ("Second Reflect Mask", 2D) = "white" { }
_ReflectionTex ("Reflection", 2D) = "white" { }
_ReflectionEmissionAdjust ("Reflection Emission Adjust", Float) = 1
_SecondReflectPower ("Second Reflect Power", Float) = 1
_SecondReflectIntensity ("Second Reflect Intensity", Float) = 1
_SecondReflectFactor ("Reflect Lerp Factor", Range(0, 1)) = 0
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
  GpuProgramID 21565
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_17 = tmpvar_19;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = (xlv_COLOR1.xyz + (outColor_4.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_17 = tmpvar_19;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = (xlv_COLOR1.xyz + (outColor_4.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_17 = tmpvar_19;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = (xlv_COLOR1.xyz + (outColor_4.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_14.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_87;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = (xlv_COLOR1.xyz + (outColor_4.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_14.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_87;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = (xlv_COLOR1.xyz + (outColor_4.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_14.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_87;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = (xlv_COLOR1.xyz + (outColor_4.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = mix (outColor_10.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = mix (outColor_10.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = mix (outColor_10.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = mix (outColor_10.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = mix (outColor_10.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = mix (outColor_10.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_17 = tmpvar_19;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = (xlv_COLOR1.xyz + (outColor_10.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_17 = tmpvar_19;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = (xlv_COLOR1.xyz + (outColor_10.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_17 = tmpvar_19;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = (xlv_COLOR1.xyz + (outColor_10.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_14.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_87;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = (xlv_COLOR1.xyz + (outColor_10.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_14.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_87;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = (xlv_COLOR1.xyz + (outColor_10.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_14.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_87;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = (xlv_COLOR1.xyz + (outColor_10.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  gl_FragData[0] = outColor_10;
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_17 = tmpvar_19;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = (xlv_COLOR1.xyz + (outColor_4.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_17 = tmpvar_19;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = (xlv_COLOR1.xyz + (outColor_4.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_17 = tmpvar_19;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = (xlv_COLOR1.xyz + (outColor_4.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_14.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_87;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = (xlv_COLOR1.xyz + (outColor_4.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_14.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_87;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = (xlv_COLOR1.xyz + (outColor_4.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
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
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_14.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_87;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
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
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = diffColor_1;
  tmpvar_8.w = _BloomFactor;
  outColor_4 = tmpvar_8;
  outColor_4.xyz = (xlv_COLOR1.xyz + (outColor_4.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = mix (outColor_10.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = mix (outColor_10.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = mix (outColor_10.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = mix (outColor_10.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = mix (outColor_10.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_1 = _glesMultiTexCoord0.xy;
  tmpvar_2 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_7 = _glesMultiTexCoord2.xy;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3 = o_10;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_4 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  tmpvar_5 = tmpvar_15;
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
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_COLOR1 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = mix (outColor_10.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_17 = tmpvar_19;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = (xlv_COLOR1.xyz + (outColor_10.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_17 = tmpvar_19;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = (xlv_COLOR1.xyz + (outColor_10.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase.xyz + (h_25 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_27 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  tmpvar_17 = tmpvar_19;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = (xlv_COLOR1.xyz + (outColor_10.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_14.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_87;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = (xlv_COLOR1.xyz + (outColor_10.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_14.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_87;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = (xlv_COLOR1.xyz + (outColor_10.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_10;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = ((_glesVertex.xz * _BrushedNormalMap_ST.xy) + _BrushedNormalMap_ST.zw);
  tmpvar_7 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_4 = o_10;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_13 = tmpvar_14.xyz;
  tmpvar_5 = tmpvar_13;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6 = tmpvar_16;
  mediump vec4 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_14.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_19;
  mediump float fogFactor_20;
  mediump vec3 fogColor_21;
  mediump vec3 heightFogColor_22;
  highp float HeightFogFactor_23;
  mediump vec3 atomesphereFogColor_24;
  mediump float h_25;
  highp float linearFogDensity_26;
  mediump float len_27;
  highp float tmpvar_28;
  tmpvar_28 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (((len_27 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_26 = (tmpvar_29 * (2.0 - tmpvar_29));
  if ((len_27 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_26 = (linearFogDensity_26 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_30;
  tmpvar_30 = min (pow (linearFogDensity_26, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_26 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((tmpvar_14.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  h_25 = (tmpvar_31 * (2.0 - tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = (_HeigtFogColBase2.xyz + (h_25 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_24 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (atomesphereFogColor_24, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_27 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_24 = tmpvar_34;
  mediump float tmpvar_35;
  mediump float r_36;
  mediump float f_37;
  mediump float u_38;
  mediump float l_39;
  mediump float fogInt_40;
  fogInt_40 = 1.0;
  highp float tmpvar_41;
  tmpvar_41 = (_HeigtFogParams2.x * tmpvar_18.y);
  highp float tmpvar_42;
  tmpvar_42 = abs(tmpvar_41);
  if ((tmpvar_42 > 0.01)) {
    highp float tmpvar_43;
    tmpvar_43 = exp(-(tmpvar_41));
    fogInt_40 = ((1.0 - tmpvar_43) / tmpvar_41);
  };
  highp float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_39 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (l_39 * _HeigtFogParams2.y);
  u_38 = tmpvar_45;
  fogInt_40 = (fogInt_40 * u_38);
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (((l_39 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  r_36 = (tmpvar_46 * (2.0 - tmpvar_46));
  r_36 = ((r_36 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_37 = ((1.0 - clamp (
    exp2(-(fogInt_40))
  , 0.0, 1.0)) * r_36);
  highp float tmpvar_48;
  tmpvar_48 = min (f_37, _HeigtFogColBase2.w);
  tmpvar_35 = tmpvar_48;
  HeightFogFactor_23 = tmpvar_35;
  highp vec3 tmpvar_49;
  tmpvar_49 = _Mihoyo_FogColor2.xyz;
  heightFogColor_22 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((heightFogColor_22 * HeightFogFactor_23) + ((atomesphereFogColor_24 * tmpvar_30) * (1.0 - HeightFogFactor_23)));
  fogColor_21 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = ((1.0 - tmpvar_30) * (1.0 - HeightFogFactor_23));
  fogFactor_20 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.xyz = fogColor_21;
  tmpvar_52.w = fogFactor_20;
  tmpvar_19 = tmpvar_52;
  highp vec4 tmpvar_53;
  mediump float fogFactor_54;
  mediump vec3 fogColor_55;
  mediump vec3 heightFogColor_56;
  highp float HeightFogFactor_57;
  mediump vec3 atomesphereFogColor_58;
  mediump float h_59;
  highp float linearFogDensity_60;
  mediump float len_61;
  highp float tmpvar_62;
  tmpvar_62 = sqrt(dot (tmpvar_18, tmpvar_18));
  len_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (((len_61 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_60 = (tmpvar_63 * (2.0 - tmpvar_63));
  if ((len_61 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_60 = (linearFogDensity_60 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_64;
  tmpvar_64 = min (pow (linearFogDensity_60, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_60 = tmpvar_64;
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (((tmpvar_14.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  h_59 = (tmpvar_65 * (2.0 - tmpvar_65));
  highp vec3 tmpvar_67;
  tmpvar_67 = (_HeigtFogColBase3.xyz + (h_59 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_58 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = mix (atomesphereFogColor_58, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_61 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  mediump float r_70;
  mediump float f_71;
  mediump float u_72;
  mediump float l_73;
  mediump float fogInt_74;
  fogInt_74 = 1.0;
  highp float tmpvar_75;
  tmpvar_75 = (_HeigtFogParams3.x * tmpvar_18.y);
  highp float tmpvar_76;
  tmpvar_76 = abs(tmpvar_75);
  if ((tmpvar_76 > 0.01)) {
    highp float tmpvar_77;
    tmpvar_77 = exp(-(tmpvar_75));
    fogInt_74 = ((1.0 - tmpvar_77) / tmpvar_75);
  };
  highp float tmpvar_78;
  tmpvar_78 = sqrt(dot (tmpvar_18, tmpvar_18));
  l_73 = tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = (l_73 * _HeigtFogParams3.y);
  u_72 = tmpvar_79;
  fogInt_74 = (fogInt_74 * u_72);
  mediump float tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (((l_73 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_80 = tmpvar_81;
  r_70 = (tmpvar_80 * (2.0 - tmpvar_80));
  r_70 = ((r_70 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_71 = ((1.0 - clamp (
    exp2(-(fogInt_74))
  , 0.0, 1.0)) * r_70);
  highp float tmpvar_82;
  tmpvar_82 = min (f_71, _HeigtFogColBase3.w);
  tmpvar_69 = tmpvar_82;
  HeightFogFactor_57 = tmpvar_69;
  highp vec3 tmpvar_83;
  tmpvar_83 = _Mihoyo_FogColor3.xyz;
  heightFogColor_56 = tmpvar_83;
  highp vec3 tmpvar_84;
  tmpvar_84 = ((heightFogColor_56 * HeightFogFactor_57) + ((atomesphereFogColor_58 * tmpvar_64) * (1.0 - HeightFogFactor_57)));
  fogColor_55 = tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = ((1.0 - tmpvar_64) * (1.0 - HeightFogFactor_57));
  fogFactor_54 = tmpvar_85;
  mediump vec4 tmpvar_86;
  tmpvar_86.xyz = fogColor_55;
  tmpvar_86.w = fogFactor_54;
  tmpvar_53 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87 = mix (tmpvar_19, tmpvar_53, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_87;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform sampler2D _SecondReflectMask;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform mediump float _SecondReflectPower;
uniform mediump float _SecondReflectIntensity;
uniform mediump float _SecondReflectFactor;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump float SecondReflectMask_6;
  mediump vec4 ShadowColor_7;
  mediump float reflectMask_8;
  mediump vec4 baseTexColor_9;
  mediump vec4 outColor_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_8 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_7 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_SecondReflectMask, xlv_TEXCOORD6).x;
  SecondReflectMask_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (baseTexColor_9.xyz * _Color.xyz);
  diffColor_5 = tmpvar_15;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_7.xyz) * ShadowColor_7.w) + 1.0)
   - ShadowColor_7.w)) * _LightMapIntensity);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_16;
  mediump float tmpvar_17;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  tmpvar_17 = (bias_20 + max (0.0, (
    pow (clamp ((1.0 - dot (I_4, xlv_TEXCOORD4)), 0.001, 1.0), power_18)
   * scale_19)));
  lowp vec2 tmpvar_21;
  tmpvar_21 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_21;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_22;
  tmpvar_22.x = _BrushScaleX;
  tmpvar_22.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_22);
  mediump vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_24;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  SecondReflectMask_6 = (_SecondReflectIntensity * pow (SecondReflectMask_6, _SecondReflectPower));
  reflColor_1.xyz = (reflColor_1.xyz * mix (reflectMask_8, SecondReflectMask_6, _SecondReflectFactor));
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = diffColor_5;
  tmpvar_25.w = _BloomFactor;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tmpvar_25, reflColor_1, vec4(tmpvar_17));
  outColor_10 = tmpvar_26;
  outColor_10.xyz = (xlv_COLOR1.xyz + (outColor_10.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_10;
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
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
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
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
}
}
}
}