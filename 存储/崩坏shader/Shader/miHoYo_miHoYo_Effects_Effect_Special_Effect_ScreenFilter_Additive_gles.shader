//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/ScreenFilter_Additive" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
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
[Toggle(REVERSEU)] _ReverseU ("Reverse U Coord", Float) = 0
[Toggle(REVERSEV)] _ReverseV ("Reverse V Coord", Float) = 0
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 5815
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4.z = 0.0;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_4;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - tmpvar_3.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - tmpvar_3.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4.z = 0.0;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_4;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - tmpvar_3.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - tmpvar_3.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4.z = 0.0;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_4;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - tmpvar_3.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - tmpvar_3.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4.z = 0.0;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_4;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - tmpvar_3.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - tmpvar_3.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4.z = 0.0;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_4;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - tmpvar_3.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - tmpvar_3.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4.z = 0.0;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_4;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - tmpvar_3.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - tmpvar_3.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = vec2(0.0, 0.0);
  highp vec3 tmpvar_4;
  tmpvar_4.z = 0.0;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_4;
  highp vec4 borders_5;
  highp vec2 texcoord_6;
  texcoord_6 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_7;
    tmpvar_7.x = 1.0;
    tmpvar_7.y = _TSAspectRatio;
    texcoord_6 = (texcoord_6 * tmpvar_7);
  } else {
    highp vec2 tmpvar_8;
    tmpvar_8.y = 1.0;
    tmpvar_8.x = (1.0/(_TSAspectRatio));
    texcoord_6 = (texcoord_6 * tmpvar_8);
  };
  texcoord_6 = (texcoord_6 + 0.5);
  texcoord_6 = ((texcoord_6 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9.xy = vec2(0.0, 0.0);
  tmpvar_9.zw = _MainTex_ST.xy;
  borders_5 = (tmpvar_9 + _MainTex_ST.zwzw);
  tmpvar_3 = texcoord_6;
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - texcoord_6.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - texcoord_6.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = borders_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
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
  color_1.w = clamp (tmpvar_7.w, 0.0, 1.0);
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = vec2(0.0, 0.0);
  highp vec3 tmpvar_4;
  tmpvar_4.z = 0.0;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_4;
  highp vec4 borders_5;
  highp vec2 texcoord_6;
  texcoord_6 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_7;
    tmpvar_7.x = 1.0;
    tmpvar_7.y = _TSAspectRatio;
    texcoord_6 = (texcoord_6 * tmpvar_7);
  } else {
    highp vec2 tmpvar_8;
    tmpvar_8.y = 1.0;
    tmpvar_8.x = (1.0/(_TSAspectRatio));
    texcoord_6 = (texcoord_6 * tmpvar_8);
  };
  texcoord_6 = (texcoord_6 + 0.5);
  texcoord_6 = ((texcoord_6 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9.xy = vec2(0.0, 0.0);
  tmpvar_9.zw = _MainTex_ST.xy;
  borders_5 = (tmpvar_9 + _MainTex_ST.zwzw);
  tmpvar_3 = texcoord_6;
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - texcoord_6.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - texcoord_6.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = borders_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
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
  color_1.w = clamp (tmpvar_7.w, 0.0, 1.0);
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = vec2(0.0, 0.0);
  highp vec3 tmpvar_4;
  tmpvar_4.z = 0.0;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_4;
  highp vec4 borders_5;
  highp vec2 texcoord_6;
  texcoord_6 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_7;
    tmpvar_7.x = 1.0;
    tmpvar_7.y = _TSAspectRatio;
    texcoord_6 = (texcoord_6 * tmpvar_7);
  } else {
    highp vec2 tmpvar_8;
    tmpvar_8.y = 1.0;
    tmpvar_8.x = (1.0/(_TSAspectRatio));
    texcoord_6 = (texcoord_6 * tmpvar_8);
  };
  texcoord_6 = (texcoord_6 + 0.5);
  texcoord_6 = ((texcoord_6 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9.xy = vec2(0.0, 0.0);
  tmpvar_9.zw = _MainTex_ST.xy;
  borders_5 = (tmpvar_9 + _MainTex_ST.zwzw);
  tmpvar_3 = texcoord_6;
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - texcoord_6.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - texcoord_6.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = borders_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
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
  color_1.w = clamp (tmpvar_7.w, 0.0, 1.0);
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = vec2(0.0, 0.0);
  highp vec3 tmpvar_4;
  tmpvar_4.z = 0.0;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_4;
  highp vec4 borders_5;
  highp vec2 texcoord_6;
  texcoord_6 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_7;
    tmpvar_7.x = 1.0;
    tmpvar_7.y = _TSAspectRatio;
    texcoord_6 = (texcoord_6 * tmpvar_7);
  } else {
    highp vec2 tmpvar_8;
    tmpvar_8.y = 1.0;
    tmpvar_8.x = (1.0/(_TSAspectRatio));
    texcoord_6 = (texcoord_6 * tmpvar_8);
  };
  texcoord_6 = (texcoord_6 + 0.5);
  texcoord_6 = ((texcoord_6 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9.xy = vec2(0.0, 0.0);
  tmpvar_9.zw = _MainTex_ST.xy;
  borders_5 = (tmpvar_9 + _MainTex_ST.zwzw);
  tmpvar_3 = texcoord_6;
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - texcoord_6.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - texcoord_6.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = borders_5;
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
  color_1.w = clamp (tmpvar_7.w, 0.0, 1.0);
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = vec2(0.0, 0.0);
  highp vec3 tmpvar_4;
  tmpvar_4.z = 0.0;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_4;
  highp vec4 borders_5;
  highp vec2 texcoord_6;
  texcoord_6 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_7;
    tmpvar_7.x = 1.0;
    tmpvar_7.y = _TSAspectRatio;
    texcoord_6 = (texcoord_6 * tmpvar_7);
  } else {
    highp vec2 tmpvar_8;
    tmpvar_8.y = 1.0;
    tmpvar_8.x = (1.0/(_TSAspectRatio));
    texcoord_6 = (texcoord_6 * tmpvar_8);
  };
  texcoord_6 = (texcoord_6 + 0.5);
  texcoord_6 = ((texcoord_6 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9.xy = vec2(0.0, 0.0);
  tmpvar_9.zw = _MainTex_ST.xy;
  borders_5 = (tmpvar_9 + _MainTex_ST.zwzw);
  tmpvar_3 = texcoord_6;
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - texcoord_6.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - texcoord_6.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = borders_5;
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
  color_1.w = clamp (tmpvar_7.w, 0.0, 1.0);
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  tmpvar_3 = vec2(0.0, 0.0);
  highp vec3 tmpvar_4;
  tmpvar_4.z = 0.0;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_4;
  highp vec4 borders_5;
  highp vec2 texcoord_6;
  texcoord_6 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_7;
    tmpvar_7.x = 1.0;
    tmpvar_7.y = _TSAspectRatio;
    texcoord_6 = (texcoord_6 * tmpvar_7);
  } else {
    highp vec2 tmpvar_8;
    tmpvar_8.y = 1.0;
    tmpvar_8.x = (1.0/(_TSAspectRatio));
    texcoord_6 = (texcoord_6 * tmpvar_8);
  };
  texcoord_6 = (texcoord_6 + 0.5);
  texcoord_6 = ((texcoord_6 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9.xy = vec2(0.0, 0.0);
  tmpvar_9.zw = _MainTex_ST.xy;
  borders_5 = (tmpvar_9 + _MainTex_ST.zwzw);
  tmpvar_3 = texcoord_6;
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - texcoord_6.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - texcoord_6.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = borders_5;
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
  color_1.w = clamp (tmpvar_7.w, 0.0, 1.0);
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
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 103991
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  mediump float tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_5;
  tmpvar_4 = tmpvar_1.w;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - tmpvar_3.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - tmpvar_3.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  mediump float tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_5;
  tmpvar_4 = tmpvar_1.w;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - tmpvar_3.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - tmpvar_3.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  mediump float tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_5;
  tmpvar_4 = tmpvar_1.w;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - tmpvar_3.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - tmpvar_3.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  mediump float tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_5;
  tmpvar_4 = tmpvar_1.w;
  highp vec4 borders_6;
  highp vec2 texcoord_7;
  texcoord_7 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_8;
    tmpvar_8.x = 1.0;
    tmpvar_8.y = _TSAspectRatio;
    texcoord_7 = (texcoord_7 * tmpvar_8);
  } else {
    highp vec2 tmpvar_9;
    tmpvar_9.y = 1.0;
    tmpvar_9.x = (1.0/(_TSAspectRatio));
    texcoord_7 = (texcoord_7 * tmpvar_9);
  };
  texcoord_7 = (texcoord_7 + 0.5);
  texcoord_7 = ((texcoord_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10.xy = vec2(0.0, 0.0);
  tmpvar_10.zw = _MainTex_ST.xy;
  borders_6 = (tmpvar_10 + _MainTex_ST.zwzw);
  tmpvar_3 = texcoord_7;
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - texcoord_7.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - texcoord_7.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = borders_6;
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  mediump float tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_5;
  tmpvar_4 = tmpvar_1.w;
  highp vec4 borders_6;
  highp vec2 texcoord_7;
  texcoord_7 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_8;
    tmpvar_8.x = 1.0;
    tmpvar_8.y = _TSAspectRatio;
    texcoord_7 = (texcoord_7 * tmpvar_8);
  } else {
    highp vec2 tmpvar_9;
    tmpvar_9.y = 1.0;
    tmpvar_9.x = (1.0/(_TSAspectRatio));
    texcoord_7 = (texcoord_7 * tmpvar_9);
  };
  texcoord_7 = (texcoord_7 + 0.5);
  texcoord_7 = ((texcoord_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10.xy = vec2(0.0, 0.0);
  tmpvar_10.zw = _MainTex_ST.xy;
  borders_6 = (tmpvar_10 + _MainTex_ST.zwzw);
  tmpvar_3 = texcoord_7;
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - texcoord_7.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - texcoord_7.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = borders_6;
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _ReverseU;
uniform mediump float _ReverseV;
uniform highp float _TSAspectRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.w = _glesVertex.w;
  highp vec2 tmpvar_3;
  mediump float tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5.z = 0.0;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2.xyz = tmpvar_5;
  tmpvar_4 = tmpvar_1.w;
  highp vec4 borders_6;
  highp vec2 texcoord_7;
  texcoord_7 = (_glesMultiTexCoord0.xy - 0.5);
  if ((1.0 < _TSAspectRatio)) {
    highp vec2 tmpvar_8;
    tmpvar_8.x = 1.0;
    tmpvar_8.y = _TSAspectRatio;
    texcoord_7 = (texcoord_7 * tmpvar_8);
  } else {
    highp vec2 tmpvar_9;
    tmpvar_9.y = 1.0;
    tmpvar_9.x = (1.0/(_TSAspectRatio));
    texcoord_7 = (texcoord_7 * tmpvar_9);
  };
  texcoord_7 = (texcoord_7 + 0.5);
  texcoord_7 = ((texcoord_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10.xy = vec2(0.0, 0.0);
  tmpvar_10.zw = _MainTex_ST.xy;
  borders_6 = (tmpvar_10 + _MainTex_ST.zwzw);
  tmpvar_3 = texcoord_7;
  if ((_ReverseV > 0.0)) {
    tmpvar_3.y = (1.0 - texcoord_7.y);
  };
  if ((_ReverseU > 0.0)) {
    tmpvar_3.x = (1.0 - texcoord_7.x);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = borders_6;
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