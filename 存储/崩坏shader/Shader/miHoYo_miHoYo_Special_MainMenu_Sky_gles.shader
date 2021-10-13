//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/MainMenu/Sky" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
_TexRColor ("Texture Color For R Channel", Color) = (1,1,1,1)
_TexGColor ("Texture Color For G Channel", Color) = (1,1,1,1)
_TexBColor ("Texture Color For B Channel", Color) = (1,1,1,1)
_TexXLocation ("Texture Location X", Range(0, 1)) = 0
_TexYLocation ("Texture Location Y", Range(0, 1)) = 0.5
_TexHigh ("Texture High", Range(0.01, 1)) = 1
_SecTex ("Second Texture", 2D) = "white" { }
_SecTexXLocation ("Second Texture Location X", Range(0, 1)) = 0
_SecTexYLocation ("Second Texture Location Y", Range(0, 1)) = 0.5
_SecTexHigh ("Second Texture High", Range(0.01, 1)) = 1
_SecTexEmission ("Second Texture Emission", Range(0, 10)) = 1
_GradBottomColor ("Gradiant Bottom Color", Color) = (1,1,1,1)
_GradTopColor ("Gradiant Top Color", Color) = (1,1,1,1)
_GradLocation ("Gradiant Location", Range(-5, 1)) = 0
_GradHigh ("Gradiant High", Range(0.01, 10)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 3236
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexHigh;
uniform highp float _SecTexXLocation;
uniform highp float _SecTexYLocation;
uniform highp float _SecTexHigh;
uniform highp float _GradLocation;
uniform highp float _GradHigh;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_3;
  tmpvar_3.x = _TexXLocation;
  tmpvar_3.y = -(_TexYLocation);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy + tmpvar_3) / _TexHigh);
  highp vec2 tmpvar_4;
  tmpvar_4.x = _SecTexXLocation;
  tmpvar_4.y = -(_SecTexYLocation);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy + tmpvar_4) / _SecTexHigh);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _GradLocation) / _GradHigh);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform sampler2D _SecTex;
uniform highp float _SecTexEmission;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 secTexCol_2;
  mediump vec4 outColor_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = mix (_GradBottomColor, _GradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SecTex, xlv_TEXCOORD0.zw);
  secTexCol_2 = tmpvar_5;
  if (((xlv_TEXCOORD0.w >= 0.0) && (xlv_TEXCOORD0.w < 1.0))) {
    outColor_3 = (outColor_3 + (secTexCol_2 * _SecTexEmission));
  };
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_6;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    outColor_3 = mix (mix (mix (outColor_3, _TexRColor, vec4(
      (texCol_1.x * _TexRColor.w)
    )), _TexGColor, vec4((texCol_1.y * _TexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_TexBColor * texCol_1.z));
  };
  outColor_3.w = _BloomFactor;
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexHigh;
uniform highp float _SecTexXLocation;
uniform highp float _SecTexYLocation;
uniform highp float _SecTexHigh;
uniform highp float _GradLocation;
uniform highp float _GradHigh;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_3;
  tmpvar_3.x = _TexXLocation;
  tmpvar_3.y = -(_TexYLocation);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy + tmpvar_3) / _TexHigh);
  highp vec2 tmpvar_4;
  tmpvar_4.x = _SecTexXLocation;
  tmpvar_4.y = -(_SecTexYLocation);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy + tmpvar_4) / _SecTexHigh);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _GradLocation) / _GradHigh);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform sampler2D _SecTex;
uniform highp float _SecTexEmission;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 secTexCol_2;
  mediump vec4 outColor_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = mix (_GradBottomColor, _GradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SecTex, xlv_TEXCOORD0.zw);
  secTexCol_2 = tmpvar_5;
  if (((xlv_TEXCOORD0.w >= 0.0) && (xlv_TEXCOORD0.w < 1.0))) {
    outColor_3 = (outColor_3 + (secTexCol_2 * _SecTexEmission));
  };
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_6;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    outColor_3 = mix (mix (mix (outColor_3, _TexRColor, vec4(
      (texCol_1.x * _TexRColor.w)
    )), _TexGColor, vec4((texCol_1.y * _TexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_TexBColor * texCol_1.z));
  };
  outColor_3.w = _BloomFactor;
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _TexXLocation;
uniform highp float _TexYLocation;
uniform highp float _TexHigh;
uniform highp float _SecTexXLocation;
uniform highp float _SecTexYLocation;
uniform highp float _SecTexHigh;
uniform highp float _GradLocation;
uniform highp float _GradHigh;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_3;
  tmpvar_3.x = _TexXLocation;
  tmpvar_3.y = -(_TexYLocation);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy + tmpvar_3) / _TexHigh);
  highp vec2 tmpvar_4;
  tmpvar_4.x = _SecTexXLocation;
  tmpvar_4.y = -(_SecTexYLocation);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy + tmpvar_4) / _SecTexHigh);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _GradLocation) / _GradHigh);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform sampler2D _SecTex;
uniform highp float _SecTexEmission;
uniform mediump vec4 _GradBottomColor;
uniform mediump vec4 _GradTopColor;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 secTexCol_2;
  mediump vec4 outColor_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = mix (_GradBottomColor, _GradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SecTex, xlv_TEXCOORD0.zw);
  secTexCol_2 = tmpvar_5;
  if (((xlv_TEXCOORD0.w >= 0.0) && (xlv_TEXCOORD0.w < 1.0))) {
    outColor_3 = (outColor_3 + (secTexCol_2 * _SecTexEmission));
  };
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texCol_1 = tmpvar_6;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 1.0))) {
    outColor_3 = mix (mix (mix (outColor_3, _TexRColor, vec4(
      (texCol_1.x * _TexRColor.w)
    )), _TexGColor, vec4((texCol_1.y * _TexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_TexBColor * texCol_1.z));
  };
  outColor_3.w = _BloomFactor;
  gl_FragData[0] = outColor_3;
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
}
}
}
}