//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/AirDestruction_AlphaBlend" {
Properties {
_MainTex ("Color Tex (RGB)", 2D) = "gray" { }
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_DestructionAlpha ("Destruction Alpha", Range(0, 1)) = 1
}
SubShader {
 Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 12398
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
uniform mediump vec4 _MainTex_ST;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  outColor_2.xyz = mix (texMainColor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  outColor_2.xyz = mix (texMainColor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  outColor_2.xyz = mix (texMainColor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  outColor_2.xyz = mix (texMainColor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  outColor_2.xyz = mix (texMainColor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  outColor_2.xyz = mix (texMainColor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = fogParam_2;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD2;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    texMainColor_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    texMainColor_1.xyz = tmpvar_13;
  };
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = fogParam_2;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD2;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    texMainColor_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    texMainColor_1.xyz = tmpvar_13;
  };
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = fogParam_2;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD2;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    texMainColor_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    texMainColor_1.xyz = tmpvar_13;
  };
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = fogParam_2;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD2;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    texMainColor_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    texMainColor_1.xyz = tmpvar_13;
  };
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = fogParam_2;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD2;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    texMainColor_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    texMainColor_1.xyz = tmpvar_13;
  };
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = fogParam_2;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD2;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    texMainColor_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    texMainColor_1.xyz = tmpvar_13;
  };
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
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
uniform mediump float _DestructionAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  outColor_2.xyz = mix (texMainColor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _DestructionAlpha;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
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
uniform mediump float _DestructionAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  outColor_2.xyz = mix (texMainColor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _DestructionAlpha;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
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
uniform mediump float _DestructionAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  outColor_2.xyz = mix (texMainColor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _DestructionAlpha;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
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
uniform mediump float _DestructionAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  outColor_2.xyz = mix (texMainColor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _DestructionAlpha;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
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
uniform mediump float _DestructionAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  outColor_2.xyz = mix (texMainColor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _DestructionAlpha;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
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
uniform mediump float _DestructionAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  outColor_2.xyz = mix (texMainColor_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _DestructionAlpha;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = fogParam_2;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD2;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    texMainColor_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    texMainColor_1.xyz = tmpvar_13;
  };
  outColor_2.xyz = vec3(0.0, 0.0, 0.0);
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = fogParam_2;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD2;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    texMainColor_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    texMainColor_1.xyz = tmpvar_13;
  };
  outColor_2.xyz = vec3(0.0, 0.0, 0.0);
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = fogParam_2;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD2;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    texMainColor_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    texMainColor_1.xyz = tmpvar_13;
  };
  outColor_2.xyz = vec3(0.0, 0.0, 0.0);
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = fogParam_2;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD2;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    texMainColor_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    texMainColor_1.xyz = tmpvar_13;
  };
  outColor_2.xyz = vec3(0.0, 0.0, 0.0);
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = fogParam_2;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD2;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    texMainColor_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    texMainColor_1.xyz = tmpvar_13;
  };
  outColor_2.xyz = vec3(0.0, 0.0, 0.0);
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = fogParam_2;
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
uniform mediump float _DestructionAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texMainColor_1;
  mediump vec4 outColor_2;
  outColor_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texMainColor_1 = tmpvar_3;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_4;
    xlat_varinput_4 = xlv_TEXCOORD2;
    mediump vec3 fogParam_5;
    highp float tmpvar_6;
    tmpvar_6 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_7;
    tmpvar_7 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_6))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_8;
    tmpvar_8 = clamp ((_UWFogColorHLIntensity * tmpvar_6), 0.0, 1.0);
    fogParam_5.z = 0.0;
    fogParam_5.y = tmpvar_7;
    fogParam_5.x = tmpvar_8;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_4.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_6 * _UWHeightRatio)));
      highp float tmpvar_9;
      tmpvar_9 = clamp (xlat_varinput_4.y, _UWCriticalRange, 1.0);
      xlat_varinput_4.y = tmpvar_9;
    };
    fogParam_5.z = (1.0 - xlat_varinput_4.y);
    mediump vec4 tmpvar_10;
    tmpvar_10.w = 0.0;
    tmpvar_10.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_10, fogParam_5.zzzz).xyz;
    texMainColor_1.xyz = tmpvar_11;
    mediump vec4 tmpvar_12;
    tmpvar_12.w = 0.0;
    tmpvar_12.xyz = texMainColor_1.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_5.xxxx), tmpvar_12, fogParam_5.yyyy).xyz;
    texMainColor_1.xyz = tmpvar_13;
  };
  outColor_2.xyz = vec3(0.0, 0.0, 0.0);
  outColor_2.w = clamp (_DestructionAlpha, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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