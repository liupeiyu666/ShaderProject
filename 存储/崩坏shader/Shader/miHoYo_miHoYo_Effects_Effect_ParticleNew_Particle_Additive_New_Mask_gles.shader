//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Particle_Additive_New_Mask" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_MaskTex ("Mask Texture", 2D) = "white" { }
maskScale ("MaskScale", Float) = 1
[Toggle(TEXTURE_SCALE)] _TextureScale ("Texture Scale", Float) = 0
_TSAspectRatio ("Texture Aspect Ratio (width : height)", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DistortionTex ("Distortion Tex", 2D) = "gray" { }
_DistortionIntensity ("Distortion Intensity", Range(0, 10)) = 5
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 50303
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
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float maskScale;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 color_1;
  mediump vec4 maskcolor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MaskTex, xlv_TEXCOORD0);
  maskcolor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * _TintColor) * (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0)));
  mediump float tmpvar_5;
  tmpvar_5 = min (max ((
    (maskcolor_2.x + 0.1)
   * maskScale), 0.0), 1.0);
  color_1.xyz = (tmpvar_4.xyz * (_EmissionScaler * tmpvar_5));
  color_1.w = clamp (tmpvar_4.w, 0.0, 1.0);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float maskScale;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 color_1;
  mediump vec4 maskcolor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MaskTex, xlv_TEXCOORD0);
  maskcolor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * _TintColor) * (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0)));
  mediump float tmpvar_5;
  tmpvar_5 = min (max ((
    (maskcolor_2.x + 0.1)
   * maskScale), 0.0), 1.0);
  color_1.xyz = (tmpvar_4.xyz * (_EmissionScaler * tmpvar_5));
  color_1.w = clamp (tmpvar_4.w, 0.0, 1.0);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float maskScale;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 color_1;
  mediump vec4 maskcolor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MaskTex, xlv_TEXCOORD0);
  maskcolor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * _TintColor) * (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0)));
  mediump float tmpvar_5;
  tmpvar_5 = min (max ((
    (maskcolor_2.x + 0.1)
   * maskScale), 0.0), 1.0);
  color_1.xyz = (tmpvar_4.xyz * (_EmissionScaler * tmpvar_5));
  color_1.w = clamp (tmpvar_4.w, 0.0, 1.0);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float maskScale;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 color_1;
  mediump vec4 maskcolor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MaskTex, xlv_TEXCOORD0);
  maskcolor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * _TintColor) * (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0)));
  mediump float tmpvar_5;
  tmpvar_5 = min (max ((
    (maskcolor_2.x + 0.1)
   * maskScale), 0.0), 1.0);
  color_1.xyz = (tmpvar_4.xyz * (_EmissionScaler * tmpvar_5));
  color_1.w = clamp (tmpvar_4.w, 0.0, 1.0);
  lowp float tmpvar_6;
  tmpvar_6 = dot (color_1.xyz, vec3(0.3, 0.59, 0.11));
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (color_1.xyz, vec3(tmpvar_6), vec3(_LumiFactor));
  color_1.xyz = tmpvar_7;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float maskScale;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 color_1;
  mediump vec4 maskcolor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MaskTex, xlv_TEXCOORD0);
  maskcolor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * _TintColor) * (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0)));
  mediump float tmpvar_5;
  tmpvar_5 = min (max ((
    (maskcolor_2.x + 0.1)
   * maskScale), 0.0), 1.0);
  color_1.xyz = (tmpvar_4.xyz * (_EmissionScaler * tmpvar_5));
  color_1.w = clamp (tmpvar_4.w, 0.0, 1.0);
  lowp float tmpvar_6;
  tmpvar_6 = dot (color_1.xyz, vec3(0.3, 0.59, 0.11));
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (color_1.xyz, vec3(tmpvar_6), vec3(_LumiFactor));
  color_1.xyz = tmpvar_7;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float maskScale;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 color_1;
  mediump vec4 maskcolor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MaskTex, xlv_TEXCOORD0);
  maskcolor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * _TintColor) * (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0)));
  mediump float tmpvar_5;
  tmpvar_5 = min (max ((
    (maskcolor_2.x + 0.1)
   * maskScale), 0.0), 1.0);
  color_1.xyz = (tmpvar_4.xyz * (_EmissionScaler * tmpvar_5));
  color_1.w = clamp (tmpvar_4.w, 0.0, 1.0);
  lowp float tmpvar_6;
  tmpvar_6 = dot (color_1.xyz, vec3(0.3, 0.59, 0.11));
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (color_1.xyz, vec3(tmpvar_6), vec3(_LumiFactor));
  color_1.xyz = tmpvar_7;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 texcoord_4;
  texcoord_4 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_5;
    tmpvar_5.x = 1.0;
    tmpvar_5.y = _TSAspectRatio;
    texcoord_4 = (texcoord_4 * tmpvar_5);
  } else {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (1.0/(_TSAspectRatio));
    texcoord_4 = (texcoord_4 * tmpvar_6);
  };
  texcoord_4 = (texcoord_4 + 0.5);
  texcoord_4 = ((texcoord_4 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.xy = vec2(0.0, 0.0);
  tmpvar_7.zw = _MainTex_ST.xy;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = texcoord_4;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_7 + _MainTex_ST.zwzw);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float maskScale;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 color_1;
  mediump vec4 maskcolor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.x - xlv_TEXCOORD1.x);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD0.y - xlv_TEXCOORD1.y);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD1.z - xlv_TEXCOORD0.x);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD1.w - xlv_TEXCOORD0.y);
  if ((x_6 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MaskTex, xlv_TEXCOORD0);
  maskcolor_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = ((2.0 * _TintColor) * (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0)));
  mediump float tmpvar_9;
  tmpvar_9 = min (max ((
    (maskcolor_2.x + 0.1)
   * maskScale), 0.0), 1.0);
  color_1.xyz = (tmpvar_8.xyz * (_EmissionScaler * tmpvar_9));
  color_1.w = clamp (tmpvar_8.w, 0.0, 1.0);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 texcoord_4;
  texcoord_4 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_5;
    tmpvar_5.x = 1.0;
    tmpvar_5.y = _TSAspectRatio;
    texcoord_4 = (texcoord_4 * tmpvar_5);
  } else {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (1.0/(_TSAspectRatio));
    texcoord_4 = (texcoord_4 * tmpvar_6);
  };
  texcoord_4 = (texcoord_4 + 0.5);
  texcoord_4 = ((texcoord_4 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.xy = vec2(0.0, 0.0);
  tmpvar_7.zw = _MainTex_ST.xy;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = texcoord_4;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_7 + _MainTex_ST.zwzw);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float maskScale;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 color_1;
  mediump vec4 maskcolor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.x - xlv_TEXCOORD1.x);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD0.y - xlv_TEXCOORD1.y);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD1.z - xlv_TEXCOORD0.x);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD1.w - xlv_TEXCOORD0.y);
  if ((x_6 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MaskTex, xlv_TEXCOORD0);
  maskcolor_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = ((2.0 * _TintColor) * (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0)));
  mediump float tmpvar_9;
  tmpvar_9 = min (max ((
    (maskcolor_2.x + 0.1)
   * maskScale), 0.0), 1.0);
  color_1.xyz = (tmpvar_8.xyz * (_EmissionScaler * tmpvar_9));
  color_1.w = clamp (tmpvar_8.w, 0.0, 1.0);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 texcoord_4;
  texcoord_4 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_5;
    tmpvar_5.x = 1.0;
    tmpvar_5.y = _TSAspectRatio;
    texcoord_4 = (texcoord_4 * tmpvar_5);
  } else {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (1.0/(_TSAspectRatio));
    texcoord_4 = (texcoord_4 * tmpvar_6);
  };
  texcoord_4 = (texcoord_4 + 0.5);
  texcoord_4 = ((texcoord_4 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.xy = vec2(0.0, 0.0);
  tmpvar_7.zw = _MainTex_ST.xy;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = texcoord_4;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_7 + _MainTex_ST.zwzw);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float maskScale;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 color_1;
  mediump vec4 maskcolor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.x - xlv_TEXCOORD1.x);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD0.y - xlv_TEXCOORD1.y);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD1.z - xlv_TEXCOORD0.x);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD1.w - xlv_TEXCOORD0.y);
  if ((x_6 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MaskTex, xlv_TEXCOORD0);
  maskcolor_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = ((2.0 * _TintColor) * (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0)));
  mediump float tmpvar_9;
  tmpvar_9 = min (max ((
    (maskcolor_2.x + 0.1)
   * maskScale), 0.0), 1.0);
  color_1.xyz = (tmpvar_8.xyz * (_EmissionScaler * tmpvar_9));
  color_1.w = clamp (tmpvar_8.w, 0.0, 1.0);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 texcoord_4;
  texcoord_4 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_5;
    tmpvar_5.x = 1.0;
    tmpvar_5.y = _TSAspectRatio;
    texcoord_4 = (texcoord_4 * tmpvar_5);
  } else {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (1.0/(_TSAspectRatio));
    texcoord_4 = (texcoord_4 * tmpvar_6);
  };
  texcoord_4 = (texcoord_4 + 0.5);
  texcoord_4 = ((texcoord_4 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.xy = vec2(0.0, 0.0);
  tmpvar_7.zw = _MainTex_ST.xy;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = texcoord_4;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_7 + _MainTex_ST.zwzw);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float maskScale;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 color_1;
  mediump vec4 maskcolor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.x - xlv_TEXCOORD1.x);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD0.y - xlv_TEXCOORD1.y);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD1.z - xlv_TEXCOORD0.x);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD1.w - xlv_TEXCOORD0.y);
  if ((x_6 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MaskTex, xlv_TEXCOORD0);
  maskcolor_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = ((2.0 * _TintColor) * (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0)));
  mediump float tmpvar_9;
  tmpvar_9 = min (max ((
    (maskcolor_2.x + 0.1)
   * maskScale), 0.0), 1.0);
  color_1.xyz = (tmpvar_8.xyz * (_EmissionScaler * tmpvar_9));
  color_1.w = clamp (tmpvar_8.w, 0.0, 1.0);
  lowp float tmpvar_10;
  tmpvar_10 = dot (color_1.xyz, vec3(0.3, 0.59, 0.11));
  mediump vec3 tmpvar_11;
  tmpvar_11 = mix (color_1.xyz, vec3(tmpvar_10), vec3(_LumiFactor));
  color_1.xyz = tmpvar_11;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 texcoord_4;
  texcoord_4 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_5;
    tmpvar_5.x = 1.0;
    tmpvar_5.y = _TSAspectRatio;
    texcoord_4 = (texcoord_4 * tmpvar_5);
  } else {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (1.0/(_TSAspectRatio));
    texcoord_4 = (texcoord_4 * tmpvar_6);
  };
  texcoord_4 = (texcoord_4 + 0.5);
  texcoord_4 = ((texcoord_4 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.xy = vec2(0.0, 0.0);
  tmpvar_7.zw = _MainTex_ST.xy;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = texcoord_4;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_7 + _MainTex_ST.zwzw);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float maskScale;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 color_1;
  mediump vec4 maskcolor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.x - xlv_TEXCOORD1.x);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD0.y - xlv_TEXCOORD1.y);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD1.z - xlv_TEXCOORD0.x);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD1.w - xlv_TEXCOORD0.y);
  if ((x_6 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MaskTex, xlv_TEXCOORD0);
  maskcolor_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = ((2.0 * _TintColor) * (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0)));
  mediump float tmpvar_9;
  tmpvar_9 = min (max ((
    (maskcolor_2.x + 0.1)
   * maskScale), 0.0), 1.0);
  color_1.xyz = (tmpvar_8.xyz * (_EmissionScaler * tmpvar_9));
  color_1.w = clamp (tmpvar_8.w, 0.0, 1.0);
  lowp float tmpvar_10;
  tmpvar_10 = dot (color_1.xyz, vec3(0.3, 0.59, 0.11));
  mediump vec3 tmpvar_11;
  tmpvar_11 = mix (color_1.xyz, vec3(tmpvar_10), vec3(_LumiFactor));
  color_1.xyz = tmpvar_11;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 texcoord_4;
  texcoord_4 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_5;
    tmpvar_5.x = 1.0;
    tmpvar_5.y = _TSAspectRatio;
    texcoord_4 = (texcoord_4 * tmpvar_5);
  } else {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (1.0/(_TSAspectRatio));
    texcoord_4 = (texcoord_4 * tmpvar_6);
  };
  texcoord_4 = (texcoord_4 + 0.5);
  texcoord_4 = ((texcoord_4 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7.xy = vec2(0.0, 0.0);
  tmpvar_7.zw = _MainTex_ST.xy;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = texcoord_4;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_7 + _MainTex_ST.zwzw);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform mediump float maskScale;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 color_1;
  mediump vec4 maskcolor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.x - xlv_TEXCOORD1.x);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD0.y - xlv_TEXCOORD1.y);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD1.z - xlv_TEXCOORD0.x);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD1.w - xlv_TEXCOORD0.y);
  if ((x_6 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MaskTex, xlv_TEXCOORD0);
  maskcolor_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = ((2.0 * _TintColor) * (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0)));
  mediump float tmpvar_9;
  tmpvar_9 = min (max ((
    (maskcolor_2.x + 0.1)
   * maskScale), 0.0), 1.0);
  color_1.xyz = (tmpvar_8.xyz * (_EmissionScaler * tmpvar_9));
  color_1.w = clamp (tmpvar_8.w, 0.0, 1.0);
  lowp float tmpvar_10;
  tmpvar_10 = dot (color_1.xyz, vec3(0.3, 0.59, 0.11));
  mediump vec3 tmpvar_11;
  tmpvar_11 = mix (color_1.xyz, vec3(tmpvar_10), vec3(_LumiFactor));
  color_1.xyz = tmpvar_11;
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
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}