//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Layer0/Caustic" {
Properties {
_CausticColor ("Caustic Color", Color) = (1,0,0,1)
_Speed ("Speed", Range(0.001, 2)) = 0.5
_Frequency ("Frequency", Range(1, 200)) = 20
_Delta ("Delta", Range(0, 0.1)) = 0.01
_PhaseOffset ("PhaseOffset", Range(0, 6)) = 0
_CausticScale ("CausticScale", Range(0, 10)) = 3
_CausticIntensity ("CausticIntensity", Range(0, 5)) = 1
_MainTex ("CausticMap (RGB)", 2D) = "black" { }
_BloomFactor ("Bloom Factor", Float) = 1
[Toggle(WRITEDEPTH)] _WriteDepth ("WriteDepth", Float) = 0
[Toggle(TEXTURE_SCALE)] _TextureScale ("Texture Scale", Float) = 0
_TSAspectRatio ("Texture Aspect Ratio (width : height)", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DistortionTex ("Distortion Tex", 2D) = "gray" { }
_DistortionIntensity ("Distortion Intensity", Range(0, 10)) = 5
_OffestFactor ("OFfset Factor", Range(-100, 100)) = 0
_OffestUnit ("OFfset Unit", Range(-100, 100)) = 0
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 17893
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = mix (CausticColor_1.xyz, xlv_COLOR0.xyz, xlv_COLOR0.www);
  outColor_5.w = CausticColor_1.w;
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = mix (CausticColor_1.xyz, xlv_COLOR0.xyz, xlv_COLOR0.www);
  outColor_5.w = CausticColor_1.w;
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = mix (CausticColor_1.xyz, xlv_COLOR0.xyz, xlv_COLOR0.www);
  outColor_5.w = CausticColor_1.w;
  gl_FragData[0] = outColor_5;
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
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = mix (CausticColor_1.xyz, xlv_COLOR0.xyz, xlv_COLOR0.www);
  outColor_5.w = CausticColor_1.w;
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_5;
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
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = mix (CausticColor_1.xyz, xlv_COLOR0.xyz, xlv_COLOR0.www);
  outColor_5.w = CausticColor_1.w;
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_5;
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
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = mix (CausticColor_1.xyz, xlv_COLOR0.xyz, xlv_COLOR0.www);
  outColor_5.w = CausticColor_1.w;
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_5;
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
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = mix (CausticColor_1.xyz, xlv_COLOR0.xyz, xlv_COLOR0.www);
  outColor_5.w = CausticColor_1.w;
  gl_FragData[0] = outColor_5;
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
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = mix (CausticColor_1.xyz, xlv_COLOR0.xyz, xlv_COLOR0.www);
  outColor_5.w = CausticColor_1.w;
  gl_FragData[0] = outColor_5;
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
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = mix (CausticColor_1.xyz, xlv_COLOR0.xyz, xlv_COLOR0.www);
  outColor_5.w = CausticColor_1.w;
  gl_FragData[0] = outColor_5;
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
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = mix (CausticColor_1.xyz, xlv_COLOR0.xyz, xlv_COLOR0.www);
  outColor_5.w = CausticColor_1.w;
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_5;
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
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = mix (CausticColor_1.xyz, xlv_COLOR0.xyz, xlv_COLOR0.www);
  outColor_5.w = CausticColor_1.w;
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_5;
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
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = mix (CausticColor_1.xyz, xlv_COLOR0.xyz, xlv_COLOR0.www);
  outColor_5.w = CausticColor_1.w;
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = (xlv_COLOR0.xyz + (CausticColor_1.xyz * clamp (xlv_COLOR0.w, 0.0, 1.0)));
  outColor_5.w = CausticColor_1.w;
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = (xlv_COLOR0.xyz + (CausticColor_1.xyz * clamp (xlv_COLOR0.w, 0.0, 1.0)));
  outColor_5.w = CausticColor_1.w;
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = (xlv_COLOR0.xyz + (CausticColor_1.xyz * clamp (xlv_COLOR0.w, 0.0, 1.0)));
  outColor_5.w = CausticColor_1.w;
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = (xlv_COLOR0.xyz + (CausticColor_1.xyz * clamp (xlv_COLOR0.w, 0.0, 1.0)));
  outColor_5.w = CausticColor_1.w;
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = (xlv_COLOR0.xyz + (CausticColor_1.xyz * clamp (xlv_COLOR0.w, 0.0, 1.0)));
  outColor_5.w = CausticColor_1.w;
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = (xlv_COLOR0.xyz + (CausticColor_1.xyz * clamp (xlv_COLOR0.w, 0.0, 1.0)));
  outColor_5.w = CausticColor_1.w;
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = (xlv_COLOR0.xyz + (CausticColor_1.xyz * clamp (xlv_COLOR0.w, 0.0, 1.0)));
  outColor_5.w = CausticColor_1.w;
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = (xlv_COLOR0.xyz + (CausticColor_1.xyz * clamp (xlv_COLOR0.w, 0.0, 1.0)));
  outColor_5.w = CausticColor_1.w;
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = (xlv_COLOR0.xyz + (CausticColor_1.xyz * clamp (xlv_COLOR0.w, 0.0, 1.0)));
  outColor_5.w = CausticColor_1.w;
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = (xlv_COLOR0.xyz + (CausticColor_1.xyz * clamp (xlv_COLOR0.w, 0.0, 1.0)));
  outColor_5.w = CausticColor_1.w;
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = (xlv_COLOR0.xyz + (CausticColor_1.xyz * clamp (xlv_COLOR0.w, 0.0, 1.0)));
  outColor_5.w = CausticColor_1.w;
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = tmpvar_5;
  xlv_COLOR1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 CausticColor_1;
  mediump float dy_2;
  mediump float dx_3;
  highp vec2 p_4;
  mediump vec4 outColor_5;
  p_4 = xlv_TEXCOORD0;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _Speed);
  tmpvar_6 = (cos((
    ((p_4.x + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (cos((
    ((p_4.y + tmpvar_7) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_2 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = dx_3;
  tmpvar_9.y = dy_2;
  p_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + p_4) * _CausticScale);
  tmpvar_10 = texture2D (_MainTex, P_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10.y * _CausticColor) * (_CausticIntensity * xlv_COLOR1.w));
  CausticColor_1 = tmpvar_12;
  outColor_5.xyz = (xlv_COLOR0.xyz + (CausticColor_1.xyz * clamp (xlv_COLOR0.w, 0.0, 1.0)));
  outColor_5.w = CausticColor_1.w;
  outColor_5.xyz = mix (outColor_5.xyz, vec3(dot (outColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_5;
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
 Pass {
  Name "CONSTANT_MAX"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 119980
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 texColor_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_1 = tmpvar_3;
  mediump float tmpvar_4;
  tmpvar_4 = dot ((texColor_1.xyz * texColor_1.w), vec3(0.22, 0.707, 0.071));
  mediump float x_5;
  x_5 = (tmpvar_4 - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_2.w = ((_BloomFactor * tmpvar_4) * xlv_TEXCOORD1);
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 texColor_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_1 = tmpvar_3;
  mediump float tmpvar_4;
  tmpvar_4 = dot ((texColor_1.xyz * texColor_1.w), vec3(0.22, 0.707, 0.071));
  mediump float x_5;
  x_5 = (tmpvar_4 - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_2.w = ((_BloomFactor * tmpvar_4) * xlv_TEXCOORD1);
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 texColor_1;
  mediump vec4 color_2;
  color_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_1 = tmpvar_3;
  mediump float tmpvar_4;
  tmpvar_4 = dot ((texColor_1.xyz * texColor_1.w), vec3(0.22, 0.707, 0.071));
  mediump float x_5;
  x_5 = (tmpvar_4 - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_2.w = ((_BloomFactor * tmpvar_4) * xlv_TEXCOORD1);
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = tmpvar_1.w;
  highp vec2 texcoord_5;
  texcoord_5 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_6;
    tmpvar_6.x = 1.0;
    tmpvar_6.y = _TSAspectRatio;
    texcoord_5 = (texcoord_5 * tmpvar_6);
  } else {
    highp vec2 tmpvar_7;
    tmpvar_7.y = 1.0;
    tmpvar_7.x = (1.0/(_TSAspectRatio));
    texcoord_5 = (texcoord_5 * tmpvar_7);
  };
  texcoord_5 = (texcoord_5 + 0.5);
  texcoord_5 = ((texcoord_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.zw = _MainTex_ST.xy;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_5;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_8 + _MainTex_ST.zwzw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texColor_1;
  mediump vec4 color_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.x - xlv_TEXCOORD2.x);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD0.y - xlv_TEXCOORD2.y);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2.z - xlv_TEXCOORD0.x);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD2.w - xlv_TEXCOORD0.y);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot ((texColor_1.xyz * texColor_1.w), vec3(0.22, 0.707, 0.071));
  mediump float x_9;
  x_9 = (tmpvar_8 - 0.01);
  if ((x_9 < 0.0)) {
    discard;
  };
  color_2.w = ((_BloomFactor * tmpvar_8) * xlv_TEXCOORD1);
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = tmpvar_1.w;
  highp vec2 texcoord_5;
  texcoord_5 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_6;
    tmpvar_6.x = 1.0;
    tmpvar_6.y = _TSAspectRatio;
    texcoord_5 = (texcoord_5 * tmpvar_6);
  } else {
    highp vec2 tmpvar_7;
    tmpvar_7.y = 1.0;
    tmpvar_7.x = (1.0/(_TSAspectRatio));
    texcoord_5 = (texcoord_5 * tmpvar_7);
  };
  texcoord_5 = (texcoord_5 + 0.5);
  texcoord_5 = ((texcoord_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.zw = _MainTex_ST.xy;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_5;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_8 + _MainTex_ST.zwzw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texColor_1;
  mediump vec4 color_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.x - xlv_TEXCOORD2.x);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD0.y - xlv_TEXCOORD2.y);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2.z - xlv_TEXCOORD0.x);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD2.w - xlv_TEXCOORD0.y);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot ((texColor_1.xyz * texColor_1.w), vec3(0.22, 0.707, 0.071));
  mediump float x_9;
  x_9 = (tmpvar_8 - 0.01);
  if ((x_9 < 0.0)) {
    discard;
  };
  color_2.w = ((_BloomFactor * tmpvar_8) * xlv_TEXCOORD1);
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = tmpvar_1.w;
  highp vec2 texcoord_5;
  texcoord_5 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_6;
    tmpvar_6.x = 1.0;
    tmpvar_6.y = _TSAspectRatio;
    texcoord_5 = (texcoord_5 * tmpvar_6);
  } else {
    highp vec2 tmpvar_7;
    tmpvar_7.y = 1.0;
    tmpvar_7.x = (1.0/(_TSAspectRatio));
    texcoord_5 = (texcoord_5 * tmpvar_7);
  };
  texcoord_5 = (texcoord_5 + 0.5);
  texcoord_5 = ((texcoord_5 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.zw = _MainTex_ST.xy;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_5;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_8 + _MainTex_ST.zwzw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 texColor_1;
  mediump vec4 color_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.x - xlv_TEXCOORD2.x);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD0.y - xlv_TEXCOORD2.y);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2.z - xlv_TEXCOORD0.x);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD2.w - xlv_TEXCOORD0.y);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot ((texColor_1.xyz * texColor_1.w), vec3(0.22, 0.707, 0.071));
  mediump float x_9;
  x_9 = (tmpvar_8 - 0.01);
  if ((x_9 < 0.0)) {
    discard;
  };
  color_2.w = ((_BloomFactor * tmpvar_8) * xlv_TEXCOORD1);
  gl_FragData[0] = color_2;
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
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}