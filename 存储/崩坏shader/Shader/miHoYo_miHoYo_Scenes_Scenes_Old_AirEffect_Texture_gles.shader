//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/AirEffect_Texture" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "gray" { }
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 26929
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  mediump vec3 fogParam_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, (sqrt(
    dot (tmpvar_18, tmpvar_18)
  ) - _UWFogDistStart));
  highp float tmpvar_20;
  tmpvar_20 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_19)
    ) * (_UWFogDensity * tmpvar_19))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_21;
  tmpvar_21 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_19))
   * 
    (_UWFogColorNFIntensity * tmpvar_19)
  )), 0.0, 1.0);
  fogParam_16.x = tmpvar_21;
  fogParam_16.y = tmpvar_20;
  fogParam_16.z = tmpvar_17.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_16;
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
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD2;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  mediump vec3 fogParam_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, (sqrt(
    dot (tmpvar_18, tmpvar_18)
  ) - _UWFogDistStart));
  highp float tmpvar_20;
  tmpvar_20 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_19)
    ) * (_UWFogDensity * tmpvar_19))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_21;
  tmpvar_21 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_19))
   * 
    (_UWFogColorNFIntensity * tmpvar_19)
  )), 0.0, 1.0);
  fogParam_16.x = tmpvar_21;
  fogParam_16.y = tmpvar_20;
  fogParam_16.z = tmpvar_17.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_16;
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
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD2;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  mediump vec3 fogParam_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, (sqrt(
    dot (tmpvar_18, tmpvar_18)
  ) - _UWFogDistStart));
  highp float tmpvar_20;
  tmpvar_20 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_19)
    ) * (_UWFogDensity * tmpvar_19))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_21;
  tmpvar_21 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_19))
   * 
    (_UWFogColorNFIntensity * tmpvar_19)
  )), 0.0, 1.0);
  fogParam_16.x = tmpvar_21;
  fogParam_16.y = tmpvar_20;
  fogParam_16.z = tmpvar_17.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_16;
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
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD2;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  mediump vec3 fogParam_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, (sqrt(
    dot (tmpvar_18, tmpvar_18)
  ) - _UWFogDistStart));
  highp float tmpvar_20;
  tmpvar_20 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_19)
    ) * (_UWFogDensity * tmpvar_19))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_21;
  tmpvar_21 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_19))
   * 
    (_UWFogColorNFIntensity * tmpvar_19)
  )), 0.0, 1.0);
  fogParam_16.x = tmpvar_21;
  fogParam_16.y = tmpvar_20;
  fogParam_16.z = tmpvar_17.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_16;
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
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD2;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  mediump vec3 fogParam_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, (sqrt(
    dot (tmpvar_18, tmpvar_18)
  ) - _UWFogDistStart));
  highp float tmpvar_20;
  tmpvar_20 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_19)
    ) * (_UWFogDensity * tmpvar_19))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_21;
  tmpvar_21 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_19))
   * 
    (_UWFogColorNFIntensity * tmpvar_19)
  )), 0.0, 1.0);
  fogParam_16.x = tmpvar_21;
  fogParam_16.y = tmpvar_20;
  fogParam_16.z = tmpvar_17.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_16;
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
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD2;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  mediump vec3 fogParam_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, (sqrt(
    dot (tmpvar_18, tmpvar_18)
  ) - _UWFogDistStart));
  highp float tmpvar_20;
  tmpvar_20 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_19)
    ) * (_UWFogDensity * tmpvar_19))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_21;
  tmpvar_21 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_19))
   * 
    (_UWFogColorNFIntensity * tmpvar_19)
  )), 0.0, 1.0);
  fogParam_16.x = tmpvar_21;
  fogParam_16.y = tmpvar_20;
  fogParam_16.z = tmpvar_17.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_16;
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
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD2;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  mediump vec3 fogParam_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, (sqrt(
    dot (tmpvar_18, tmpvar_18)
  ) - _UWFogDistStart));
  highp float tmpvar_20;
  tmpvar_20 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_19)
    ) * (_UWFogDensity * tmpvar_19))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_21;
  tmpvar_21 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_19))
   * 
    (_UWFogColorNFIntensity * tmpvar_19)
  )), 0.0, 1.0);
  fogParam_16.x = tmpvar_21;
  fogParam_16.y = tmpvar_20;
  fogParam_16.z = tmpvar_17.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_16;
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
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD2;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  mediump vec3 fogParam_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, (sqrt(
    dot (tmpvar_18, tmpvar_18)
  ) - _UWFogDistStart));
  highp float tmpvar_20;
  tmpvar_20 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_19)
    ) * (_UWFogDensity * tmpvar_19))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_21;
  tmpvar_21 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_19))
   * 
    (_UWFogColorNFIntensity * tmpvar_19)
  )), 0.0, 1.0);
  fogParam_16.x = tmpvar_21;
  fogParam_16.y = tmpvar_20;
  fogParam_16.z = tmpvar_17.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_16;
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
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD2;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  mediump vec3 fogParam_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, (sqrt(
    dot (tmpvar_18, tmpvar_18)
  ) - _UWFogDistStart));
  highp float tmpvar_20;
  tmpvar_20 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_19)
    ) * (_UWFogDensity * tmpvar_19))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_21;
  tmpvar_21 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_19))
   * 
    (_UWFogColorNFIntensity * tmpvar_19)
  )), 0.0, 1.0);
  fogParam_16.x = tmpvar_21;
  fogParam_16.y = tmpvar_20;
  fogParam_16.z = tmpvar_17.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_16;
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
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD2;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  mediump vec3 fogParam_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, (sqrt(
    dot (tmpvar_18, tmpvar_18)
  ) - _UWFogDistStart));
  highp float tmpvar_20;
  tmpvar_20 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_19)
    ) * (_UWFogDensity * tmpvar_19))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_21;
  tmpvar_21 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_19))
   * 
    (_UWFogColorNFIntensity * tmpvar_19)
  )), 0.0, 1.0);
  fogParam_16.x = tmpvar_21;
  fogParam_16.y = tmpvar_20;
  fogParam_16.z = tmpvar_17.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_16;
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
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD2;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  mediump vec3 fogParam_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, (sqrt(
    dot (tmpvar_18, tmpvar_18)
  ) - _UWFogDistStart));
  highp float tmpvar_20;
  tmpvar_20 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_19)
    ) * (_UWFogDensity * tmpvar_19))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_21;
  tmpvar_21 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_19))
   * 
    (_UWFogColorNFIntensity * tmpvar_19)
  )), 0.0, 1.0);
  fogParam_16.x = tmpvar_21;
  fogParam_16.y = tmpvar_20;
  fogParam_16.z = tmpvar_17.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_16;
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
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD2;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_4;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_5;
    highp vec3 tmpvar_6;
    tmpvar_6 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_7;
    tmpvar_7 = max (0.0, (sqrt(
      dot (tmpvar_6, tmpvar_6)
    ) - _FogStartDistance));
    highp float tmpvar_8;
    tmpvar_8 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_7)
      ) * (_FogIntensity * tmpvar_7))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_9;
    tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
    ), 0.0, 1.0)));
    fogColor_5.xyz = tmpvar_9;
    fogColor_5.w = tmpvar_8;
    tmpvar_4 = fogColor_5;
  } else {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    highp float tmpvar_14;
    tmpvar_14 = (_FogEndDistance - _FogStartDistance);
    tmpvar_13 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_12) / max (0.1, tmpvar_14))
    , 0.0, 1.0))));
    fogColor_10.xyz = tmpvar_15;
    fogColor_10.w = tmpvar_13;
    tmpvar_4 = fogColor_10;
  };
  mediump vec3 fogParam_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_17.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_19;
  tmpvar_19 = max (0.0, (sqrt(
    dot (tmpvar_18, tmpvar_18)
  ) - _UWFogDistStart));
  highp float tmpvar_20;
  tmpvar_20 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_19)
    ) * (_UWFogDensity * tmpvar_19))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_21;
  tmpvar_21 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_19))
   * 
    (_UWFogColorNFIntensity * tmpvar_19)
  )), 0.0, 1.0);
  fogParam_16.x = tmpvar_21;
  fogParam_16.y = tmpvar_20;
  fogParam_16.z = tmpvar_17.y;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD2 = fogParam_16;
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
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD2;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = _BloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
}
}
}
}