//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/ScreenFilter_AlphaBlend" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Toggle(TEXTURE_SCALE)] _TextureScale ("Texture Scale", Float) = 0
_TSAspectRatio ("Texture Aspect Ratio (width : height)", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DistortionTex ("Distortion Tex", 2D) = "gray" { }
_DistortionIntensity ("Distortion Intensity", Range(0, 10)) = 5
[Toggle(LUMINANCE)] _Luminance ("Luminance", Float) = 0
_LumiFactor ("Luminance Factor", Float) = 0
[Toggle(REVERSEU)] _ReverseU ("Reverse U Coord", Float) = 0
[Toggle(REVERSEV)] _ReverseV ("Reverse V Coord", Float) = 0
[Toggle(DISTORTION)] _Dissolve ("Dissolve", Float) = 0
_ScreenDissColor ("Dissolve Color", Color) = (0.5,0.5,0.5,0.5)
_ScreenDissRangeColor ("Dissolve Range Color", Color) = (0.5,0.5,0.5,0.5)
_RangeScale ("RangeScale Intensity", Range(0, 2)) = 1.6
_RangeNormal ("Range Normal", Range(0, 100)) = 10
_ScreenDissTex ("Screen Dissolve", 2D) = "" { }
_ScreenDissRange ("Screen Dissolve Range", Float) = 1
_BloomFactorDissolve ("BloomFactorDissolve", Float) = 1
TimeAdd ("TimeAdd", Float) = 0
TimeFlow ("TimeFlow", Range(0, 1)) = 0.5
_RotationSpeed ("RotationSpeed", Float) = 25
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 12277
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
uniform highp vec4 _Time;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _ScreenDissColor;
uniform mediump vec4 _ScreenDissRangeColor;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _EmissionScaler;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = ((2.0 * _TintColor) * xlv_COLOR);
  color_1.w = tmpvar_2.w;
  color_1.xyz = (tmpvar_2.xyz * _EmissionScaler);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_3;
    mediump vec4 ScreenDissColorFlow_4;
    mediump vec4 spColor_5;
    mediump float tt_6;
    mediump vec4 ScreenDissColor_7;
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_7 = tmpvar_8;
    tt_6 = 0.0;
    spColor_5 = _ScreenDissColor;
    mediump float tmpvar_9;
    tmpvar_9 = ((7.96 * ScreenDissColor_7.y) - 1.0);
    highp vec4 tmpvar_10;
    tmpvar_10 = (_RotationSpeed * _Time);
    highp float tmpvar_11;
    tmpvar_11 = cos(tmpvar_10).x;
    highp mat2 tmpvar_12;
    tmpvar_12[0].x = tmpvar_11;
    tmpvar_12[0].y = sin(tmpvar_10).x;
    tmpvar_12[1].x = -(sin(tmpvar_10).x);
    tmpvar_12[1].y = tmpvar_11;
    highp vec2 tmpvar_13;
    tmpvar_13 = (xlv_TEXCOORD0 * tmpvar_12);
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_ScreenDissTex, tmpvar_13);
    ScreenDissColorFlow_4 = tmpvar_14;
    DRange_3 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_7.x * _RangeNormal));
    if ((tmpvar_9 >= ((
      (1.7 - (ScreenDissColorFlow_4.z * TimeFlow))
     + TimeAdd) * DRange_3))) {
      tt_6 = 1.0;
    } else {
      if ((tmpvar_9 >= (_RangeScale * DRange_3))) {
        tt_6 = 1.0;
        spColor_5 = _ScreenDissRangeColor;
      };
    };
    color_1 = mix (color_1, spColor_5, vec4(tt_6));
  };
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
uniform highp vec4 _Time;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _ScreenDissColor;
uniform mediump vec4 _ScreenDissRangeColor;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _EmissionScaler;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = ((2.0 * _TintColor) * xlv_COLOR);
  color_1.w = tmpvar_2.w;
  color_1.xyz = (tmpvar_2.xyz * _EmissionScaler);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_3;
    mediump vec4 ScreenDissColorFlow_4;
    mediump vec4 spColor_5;
    mediump float tt_6;
    mediump vec4 ScreenDissColor_7;
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_7 = tmpvar_8;
    tt_6 = 0.0;
    spColor_5 = _ScreenDissColor;
    mediump float tmpvar_9;
    tmpvar_9 = ((7.96 * ScreenDissColor_7.y) - 1.0);
    highp vec4 tmpvar_10;
    tmpvar_10 = (_RotationSpeed * _Time);
    highp float tmpvar_11;
    tmpvar_11 = cos(tmpvar_10).x;
    highp mat2 tmpvar_12;
    tmpvar_12[0].x = tmpvar_11;
    tmpvar_12[0].y = sin(tmpvar_10).x;
    tmpvar_12[1].x = -(sin(tmpvar_10).x);
    tmpvar_12[1].y = tmpvar_11;
    highp vec2 tmpvar_13;
    tmpvar_13 = (xlv_TEXCOORD0 * tmpvar_12);
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_ScreenDissTex, tmpvar_13);
    ScreenDissColorFlow_4 = tmpvar_14;
    DRange_3 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_7.x * _RangeNormal));
    if ((tmpvar_9 >= ((
      (1.7 - (ScreenDissColorFlow_4.z * TimeFlow))
     + TimeAdd) * DRange_3))) {
      tt_6 = 1.0;
    } else {
      if ((tmpvar_9 >= (_RangeScale * DRange_3))) {
        tt_6 = 1.0;
        spColor_5 = _ScreenDissRangeColor;
      };
    };
    color_1 = mix (color_1, spColor_5, vec4(tt_6));
  };
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
uniform highp vec4 _Time;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _ScreenDissColor;
uniform mediump vec4 _ScreenDissRangeColor;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _EmissionScaler;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = ((2.0 * _TintColor) * xlv_COLOR);
  color_1.w = tmpvar_2.w;
  color_1.xyz = (tmpvar_2.xyz * _EmissionScaler);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_3;
    mediump vec4 ScreenDissColorFlow_4;
    mediump vec4 spColor_5;
    mediump float tt_6;
    mediump vec4 ScreenDissColor_7;
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_7 = tmpvar_8;
    tt_6 = 0.0;
    spColor_5 = _ScreenDissColor;
    mediump float tmpvar_9;
    tmpvar_9 = ((7.96 * ScreenDissColor_7.y) - 1.0);
    highp vec4 tmpvar_10;
    tmpvar_10 = (_RotationSpeed * _Time);
    highp float tmpvar_11;
    tmpvar_11 = cos(tmpvar_10).x;
    highp mat2 tmpvar_12;
    tmpvar_12[0].x = tmpvar_11;
    tmpvar_12[0].y = sin(tmpvar_10).x;
    tmpvar_12[1].x = -(sin(tmpvar_10).x);
    tmpvar_12[1].y = tmpvar_11;
    highp vec2 tmpvar_13;
    tmpvar_13 = (xlv_TEXCOORD0 * tmpvar_12);
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_ScreenDissTex, tmpvar_13);
    ScreenDissColorFlow_4 = tmpvar_14;
    DRange_3 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_7.x * _RangeNormal));
    if ((tmpvar_9 >= ((
      (1.7 - (ScreenDissColorFlow_4.z * TimeFlow))
     + TimeAdd) * DRange_3))) {
      tt_6 = 1.0;
    } else {
      if ((tmpvar_9 >= (_RangeScale * DRange_3))) {
        tt_6 = 1.0;
        spColor_5 = _ScreenDissRangeColor;
      };
    };
    color_1 = mix (color_1, spColor_5, vec4(tt_6));
  };
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
uniform highp vec4 _Time;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _ScreenDissColor;
uniform mediump vec4 _ScreenDissRangeColor;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = ((2.0 * _TintColor) * xlv_COLOR);
  color_1.w = tmpvar_2.w;
  color_1.xyz = (tmpvar_2.xyz * _EmissionScaler);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_3;
    mediump vec4 ScreenDissColorFlow_4;
    mediump vec4 spColor_5;
    mediump float tt_6;
    mediump vec4 ScreenDissColor_7;
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_7 = tmpvar_8;
    tt_6 = 0.0;
    spColor_5 = _ScreenDissColor;
    mediump float tmpvar_9;
    tmpvar_9 = ((7.96 * ScreenDissColor_7.y) - 1.0);
    highp vec4 tmpvar_10;
    tmpvar_10 = (_RotationSpeed * _Time);
    highp float tmpvar_11;
    tmpvar_11 = cos(tmpvar_10).x;
    highp mat2 tmpvar_12;
    tmpvar_12[0].x = tmpvar_11;
    tmpvar_12[0].y = sin(tmpvar_10).x;
    tmpvar_12[1].x = -(sin(tmpvar_10).x);
    tmpvar_12[1].y = tmpvar_11;
    highp vec2 tmpvar_13;
    tmpvar_13 = (xlv_TEXCOORD0 * tmpvar_12);
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_ScreenDissTex, tmpvar_13);
    ScreenDissColorFlow_4 = tmpvar_14;
    DRange_3 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_7.x * _RangeNormal));
    if ((tmpvar_9 >= ((
      (1.7 - (ScreenDissColorFlow_4.z * TimeFlow))
     + TimeAdd) * DRange_3))) {
      tt_6 = 1.0;
    } else {
      if ((tmpvar_9 >= (_RangeScale * DRange_3))) {
        tt_6 = 1.0;
        spColor_5 = _ScreenDissRangeColor;
      };
    };
    color_1 = mix (color_1, spColor_5, vec4(tt_6));
  };
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
uniform highp vec4 _Time;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _ScreenDissColor;
uniform mediump vec4 _ScreenDissRangeColor;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = ((2.0 * _TintColor) * xlv_COLOR);
  color_1.w = tmpvar_2.w;
  color_1.xyz = (tmpvar_2.xyz * _EmissionScaler);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_3;
    mediump vec4 ScreenDissColorFlow_4;
    mediump vec4 spColor_5;
    mediump float tt_6;
    mediump vec4 ScreenDissColor_7;
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_7 = tmpvar_8;
    tt_6 = 0.0;
    spColor_5 = _ScreenDissColor;
    mediump float tmpvar_9;
    tmpvar_9 = ((7.96 * ScreenDissColor_7.y) - 1.0);
    highp vec4 tmpvar_10;
    tmpvar_10 = (_RotationSpeed * _Time);
    highp float tmpvar_11;
    tmpvar_11 = cos(tmpvar_10).x;
    highp mat2 tmpvar_12;
    tmpvar_12[0].x = tmpvar_11;
    tmpvar_12[0].y = sin(tmpvar_10).x;
    tmpvar_12[1].x = -(sin(tmpvar_10).x);
    tmpvar_12[1].y = tmpvar_11;
    highp vec2 tmpvar_13;
    tmpvar_13 = (xlv_TEXCOORD0 * tmpvar_12);
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_ScreenDissTex, tmpvar_13);
    ScreenDissColorFlow_4 = tmpvar_14;
    DRange_3 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_7.x * _RangeNormal));
    if ((tmpvar_9 >= ((
      (1.7 - (ScreenDissColorFlow_4.z * TimeFlow))
     + TimeAdd) * DRange_3))) {
      tt_6 = 1.0;
    } else {
      if ((tmpvar_9 >= (_RangeScale * DRange_3))) {
        tt_6 = 1.0;
        spColor_5 = _ScreenDissRangeColor;
      };
    };
    color_1 = mix (color_1, spColor_5, vec4(tt_6));
  };
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
uniform highp vec4 _Time;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _ScreenDissColor;
uniform mediump vec4 _ScreenDissRangeColor;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = ((2.0 * _TintColor) * xlv_COLOR);
  color_1.w = tmpvar_2.w;
  color_1.xyz = (tmpvar_2.xyz * _EmissionScaler);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_3;
    mediump vec4 ScreenDissColorFlow_4;
    mediump vec4 spColor_5;
    mediump float tt_6;
    mediump vec4 ScreenDissColor_7;
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_7 = tmpvar_8;
    tt_6 = 0.0;
    spColor_5 = _ScreenDissColor;
    mediump float tmpvar_9;
    tmpvar_9 = ((7.96 * ScreenDissColor_7.y) - 1.0);
    highp vec4 tmpvar_10;
    tmpvar_10 = (_RotationSpeed * _Time);
    highp float tmpvar_11;
    tmpvar_11 = cos(tmpvar_10).x;
    highp mat2 tmpvar_12;
    tmpvar_12[0].x = tmpvar_11;
    tmpvar_12[0].y = sin(tmpvar_10).x;
    tmpvar_12[1].x = -(sin(tmpvar_10).x);
    tmpvar_12[1].y = tmpvar_11;
    highp vec2 tmpvar_13;
    tmpvar_13 = (xlv_TEXCOORD0 * tmpvar_12);
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_ScreenDissTex, tmpvar_13);
    ScreenDissColorFlow_4 = tmpvar_14;
    DRange_3 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_7.x * _RangeNormal));
    if ((tmpvar_9 >= ((
      (1.7 - (ScreenDissColorFlow_4.z * TimeFlow))
     + TimeAdd) * DRange_3))) {
      tt_6 = 1.0;
    } else {
      if ((tmpvar_9 >= (_RangeScale * DRange_3))) {
        tt_6 = 1.0;
        spColor_5 = _ScreenDissRangeColor;
      };
    };
    color_1 = mix (color_1, spColor_5, vec4(tt_6));
  };
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
uniform highp vec4 _Time;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _ScreenDissColor;
uniform mediump vec4 _ScreenDissRangeColor;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _EmissionScaler;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
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
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * xlv_COLOR);
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_7;
    mediump vec4 ScreenDissColorFlow_8;
    mediump vec4 spColor_9;
    mediump float tt_10;
    mediump vec4 ScreenDissColor_11;
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_11 = tmpvar_12;
    tt_10 = 0.0;
    spColor_9 = _ScreenDissColor;
    mediump float tmpvar_13;
    tmpvar_13 = ((7.96 * ScreenDissColor_11.y) - 1.0);
    highp vec4 tmpvar_14;
    tmpvar_14 = (_RotationSpeed * _Time);
    highp float tmpvar_15;
    tmpvar_15 = cos(tmpvar_14).x;
    highp mat2 tmpvar_16;
    tmpvar_16[0].x = tmpvar_15;
    tmpvar_16[0].y = sin(tmpvar_14).x;
    tmpvar_16[1].x = -(sin(tmpvar_14).x);
    tmpvar_16[1].y = tmpvar_15;
    highp vec2 tmpvar_17;
    tmpvar_17 = (xlv_TEXCOORD0 * tmpvar_16);
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_ScreenDissTex, tmpvar_17);
    ScreenDissColorFlow_8 = tmpvar_18;
    DRange_7 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_11.x * _RangeNormal));
    if ((tmpvar_13 >= ((
      (1.7 - (ScreenDissColorFlow_8.z * TimeFlow))
     + TimeAdd) * DRange_7))) {
      tt_10 = 1.0;
    } else {
      if ((tmpvar_13 >= (_RangeScale * DRange_7))) {
        tt_10 = 1.0;
        spColor_9 = _ScreenDissRangeColor;
      };
    };
    color_1 = mix (color_1, spColor_9, vec4(tt_10));
  };
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
uniform highp vec4 _Time;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _ScreenDissColor;
uniform mediump vec4 _ScreenDissRangeColor;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _EmissionScaler;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
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
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * xlv_COLOR);
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_7;
    mediump vec4 ScreenDissColorFlow_8;
    mediump vec4 spColor_9;
    mediump float tt_10;
    mediump vec4 ScreenDissColor_11;
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_11 = tmpvar_12;
    tt_10 = 0.0;
    spColor_9 = _ScreenDissColor;
    mediump float tmpvar_13;
    tmpvar_13 = ((7.96 * ScreenDissColor_11.y) - 1.0);
    highp vec4 tmpvar_14;
    tmpvar_14 = (_RotationSpeed * _Time);
    highp float tmpvar_15;
    tmpvar_15 = cos(tmpvar_14).x;
    highp mat2 tmpvar_16;
    tmpvar_16[0].x = tmpvar_15;
    tmpvar_16[0].y = sin(tmpvar_14).x;
    tmpvar_16[1].x = -(sin(tmpvar_14).x);
    tmpvar_16[1].y = tmpvar_15;
    highp vec2 tmpvar_17;
    tmpvar_17 = (xlv_TEXCOORD0 * tmpvar_16);
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_ScreenDissTex, tmpvar_17);
    ScreenDissColorFlow_8 = tmpvar_18;
    DRange_7 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_11.x * _RangeNormal));
    if ((tmpvar_13 >= ((
      (1.7 - (ScreenDissColorFlow_8.z * TimeFlow))
     + TimeAdd) * DRange_7))) {
      tt_10 = 1.0;
    } else {
      if ((tmpvar_13 >= (_RangeScale * DRange_7))) {
        tt_10 = 1.0;
        spColor_9 = _ScreenDissRangeColor;
      };
    };
    color_1 = mix (color_1, spColor_9, vec4(tt_10));
  };
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
uniform highp vec4 _Time;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _ScreenDissColor;
uniform mediump vec4 _ScreenDissRangeColor;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _EmissionScaler;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
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
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * xlv_COLOR);
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_7;
    mediump vec4 ScreenDissColorFlow_8;
    mediump vec4 spColor_9;
    mediump float tt_10;
    mediump vec4 ScreenDissColor_11;
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_11 = tmpvar_12;
    tt_10 = 0.0;
    spColor_9 = _ScreenDissColor;
    mediump float tmpvar_13;
    tmpvar_13 = ((7.96 * ScreenDissColor_11.y) - 1.0);
    highp vec4 tmpvar_14;
    tmpvar_14 = (_RotationSpeed * _Time);
    highp float tmpvar_15;
    tmpvar_15 = cos(tmpvar_14).x;
    highp mat2 tmpvar_16;
    tmpvar_16[0].x = tmpvar_15;
    tmpvar_16[0].y = sin(tmpvar_14).x;
    tmpvar_16[1].x = -(sin(tmpvar_14).x);
    tmpvar_16[1].y = tmpvar_15;
    highp vec2 tmpvar_17;
    tmpvar_17 = (xlv_TEXCOORD0 * tmpvar_16);
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_ScreenDissTex, tmpvar_17);
    ScreenDissColorFlow_8 = tmpvar_18;
    DRange_7 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_11.x * _RangeNormal));
    if ((tmpvar_13 >= ((
      (1.7 - (ScreenDissColorFlow_8.z * TimeFlow))
     + TimeAdd) * DRange_7))) {
      tt_10 = 1.0;
    } else {
      if ((tmpvar_13 >= (_RangeScale * DRange_7))) {
        tt_10 = 1.0;
        spColor_9 = _ScreenDissRangeColor;
      };
    };
    color_1 = mix (color_1, spColor_9, vec4(tt_10));
  };
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
uniform highp vec4 _Time;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _ScreenDissColor;
uniform mediump vec4 _ScreenDissRangeColor;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
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
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * xlv_COLOR);
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_7;
    mediump vec4 ScreenDissColorFlow_8;
    mediump vec4 spColor_9;
    mediump float tt_10;
    mediump vec4 ScreenDissColor_11;
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_11 = tmpvar_12;
    tt_10 = 0.0;
    spColor_9 = _ScreenDissColor;
    mediump float tmpvar_13;
    tmpvar_13 = ((7.96 * ScreenDissColor_11.y) - 1.0);
    highp vec4 tmpvar_14;
    tmpvar_14 = (_RotationSpeed * _Time);
    highp float tmpvar_15;
    tmpvar_15 = cos(tmpvar_14).x;
    highp mat2 tmpvar_16;
    tmpvar_16[0].x = tmpvar_15;
    tmpvar_16[0].y = sin(tmpvar_14).x;
    tmpvar_16[1].x = -(sin(tmpvar_14).x);
    tmpvar_16[1].y = tmpvar_15;
    highp vec2 tmpvar_17;
    tmpvar_17 = (xlv_TEXCOORD0 * tmpvar_16);
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_ScreenDissTex, tmpvar_17);
    ScreenDissColorFlow_8 = tmpvar_18;
    DRange_7 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_11.x * _RangeNormal));
    if ((tmpvar_13 >= ((
      (1.7 - (ScreenDissColorFlow_8.z * TimeFlow))
     + TimeAdd) * DRange_7))) {
      tt_10 = 1.0;
    } else {
      if ((tmpvar_13 >= (_RangeScale * DRange_7))) {
        tt_10 = 1.0;
        spColor_9 = _ScreenDissRangeColor;
      };
    };
    color_1 = mix (color_1, spColor_9, vec4(tt_10));
  };
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
uniform highp vec4 _Time;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _ScreenDissColor;
uniform mediump vec4 _ScreenDissRangeColor;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
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
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * xlv_COLOR);
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_7;
    mediump vec4 ScreenDissColorFlow_8;
    mediump vec4 spColor_9;
    mediump float tt_10;
    mediump vec4 ScreenDissColor_11;
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_11 = tmpvar_12;
    tt_10 = 0.0;
    spColor_9 = _ScreenDissColor;
    mediump float tmpvar_13;
    tmpvar_13 = ((7.96 * ScreenDissColor_11.y) - 1.0);
    highp vec4 tmpvar_14;
    tmpvar_14 = (_RotationSpeed * _Time);
    highp float tmpvar_15;
    tmpvar_15 = cos(tmpvar_14).x;
    highp mat2 tmpvar_16;
    tmpvar_16[0].x = tmpvar_15;
    tmpvar_16[0].y = sin(tmpvar_14).x;
    tmpvar_16[1].x = -(sin(tmpvar_14).x);
    tmpvar_16[1].y = tmpvar_15;
    highp vec2 tmpvar_17;
    tmpvar_17 = (xlv_TEXCOORD0 * tmpvar_16);
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_ScreenDissTex, tmpvar_17);
    ScreenDissColorFlow_8 = tmpvar_18;
    DRange_7 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_11.x * _RangeNormal));
    if ((tmpvar_13 >= ((
      (1.7 - (ScreenDissColorFlow_8.z * TimeFlow))
     + TimeAdd) * DRange_7))) {
      tt_10 = 1.0;
    } else {
      if ((tmpvar_13 >= (_RangeScale * DRange_7))) {
        tt_10 = 1.0;
        spColor_9 = _ScreenDissRangeColor;
      };
    };
    color_1 = mix (color_1, spColor_9, vec4(tt_10));
  };
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
uniform highp vec4 _Time;
uniform mediump vec4 _TintColor;
uniform mediump vec4 _ScreenDissColor;
uniform mediump vec4 _ScreenDissRangeColor;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
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
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * xlv_COLOR);
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_7;
    mediump vec4 ScreenDissColorFlow_8;
    mediump vec4 spColor_9;
    mediump float tt_10;
    mediump vec4 ScreenDissColor_11;
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_11 = tmpvar_12;
    tt_10 = 0.0;
    spColor_9 = _ScreenDissColor;
    mediump float tmpvar_13;
    tmpvar_13 = ((7.96 * ScreenDissColor_11.y) - 1.0);
    highp vec4 tmpvar_14;
    tmpvar_14 = (_RotationSpeed * _Time);
    highp float tmpvar_15;
    tmpvar_15 = cos(tmpvar_14).x;
    highp mat2 tmpvar_16;
    tmpvar_16[0].x = tmpvar_15;
    tmpvar_16[0].y = sin(tmpvar_14).x;
    tmpvar_16[1].x = -(sin(tmpvar_14).x);
    tmpvar_16[1].y = tmpvar_15;
    highp vec2 tmpvar_17;
    tmpvar_17 = (xlv_TEXCOORD0 * tmpvar_16);
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_ScreenDissTex, tmpvar_17);
    ScreenDissColorFlow_8 = tmpvar_18;
    DRange_7 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_11.x * _RangeNormal));
    if ((tmpvar_13 >= ((
      (1.7 - (ScreenDissColorFlow_8.z * TimeFlow))
     + TimeAdd) * DRange_7))) {
      tt_10 = 1.0;
    } else {
      if ((tmpvar_13 >= (_RangeScale * DRange_7))) {
        tt_10 = 1.0;
        spColor_9 = _ScreenDissRangeColor;
      };
    };
    color_1 = mix (color_1, spColor_9, vec4(tt_10));
  };
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
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 89208
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
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _BloomFactor;
uniform mediump float _BloomFactorDissolve;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_2;
    mediump vec4 ScreenDissColorFlow_3;
    mediump float tt_4;
    mediump vec4 ScreenDissColor_5;
    lowp vec4 tmpvar_6;
    tmpvar_6 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_5 = tmpvar_6;
    tt_4 = 0.0;
    mediump float tmpvar_7;
    tmpvar_7 = ((7.96 * ScreenDissColor_5.y) - 1.0);
    highp vec4 tmpvar_8;
    tmpvar_8 = (_RotationSpeed * _Time);
    highp float tmpvar_9;
    tmpvar_9 = cos(tmpvar_8).x;
    highp mat2 tmpvar_10;
    tmpvar_10[0].x = tmpvar_9;
    tmpvar_10[0].y = sin(tmpvar_8).x;
    tmpvar_10[1].x = -(sin(tmpvar_8).x);
    tmpvar_10[1].y = tmpvar_9;
    highp vec2 tmpvar_11;
    tmpvar_11 = (xlv_TEXCOORD0 * tmpvar_10);
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_ScreenDissTex, tmpvar_11);
    ScreenDissColorFlow_3 = tmpvar_12;
    DRange_2 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_5.x * _RangeNormal));
    if ((tmpvar_7 >= ((
      (1.7 - (ScreenDissColorFlow_3.z * TimeFlow))
     + TimeAdd) * DRange_2))) {
      tt_4 = 0.0;
    } else {
      if ((tmpvar_7 >= (_RangeScale * DRange_2))) {
        tt_4 = 1.0;
      };
    };
    mediump float x_13;
    x_13 = (tt_4 - 0.01);
    if ((x_13 < 0.0)) {
      discard;
    };
    color_1.w = ((_BloomFactor * xlv_TEXCOORD1) * _BloomFactorDissolve);
  } else {
    lowp float x_14;
    x_14 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
    if ((x_14 < 0.0)) {
      discard;
    };
    color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  };
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
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _BloomFactor;
uniform mediump float _BloomFactorDissolve;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_2;
    mediump vec4 ScreenDissColorFlow_3;
    mediump float tt_4;
    mediump vec4 ScreenDissColor_5;
    lowp vec4 tmpvar_6;
    tmpvar_6 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_5 = tmpvar_6;
    tt_4 = 0.0;
    mediump float tmpvar_7;
    tmpvar_7 = ((7.96 * ScreenDissColor_5.y) - 1.0);
    highp vec4 tmpvar_8;
    tmpvar_8 = (_RotationSpeed * _Time);
    highp float tmpvar_9;
    tmpvar_9 = cos(tmpvar_8).x;
    highp mat2 tmpvar_10;
    tmpvar_10[0].x = tmpvar_9;
    tmpvar_10[0].y = sin(tmpvar_8).x;
    tmpvar_10[1].x = -(sin(tmpvar_8).x);
    tmpvar_10[1].y = tmpvar_9;
    highp vec2 tmpvar_11;
    tmpvar_11 = (xlv_TEXCOORD0 * tmpvar_10);
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_ScreenDissTex, tmpvar_11);
    ScreenDissColorFlow_3 = tmpvar_12;
    DRange_2 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_5.x * _RangeNormal));
    if ((tmpvar_7 >= ((
      (1.7 - (ScreenDissColorFlow_3.z * TimeFlow))
     + TimeAdd) * DRange_2))) {
      tt_4 = 0.0;
    } else {
      if ((tmpvar_7 >= (_RangeScale * DRange_2))) {
        tt_4 = 1.0;
      };
    };
    mediump float x_13;
    x_13 = (tt_4 - 0.01);
    if ((x_13 < 0.0)) {
      discard;
    };
    color_1.w = ((_BloomFactor * xlv_TEXCOORD1) * _BloomFactorDissolve);
  } else {
    lowp float x_14;
    x_14 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
    if ((x_14 < 0.0)) {
      discard;
    };
    color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  };
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
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _BloomFactor;
uniform mediump float _BloomFactorDissolve;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_2;
    mediump vec4 ScreenDissColorFlow_3;
    mediump float tt_4;
    mediump vec4 ScreenDissColor_5;
    lowp vec4 tmpvar_6;
    tmpvar_6 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_5 = tmpvar_6;
    tt_4 = 0.0;
    mediump float tmpvar_7;
    tmpvar_7 = ((7.96 * ScreenDissColor_5.y) - 1.0);
    highp vec4 tmpvar_8;
    tmpvar_8 = (_RotationSpeed * _Time);
    highp float tmpvar_9;
    tmpvar_9 = cos(tmpvar_8).x;
    highp mat2 tmpvar_10;
    tmpvar_10[0].x = tmpvar_9;
    tmpvar_10[0].y = sin(tmpvar_8).x;
    tmpvar_10[1].x = -(sin(tmpvar_8).x);
    tmpvar_10[1].y = tmpvar_9;
    highp vec2 tmpvar_11;
    tmpvar_11 = (xlv_TEXCOORD0 * tmpvar_10);
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_ScreenDissTex, tmpvar_11);
    ScreenDissColorFlow_3 = tmpvar_12;
    DRange_2 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_5.x * _RangeNormal));
    if ((tmpvar_7 >= ((
      (1.7 - (ScreenDissColorFlow_3.z * TimeFlow))
     + TimeAdd) * DRange_2))) {
      tt_4 = 0.0;
    } else {
      if ((tmpvar_7 >= (_RangeScale * DRange_2))) {
        tt_4 = 1.0;
      };
    };
    mediump float x_13;
    x_13 = (tt_4 - 0.01);
    if ((x_13 < 0.0)) {
      discard;
    };
    color_1.w = ((_BloomFactor * xlv_TEXCOORD1) * _BloomFactorDissolve);
  } else {
    lowp float x_14;
    x_14 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
    if ((x_14 < 0.0)) {
      discard;
    };
    color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  };
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
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _BloomFactor;
uniform mediump float _BloomFactorDissolve;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD0.x - xlv_TEXCOORD2.x);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.y - xlv_TEXCOORD2.y);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD2.z - xlv_TEXCOORD0.x);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2.w - xlv_TEXCOORD0.y);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_6;
    mediump vec4 ScreenDissColorFlow_7;
    mediump float tt_8;
    mediump vec4 ScreenDissColor_9;
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_9 = tmpvar_10;
    tt_8 = 0.0;
    mediump float tmpvar_11;
    tmpvar_11 = ((7.96 * ScreenDissColor_9.y) - 1.0);
    highp vec4 tmpvar_12;
    tmpvar_12 = (_RotationSpeed * _Time);
    highp float tmpvar_13;
    tmpvar_13 = cos(tmpvar_12).x;
    highp mat2 tmpvar_14;
    tmpvar_14[0].x = tmpvar_13;
    tmpvar_14[0].y = sin(tmpvar_12).x;
    tmpvar_14[1].x = -(sin(tmpvar_12).x);
    tmpvar_14[1].y = tmpvar_13;
    highp vec2 tmpvar_15;
    tmpvar_15 = (xlv_TEXCOORD0 * tmpvar_14);
    lowp vec4 tmpvar_16;
    tmpvar_16 = texture2D (_ScreenDissTex, tmpvar_15);
    ScreenDissColorFlow_7 = tmpvar_16;
    DRange_6 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_9.x * _RangeNormal));
    if ((tmpvar_11 >= ((
      (1.7 - (ScreenDissColorFlow_7.z * TimeFlow))
     + TimeAdd) * DRange_6))) {
      tt_8 = 0.0;
    } else {
      if ((tmpvar_11 >= (_RangeScale * DRange_6))) {
        tt_8 = 1.0;
      };
    };
    mediump float x_17;
    x_17 = (tt_8 - 0.01);
    if ((x_17 < 0.0)) {
      discard;
    };
    color_1.w = ((_BloomFactor * xlv_TEXCOORD1) * _BloomFactorDissolve);
  } else {
    lowp float x_18;
    x_18 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
    if ((x_18 < 0.0)) {
      discard;
    };
    color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  };
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
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _BloomFactor;
uniform mediump float _BloomFactorDissolve;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD0.x - xlv_TEXCOORD2.x);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.y - xlv_TEXCOORD2.y);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD2.z - xlv_TEXCOORD0.x);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2.w - xlv_TEXCOORD0.y);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_6;
    mediump vec4 ScreenDissColorFlow_7;
    mediump float tt_8;
    mediump vec4 ScreenDissColor_9;
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_9 = tmpvar_10;
    tt_8 = 0.0;
    mediump float tmpvar_11;
    tmpvar_11 = ((7.96 * ScreenDissColor_9.y) - 1.0);
    highp vec4 tmpvar_12;
    tmpvar_12 = (_RotationSpeed * _Time);
    highp float tmpvar_13;
    tmpvar_13 = cos(tmpvar_12).x;
    highp mat2 tmpvar_14;
    tmpvar_14[0].x = tmpvar_13;
    tmpvar_14[0].y = sin(tmpvar_12).x;
    tmpvar_14[1].x = -(sin(tmpvar_12).x);
    tmpvar_14[1].y = tmpvar_13;
    highp vec2 tmpvar_15;
    tmpvar_15 = (xlv_TEXCOORD0 * tmpvar_14);
    lowp vec4 tmpvar_16;
    tmpvar_16 = texture2D (_ScreenDissTex, tmpvar_15);
    ScreenDissColorFlow_7 = tmpvar_16;
    DRange_6 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_9.x * _RangeNormal));
    if ((tmpvar_11 >= ((
      (1.7 - (ScreenDissColorFlow_7.z * TimeFlow))
     + TimeAdd) * DRange_6))) {
      tt_8 = 0.0;
    } else {
      if ((tmpvar_11 >= (_RangeScale * DRange_6))) {
        tt_8 = 1.0;
      };
    };
    mediump float x_17;
    x_17 = (tt_8 - 0.01);
    if ((x_17 < 0.0)) {
      discard;
    };
    color_1.w = ((_BloomFactor * xlv_TEXCOORD1) * _BloomFactorDissolve);
  } else {
    lowp float x_18;
    x_18 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
    if ((x_18 < 0.0)) {
      discard;
    };
    color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  };
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
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _RangeScale;
uniform mediump float _RangeNormal;
uniform sampler2D _ScreenDissTex;
uniform mediump float _ScreenDissRange;
uniform mediump float _BloomFactor;
uniform mediump float _BloomFactorDissolve;
uniform mediump float _Dissolve;
uniform mediump float TimeAdd;
uniform mediump float TimeFlow;
uniform mediump float _RotationSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = (xlv_TEXCOORD0.x - xlv_TEXCOORD2.x);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp float x_3;
  x_3 = (xlv_TEXCOORD0.y - xlv_TEXCOORD2.y);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (xlv_TEXCOORD2.z - xlv_TEXCOORD0.x);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2.w - xlv_TEXCOORD0.y);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_Dissolve > 0.0)) {
    mediump float DRange_6;
    mediump vec4 ScreenDissColorFlow_7;
    mediump float tt_8;
    mediump vec4 ScreenDissColor_9;
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_ScreenDissTex, xlv_TEXCOORD0);
    ScreenDissColor_9 = tmpvar_10;
    tt_8 = 0.0;
    mediump float tmpvar_11;
    tmpvar_11 = ((7.96 * ScreenDissColor_9.y) - 1.0);
    highp vec4 tmpvar_12;
    tmpvar_12 = (_RotationSpeed * _Time);
    highp float tmpvar_13;
    tmpvar_13 = cos(tmpvar_12).x;
    highp mat2 tmpvar_14;
    tmpvar_14[0].x = tmpvar_13;
    tmpvar_14[0].y = sin(tmpvar_12).x;
    tmpvar_14[1].x = -(sin(tmpvar_12).x);
    tmpvar_14[1].y = tmpvar_13;
    highp vec2 tmpvar_15;
    tmpvar_15 = (xlv_TEXCOORD0 * tmpvar_14);
    lowp vec4 tmpvar_16;
    tmpvar_16 = texture2D (_ScreenDissTex, tmpvar_15);
    ScreenDissColorFlow_7 = tmpvar_16;
    DRange_6 = ((_ScreenDissRange * 4.0) + (ScreenDissColor_9.x * _RangeNormal));
    if ((tmpvar_11 >= ((
      (1.7 - (ScreenDissColorFlow_7.z * TimeFlow))
     + TimeAdd) * DRange_6))) {
      tt_8 = 0.0;
    } else {
      if ((tmpvar_11 >= (_RangeScale * DRange_6))) {
        tt_8 = 1.0;
      };
    };
    mediump float x_17;
    x_17 = (tt_8 - 0.01);
    if ((x_17 < 0.0)) {
      discard;
    };
    color_1.w = ((_BloomFactor * xlv_TEXCOORD1) * _BloomFactorDissolve);
  } else {
    lowp float x_18;
    x_18 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
    if ((x_18 < 0.0)) {
      discard;
    };
    color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  };
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