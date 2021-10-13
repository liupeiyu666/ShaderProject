//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Floor (Reflecting Light)(Single Mask)" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_ReflectMaskTex ("Reflect Mask Tex(R)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "white" { }
_LightMapIntensity ("Light Map Intensity", Float) = 1
_ReflectionTex ("Reflection", 2D) = "black" { }
_ReflectionEmissionAdjust ("Reflection Emission Adjust", Float) = 1
_FresnelParams ("Fresnel Parameters", Vector) = (1,1,0,0)
_BrushedNormalMap ("Brushed Normal Map", 2D) = "green" { }
_BrushScaleX ("Brush Scale X", Range(0, 1)) = 1
_BrushScaleY ("Brush Scale Y", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
[Toggle(HIGH_FOG)] _HighFog ("HighFog", Float) = 0
_HighFogColor ("HighFogColor", Color) = (1,1,1,1)
_FogHighStartDistance ("FogHighStartDistance", Float) = 8.5
_FogHighIntensity ("FogHighIntensity", Float) = 0.03
_FogHighEffectLimit ("FogHighEffectLimit", Float) = 0.7
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 32299
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
uniform mediump vec4 _MainTex_ST;
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
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
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
uniform mediump vec4 _MainTex_ST;
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
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
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
uniform mediump vec4 _MainTex_ST;
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
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
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
uniform mediump vec4 _MainTex_ST;
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
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
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
uniform mediump vec4 _MainTex_ST;
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
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
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
uniform mediump vec4 _MainTex_ST;
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
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform mediump vec4 _MainTex_ST;
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
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
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
uniform mediump vec4 _MainTex_ST;
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
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
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
uniform mediump vec4 _MainTex_ST;
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
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
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
uniform mediump vec4 _MainTex_ST;
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
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
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
uniform mediump vec4 _MainTex_ST;
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
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
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
uniform mediump vec4 _MainTex_ST;
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
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  outColor_9.xyz = mix (outColor_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = outColor_9;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  outColor_9.xyz = mix (outColor_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = outColor_9;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  outColor_9.xyz = mix (outColor_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = outColor_9;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  outColor_9.xyz = mix (outColor_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = outColor_9;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  outColor_9.xyz = mix (outColor_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = outColor_9;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  outColor_9.xyz = mix (outColor_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = outColor_9;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  outColor_9.xyz = mix (outColor_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  outColor_9.xyz = mix (outColor_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  outColor_9.xyz = mix (outColor_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  outColor_9.xyz = mix (outColor_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  outColor_9.xyz = mix (outColor_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  outColor_9.xyz = mix (outColor_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
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
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD6;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  gl_FragData[0] = outColor_4;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
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
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD6;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  gl_FragData[0] = outColor_4;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
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
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD6;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  gl_FragData[0] = outColor_4;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
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
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD6;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  gl_FragData[0] = outColor_4;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
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
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD6;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  gl_FragData[0] = outColor_4;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
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
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD6;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  gl_FragData[0] = outColor_4;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
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
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD6;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
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
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD6;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
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
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD6;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
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
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD6;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
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
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD6;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
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
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform highp float _LightMapIntensity;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 diffColor_1;
  mediump vec4 ShadowColor_2;
  mediump vec4 baseTexColor_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = texture2D (_MainTex, P_6);
  baseTexColor_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (baseTexColor_3.xyz * _Color.xyz);
  diffColor_1 = tmpvar_8;
  diffColor_1 = ((diffColor_1 * (
    (((2.0 * ShadowColor_2.xyz) * ShadowColor_2.w) + 1.0)
   - ShadowColor_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = diffColor_1;
  tmpvar_9.w = _BloomFactor;
  outColor_4 = tmpvar_9;
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD6;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_24;
    xlat_varinput_24 = xlv_TEXCOORD6;
    mediump vec3 fogParam_25;
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_27;
    tmpvar_27 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_26))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_28;
    tmpvar_28 = clamp ((_UWFogColorHLIntensity * tmpvar_26), 0.0, 1.0);
    fogParam_25.z = 0.0;
    fogParam_25.y = tmpvar_27;
    fogParam_25.x = tmpvar_28;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_24.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_26 * _UWHeightRatio)));
      highp float tmpvar_29;
      tmpvar_29 = clamp (xlat_varinput_24.y, _UWCriticalRange, 1.0);
      xlat_varinput_24.y = tmpvar_29;
    };
    fogParam_25.z = (1.0 - xlat_varinput_24.y);
    mediump vec4 tmpvar_30;
    tmpvar_30.w = 0.0;
    tmpvar_30.xyz = outColor_9.xyz;
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_30, fogParam_25.zzzz).xyz;
    outColor_9.xyz = tmpvar_31;
    mediump vec4 tmpvar_32;
    tmpvar_32.w = 0.0;
    tmpvar_32.xyz = outColor_9.xyz;
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_25.xxxx), tmpvar_32, fogParam_25.yyyy).xyz;
    outColor_9.xyz = tmpvar_33;
  };
  gl_FragData[0] = outColor_9;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_24;
    xlat_varinput_24 = xlv_TEXCOORD6;
    mediump vec3 fogParam_25;
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_27;
    tmpvar_27 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_26))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_28;
    tmpvar_28 = clamp ((_UWFogColorHLIntensity * tmpvar_26), 0.0, 1.0);
    fogParam_25.z = 0.0;
    fogParam_25.y = tmpvar_27;
    fogParam_25.x = tmpvar_28;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_24.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_26 * _UWHeightRatio)));
      highp float tmpvar_29;
      tmpvar_29 = clamp (xlat_varinput_24.y, _UWCriticalRange, 1.0);
      xlat_varinput_24.y = tmpvar_29;
    };
    fogParam_25.z = (1.0 - xlat_varinput_24.y);
    mediump vec4 tmpvar_30;
    tmpvar_30.w = 0.0;
    tmpvar_30.xyz = outColor_9.xyz;
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_30, fogParam_25.zzzz).xyz;
    outColor_9.xyz = tmpvar_31;
    mediump vec4 tmpvar_32;
    tmpvar_32.w = 0.0;
    tmpvar_32.xyz = outColor_9.xyz;
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_25.xxxx), tmpvar_32, fogParam_25.yyyy).xyz;
    outColor_9.xyz = tmpvar_33;
  };
  gl_FragData[0] = outColor_9;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_24;
    xlat_varinput_24 = xlv_TEXCOORD6;
    mediump vec3 fogParam_25;
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_27;
    tmpvar_27 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_26))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_28;
    tmpvar_28 = clamp ((_UWFogColorHLIntensity * tmpvar_26), 0.0, 1.0);
    fogParam_25.z = 0.0;
    fogParam_25.y = tmpvar_27;
    fogParam_25.x = tmpvar_28;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_24.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_26 * _UWHeightRatio)));
      highp float tmpvar_29;
      tmpvar_29 = clamp (xlat_varinput_24.y, _UWCriticalRange, 1.0);
      xlat_varinput_24.y = tmpvar_29;
    };
    fogParam_25.z = (1.0 - xlat_varinput_24.y);
    mediump vec4 tmpvar_30;
    tmpvar_30.w = 0.0;
    tmpvar_30.xyz = outColor_9.xyz;
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_30, fogParam_25.zzzz).xyz;
    outColor_9.xyz = tmpvar_31;
    mediump vec4 tmpvar_32;
    tmpvar_32.w = 0.0;
    tmpvar_32.xyz = outColor_9.xyz;
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_25.xxxx), tmpvar_32, fogParam_25.yyyy).xyz;
    outColor_9.xyz = tmpvar_33;
  };
  gl_FragData[0] = outColor_9;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_24;
    xlat_varinput_24 = xlv_TEXCOORD6;
    mediump vec3 fogParam_25;
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_27;
    tmpvar_27 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_26))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_28;
    tmpvar_28 = clamp ((_UWFogColorHLIntensity * tmpvar_26), 0.0, 1.0);
    fogParam_25.z = 0.0;
    fogParam_25.y = tmpvar_27;
    fogParam_25.x = tmpvar_28;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_24.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_26 * _UWHeightRatio)));
      highp float tmpvar_29;
      tmpvar_29 = clamp (xlat_varinput_24.y, _UWCriticalRange, 1.0);
      xlat_varinput_24.y = tmpvar_29;
    };
    fogParam_25.z = (1.0 - xlat_varinput_24.y);
    mediump vec4 tmpvar_30;
    tmpvar_30.w = 0.0;
    tmpvar_30.xyz = outColor_9.xyz;
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_30, fogParam_25.zzzz).xyz;
    outColor_9.xyz = tmpvar_31;
    mediump vec4 tmpvar_32;
    tmpvar_32.w = 0.0;
    tmpvar_32.xyz = outColor_9.xyz;
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_25.xxxx), tmpvar_32, fogParam_25.yyyy).xyz;
    outColor_9.xyz = tmpvar_33;
  };
  gl_FragData[0] = outColor_9;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_24;
    xlat_varinput_24 = xlv_TEXCOORD6;
    mediump vec3 fogParam_25;
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_27;
    tmpvar_27 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_26))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_28;
    tmpvar_28 = clamp ((_UWFogColorHLIntensity * tmpvar_26), 0.0, 1.0);
    fogParam_25.z = 0.0;
    fogParam_25.y = tmpvar_27;
    fogParam_25.x = tmpvar_28;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_24.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_26 * _UWHeightRatio)));
      highp float tmpvar_29;
      tmpvar_29 = clamp (xlat_varinput_24.y, _UWCriticalRange, 1.0);
      xlat_varinput_24.y = tmpvar_29;
    };
    fogParam_25.z = (1.0 - xlat_varinput_24.y);
    mediump vec4 tmpvar_30;
    tmpvar_30.w = 0.0;
    tmpvar_30.xyz = outColor_9.xyz;
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_30, fogParam_25.zzzz).xyz;
    outColor_9.xyz = tmpvar_31;
    mediump vec4 tmpvar_32;
    tmpvar_32.w = 0.0;
    tmpvar_32.xyz = outColor_9.xyz;
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_25.xxxx), tmpvar_32, fogParam_25.yyyy).xyz;
    outColor_9.xyz = tmpvar_33;
  };
  gl_FragData[0] = outColor_9;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_24;
    xlat_varinput_24 = xlv_TEXCOORD6;
    mediump vec3 fogParam_25;
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_27;
    tmpvar_27 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_26))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_28;
    tmpvar_28 = clamp ((_UWFogColorHLIntensity * tmpvar_26), 0.0, 1.0);
    fogParam_25.z = 0.0;
    fogParam_25.y = tmpvar_27;
    fogParam_25.x = tmpvar_28;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_24.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_26 * _UWHeightRatio)));
      highp float tmpvar_29;
      tmpvar_29 = clamp (xlat_varinput_24.y, _UWCriticalRange, 1.0);
      xlat_varinput_24.y = tmpvar_29;
    };
    fogParam_25.z = (1.0 - xlat_varinput_24.y);
    mediump vec4 tmpvar_30;
    tmpvar_30.w = 0.0;
    tmpvar_30.xyz = outColor_9.xyz;
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_30, fogParam_25.zzzz).xyz;
    outColor_9.xyz = tmpvar_31;
    mediump vec4 tmpvar_32;
    tmpvar_32.w = 0.0;
    tmpvar_32.xyz = outColor_9.xyz;
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_25.xxxx), tmpvar_32, fogParam_25.yyyy).xyz;
    outColor_9.xyz = tmpvar_33;
  };
  gl_FragData[0] = outColor_9;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_24;
    xlat_varinput_24 = xlv_TEXCOORD6;
    mediump vec3 fogParam_25;
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_27;
    tmpvar_27 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_26))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_28;
    tmpvar_28 = clamp ((_UWFogColorHLIntensity * tmpvar_26), 0.0, 1.0);
    fogParam_25.z = 0.0;
    fogParam_25.y = tmpvar_27;
    fogParam_25.x = tmpvar_28;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_24.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_26 * _UWHeightRatio)));
      highp float tmpvar_29;
      tmpvar_29 = clamp (xlat_varinput_24.y, _UWCriticalRange, 1.0);
      xlat_varinput_24.y = tmpvar_29;
    };
    fogParam_25.z = (1.0 - xlat_varinput_24.y);
    mediump vec4 tmpvar_30;
    tmpvar_30.w = 0.0;
    tmpvar_30.xyz = outColor_9.xyz;
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_30, fogParam_25.zzzz).xyz;
    outColor_9.xyz = tmpvar_31;
    mediump vec4 tmpvar_32;
    tmpvar_32.w = 0.0;
    tmpvar_32.xyz = outColor_9.xyz;
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_25.xxxx), tmpvar_32, fogParam_25.yyyy).xyz;
    outColor_9.xyz = tmpvar_33;
  };
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_24;
    xlat_varinput_24 = xlv_TEXCOORD6;
    mediump vec3 fogParam_25;
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_27;
    tmpvar_27 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_26))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_28;
    tmpvar_28 = clamp ((_UWFogColorHLIntensity * tmpvar_26), 0.0, 1.0);
    fogParam_25.z = 0.0;
    fogParam_25.y = tmpvar_27;
    fogParam_25.x = tmpvar_28;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_24.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_26 * _UWHeightRatio)));
      highp float tmpvar_29;
      tmpvar_29 = clamp (xlat_varinput_24.y, _UWCriticalRange, 1.0);
      xlat_varinput_24.y = tmpvar_29;
    };
    fogParam_25.z = (1.0 - xlat_varinput_24.y);
    mediump vec4 tmpvar_30;
    tmpvar_30.w = 0.0;
    tmpvar_30.xyz = outColor_9.xyz;
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_30, fogParam_25.zzzz).xyz;
    outColor_9.xyz = tmpvar_31;
    mediump vec4 tmpvar_32;
    tmpvar_32.w = 0.0;
    tmpvar_32.xyz = outColor_9.xyz;
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_25.xxxx), tmpvar_32, fogParam_25.yyyy).xyz;
    outColor_9.xyz = tmpvar_33;
  };
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_24;
    xlat_varinput_24 = xlv_TEXCOORD6;
    mediump vec3 fogParam_25;
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_27;
    tmpvar_27 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_26))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_28;
    tmpvar_28 = clamp ((_UWFogColorHLIntensity * tmpvar_26), 0.0, 1.0);
    fogParam_25.z = 0.0;
    fogParam_25.y = tmpvar_27;
    fogParam_25.x = tmpvar_28;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_24.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_26 * _UWHeightRatio)));
      highp float tmpvar_29;
      tmpvar_29 = clamp (xlat_varinput_24.y, _UWCriticalRange, 1.0);
      xlat_varinput_24.y = tmpvar_29;
    };
    fogParam_25.z = (1.0 - xlat_varinput_24.y);
    mediump vec4 tmpvar_30;
    tmpvar_30.w = 0.0;
    tmpvar_30.xyz = outColor_9.xyz;
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_30, fogParam_25.zzzz).xyz;
    outColor_9.xyz = tmpvar_31;
    mediump vec4 tmpvar_32;
    tmpvar_32.w = 0.0;
    tmpvar_32.xyz = outColor_9.xyz;
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_25.xxxx), tmpvar_32, fogParam_25.yyyy).xyz;
    outColor_9.xyz = tmpvar_33;
  };
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_24;
    xlat_varinput_24 = xlv_TEXCOORD6;
    mediump vec3 fogParam_25;
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_27;
    tmpvar_27 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_26))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_28;
    tmpvar_28 = clamp ((_UWFogColorHLIntensity * tmpvar_26), 0.0, 1.0);
    fogParam_25.z = 0.0;
    fogParam_25.y = tmpvar_27;
    fogParam_25.x = tmpvar_28;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_24.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_26 * _UWHeightRatio)));
      highp float tmpvar_29;
      tmpvar_29 = clamp (xlat_varinput_24.y, _UWCriticalRange, 1.0);
      xlat_varinput_24.y = tmpvar_29;
    };
    fogParam_25.z = (1.0 - xlat_varinput_24.y);
    mediump vec4 tmpvar_30;
    tmpvar_30.w = 0.0;
    tmpvar_30.xyz = outColor_9.xyz;
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_30, fogParam_25.zzzz).xyz;
    outColor_9.xyz = tmpvar_31;
    mediump vec4 tmpvar_32;
    tmpvar_32.w = 0.0;
    tmpvar_32.xyz = outColor_9.xyz;
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_25.xxxx), tmpvar_32, fogParam_25.yyyy).xyz;
    outColor_9.xyz = tmpvar_33;
  };
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_24;
    xlat_varinput_24 = xlv_TEXCOORD6;
    mediump vec3 fogParam_25;
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_27;
    tmpvar_27 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_26))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_28;
    tmpvar_28 = clamp ((_UWFogColorHLIntensity * tmpvar_26), 0.0, 1.0);
    fogParam_25.z = 0.0;
    fogParam_25.y = tmpvar_27;
    fogParam_25.x = tmpvar_28;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_24.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_26 * _UWHeightRatio)));
      highp float tmpvar_29;
      tmpvar_29 = clamp (xlat_varinput_24.y, _UWCriticalRange, 1.0);
      xlat_varinput_24.y = tmpvar_29;
    };
    fogParam_25.z = (1.0 - xlat_varinput_24.y);
    mediump vec4 tmpvar_30;
    tmpvar_30.w = 0.0;
    tmpvar_30.xyz = outColor_9.xyz;
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_30, fogParam_25.zzzz).xyz;
    outColor_9.xyz = tmpvar_31;
    mediump vec4 tmpvar_32;
    tmpvar_32.w = 0.0;
    tmpvar_32.xyz = outColor_9.xyz;
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_25.xxxx), tmpvar_32, fogParam_25.yyyy).xyz;
    outColor_9.xyz = tmpvar_33;
  };
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec4 _BrushedNormalMap_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD6;
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
  mediump vec3 fogParam_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_30;
  tmpvar_30 = max (0.0, (sqrt(
    dot (tmpvar_29, tmpvar_29)
  ) - _UWFogDistStart));
  highp float tmpvar_31;
  tmpvar_31 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_30)
    ) * (_UWFogDensity * tmpvar_30))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_30))
   * 
    (_UWFogColorNFIntensity * tmpvar_30)
  )), 0.0, 1.0);
  fogParam_27.x = tmpvar_32;
  fogParam_27.y = tmpvar_31;
  fogParam_27.z = tmpvar_28.y;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
  xlv_COLOR1 = tmpvar_15;
  xlv_TEXCOORD6 = fogParam_27;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
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
uniform sampler2D _MainTex;
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _ShadowTex;
uniform sampler2D _ReflectMaskTex;
uniform highp float _LightMapIntensity;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform sampler2D _BrushedNormalMap;
uniform highp float _BrushScaleX;
uniform highp float _BrushScaleY;
uniform highp vec4 _FresnelParams;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec2 brushedValue_3;
  mediump vec3 I_4;
  mediump vec3 diffColor_5;
  mediump vec4 ShadowColor_6;
  mediump float reflectMask_7;
  mediump vec4 baseTexColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = texture2D (_MainTex, P_11);
  baseTexColor_8 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0).x;
  reflectMask_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD5);
  ShadowColor_6 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (baseTexColor_8.xyz * _Color.xyz);
  diffColor_5 = tmpvar_14;
  diffColor_5 = ((diffColor_5 * (
    (((2.0 * ShadowColor_6.xyz) * ShadowColor_6.w) + 1.0)
   - ShadowColor_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_4 = tmpvar_15;
  mediump float power_16;
  power_16 = _FresnelParams.x;
  mediump float scale_17;
  scale_17 = _FresnelParams.y;
  mediump float bias_18;
  bias_18 = _FresnelParams.z;
  lowp vec2 tmpvar_19;
  tmpvar_19 = texture2D (_BrushedNormalMap, xlv_TEXCOORD1).xy;
  brushedValue_3 = tmpvar_19;
  brushedValue_3 = ((brushedValue_3 * 2.0) - 1.0);
  highp vec2 tmpvar_20;
  tmpvar_20.x = _BrushScaleX;
  tmpvar_20.y = _BrushScaleY;
  brushedValue_3 = (brushedValue_3 * tmpvar_20);
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + brushedValue_3);
  uvSC_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_22;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_7);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = diffColor_5;
  tmpvar_23.w = _BloomFactor;
  outColor_9 = (tmpvar_23 + (reflColor_1 * (bias_18 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_4, xlv_TEXCOORD4))
    , 0.001, 1.0), power_16) * scale_17))
  )));
  if ((xlv_TEXCOORD6.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_24;
    xlat_varinput_24 = xlv_TEXCOORD6;
    mediump vec3 fogParam_25;
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD6.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_27;
    tmpvar_27 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_26))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_28;
    tmpvar_28 = clamp ((_UWFogColorHLIntensity * tmpvar_26), 0.0, 1.0);
    fogParam_25.z = 0.0;
    fogParam_25.y = tmpvar_27;
    fogParam_25.x = tmpvar_28;
    if ((xlv_TEXCOORD6.y > 0.99)) {
      xlat_varinput_24.y = (xlv_TEXCOORD6.y * (1.0 - (tmpvar_26 * _UWHeightRatio)));
      highp float tmpvar_29;
      tmpvar_29 = clamp (xlat_varinput_24.y, _UWCriticalRange, 1.0);
      xlat_varinput_24.y = tmpvar_29;
    };
    fogParam_25.z = (1.0 - xlat_varinput_24.y);
    mediump vec4 tmpvar_30;
    tmpvar_30.w = 0.0;
    tmpvar_30.xyz = outColor_9.xyz;
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD6.xxxx), tmpvar_30, fogParam_25.zzzz).xyz;
    outColor_9.xyz = tmpvar_31;
    mediump vec4 tmpvar_32;
    tmpvar_32.w = 0.0;
    tmpvar_32.xyz = outColor_9.xyz;
    highp vec3 tmpvar_33;
    tmpvar_33 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_25.xxxx), tmpvar_32, fogParam_25.yyyy).xyz;
    outColor_9.xyz = tmpvar_33;
  };
  outColor_9.xyz = mix (outColor_9.xyz, vec3(dot (outColor_9.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_9;
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
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
Keywords { "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
}
}
}
}