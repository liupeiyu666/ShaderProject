//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/Scene_Additive_Plane" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Mask Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Toggle(WRITEDEPTH)] _WriteDepth ("WriteDepth", Float) = 0
[Toggle(TEXTURE_SCALE)] _TextureScale ("Texture Scale", Float) = 0
_TSAspectRatio ("Texture Aspect Ratio (width : height)", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DistortionTex ("Distortion Tex", 2D) = "gray" { }
_DistortionIntensity ("Distortion Intensity", Range(0, 10)) = 5
[Toggle(LUMINANCE)] _Luminance ("Luminance", Float) = 0
_LumiFactor ("Luminance Factor", Float) = 0
_FadeDistance ("Fade Start Distance", Range(0.1, 100)) = 50
_FadeOffset ("Fade Start Offset", Range(0, 150)) = 100
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 30068
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp float tmpvar_3;
  tmpvar_3 = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_1 = tmpvar_3;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = (tmpvar_3.w * xlv_TEXCOORD2);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp float tmpvar_3;
  tmpvar_3 = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_1 = tmpvar_3;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = (tmpvar_3.w * xlv_TEXCOORD2);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp float tmpvar_3;
  tmpvar_3 = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_1 = tmpvar_3;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = (tmpvar_3.w * xlv_TEXCOORD2);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp float tmpvar_3;
  tmpvar_3 = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_1 = tmpvar_3;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = (tmpvar_3.w * xlv_TEXCOORD2);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp float tmpvar_3;
  tmpvar_3 = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_1 = tmpvar_3;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = (tmpvar_3.w * xlv_TEXCOORD2);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp float tmpvar_3;
  tmpvar_3 = clamp (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_1 = tmpvar_3;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = (tmpvar_3.w * xlv_TEXCOORD2);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  tmpvar_2 = 0.0;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
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
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_2 = tmpvar_9;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_5;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_8 + _MainTex_ST.zwzw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD0.x - xlv_TEXCOORD1.x);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.y - xlv_TEXCOORD1.y);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD1.z - xlv_TEXCOORD0.x);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD1.w - xlv_TEXCOORD0.y);
  if ((x_5 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_6));
  color_1.xyz = (tmpvar_7.xyz * _EmissionScaler);
  color_1.w = (tmpvar_7.w * xlv_TEXCOORD2);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  tmpvar_2 = 0.0;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
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
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_2 = tmpvar_9;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_5;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_8 + _MainTex_ST.zwzw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD0.x - xlv_TEXCOORD1.x);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.y - xlv_TEXCOORD1.y);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD1.z - xlv_TEXCOORD0.x);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD1.w - xlv_TEXCOORD0.y);
  if ((x_5 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_6));
  color_1.xyz = (tmpvar_7.xyz * _EmissionScaler);
  color_1.w = (tmpvar_7.w * xlv_TEXCOORD2);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  tmpvar_2 = 0.0;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
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
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_2 = tmpvar_9;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_5;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_8 + _MainTex_ST.zwzw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD0.x - xlv_TEXCOORD1.x);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.y - xlv_TEXCOORD1.y);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD1.z - xlv_TEXCOORD0.x);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD1.w - xlv_TEXCOORD0.y);
  if ((x_5 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_6));
  color_1.xyz = (tmpvar_7.xyz * _EmissionScaler);
  color_1.w = (tmpvar_7.w * xlv_TEXCOORD2);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  tmpvar_2 = 0.0;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
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
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_2 = tmpvar_9;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_5;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_8 + _MainTex_ST.zwzw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD0.x - xlv_TEXCOORD1.x);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.y - xlv_TEXCOORD1.y);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD1.z - xlv_TEXCOORD0.x);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD1.w - xlv_TEXCOORD0.y);
  if ((x_5 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_6));
  color_1.xyz = (tmpvar_7.xyz * _EmissionScaler);
  color_1.w = (tmpvar_7.w * xlv_TEXCOORD2);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  tmpvar_2 = 0.0;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
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
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_2 = tmpvar_9;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_5;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_8 + _MainTex_ST.zwzw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD0.x - xlv_TEXCOORD1.x);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.y - xlv_TEXCOORD1.y);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD1.z - xlv_TEXCOORD0.x);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD1.w - xlv_TEXCOORD0.y);
  if ((x_5 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_6));
  color_1.xyz = (tmpvar_7.xyz * _EmissionScaler);
  color_1.w = (tmpvar_7.w * xlv_TEXCOORD2);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  tmpvar_2 = 0.0;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
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
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 0.0, 1.0);
  tmpvar_2 = tmpvar_9;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_5;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_8 + _MainTex_ST.zwzw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD0.x - xlv_TEXCOORD1.x);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.y - xlv_TEXCOORD1.y);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD1.z - xlv_TEXCOORD0.x);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD1.w - xlv_TEXCOORD0.y);
  if ((x_5 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_6));
  color_1.xyz = (tmpvar_7.xyz * _EmissionScaler);
  color_1.w = (tmpvar_7.w * xlv_TEXCOORD2);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_1;
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
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
}
}
 Pass {
  Name "CONSTANT_MAX"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 94167
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