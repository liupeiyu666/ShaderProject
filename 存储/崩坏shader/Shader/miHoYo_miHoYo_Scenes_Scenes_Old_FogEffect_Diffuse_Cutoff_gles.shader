//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/FogEffect_Diffuse_Cutoff" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
[Toggle] _UseMiHoYoLightDir ("Use Env Light Dir", Float) = 1
_LightDir ("Light Dir", Vector) = (0,-1,0,0)
_LightColor ("Light Color", Color) = (1,1,1,1)
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,0.5)
_BloomFactor ("Bloom Factor", Float) = 1
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_EmissionScaler ("Emission Scaler", Float) = 1
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 63879
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  mediump vec3 fogParam_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_24;
  tmpvar_24 = max (0.0, (sqrt(
    dot (tmpvar_23, tmpvar_23)
  ) - _UWFogDistStart));
  highp float tmpvar_25;
  tmpvar_25 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_24)
    ) * (_UWFogDensity * tmpvar_24))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_26;
  tmpvar_26 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_24))
   * 
    (_UWFogColorNFIntensity * tmpvar_24)
  )), 0.0, 1.0);
  fogParam_21.x = tmpvar_26;
  fogParam_21.y = tmpvar_25;
  fogParam_21.z = tmpvar_22.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_21;
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
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD1;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = col_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    col_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = col_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    col_1.xyz = tmpvar_13;
  };
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  mediump vec3 fogParam_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_24;
  tmpvar_24 = max (0.0, (sqrt(
    dot (tmpvar_23, tmpvar_23)
  ) - _UWFogDistStart));
  highp float tmpvar_25;
  tmpvar_25 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_24)
    ) * (_UWFogDensity * tmpvar_24))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_26;
  tmpvar_26 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_24))
   * 
    (_UWFogColorNFIntensity * tmpvar_24)
  )), 0.0, 1.0);
  fogParam_21.x = tmpvar_26;
  fogParam_21.y = tmpvar_25;
  fogParam_21.z = tmpvar_22.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_21;
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
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD1;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = col_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    col_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = col_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    col_1.xyz = tmpvar_13;
  };
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  mediump vec3 fogParam_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_24;
  tmpvar_24 = max (0.0, (sqrt(
    dot (tmpvar_23, tmpvar_23)
  ) - _UWFogDistStart));
  highp float tmpvar_25;
  tmpvar_25 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_24)
    ) * (_UWFogDensity * tmpvar_24))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_26;
  tmpvar_26 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_24))
   * 
    (_UWFogColorNFIntensity * tmpvar_24)
  )), 0.0, 1.0);
  fogParam_21.x = tmpvar_26;
  fogParam_21.y = tmpvar_25;
  fogParam_21.z = tmpvar_22.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_21;
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
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD1;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = col_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    col_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = col_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    col_1.xyz = tmpvar_13;
  };
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  mediump vec3 fogParam_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_24;
  tmpvar_24 = max (0.0, (sqrt(
    dot (tmpvar_23, tmpvar_23)
  ) - _UWFogDistStart));
  highp float tmpvar_25;
  tmpvar_25 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_24)
    ) * (_UWFogDensity * tmpvar_24))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_26;
  tmpvar_26 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_24))
   * 
    (_UWFogColorNFIntensity * tmpvar_24)
  )), 0.0, 1.0);
  fogParam_21.x = tmpvar_26;
  fogParam_21.y = tmpvar_25;
  fogParam_21.z = tmpvar_22.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_21;
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
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD1;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = col_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    col_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = col_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    col_1.xyz = tmpvar_13;
  };
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  mediump vec3 fogParam_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_24;
  tmpvar_24 = max (0.0, (sqrt(
    dot (tmpvar_23, tmpvar_23)
  ) - _UWFogDistStart));
  highp float tmpvar_25;
  tmpvar_25 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_24)
    ) * (_UWFogDensity * tmpvar_24))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_26;
  tmpvar_26 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_24))
   * 
    (_UWFogColorNFIntensity * tmpvar_24)
  )), 0.0, 1.0);
  fogParam_21.x = tmpvar_26;
  fogParam_21.y = tmpvar_25;
  fogParam_21.z = tmpvar_22.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_21;
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
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD1;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = col_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    col_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = col_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    col_1.xyz = tmpvar_13;
  };
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  mediump vec3 fogParam_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_24;
  tmpvar_24 = max (0.0, (sqrt(
    dot (tmpvar_23, tmpvar_23)
  ) - _UWFogDistStart));
  highp float tmpvar_25;
  tmpvar_25 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_24)
    ) * (_UWFogDensity * tmpvar_24))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_26;
  tmpvar_26 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_24))
   * 
    (_UWFogColorNFIntensity * tmpvar_24)
  )), 0.0, 1.0);
  fogParam_21.x = tmpvar_26;
  fogParam_21.y = tmpvar_25;
  fogParam_21.z = tmpvar_22.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_21;
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
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD1;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = col_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    col_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = col_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    col_1.xyz = tmpvar_13;
  };
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  mediump vec3 fogParam_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_24;
  tmpvar_24 = max (0.0, (sqrt(
    dot (tmpvar_23, tmpvar_23)
  ) - _UWFogDistStart));
  highp float tmpvar_25;
  tmpvar_25 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_24)
    ) * (_UWFogDensity * tmpvar_24))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_26;
  tmpvar_26 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_24))
   * 
    (_UWFogColorNFIntensity * tmpvar_24)
  )), 0.0, 1.0);
  fogParam_21.x = tmpvar_26;
  fogParam_21.y = tmpvar_25;
  fogParam_21.z = tmpvar_22.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_21;
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
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD1;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = col_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    col_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = col_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    col_1.xyz = tmpvar_13;
  };
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  mediump vec3 fogParam_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_24;
  tmpvar_24 = max (0.0, (sqrt(
    dot (tmpvar_23, tmpvar_23)
  ) - _UWFogDistStart));
  highp float tmpvar_25;
  tmpvar_25 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_24)
    ) * (_UWFogDensity * tmpvar_24))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_26;
  tmpvar_26 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_24))
   * 
    (_UWFogColorNFIntensity * tmpvar_24)
  )), 0.0, 1.0);
  fogParam_21.x = tmpvar_26;
  fogParam_21.y = tmpvar_25;
  fogParam_21.z = tmpvar_22.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_21;
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
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD1;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = col_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    col_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = col_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    col_1.xyz = tmpvar_13;
  };
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  mediump vec3 fogParam_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_24;
  tmpvar_24 = max (0.0, (sqrt(
    dot (tmpvar_23, tmpvar_23)
  ) - _UWFogDistStart));
  highp float tmpvar_25;
  tmpvar_25 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_24)
    ) * (_UWFogDensity * tmpvar_24))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_26;
  tmpvar_26 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_24))
   * 
    (_UWFogColorNFIntensity * tmpvar_24)
  )), 0.0, 1.0);
  fogParam_21.x = tmpvar_26;
  fogParam_21.y = tmpvar_25;
  fogParam_21.z = tmpvar_22.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_21;
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
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD1;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = col_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    col_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = col_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    col_1.xyz = tmpvar_13;
  };
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  mediump vec3 fogParam_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_24;
  tmpvar_24 = max (0.0, (sqrt(
    dot (tmpvar_23, tmpvar_23)
  ) - _UWFogDistStart));
  highp float tmpvar_25;
  tmpvar_25 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_24)
    ) * (_UWFogDensity * tmpvar_24))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_26;
  tmpvar_26 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_24))
   * 
    (_UWFogColorNFIntensity * tmpvar_24)
  )), 0.0, 1.0);
  fogParam_21.x = tmpvar_26;
  fogParam_21.y = tmpvar_25;
  fogParam_21.z = tmpvar_22.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_21;
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
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD1;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = col_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    col_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = col_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    col_1.xyz = tmpvar_13;
  };
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  mediump vec3 fogParam_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_24;
  tmpvar_24 = max (0.0, (sqrt(
    dot (tmpvar_23, tmpvar_23)
  ) - _UWFogDistStart));
  highp float tmpvar_25;
  tmpvar_25 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_24)
    ) * (_UWFogDensity * tmpvar_24))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_26;
  tmpvar_26 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_24))
   * 
    (_UWFogColorNFIntensity * tmpvar_24)
  )), 0.0, 1.0);
  fogParam_21.x = tmpvar_26;
  fogParam_21.y = tmpvar_25;
  fogParam_21.z = tmpvar_22.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_21;
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
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD1;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = col_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    col_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = col_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    col_1.xyz = tmpvar_13;
  };
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump float _UseMiHoYoLightDir;
uniform mediump vec3 _miHoYo_LightDir;
uniform mediump vec3 _LightDir;
uniform mediump vec3 _LightColor;
uniform mediump vec3 _ShadowColor;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_1 = _glesNormal;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  tmpvar_5 = tmpvar_2.xyz;
  mediump vec3 tmpvar_19;
  if (bool(_UseMiHoYoLightDir)) {
    tmpvar_19 = -(_miHoYo_LightDir);
  } else {
    tmpvar_19 = normalize(-(_LightDir));
  };
  mediump vec3 N_20;
  N_20 = tmpvar_1;
  tmpvar_5 = (_glesColor.xyz * mix (_ShadowColor, (_LightColor * _EmissionScaler), vec3((
    (dot (N_20, tmpvar_19) * 0.4975)
   + 0.5))));
  mediump vec3 fogParam_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_24;
  tmpvar_24 = max (0.0, (sqrt(
    dot (tmpvar_23, tmpvar_23)
  ) - _UWFogDistStart));
  highp float tmpvar_25;
  tmpvar_25 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_24)
    ) * (_UWFogDensity * tmpvar_24))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_26;
  tmpvar_26 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_24))
   * 
    (_UWFogColorNFIntensity * tmpvar_24)
  )), 0.0, 1.0);
  fogParam_21.x = tmpvar_26;
  fogParam_21.y = tmpvar_25;
  fogParam_21.z = tmpvar_22.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_7;
  xlv_TEXCOORD1 = fogParam_21;
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
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  if ((xlv_TEXCOORD1.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD1;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = col_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    col_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = col_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    col_1.xyz = tmpvar_13;
  };
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
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
}