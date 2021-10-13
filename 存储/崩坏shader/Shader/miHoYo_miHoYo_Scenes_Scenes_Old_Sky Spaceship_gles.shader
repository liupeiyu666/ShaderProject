//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Sky Spaceship" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
_TexRColor ("Texture Color For R Channel", Color) = (1,1,1,1)
_TexGColor ("Texture Color For G Channel", Color) = (1,1,1,1)
_TexBColor ("Texture Color For B Channel", Color) = (1,1,1,1)
_TexXLocation ("Texture Location X", Range(0, 1)) = 0
_TexYLocation ("Texture Location Y", Range(0, 1)) = 0.5
_TexScaleX ("Texture ScaleX", Range(0.01, 2)) = 1
_TexScaleY ("Texture ScaleY", Range(0.01, 2)) = 1
_CloudMaskIntensity ("Cloud Mask Intensity", Range(0, 1)) = 1
_SecTex ("Second Texture", 2D) = "white" { }
_SecTexXLocation ("Second Texture Location X", Range(0, 1)) = 0
_SecTexYLocation ("Second Texture Location Y", Range(0, 1)) = 0.5
_SecTexHigh ("Second Texture High", Range(0.01, 1)) = 1
_SecTexEmission ("Second Texture Emission", Range(0, 10)) = 1
_GradBottomColor ("Gradiant Bottom Color", Color) = (1,1,1,1)
_GradTopColor ("Gradiant Top Color", Color) = (1,1,1,1)
_GradFrontColor ("Gradiant Front Color", Color) = (1,1,1,1)
_GradBackColor ("Gradiant Back Color", Color) = (1,1,1,1)
_GradLocationY ("Gradiant LocationY", Range(-5, 1)) = 0
_GradHighY ("Gradiant HighY", Range(0.01, 10)) = 1
_GradLocationX ("Gradiant LocationX", Range(-5, 1)) = 0
_GradHighX ("Gradiant HighX", Range(0.01, 10)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Background" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Background" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 32776
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
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexScaleX;
uniform highp float _TexScaleY;
uniform highp vec4 _SecTex_ST;
uniform highp float _GradLocationY;
uniform highp float _GradHighY;
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _TexXLocation;
  tmpvar_4.y = -(_TexYLocation);
  tmpvar_1.xy = (_glesMultiTexCoord0.xy + tmpvar_4);
  tmpvar_1.x = (tmpvar_1.x / _TexScaleX);
  tmpvar_1.y = (tmpvar_1.y / _TexScaleY);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _SecTex_ST.xy) + _SecTex_ST.zw);
  tmpvar_2.y = ((_glesMultiTexCoord0.y + _GradLocationY) / _GradHighY);
  tmpvar_2.x = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
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
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
  ), 0.0, 1.0)));
  fogColor_5.xyz = tmpvar_9;
  fogColor_5.w = tmpvar_8;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = fogColor_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskTB_2;
  mediump float maskFB_3;
  mediump vec4 outColor_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1.x, 0.0, 1.0);
  maskFB_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (xlv_TEXCOORD1.y, 0.0, 1.0);
  maskTB_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (_GradFrontColor, _GradBackColor, vec4(maskFB_3));
  outColor_4 = (mix (_GradBottomColor, _GradTopColor, vec4(maskTB_2)) * tmpvar_7);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_8;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    mediump vec4 tmpvar_9;
    tmpvar_9 = vec4((texCol_1.x * _TexRColor.w));
    highp vec4 tmpvar_10;
    tmpvar_10 = mix (outColor_4, (_TexRColor * mix (1.0, maskFB_3, _CloudMaskIntensity)), tmpvar_9);
    outColor_4 = tmpvar_10;
    outColor_4 = (mix (mix (outColor_4, 
      (_TexGColor * tmpvar_7)
    , vec4(
      (texCol_1.y * _TexGColor.w)
    )), vec4(1.0, 1.0, 1.0, 1.0), (
      (_TexBColor * texCol_1.z)
     * 2.0)) + ((_TexBColor * texCol_1.z) * (1.0 - maskFB_3)));
  };
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexScaleX;
uniform highp float _TexScaleY;
uniform highp vec4 _SecTex_ST;
uniform highp float _GradLocationY;
uniform highp float _GradHighY;
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _TexXLocation;
  tmpvar_4.y = -(_TexYLocation);
  tmpvar_1.xy = (_glesMultiTexCoord0.xy + tmpvar_4);
  tmpvar_1.x = (tmpvar_1.x / _TexScaleX);
  tmpvar_1.y = (tmpvar_1.y / _TexScaleY);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _SecTex_ST.xy) + _SecTex_ST.zw);
  tmpvar_2.y = ((_glesMultiTexCoord0.y + _GradLocationY) / _GradHighY);
  tmpvar_2.x = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
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
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
  ), 0.0, 1.0)));
  fogColor_5.xyz = tmpvar_9;
  fogColor_5.w = tmpvar_8;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = fogColor_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskTB_2;
  mediump float maskFB_3;
  mediump vec4 outColor_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1.x, 0.0, 1.0);
  maskFB_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (xlv_TEXCOORD1.y, 0.0, 1.0);
  maskTB_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (_GradFrontColor, _GradBackColor, vec4(maskFB_3));
  outColor_4 = (mix (_GradBottomColor, _GradTopColor, vec4(maskTB_2)) * tmpvar_7);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_8;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    mediump vec4 tmpvar_9;
    tmpvar_9 = vec4((texCol_1.x * _TexRColor.w));
    highp vec4 tmpvar_10;
    tmpvar_10 = mix (outColor_4, (_TexRColor * mix (1.0, maskFB_3, _CloudMaskIntensity)), tmpvar_9);
    outColor_4 = tmpvar_10;
    outColor_4 = (mix (mix (outColor_4, 
      (_TexGColor * tmpvar_7)
    , vec4(
      (texCol_1.y * _TexGColor.w)
    )), vec4(1.0, 1.0, 1.0, 1.0), (
      (_TexBColor * texCol_1.z)
     * 2.0)) + ((_TexBColor * texCol_1.z) * (1.0 - maskFB_3)));
  };
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexScaleX;
uniform highp float _TexScaleY;
uniform highp vec4 _SecTex_ST;
uniform highp float _GradLocationY;
uniform highp float _GradHighY;
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _TexXLocation;
  tmpvar_4.y = -(_TexYLocation);
  tmpvar_1.xy = (_glesMultiTexCoord0.xy + tmpvar_4);
  tmpvar_1.x = (tmpvar_1.x / _TexScaleX);
  tmpvar_1.y = (tmpvar_1.y / _TexScaleY);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _SecTex_ST.xy) + _SecTex_ST.zw);
  tmpvar_2.y = ((_glesMultiTexCoord0.y + _GradLocationY) / _GradHighY);
  tmpvar_2.x = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
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
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
  ), 0.0, 1.0)));
  fogColor_5.xyz = tmpvar_9;
  fogColor_5.w = tmpvar_8;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = fogColor_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskTB_2;
  mediump float maskFB_3;
  mediump vec4 outColor_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1.x, 0.0, 1.0);
  maskFB_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (xlv_TEXCOORD1.y, 0.0, 1.0);
  maskTB_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (_GradFrontColor, _GradBackColor, vec4(maskFB_3));
  outColor_4 = (mix (_GradBottomColor, _GradTopColor, vec4(maskTB_2)) * tmpvar_7);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_8;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    mediump vec4 tmpvar_9;
    tmpvar_9 = vec4((texCol_1.x * _TexRColor.w));
    highp vec4 tmpvar_10;
    tmpvar_10 = mix (outColor_4, (_TexRColor * mix (1.0, maskFB_3, _CloudMaskIntensity)), tmpvar_9);
    outColor_4 = tmpvar_10;
    outColor_4 = (mix (mix (outColor_4, 
      (_TexGColor * tmpvar_7)
    , vec4(
      (texCol_1.y * _TexGColor.w)
    )), vec4(1.0, 1.0, 1.0, 1.0), (
      (_TexBColor * texCol_1.z)
     * 2.0)) + ((_TexBColor * texCol_1.z) * (1.0 - maskFB_3)));
  };
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexScaleX;
uniform highp float _TexScaleY;
uniform highp vec4 _SecTex_ST;
uniform highp float _GradLocationY;
uniform highp float _GradHighY;
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _TexXLocation;
  tmpvar_4.y = -(_TexYLocation);
  tmpvar_1.xy = (_glesMultiTexCoord0.xy + tmpvar_4);
  tmpvar_1.x = (tmpvar_1.x / _TexScaleX);
  tmpvar_1.y = (tmpvar_1.y / _TexScaleY);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _SecTex_ST.xy) + _SecTex_ST.zw);
  tmpvar_2.y = ((_glesMultiTexCoord0.y + _GradLocationY) / _GradHighY);
  tmpvar_2.x = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
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
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
  ), 0.0, 1.0)));
  fogColor_5.xyz = tmpvar_9;
  fogColor_5.w = tmpvar_8;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = fogColor_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskTB_2;
  mediump float maskFB_3;
  mediump vec4 outColor_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1.x, 0.0, 1.0);
  maskFB_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (xlv_TEXCOORD1.y, 0.0, 1.0);
  maskTB_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (_GradFrontColor, _GradBackColor, vec4(maskFB_3));
  outColor_4 = (mix (_GradBottomColor, _GradTopColor, vec4(maskTB_2)) * tmpvar_7);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_8;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    mediump vec4 tmpvar_9;
    tmpvar_9 = vec4((texCol_1.x * _TexRColor.w));
    highp vec4 tmpvar_10;
    tmpvar_10 = mix (outColor_4, (_TexRColor * mix (1.0, maskFB_3, _CloudMaskIntensity)), tmpvar_9);
    outColor_4 = tmpvar_10;
    outColor_4 = (mix (mix (outColor_4, 
      (_TexGColor * tmpvar_7)
    , vec4(
      (texCol_1.y * _TexGColor.w)
    )), vec4(1.0, 1.0, 1.0, 1.0), (
      (_TexBColor * texCol_1.z)
     * 2.0)) + ((_TexBColor * texCol_1.z) * (1.0 - maskFB_3)));
  };
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexScaleX;
uniform highp float _TexScaleY;
uniform highp vec4 _SecTex_ST;
uniform highp float _GradLocationY;
uniform highp float _GradHighY;
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _TexXLocation;
  tmpvar_4.y = -(_TexYLocation);
  tmpvar_1.xy = (_glesMultiTexCoord0.xy + tmpvar_4);
  tmpvar_1.x = (tmpvar_1.x / _TexScaleX);
  tmpvar_1.y = (tmpvar_1.y / _TexScaleY);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _SecTex_ST.xy) + _SecTex_ST.zw);
  tmpvar_2.y = ((_glesMultiTexCoord0.y + _GradLocationY) / _GradHighY);
  tmpvar_2.x = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
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
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
  ), 0.0, 1.0)));
  fogColor_5.xyz = tmpvar_9;
  fogColor_5.w = tmpvar_8;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = fogColor_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskTB_2;
  mediump float maskFB_3;
  mediump vec4 outColor_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1.x, 0.0, 1.0);
  maskFB_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (xlv_TEXCOORD1.y, 0.0, 1.0);
  maskTB_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (_GradFrontColor, _GradBackColor, vec4(maskFB_3));
  outColor_4 = (mix (_GradBottomColor, _GradTopColor, vec4(maskTB_2)) * tmpvar_7);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_8;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    mediump vec4 tmpvar_9;
    tmpvar_9 = vec4((texCol_1.x * _TexRColor.w));
    highp vec4 tmpvar_10;
    tmpvar_10 = mix (outColor_4, (_TexRColor * mix (1.0, maskFB_3, _CloudMaskIntensity)), tmpvar_9);
    outColor_4 = tmpvar_10;
    outColor_4 = (mix (mix (outColor_4, 
      (_TexGColor * tmpvar_7)
    , vec4(
      (texCol_1.y * _TexGColor.w)
    )), vec4(1.0, 1.0, 1.0, 1.0), (
      (_TexBColor * texCol_1.z)
     * 2.0)) + ((_TexBColor * texCol_1.z) * (1.0 - maskFB_3)));
  };
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexScaleX;
uniform highp float _TexScaleY;
uniform highp vec4 _SecTex_ST;
uniform highp float _GradLocationY;
uniform highp float _GradHighY;
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _TexXLocation;
  tmpvar_4.y = -(_TexYLocation);
  tmpvar_1.xy = (_glesMultiTexCoord0.xy + tmpvar_4);
  tmpvar_1.x = (tmpvar_1.x / _TexScaleX);
  tmpvar_1.y = (tmpvar_1.y / _TexScaleY);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _SecTex_ST.xy) + _SecTex_ST.zw);
  tmpvar_2.y = ((_glesMultiTexCoord0.y + _GradLocationY) / _GradHighY);
  tmpvar_2.x = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
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
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
  ), 0.0, 1.0)));
  fogColor_5.xyz = tmpvar_9;
  fogColor_5.w = tmpvar_8;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = fogColor_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskTB_2;
  mediump float maskFB_3;
  mediump vec4 outColor_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1.x, 0.0, 1.0);
  maskFB_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (xlv_TEXCOORD1.y, 0.0, 1.0);
  maskTB_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (_GradFrontColor, _GradBackColor, vec4(maskFB_3));
  outColor_4 = (mix (_GradBottomColor, _GradTopColor, vec4(maskTB_2)) * tmpvar_7);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_8;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    mediump vec4 tmpvar_9;
    tmpvar_9 = vec4((texCol_1.x * _TexRColor.w));
    highp vec4 tmpvar_10;
    tmpvar_10 = mix (outColor_4, (_TexRColor * mix (1.0, maskFB_3, _CloudMaskIntensity)), tmpvar_9);
    outColor_4 = tmpvar_10;
    outColor_4 = (mix (mix (outColor_4, 
      (_TexGColor * tmpvar_7)
    , vec4(
      (texCol_1.y * _TexGColor.w)
    )), vec4(1.0, 1.0, 1.0, 1.0), (
      (_TexBColor * texCol_1.z)
     * 2.0)) + ((_TexBColor * texCol_1.z) * (1.0 - maskFB_3)));
  };
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexScaleX;
uniform highp float _TexScaleY;
uniform highp vec4 _SecTex_ST;
uniform highp float _GradLocationY;
uniform highp float _GradHighY;
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _TexXLocation;
  tmpvar_4.y = -(_TexYLocation);
  tmpvar_1.xy = (_glesMultiTexCoord0.xy + tmpvar_4);
  tmpvar_1.x = (tmpvar_1.x / _TexScaleX);
  tmpvar_1.y = (tmpvar_1.y / _TexScaleY);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _SecTex_ST.xy) + _SecTex_ST.zw);
  tmpvar_2.y = ((_glesMultiTexCoord0.y + _GradLocationY) / _GradHighY);
  tmpvar_2.x = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
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
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
  ), 0.0, 1.0)));
  fogColor_5.xyz = tmpvar_9;
  fogColor_5.w = tmpvar_8;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = fogColor_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskTB_2;
  mediump float maskFB_3;
  mediump vec4 outColor_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1.x, 0.0, 1.0);
  maskFB_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (xlv_TEXCOORD1.y, 0.0, 1.0);
  maskTB_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (_GradFrontColor, _GradBackColor, vec4(maskFB_3));
  outColor_4 = (mix (_GradBottomColor, _GradTopColor, vec4(maskTB_2)) * tmpvar_7);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_8;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    mediump vec4 tmpvar_9;
    tmpvar_9 = vec4((texCol_1.x * _TexRColor.w));
    highp vec4 tmpvar_10;
    tmpvar_10 = mix (outColor_4, (_TexRColor * mix (1.0, maskFB_3, _CloudMaskIntensity)), tmpvar_9);
    outColor_4 = tmpvar_10;
    outColor_4 = (mix (mix (outColor_4, 
      (_TexGColor * tmpvar_7)
    , vec4(
      (texCol_1.y * _TexGColor.w)
    )), vec4(1.0, 1.0, 1.0, 1.0), (
      (_TexBColor * texCol_1.z)
     * 2.0)) + ((_TexBColor * texCol_1.z) * (1.0 - maskFB_3)));
  };
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexScaleX;
uniform highp float _TexScaleY;
uniform highp vec4 _SecTex_ST;
uniform highp float _GradLocationY;
uniform highp float _GradHighY;
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _TexXLocation;
  tmpvar_4.y = -(_TexYLocation);
  tmpvar_1.xy = (_glesMultiTexCoord0.xy + tmpvar_4);
  tmpvar_1.x = (tmpvar_1.x / _TexScaleX);
  tmpvar_1.y = (tmpvar_1.y / _TexScaleY);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _SecTex_ST.xy) + _SecTex_ST.zw);
  tmpvar_2.y = ((_glesMultiTexCoord0.y + _GradLocationY) / _GradHighY);
  tmpvar_2.x = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
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
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
  ), 0.0, 1.0)));
  fogColor_5.xyz = tmpvar_9;
  fogColor_5.w = tmpvar_8;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = fogColor_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskTB_2;
  mediump float maskFB_3;
  mediump vec4 outColor_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1.x, 0.0, 1.0);
  maskFB_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (xlv_TEXCOORD1.y, 0.0, 1.0);
  maskTB_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (_GradFrontColor, _GradBackColor, vec4(maskFB_3));
  outColor_4 = (mix (_GradBottomColor, _GradTopColor, vec4(maskTB_2)) * tmpvar_7);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_8;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    mediump vec4 tmpvar_9;
    tmpvar_9 = vec4((texCol_1.x * _TexRColor.w));
    highp vec4 tmpvar_10;
    tmpvar_10 = mix (outColor_4, (_TexRColor * mix (1.0, maskFB_3, _CloudMaskIntensity)), tmpvar_9);
    outColor_4 = tmpvar_10;
    outColor_4 = (mix (mix (outColor_4, 
      (_TexGColor * tmpvar_7)
    , vec4(
      (texCol_1.y * _TexGColor.w)
    )), vec4(1.0, 1.0, 1.0, 1.0), (
      (_TexBColor * texCol_1.z)
     * 2.0)) + ((_TexBColor * texCol_1.z) * (1.0 - maskFB_3)));
  };
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexScaleX;
uniform highp float _TexScaleY;
uniform highp vec4 _SecTex_ST;
uniform highp float _GradLocationY;
uniform highp float _GradHighY;
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _TexXLocation;
  tmpvar_4.y = -(_TexYLocation);
  tmpvar_1.xy = (_glesMultiTexCoord0.xy + tmpvar_4);
  tmpvar_1.x = (tmpvar_1.x / _TexScaleX);
  tmpvar_1.y = (tmpvar_1.y / _TexScaleY);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _SecTex_ST.xy) + _SecTex_ST.zw);
  tmpvar_2.y = ((_glesMultiTexCoord0.y + _GradLocationY) / _GradHighY);
  tmpvar_2.x = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
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
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
  ), 0.0, 1.0)));
  fogColor_5.xyz = tmpvar_9;
  fogColor_5.w = tmpvar_8;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = fogColor_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskTB_2;
  mediump float maskFB_3;
  mediump vec4 outColor_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1.x, 0.0, 1.0);
  maskFB_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (xlv_TEXCOORD1.y, 0.0, 1.0);
  maskTB_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (_GradFrontColor, _GradBackColor, vec4(maskFB_3));
  outColor_4 = (mix (_GradBottomColor, _GradTopColor, vec4(maskTB_2)) * tmpvar_7);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_8;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    mediump vec4 tmpvar_9;
    tmpvar_9 = vec4((texCol_1.x * _TexRColor.w));
    highp vec4 tmpvar_10;
    tmpvar_10 = mix (outColor_4, (_TexRColor * mix (1.0, maskFB_3, _CloudMaskIntensity)), tmpvar_9);
    outColor_4 = tmpvar_10;
    outColor_4 = (mix (mix (outColor_4, 
      (_TexGColor * tmpvar_7)
    , vec4(
      (texCol_1.y * _TexGColor.w)
    )), vec4(1.0, 1.0, 1.0, 1.0), (
      (_TexBColor * texCol_1.z)
     * 2.0)) + ((_TexBColor * texCol_1.z) * (1.0 - maskFB_3)));
  };
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexScaleX;
uniform highp float _TexScaleY;
uniform highp vec4 _SecTex_ST;
uniform highp float _GradLocationY;
uniform highp float _GradHighY;
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _TexXLocation;
  tmpvar_4.y = -(_TexYLocation);
  tmpvar_1.xy = (_glesMultiTexCoord0.xy + tmpvar_4);
  tmpvar_1.x = (tmpvar_1.x / _TexScaleX);
  tmpvar_1.y = (tmpvar_1.y / _TexScaleY);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _SecTex_ST.xy) + _SecTex_ST.zw);
  tmpvar_2.y = ((_glesMultiTexCoord0.y + _GradLocationY) / _GradHighY);
  tmpvar_2.x = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
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
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
  ), 0.0, 1.0)));
  fogColor_5.xyz = tmpvar_9;
  fogColor_5.w = tmpvar_8;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = fogColor_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskTB_2;
  mediump float maskFB_3;
  mediump vec4 outColor_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1.x, 0.0, 1.0);
  maskFB_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (xlv_TEXCOORD1.y, 0.0, 1.0);
  maskTB_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (_GradFrontColor, _GradBackColor, vec4(maskFB_3));
  outColor_4 = (mix (_GradBottomColor, _GradTopColor, vec4(maskTB_2)) * tmpvar_7);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_8;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    mediump vec4 tmpvar_9;
    tmpvar_9 = vec4((texCol_1.x * _TexRColor.w));
    highp vec4 tmpvar_10;
    tmpvar_10 = mix (outColor_4, (_TexRColor * mix (1.0, maskFB_3, _CloudMaskIntensity)), tmpvar_9);
    outColor_4 = tmpvar_10;
    outColor_4 = (mix (mix (outColor_4, 
      (_TexGColor * tmpvar_7)
    , vec4(
      (texCol_1.y * _TexGColor.w)
    )), vec4(1.0, 1.0, 1.0, 1.0), (
      (_TexBColor * texCol_1.z)
     * 2.0)) + ((_TexBColor * texCol_1.z) * (1.0 - maskFB_3)));
  };
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexScaleX;
uniform highp float _TexScaleY;
uniform highp vec4 _SecTex_ST;
uniform highp float _GradLocationY;
uniform highp float _GradHighY;
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _TexXLocation;
  tmpvar_4.y = -(_TexYLocation);
  tmpvar_1.xy = (_glesMultiTexCoord0.xy + tmpvar_4);
  tmpvar_1.x = (tmpvar_1.x / _TexScaleX);
  tmpvar_1.y = (tmpvar_1.y / _TexScaleY);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _SecTex_ST.xy) + _SecTex_ST.zw);
  tmpvar_2.y = ((_glesMultiTexCoord0.y + _GradLocationY) / _GradHighY);
  tmpvar_2.x = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
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
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
  ), 0.0, 1.0)));
  fogColor_5.xyz = tmpvar_9;
  fogColor_5.w = tmpvar_8;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = fogColor_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskTB_2;
  mediump float maskFB_3;
  mediump vec4 outColor_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1.x, 0.0, 1.0);
  maskFB_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (xlv_TEXCOORD1.y, 0.0, 1.0);
  maskTB_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (_GradFrontColor, _GradBackColor, vec4(maskFB_3));
  outColor_4 = (mix (_GradBottomColor, _GradTopColor, vec4(maskTB_2)) * tmpvar_7);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_8;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    mediump vec4 tmpvar_9;
    tmpvar_9 = vec4((texCol_1.x * _TexRColor.w));
    highp vec4 tmpvar_10;
    tmpvar_10 = mix (outColor_4, (_TexRColor * mix (1.0, maskFB_3, _CloudMaskIntensity)), tmpvar_9);
    outColor_4 = tmpvar_10;
    outColor_4 = (mix (mix (outColor_4, 
      (_TexGColor * tmpvar_7)
    , vec4(
      (texCol_1.y * _TexGColor.w)
    )), vec4(1.0, 1.0, 1.0, 1.0), (
      (_TexBColor * texCol_1.z)
     * 2.0)) + ((_TexBColor * texCol_1.z) * (1.0 - maskFB_3)));
  };
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexScaleX;
uniform highp float _TexScaleY;
uniform highp vec4 _SecTex_ST;
uniform highp float _GradLocationY;
uniform highp float _GradHighY;
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _TexXLocation;
  tmpvar_4.y = -(_TexYLocation);
  tmpvar_1.xy = (_glesMultiTexCoord0.xy + tmpvar_4);
  tmpvar_1.x = (tmpvar_1.x / _TexScaleX);
  tmpvar_1.y = (tmpvar_1.y / _TexScaleY);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _SecTex_ST.xy) + _SecTex_ST.zw);
  tmpvar_2.y = ((_glesMultiTexCoord0.y + _GradLocationY) / _GradHighY);
  tmpvar_2.x = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
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
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_7)) * (_FogColorIntensity * tmpvar_7))
  ), 0.0, 1.0)));
  fogColor_5.xyz = tmpvar_9;
  fogColor_5.w = tmpvar_8;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = fogColor_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskTB_2;
  mediump float maskFB_3;
  mediump vec4 outColor_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (xlv_TEXCOORD1.x, 0.0, 1.0);
  maskFB_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (xlv_TEXCOORD1.y, 0.0, 1.0);
  maskTB_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = mix (_GradFrontColor, _GradBackColor, vec4(maskFB_3));
  outColor_4 = (mix (_GradBottomColor, _GradTopColor, vec4(maskTB_2)) * tmpvar_7);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_8;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    mediump vec4 tmpvar_9;
    tmpvar_9 = vec4((texCol_1.x * _TexRColor.w));
    highp vec4 tmpvar_10;
    tmpvar_10 = mix (outColor_4, (_TexRColor * mix (1.0, maskFB_3, _CloudMaskIntensity)), tmpvar_9);
    outColor_4 = tmpvar_10;
    outColor_4 = (mix (mix (outColor_4, 
      (_TexGColor * tmpvar_7)
    , vec4(
      (texCol_1.y * _TexGColor.w)
    )), vec4(1.0, 1.0, 1.0, 1.0), (
      (_TexBColor * texCol_1.z)
     * 2.0)) + ((_TexBColor * texCol_1.z) * (1.0 - maskFB_3)));
  };
  outColor_4.xyz = mix (outColor_4.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
}