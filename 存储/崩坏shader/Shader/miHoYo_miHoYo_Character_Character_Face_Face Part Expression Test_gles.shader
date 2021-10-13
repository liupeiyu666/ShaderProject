//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Face/Face Part Expression Test" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionFactor ("Emission Factor", Range(0, 10)) = 1
_Blend ("Switch to closed eye textures", Range(0, 1)) = 0
_MainTex ("Base (RGB)", 2D) = "white" { }
_ClosedEyeTex ("Closed Eye Tex (RGB)", 2D) = "white" { }
_ColorToOffset ("Color To Tune", Color) = (0,0,0,0)
_ColorTolerance ("Color Tolerance", Range(0.01, 1)) = 0
_HueOffset ("Hue Offset", Range(0, 1)) = 0
_SaturateOffset ("Satureate Offset", Range(-1, 1)) = 0
_ValueOffset ("Value Offset", Range(-1, 1)) = 0
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Offset -2, -2
  GpuProgramID 34170
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ClosedEyeTex_ST;
uniform mediump vec3 _ColorToOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_1 = vec2(0.0, 0.0);
  tmpvar_2 = vec2(0.0, 0.0);
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  mediump float maxChannel_6;
  mediump float minChannel_7;
  mediump vec3 HSV_8;
  if ((_ColorToOffset.y < _ColorToOffset.x)) {
    maxChannel_6 = _ColorToOffset.x;
    minChannel_7 = _ColorToOffset.y;
  } else {
    maxChannel_6 = _ColorToOffset.y;
    minChannel_7 = _ColorToOffset.x;
  };
  if ((maxChannel_6 < _ColorToOffset.z)) {
    maxChannel_6 = _ColorToOffset.z;
  };
  if ((_ColorToOffset.z < minChannel_7)) {
    minChannel_7 = _ColorToOffset.z;
  };
  HSV_8.xy = vec2(0.0, 0.0);
  HSV_8.z = maxChannel_6;
  mediump float tmpvar_9;
  tmpvar_9 = (maxChannel_6 - minChannel_7);
  if ((tmpvar_9 != 0.0)) {
    mediump vec3 delRGB_10;
    HSV_8.y = (tmpvar_9 / maxChannel_6);
    delRGB_10 = (((vec3(maxChannel_6) - _ColorToOffset) + (3.0 * tmpvar_9)) / (6.0 * tmpvar_9));
    if ((_ColorToOffset.x == maxChannel_6)) {
      HSV_8.x = (delRGB_10.z - delRGB_10.y);
    } else {
      if ((_ColorToOffset.y == maxChannel_6)) {
        HSV_8.x = ((0.3333333 + delRGB_10.x) - delRGB_10.z);
      } else {
        if ((_ColorToOffset.z == maxChannel_6)) {
          HSV_8.x = ((0.6666667 + delRGB_10.y) - delRGB_10.x);
        };
      };
    };
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_11;
    highp vec4 tmpvar_12;
    tmpvar_12 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_13;
    tmpvar_13.x = tmpvar_12.x;
    tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
    o_11.xy = (tmpvar_13 + tmpvar_12.w);
    o_11.zw = tmpvar_4.zw;
    tmpvar_3.xyw = o_11.xyw;
    tmpvar_3.z = _DitherAlpha;
  };
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ClosedEyeTex_ST.xy) + _ClosedEyeTex_ST.zw);
  gl_Position = tmpvar_4;
  xlv_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = HSV_8;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ClosedEyeTex;
uniform highp float _Blend;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_2 = tmpvar_3;
  if ((_Blend >= 0.5)) {
    lowp vec4 tmpvar_4;
    tmpvar_4 = texture2D (_ClosedEyeTex, xlv_TEXCOORD1);
    outColor_2 = tmpvar_4;
  };
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ClosedEyeTex_ST;
uniform mediump vec3 _ColorToOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_1 = vec2(0.0, 0.0);
  tmpvar_2 = vec2(0.0, 0.0);
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  mediump float maxChannel_6;
  mediump float minChannel_7;
  mediump vec3 HSV_8;
  if ((_ColorToOffset.y < _ColorToOffset.x)) {
    maxChannel_6 = _ColorToOffset.x;
    minChannel_7 = _ColorToOffset.y;
  } else {
    maxChannel_6 = _ColorToOffset.y;
    minChannel_7 = _ColorToOffset.x;
  };
  if ((maxChannel_6 < _ColorToOffset.z)) {
    maxChannel_6 = _ColorToOffset.z;
  };
  if ((_ColorToOffset.z < minChannel_7)) {
    minChannel_7 = _ColorToOffset.z;
  };
  HSV_8.xy = vec2(0.0, 0.0);
  HSV_8.z = maxChannel_6;
  mediump float tmpvar_9;
  tmpvar_9 = (maxChannel_6 - minChannel_7);
  if ((tmpvar_9 != 0.0)) {
    mediump vec3 delRGB_10;
    HSV_8.y = (tmpvar_9 / maxChannel_6);
    delRGB_10 = (((vec3(maxChannel_6) - _ColorToOffset) + (3.0 * tmpvar_9)) / (6.0 * tmpvar_9));
    if ((_ColorToOffset.x == maxChannel_6)) {
      HSV_8.x = (delRGB_10.z - delRGB_10.y);
    } else {
      if ((_ColorToOffset.y == maxChannel_6)) {
        HSV_8.x = ((0.3333333 + delRGB_10.x) - delRGB_10.z);
      } else {
        if ((_ColorToOffset.z == maxChannel_6)) {
          HSV_8.x = ((0.6666667 + delRGB_10.y) - delRGB_10.x);
        };
      };
    };
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_11;
    highp vec4 tmpvar_12;
    tmpvar_12 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_13;
    tmpvar_13.x = tmpvar_12.x;
    tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
    o_11.xy = (tmpvar_13 + tmpvar_12.w);
    o_11.zw = tmpvar_4.zw;
    tmpvar_3.xyw = o_11.xyw;
    tmpvar_3.z = _DitherAlpha;
  };
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ClosedEyeTex_ST.xy) + _ClosedEyeTex_ST.zw);
  gl_Position = tmpvar_4;
  xlv_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = HSV_8;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ClosedEyeTex;
uniform highp float _Blend;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_2 = tmpvar_3;
  if ((_Blend >= 0.5)) {
    lowp vec4 tmpvar_4;
    tmpvar_4 = texture2D (_ClosedEyeTex, xlv_TEXCOORD1);
    outColor_2 = tmpvar_4;
  };
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ClosedEyeTex_ST;
uniform mediump vec3 _ColorToOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_1 = vec2(0.0, 0.0);
  tmpvar_2 = vec2(0.0, 0.0);
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  mediump float maxChannel_6;
  mediump float minChannel_7;
  mediump vec3 HSV_8;
  if ((_ColorToOffset.y < _ColorToOffset.x)) {
    maxChannel_6 = _ColorToOffset.x;
    minChannel_7 = _ColorToOffset.y;
  } else {
    maxChannel_6 = _ColorToOffset.y;
    minChannel_7 = _ColorToOffset.x;
  };
  if ((maxChannel_6 < _ColorToOffset.z)) {
    maxChannel_6 = _ColorToOffset.z;
  };
  if ((_ColorToOffset.z < minChannel_7)) {
    minChannel_7 = _ColorToOffset.z;
  };
  HSV_8.xy = vec2(0.0, 0.0);
  HSV_8.z = maxChannel_6;
  mediump float tmpvar_9;
  tmpvar_9 = (maxChannel_6 - minChannel_7);
  if ((tmpvar_9 != 0.0)) {
    mediump vec3 delRGB_10;
    HSV_8.y = (tmpvar_9 / maxChannel_6);
    delRGB_10 = (((vec3(maxChannel_6) - _ColorToOffset) + (3.0 * tmpvar_9)) / (6.0 * tmpvar_9));
    if ((_ColorToOffset.x == maxChannel_6)) {
      HSV_8.x = (delRGB_10.z - delRGB_10.y);
    } else {
      if ((_ColorToOffset.y == maxChannel_6)) {
        HSV_8.x = ((0.3333333 + delRGB_10.x) - delRGB_10.z);
      } else {
        if ((_ColorToOffset.z == maxChannel_6)) {
          HSV_8.x = ((0.6666667 + delRGB_10.y) - delRGB_10.x);
        };
      };
    };
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_11;
    highp vec4 tmpvar_12;
    tmpvar_12 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_13;
    tmpvar_13.x = tmpvar_12.x;
    tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
    o_11.xy = (tmpvar_13 + tmpvar_12.w);
    o_11.zw = tmpvar_4.zw;
    tmpvar_3.xyw = o_11.xyw;
    tmpvar_3.z = _DitherAlpha;
  };
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _ClosedEyeTex_ST.xy) + _ClosedEyeTex_ST.zw);
  gl_Position = tmpvar_4;
  xlv_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = HSV_8;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ClosedEyeTex;
uniform highp float _Blend;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_2 = tmpvar_3;
  if ((_Blend >= 0.5)) {
    lowp vec4 tmpvar_4;
    tmpvar_4 = texture2D (_ClosedEyeTex, xlv_TEXCOORD1);
    outColor_2 = tmpvar_4;
  };
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
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
 Pass {
  Name "CONSTANT_REPLACE"
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 76345
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
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
}
}
}
Fallback "Diffuse"
}