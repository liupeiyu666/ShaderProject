//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Attribute Radar" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Size ("Radar Size", Range(0, 1)) = 1
_AntiAliasStrength ("Anti-alias Strength (refer to texel size if be 1)", Range(0.01, 10)) = 1
_Attribute1 ("Attribute 1", Range(0.01, 1)) = 1
_Attribute2 ("Attribute 2", Range(0.01, 1)) = 1
_Attribute3 ("Attribute 3", Range(0.01, 1)) = 1
_Attribute4 ("Attribute 4", Range(0.01, 1)) = 1
_Attribute5 ("Attribute 5", Range(0.01, 1)) = 1
_Attribute6 ("Attribute 6", Range(0.01, 1)) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
[Toggle(RECT_MASK)] _RectMask ("Rect Mask", Float) = 0
_RMRect ("Rect Mask Rect", Vector) = (0,0,1,1)
_RMTransitWidth ("Rect Mask Transit Width", Vector) = (0,0,0,0)
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 LOD 200
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 14611
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Size;
uniform highp float _Attribute1;
uniform highp float _Attribute2;
uniform highp float _Attribute3;
uniform highp float _Attribute4;
uniform highp float _Attribute5;
uniform highp float _Attribute6;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  highp float tmpvar_8;
  tmpvar_8 = (-(_Size) * 0.5);
  tmpvar_4.xy = ((vec2(1.0, 0.0) * _Attribute1) * tmpvar_8);
  tmpvar_4.zw = ((vec2(0.5, 0.866025) * _Attribute2) * tmpvar_8);
  tmpvar_5.xy = ((vec2(-0.5, 0.866025) * _Attribute3) * tmpvar_8);
  tmpvar_5.zw = ((vec2(-1.0, 0.0) * _Attribute4) * tmpvar_8);
  tmpvar_6.xy = ((vec2(-0.5, -0.866025) * _Attribute5) * tmpvar_8);
  tmpvar_6.zw = ((vec2(0.5, -0.866025) * _Attribute6) * tmpvar_8);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform highp float _AntiAliasStrength;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_2 + _TextureSampleAdd) * xlv_COLOR);
  color_1 = tmpvar_3;
  highp vec2 uv_4;
  uv_4 = xlv_TEXCOORD0;
  highp float dfBC_5;
  highp float dfAB_6;
  highp vec2 c_7;
  highp vec2 b_8;
  highp vec2 a_9;
  uv_4 = (uv_4 - 0.5);
  highp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (min (abs(
    (uv_4.y / uv_4.x)
  ), 1.0) / max (abs(
    (uv_4.y / uv_4.x)
  ), 1.0));
  highp float tmpvar_12;
  tmpvar_12 = (tmpvar_11 * tmpvar_11);
  tmpvar_12 = (((
    ((((
      ((((-0.01213232 * tmpvar_12) + 0.05368138) * tmpvar_12) - 0.1173503)
     * tmpvar_12) + 0.1938925) * tmpvar_12) - 0.3326756)
   * tmpvar_12) + 0.9999793) * tmpvar_11);
  tmpvar_12 = (tmpvar_12 + (float(
    (abs((uv_4.y / uv_4.x)) > 1.0)
  ) * (
    (tmpvar_12 * -2.0)
   + 1.570796)));
  tmpvar_10 = (tmpvar_12 * sign((uv_4.y / uv_4.x)));
  if ((abs(uv_4.x) > (1e-08 * abs(uv_4.y)))) {
    if ((uv_4.x < 0.0)) {
      if ((uv_4.y >= 0.0)) {
        tmpvar_10 += 3.141593;
      } else {
        tmpvar_10 = (tmpvar_10 - 3.141593);
      };
    };
  } else {
    tmpvar_10 = (sign(uv_4.y) * 1.570796);
  };
  highp float tmpvar_13;
  tmpvar_13 = (tmpvar_10 + 3.141593);
  if (((tmpvar_13 < 0.5236) || (5.7596 < tmpvar_13))) {
    a_9 = xlv_TEXCOORD3.zw;
    b_8 = xlv_TEXCOORD1.xy;
    c_7 = xlv_TEXCOORD1.zw;
  } else {
    if ((tmpvar_13 < 1.5708)) {
      a_9 = xlv_TEXCOORD1.xy;
      b_8 = xlv_TEXCOORD1.zw;
      c_7 = xlv_TEXCOORD2.xy;
    } else {
      if ((tmpvar_13 < 2.618)) {
        a_9 = xlv_TEXCOORD1.zw;
        b_8 = xlv_TEXCOORD2.xy;
        c_7 = xlv_TEXCOORD2.zw;
      } else {
        if ((tmpvar_13 < 3.6652)) {
          a_9 = xlv_TEXCOORD2.xy;
          b_8 = xlv_TEXCOORD2.zw;
          c_7 = xlv_TEXCOORD3.xy;
        } else {
          if ((tmpvar_13 < 4.7124)) {
            a_9 = xlv_TEXCOORD2.zw;
            b_8 = xlv_TEXCOORD3.xy;
            c_7 = xlv_TEXCOORD3.zw;
          } else {
            a_9 = xlv_TEXCOORD3.xy;
            b_8 = xlv_TEXCOORD3.zw;
            c_7 = xlv_TEXCOORD1.xy;
          };
        };
      };
    };
  };
  highp float tmpvar_14;
  tmpvar_14 = (b_8.y - a_9.y);
  highp float tmpvar_15;
  tmpvar_15 = (a_9.x - b_8.x);
  highp float tmpvar_16;
  tmpvar_16 = (c_7.y - b_8.y);
  highp float tmpvar_17;
  tmpvar_17 = (b_8.x - c_7.x);
  highp float tmpvar_18;
  tmpvar_18 = (_MainTex_TexelSize.x * _AntiAliasStrength);
  highp float edge0_19;
  edge0_19 = -(tmpvar_18);
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    ((((tmpvar_14 * uv_4.x) + (tmpvar_15 * uv_4.y)) - ((tmpvar_14 * a_9.x) + (tmpvar_15 * a_9.y))) / max (sqrt((
      (tmpvar_14 * tmpvar_14)
     + 
      (tmpvar_15 * tmpvar_15)
    )), 0.001))
   - edge0_19) / (tmpvar_18 - edge0_19)), 0.0, 1.0);
  dfAB_6 = (1.0 - (tmpvar_20 * (tmpvar_20 * 
    (3.0 - (2.0 * tmpvar_20))
  )));
  highp float edge0_21;
  edge0_21 = -(tmpvar_18);
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    ((((tmpvar_16 * uv_4.x) + (tmpvar_17 * uv_4.y)) - ((tmpvar_16 * b_8.x) + (tmpvar_17 * b_8.y))) / max (sqrt((
      (tmpvar_16 * tmpvar_16)
     + 
      (tmpvar_17 * tmpvar_17)
    )), 0.001))
   - edge0_21) / (tmpvar_18 - edge0_21)), 0.0, 1.0);
  dfBC_5 = (1.0 - (tmpvar_22 * (tmpvar_22 * 
    (3.0 - (2.0 * tmpvar_22))
  )));
  highp float tmpvar_23;
  tmpvar_23 = (((c_7.y - a_9.y) * (b_8.x - a_9.x)) + ((a_9.x - c_7.x) * (b_8.y - a_9.y)));
  highp float tmpvar_24;
  if ((0.0 < tmpvar_23)) {
    tmpvar_24 = min (dfAB_6, dfBC_5);
  } else {
    tmpvar_24 = max (dfAB_6, dfBC_5);
  };
  color_1.w = (tmpvar_3.w * tmpvar_24);
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
uniform mediump vec4 _Color;
uniform highp float _Size;
uniform highp float _Attribute1;
uniform highp float _Attribute2;
uniform highp float _Attribute3;
uniform highp float _Attribute4;
uniform highp float _Attribute5;
uniform highp float _Attribute6;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  highp float tmpvar_8;
  tmpvar_8 = (-(_Size) * 0.5);
  tmpvar_4.xy = ((vec2(1.0, 0.0) * _Attribute1) * tmpvar_8);
  tmpvar_4.zw = ((vec2(0.5, 0.866025) * _Attribute2) * tmpvar_8);
  tmpvar_5.xy = ((vec2(-0.5, 0.866025) * _Attribute3) * tmpvar_8);
  tmpvar_5.zw = ((vec2(-1.0, 0.0) * _Attribute4) * tmpvar_8);
  tmpvar_6.xy = ((vec2(-0.5, -0.866025) * _Attribute5) * tmpvar_8);
  tmpvar_6.zw = ((vec2(0.5, -0.866025) * _Attribute6) * tmpvar_8);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform highp float _AntiAliasStrength;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_2 + _TextureSampleAdd) * xlv_COLOR);
  color_1 = tmpvar_3;
  highp vec2 uv_4;
  uv_4 = xlv_TEXCOORD0;
  highp float dfBC_5;
  highp float dfAB_6;
  highp vec2 c_7;
  highp vec2 b_8;
  highp vec2 a_9;
  uv_4 = (uv_4 - 0.5);
  highp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (min (abs(
    (uv_4.y / uv_4.x)
  ), 1.0) / max (abs(
    (uv_4.y / uv_4.x)
  ), 1.0));
  highp float tmpvar_12;
  tmpvar_12 = (tmpvar_11 * tmpvar_11);
  tmpvar_12 = (((
    ((((
      ((((-0.01213232 * tmpvar_12) + 0.05368138) * tmpvar_12) - 0.1173503)
     * tmpvar_12) + 0.1938925) * tmpvar_12) - 0.3326756)
   * tmpvar_12) + 0.9999793) * tmpvar_11);
  tmpvar_12 = (tmpvar_12 + (float(
    (abs((uv_4.y / uv_4.x)) > 1.0)
  ) * (
    (tmpvar_12 * -2.0)
   + 1.570796)));
  tmpvar_10 = (tmpvar_12 * sign((uv_4.y / uv_4.x)));
  if ((abs(uv_4.x) > (1e-08 * abs(uv_4.y)))) {
    if ((uv_4.x < 0.0)) {
      if ((uv_4.y >= 0.0)) {
        tmpvar_10 += 3.141593;
      } else {
        tmpvar_10 = (tmpvar_10 - 3.141593);
      };
    };
  } else {
    tmpvar_10 = (sign(uv_4.y) * 1.570796);
  };
  highp float tmpvar_13;
  tmpvar_13 = (tmpvar_10 + 3.141593);
  if (((tmpvar_13 < 0.5236) || (5.7596 < tmpvar_13))) {
    a_9 = xlv_TEXCOORD3.zw;
    b_8 = xlv_TEXCOORD1.xy;
    c_7 = xlv_TEXCOORD1.zw;
  } else {
    if ((tmpvar_13 < 1.5708)) {
      a_9 = xlv_TEXCOORD1.xy;
      b_8 = xlv_TEXCOORD1.zw;
      c_7 = xlv_TEXCOORD2.xy;
    } else {
      if ((tmpvar_13 < 2.618)) {
        a_9 = xlv_TEXCOORD1.zw;
        b_8 = xlv_TEXCOORD2.xy;
        c_7 = xlv_TEXCOORD2.zw;
      } else {
        if ((tmpvar_13 < 3.6652)) {
          a_9 = xlv_TEXCOORD2.xy;
          b_8 = xlv_TEXCOORD2.zw;
          c_7 = xlv_TEXCOORD3.xy;
        } else {
          if ((tmpvar_13 < 4.7124)) {
            a_9 = xlv_TEXCOORD2.zw;
            b_8 = xlv_TEXCOORD3.xy;
            c_7 = xlv_TEXCOORD3.zw;
          } else {
            a_9 = xlv_TEXCOORD3.xy;
            b_8 = xlv_TEXCOORD3.zw;
            c_7 = xlv_TEXCOORD1.xy;
          };
        };
      };
    };
  };
  highp float tmpvar_14;
  tmpvar_14 = (b_8.y - a_9.y);
  highp float tmpvar_15;
  tmpvar_15 = (a_9.x - b_8.x);
  highp float tmpvar_16;
  tmpvar_16 = (c_7.y - b_8.y);
  highp float tmpvar_17;
  tmpvar_17 = (b_8.x - c_7.x);
  highp float tmpvar_18;
  tmpvar_18 = (_MainTex_TexelSize.x * _AntiAliasStrength);
  highp float edge0_19;
  edge0_19 = -(tmpvar_18);
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    ((((tmpvar_14 * uv_4.x) + (tmpvar_15 * uv_4.y)) - ((tmpvar_14 * a_9.x) + (tmpvar_15 * a_9.y))) / max (sqrt((
      (tmpvar_14 * tmpvar_14)
     + 
      (tmpvar_15 * tmpvar_15)
    )), 0.001))
   - edge0_19) / (tmpvar_18 - edge0_19)), 0.0, 1.0);
  dfAB_6 = (1.0 - (tmpvar_20 * (tmpvar_20 * 
    (3.0 - (2.0 * tmpvar_20))
  )));
  highp float edge0_21;
  edge0_21 = -(tmpvar_18);
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    ((((tmpvar_16 * uv_4.x) + (tmpvar_17 * uv_4.y)) - ((tmpvar_16 * b_8.x) + (tmpvar_17 * b_8.y))) / max (sqrt((
      (tmpvar_16 * tmpvar_16)
     + 
      (tmpvar_17 * tmpvar_17)
    )), 0.001))
   - edge0_21) / (tmpvar_18 - edge0_21)), 0.0, 1.0);
  dfBC_5 = (1.0 - (tmpvar_22 * (tmpvar_22 * 
    (3.0 - (2.0 * tmpvar_22))
  )));
  highp float tmpvar_23;
  tmpvar_23 = (((c_7.y - a_9.y) * (b_8.x - a_9.x)) + ((a_9.x - c_7.x) * (b_8.y - a_9.y)));
  highp float tmpvar_24;
  if ((0.0 < tmpvar_23)) {
    tmpvar_24 = min (dfAB_6, dfBC_5);
  } else {
    tmpvar_24 = max (dfAB_6, dfBC_5);
  };
  color_1.w = (tmpvar_3.w * tmpvar_24);
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
uniform mediump vec4 _Color;
uniform highp float _Size;
uniform highp float _Attribute1;
uniform highp float _Attribute2;
uniform highp float _Attribute3;
uniform highp float _Attribute4;
uniform highp float _Attribute5;
uniform highp float _Attribute6;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  highp float tmpvar_8;
  tmpvar_8 = (-(_Size) * 0.5);
  tmpvar_4.xy = ((vec2(1.0, 0.0) * _Attribute1) * tmpvar_8);
  tmpvar_4.zw = ((vec2(0.5, 0.866025) * _Attribute2) * tmpvar_8);
  tmpvar_5.xy = ((vec2(-0.5, 0.866025) * _Attribute3) * tmpvar_8);
  tmpvar_5.zw = ((vec2(-1.0, 0.0) * _Attribute4) * tmpvar_8);
  tmpvar_6.xy = ((vec2(-0.5, -0.866025) * _Attribute5) * tmpvar_8);
  tmpvar_6.zw = ((vec2(0.5, -0.866025) * _Attribute6) * tmpvar_8);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform highp float _AntiAliasStrength;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_2 + _TextureSampleAdd) * xlv_COLOR);
  color_1 = tmpvar_3;
  highp vec2 uv_4;
  uv_4 = xlv_TEXCOORD0;
  highp float dfBC_5;
  highp float dfAB_6;
  highp vec2 c_7;
  highp vec2 b_8;
  highp vec2 a_9;
  uv_4 = (uv_4 - 0.5);
  highp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (min (abs(
    (uv_4.y / uv_4.x)
  ), 1.0) / max (abs(
    (uv_4.y / uv_4.x)
  ), 1.0));
  highp float tmpvar_12;
  tmpvar_12 = (tmpvar_11 * tmpvar_11);
  tmpvar_12 = (((
    ((((
      ((((-0.01213232 * tmpvar_12) + 0.05368138) * tmpvar_12) - 0.1173503)
     * tmpvar_12) + 0.1938925) * tmpvar_12) - 0.3326756)
   * tmpvar_12) + 0.9999793) * tmpvar_11);
  tmpvar_12 = (tmpvar_12 + (float(
    (abs((uv_4.y / uv_4.x)) > 1.0)
  ) * (
    (tmpvar_12 * -2.0)
   + 1.570796)));
  tmpvar_10 = (tmpvar_12 * sign((uv_4.y / uv_4.x)));
  if ((abs(uv_4.x) > (1e-08 * abs(uv_4.y)))) {
    if ((uv_4.x < 0.0)) {
      if ((uv_4.y >= 0.0)) {
        tmpvar_10 += 3.141593;
      } else {
        tmpvar_10 = (tmpvar_10 - 3.141593);
      };
    };
  } else {
    tmpvar_10 = (sign(uv_4.y) * 1.570796);
  };
  highp float tmpvar_13;
  tmpvar_13 = (tmpvar_10 + 3.141593);
  if (((tmpvar_13 < 0.5236) || (5.7596 < tmpvar_13))) {
    a_9 = xlv_TEXCOORD3.zw;
    b_8 = xlv_TEXCOORD1.xy;
    c_7 = xlv_TEXCOORD1.zw;
  } else {
    if ((tmpvar_13 < 1.5708)) {
      a_9 = xlv_TEXCOORD1.xy;
      b_8 = xlv_TEXCOORD1.zw;
      c_7 = xlv_TEXCOORD2.xy;
    } else {
      if ((tmpvar_13 < 2.618)) {
        a_9 = xlv_TEXCOORD1.zw;
        b_8 = xlv_TEXCOORD2.xy;
        c_7 = xlv_TEXCOORD2.zw;
      } else {
        if ((tmpvar_13 < 3.6652)) {
          a_9 = xlv_TEXCOORD2.xy;
          b_8 = xlv_TEXCOORD2.zw;
          c_7 = xlv_TEXCOORD3.xy;
        } else {
          if ((tmpvar_13 < 4.7124)) {
            a_9 = xlv_TEXCOORD2.zw;
            b_8 = xlv_TEXCOORD3.xy;
            c_7 = xlv_TEXCOORD3.zw;
          } else {
            a_9 = xlv_TEXCOORD3.xy;
            b_8 = xlv_TEXCOORD3.zw;
            c_7 = xlv_TEXCOORD1.xy;
          };
        };
      };
    };
  };
  highp float tmpvar_14;
  tmpvar_14 = (b_8.y - a_9.y);
  highp float tmpvar_15;
  tmpvar_15 = (a_9.x - b_8.x);
  highp float tmpvar_16;
  tmpvar_16 = (c_7.y - b_8.y);
  highp float tmpvar_17;
  tmpvar_17 = (b_8.x - c_7.x);
  highp float tmpvar_18;
  tmpvar_18 = (_MainTex_TexelSize.x * _AntiAliasStrength);
  highp float edge0_19;
  edge0_19 = -(tmpvar_18);
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    ((((tmpvar_14 * uv_4.x) + (tmpvar_15 * uv_4.y)) - ((tmpvar_14 * a_9.x) + (tmpvar_15 * a_9.y))) / max (sqrt((
      (tmpvar_14 * tmpvar_14)
     + 
      (tmpvar_15 * tmpvar_15)
    )), 0.001))
   - edge0_19) / (tmpvar_18 - edge0_19)), 0.0, 1.0);
  dfAB_6 = (1.0 - (tmpvar_20 * (tmpvar_20 * 
    (3.0 - (2.0 * tmpvar_20))
  )));
  highp float edge0_21;
  edge0_21 = -(tmpvar_18);
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    ((((tmpvar_16 * uv_4.x) + (tmpvar_17 * uv_4.y)) - ((tmpvar_16 * b_8.x) + (tmpvar_17 * b_8.y))) / max (sqrt((
      (tmpvar_16 * tmpvar_16)
     + 
      (tmpvar_17 * tmpvar_17)
    )), 0.001))
   - edge0_21) / (tmpvar_18 - edge0_21)), 0.0, 1.0);
  dfBC_5 = (1.0 - (tmpvar_22 * (tmpvar_22 * 
    (3.0 - (2.0 * tmpvar_22))
  )));
  highp float tmpvar_23;
  tmpvar_23 = (((c_7.y - a_9.y) * (b_8.x - a_9.x)) + ((a_9.x - c_7.x) * (b_8.y - a_9.y)));
  highp float tmpvar_24;
  if ((0.0 < tmpvar_23)) {
    tmpvar_24 = min (dfAB_6, dfBC_5);
  } else {
    tmpvar_24 = max (dfAB_6, dfBC_5);
  };
  color_1.w = (tmpvar_3.w * tmpvar_24);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "RECT_MASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Size;
uniform highp float _Attribute1;
uniform highp float _Attribute2;
uniform highp float _Attribute3;
uniform highp float _Attribute4;
uniform highp float _Attribute5;
uniform highp float _Attribute6;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = tmpvar_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_7 = o_10;
  tmpvar_2 = (_glesColor * _Color);
  highp float tmpvar_13;
  tmpvar_13 = (-(_Size) * 0.5);
  tmpvar_4.xy = ((vec2(1.0, 0.0) * _Attribute1) * tmpvar_13);
  tmpvar_4.zw = ((vec2(0.5, 0.866025) * _Attribute2) * tmpvar_13);
  tmpvar_5.xy = ((vec2(-0.5, 0.866025) * _Attribute3) * tmpvar_13);
  tmpvar_5.zw = ((vec2(-1.0, 0.0) * _Attribute4) * tmpvar_13);
  tmpvar_6.xy = ((vec2(-0.5, -0.866025) * _Attribute5) * tmpvar_13);
  tmpvar_6.zw = ((vec2(0.5, -0.866025) * _Attribute6) * tmpvar_13);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _TextureSampleAdd;
uniform highp float _AntiAliasStrength;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_2 + _TextureSampleAdd) * xlv_COLOR);
  color_1 = tmpvar_3;
  highp vec2 uv_4;
  uv_4 = xlv_TEXCOORD0;
  highp float dfBC_5;
  highp float dfAB_6;
  highp vec2 c_7;
  highp vec2 b_8;
  highp vec2 a_9;
  uv_4 = (uv_4 - 0.5);
  highp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (min (abs(
    (uv_4.y / uv_4.x)
  ), 1.0) / max (abs(
    (uv_4.y / uv_4.x)
  ), 1.0));
  highp float tmpvar_12;
  tmpvar_12 = (tmpvar_11 * tmpvar_11);
  tmpvar_12 = (((
    ((((
      ((((-0.01213232 * tmpvar_12) + 0.05368138) * tmpvar_12) - 0.1173503)
     * tmpvar_12) + 0.1938925) * tmpvar_12) - 0.3326756)
   * tmpvar_12) + 0.9999793) * tmpvar_11);
  tmpvar_12 = (tmpvar_12 + (float(
    (abs((uv_4.y / uv_4.x)) > 1.0)
  ) * (
    (tmpvar_12 * -2.0)
   + 1.570796)));
  tmpvar_10 = (tmpvar_12 * sign((uv_4.y / uv_4.x)));
  if ((abs(uv_4.x) > (1e-08 * abs(uv_4.y)))) {
    if ((uv_4.x < 0.0)) {
      if ((uv_4.y >= 0.0)) {
        tmpvar_10 += 3.141593;
      } else {
        tmpvar_10 = (tmpvar_10 - 3.141593);
      };
    };
  } else {
    tmpvar_10 = (sign(uv_4.y) * 1.570796);
  };
  highp float tmpvar_13;
  tmpvar_13 = (tmpvar_10 + 3.141593);
  if (((tmpvar_13 < 0.5236) || (5.7596 < tmpvar_13))) {
    a_9 = xlv_TEXCOORD3.zw;
    b_8 = xlv_TEXCOORD1.xy;
    c_7 = xlv_TEXCOORD1.zw;
  } else {
    if ((tmpvar_13 < 1.5708)) {
      a_9 = xlv_TEXCOORD1.xy;
      b_8 = xlv_TEXCOORD1.zw;
      c_7 = xlv_TEXCOORD2.xy;
    } else {
      if ((tmpvar_13 < 2.618)) {
        a_9 = xlv_TEXCOORD1.zw;
        b_8 = xlv_TEXCOORD2.xy;
        c_7 = xlv_TEXCOORD2.zw;
      } else {
        if ((tmpvar_13 < 3.6652)) {
          a_9 = xlv_TEXCOORD2.xy;
          b_8 = xlv_TEXCOORD2.zw;
          c_7 = xlv_TEXCOORD3.xy;
        } else {
          if ((tmpvar_13 < 4.7124)) {
            a_9 = xlv_TEXCOORD2.zw;
            b_8 = xlv_TEXCOORD3.xy;
            c_7 = xlv_TEXCOORD3.zw;
          } else {
            a_9 = xlv_TEXCOORD3.xy;
            b_8 = xlv_TEXCOORD3.zw;
            c_7 = xlv_TEXCOORD1.xy;
          };
        };
      };
    };
  };
  highp float tmpvar_14;
  tmpvar_14 = (b_8.y - a_9.y);
  highp float tmpvar_15;
  tmpvar_15 = (a_9.x - b_8.x);
  highp float tmpvar_16;
  tmpvar_16 = (c_7.y - b_8.y);
  highp float tmpvar_17;
  tmpvar_17 = (b_8.x - c_7.x);
  highp float tmpvar_18;
  tmpvar_18 = (_MainTex_TexelSize.x * _AntiAliasStrength);
  highp float edge0_19;
  edge0_19 = -(tmpvar_18);
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    ((((tmpvar_14 * uv_4.x) + (tmpvar_15 * uv_4.y)) - ((tmpvar_14 * a_9.x) + (tmpvar_15 * a_9.y))) / max (sqrt((
      (tmpvar_14 * tmpvar_14)
     + 
      (tmpvar_15 * tmpvar_15)
    )), 0.001))
   - edge0_19) / (tmpvar_18 - edge0_19)), 0.0, 1.0);
  dfAB_6 = (1.0 - (tmpvar_20 * (tmpvar_20 * 
    (3.0 - (2.0 * tmpvar_20))
  )));
  highp float edge0_21;
  edge0_21 = -(tmpvar_18);
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    ((((tmpvar_16 * uv_4.x) + (tmpvar_17 * uv_4.y)) - ((tmpvar_16 * b_8.x) + (tmpvar_17 * b_8.y))) / max (sqrt((
      (tmpvar_16 * tmpvar_16)
     + 
      (tmpvar_17 * tmpvar_17)
    )), 0.001))
   - edge0_21) / (tmpvar_18 - edge0_21)), 0.0, 1.0);
  dfBC_5 = (1.0 - (tmpvar_22 * (tmpvar_22 * 
    (3.0 - (2.0 * tmpvar_22))
  )));
  highp float tmpvar_23;
  tmpvar_23 = (((c_7.y - a_9.y) * (b_8.x - a_9.x)) + ((a_9.x - c_7.x) * (b_8.y - a_9.y)));
  highp float tmpvar_24;
  if ((0.0 < tmpvar_23)) {
    tmpvar_24 = min (dfAB_6, dfBC_5);
  } else {
    tmpvar_24 = max (dfAB_6, dfBC_5);
  };
  color_1.w = (tmpvar_3.w * tmpvar_24);
  mediump vec4 tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = clamp (((
    ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  color_1.w = ((color_1.w * tmpvar_25.x) * ((tmpvar_25.y * tmpvar_25.z) * tmpvar_25.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "RECT_MASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Size;
uniform highp float _Attribute1;
uniform highp float _Attribute2;
uniform highp float _Attribute3;
uniform highp float _Attribute4;
uniform highp float _Attribute5;
uniform highp float _Attribute6;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = tmpvar_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_7 = o_10;
  tmpvar_2 = (_glesColor * _Color);
  highp float tmpvar_13;
  tmpvar_13 = (-(_Size) * 0.5);
  tmpvar_4.xy = ((vec2(1.0, 0.0) * _Attribute1) * tmpvar_13);
  tmpvar_4.zw = ((vec2(0.5, 0.866025) * _Attribute2) * tmpvar_13);
  tmpvar_5.xy = ((vec2(-0.5, 0.866025) * _Attribute3) * tmpvar_13);
  tmpvar_5.zw = ((vec2(-1.0, 0.0) * _Attribute4) * tmpvar_13);
  tmpvar_6.xy = ((vec2(-0.5, -0.866025) * _Attribute5) * tmpvar_13);
  tmpvar_6.zw = ((vec2(0.5, -0.866025) * _Attribute6) * tmpvar_13);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _TextureSampleAdd;
uniform highp float _AntiAliasStrength;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_2 + _TextureSampleAdd) * xlv_COLOR);
  color_1 = tmpvar_3;
  highp vec2 uv_4;
  uv_4 = xlv_TEXCOORD0;
  highp float dfBC_5;
  highp float dfAB_6;
  highp vec2 c_7;
  highp vec2 b_8;
  highp vec2 a_9;
  uv_4 = (uv_4 - 0.5);
  highp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (min (abs(
    (uv_4.y / uv_4.x)
  ), 1.0) / max (abs(
    (uv_4.y / uv_4.x)
  ), 1.0));
  highp float tmpvar_12;
  tmpvar_12 = (tmpvar_11 * tmpvar_11);
  tmpvar_12 = (((
    ((((
      ((((-0.01213232 * tmpvar_12) + 0.05368138) * tmpvar_12) - 0.1173503)
     * tmpvar_12) + 0.1938925) * tmpvar_12) - 0.3326756)
   * tmpvar_12) + 0.9999793) * tmpvar_11);
  tmpvar_12 = (tmpvar_12 + (float(
    (abs((uv_4.y / uv_4.x)) > 1.0)
  ) * (
    (tmpvar_12 * -2.0)
   + 1.570796)));
  tmpvar_10 = (tmpvar_12 * sign((uv_4.y / uv_4.x)));
  if ((abs(uv_4.x) > (1e-08 * abs(uv_4.y)))) {
    if ((uv_4.x < 0.0)) {
      if ((uv_4.y >= 0.0)) {
        tmpvar_10 += 3.141593;
      } else {
        tmpvar_10 = (tmpvar_10 - 3.141593);
      };
    };
  } else {
    tmpvar_10 = (sign(uv_4.y) * 1.570796);
  };
  highp float tmpvar_13;
  tmpvar_13 = (tmpvar_10 + 3.141593);
  if (((tmpvar_13 < 0.5236) || (5.7596 < tmpvar_13))) {
    a_9 = xlv_TEXCOORD3.zw;
    b_8 = xlv_TEXCOORD1.xy;
    c_7 = xlv_TEXCOORD1.zw;
  } else {
    if ((tmpvar_13 < 1.5708)) {
      a_9 = xlv_TEXCOORD1.xy;
      b_8 = xlv_TEXCOORD1.zw;
      c_7 = xlv_TEXCOORD2.xy;
    } else {
      if ((tmpvar_13 < 2.618)) {
        a_9 = xlv_TEXCOORD1.zw;
        b_8 = xlv_TEXCOORD2.xy;
        c_7 = xlv_TEXCOORD2.zw;
      } else {
        if ((tmpvar_13 < 3.6652)) {
          a_9 = xlv_TEXCOORD2.xy;
          b_8 = xlv_TEXCOORD2.zw;
          c_7 = xlv_TEXCOORD3.xy;
        } else {
          if ((tmpvar_13 < 4.7124)) {
            a_9 = xlv_TEXCOORD2.zw;
            b_8 = xlv_TEXCOORD3.xy;
            c_7 = xlv_TEXCOORD3.zw;
          } else {
            a_9 = xlv_TEXCOORD3.xy;
            b_8 = xlv_TEXCOORD3.zw;
            c_7 = xlv_TEXCOORD1.xy;
          };
        };
      };
    };
  };
  highp float tmpvar_14;
  tmpvar_14 = (b_8.y - a_9.y);
  highp float tmpvar_15;
  tmpvar_15 = (a_9.x - b_8.x);
  highp float tmpvar_16;
  tmpvar_16 = (c_7.y - b_8.y);
  highp float tmpvar_17;
  tmpvar_17 = (b_8.x - c_7.x);
  highp float tmpvar_18;
  tmpvar_18 = (_MainTex_TexelSize.x * _AntiAliasStrength);
  highp float edge0_19;
  edge0_19 = -(tmpvar_18);
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    ((((tmpvar_14 * uv_4.x) + (tmpvar_15 * uv_4.y)) - ((tmpvar_14 * a_9.x) + (tmpvar_15 * a_9.y))) / max (sqrt((
      (tmpvar_14 * tmpvar_14)
     + 
      (tmpvar_15 * tmpvar_15)
    )), 0.001))
   - edge0_19) / (tmpvar_18 - edge0_19)), 0.0, 1.0);
  dfAB_6 = (1.0 - (tmpvar_20 * (tmpvar_20 * 
    (3.0 - (2.0 * tmpvar_20))
  )));
  highp float edge0_21;
  edge0_21 = -(tmpvar_18);
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    ((((tmpvar_16 * uv_4.x) + (tmpvar_17 * uv_4.y)) - ((tmpvar_16 * b_8.x) + (tmpvar_17 * b_8.y))) / max (sqrt((
      (tmpvar_16 * tmpvar_16)
     + 
      (tmpvar_17 * tmpvar_17)
    )), 0.001))
   - edge0_21) / (tmpvar_18 - edge0_21)), 0.0, 1.0);
  dfBC_5 = (1.0 - (tmpvar_22 * (tmpvar_22 * 
    (3.0 - (2.0 * tmpvar_22))
  )));
  highp float tmpvar_23;
  tmpvar_23 = (((c_7.y - a_9.y) * (b_8.x - a_9.x)) + ((a_9.x - c_7.x) * (b_8.y - a_9.y)));
  highp float tmpvar_24;
  if ((0.0 < tmpvar_23)) {
    tmpvar_24 = min (dfAB_6, dfBC_5);
  } else {
    tmpvar_24 = max (dfAB_6, dfBC_5);
  };
  color_1.w = (tmpvar_3.w * tmpvar_24);
  mediump vec4 tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = clamp (((
    ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  color_1.w = ((color_1.w * tmpvar_25.x) * ((tmpvar_25.y * tmpvar_25.z) * tmpvar_25.w));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "RECT_MASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Size;
uniform highp float _Attribute1;
uniform highp float _Attribute2;
uniform highp float _Attribute3;
uniform highp float _Attribute4;
uniform highp float _Attribute5;
uniform highp float _Attribute6;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_3 = tmpvar_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_7 = o_10;
  tmpvar_2 = (_glesColor * _Color);
  highp float tmpvar_13;
  tmpvar_13 = (-(_Size) * 0.5);
  tmpvar_4.xy = ((vec2(1.0, 0.0) * _Attribute1) * tmpvar_13);
  tmpvar_4.zw = ((vec2(0.5, 0.866025) * _Attribute2) * tmpvar_13);
  tmpvar_5.xy = ((vec2(-0.5, 0.866025) * _Attribute3) * tmpvar_13);
  tmpvar_5.zw = ((vec2(-1.0, 0.0) * _Attribute4) * tmpvar_13);
  tmpvar_6.xy = ((vec2(-0.5, -0.866025) * _Attribute5) * tmpvar_13);
  tmpvar_6.zw = ((vec2(0.5, -0.866025) * _Attribute6) * tmpvar_13);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _TextureSampleAdd;
uniform highp float _AntiAliasStrength;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_2 + _TextureSampleAdd) * xlv_COLOR);
  color_1 = tmpvar_3;
  highp vec2 uv_4;
  uv_4 = xlv_TEXCOORD0;
  highp float dfBC_5;
  highp float dfAB_6;
  highp vec2 c_7;
  highp vec2 b_8;
  highp vec2 a_9;
  uv_4 = (uv_4 - 0.5);
  highp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (min (abs(
    (uv_4.y / uv_4.x)
  ), 1.0) / max (abs(
    (uv_4.y / uv_4.x)
  ), 1.0));
  highp float tmpvar_12;
  tmpvar_12 = (tmpvar_11 * tmpvar_11);
  tmpvar_12 = (((
    ((((
      ((((-0.01213232 * tmpvar_12) + 0.05368138) * tmpvar_12) - 0.1173503)
     * tmpvar_12) + 0.1938925) * tmpvar_12) - 0.3326756)
   * tmpvar_12) + 0.9999793) * tmpvar_11);
  tmpvar_12 = (tmpvar_12 + (float(
    (abs((uv_4.y / uv_4.x)) > 1.0)
  ) * (
    (tmpvar_12 * -2.0)
   + 1.570796)));
  tmpvar_10 = (tmpvar_12 * sign((uv_4.y / uv_4.x)));
  if ((abs(uv_4.x) > (1e-08 * abs(uv_4.y)))) {
    if ((uv_4.x < 0.0)) {
      if ((uv_4.y >= 0.0)) {
        tmpvar_10 += 3.141593;
      } else {
        tmpvar_10 = (tmpvar_10 - 3.141593);
      };
    };
  } else {
    tmpvar_10 = (sign(uv_4.y) * 1.570796);
  };
  highp float tmpvar_13;
  tmpvar_13 = (tmpvar_10 + 3.141593);
  if (((tmpvar_13 < 0.5236) || (5.7596 < tmpvar_13))) {
    a_9 = xlv_TEXCOORD3.zw;
    b_8 = xlv_TEXCOORD1.xy;
    c_7 = xlv_TEXCOORD1.zw;
  } else {
    if ((tmpvar_13 < 1.5708)) {
      a_9 = xlv_TEXCOORD1.xy;
      b_8 = xlv_TEXCOORD1.zw;
      c_7 = xlv_TEXCOORD2.xy;
    } else {
      if ((tmpvar_13 < 2.618)) {
        a_9 = xlv_TEXCOORD1.zw;
        b_8 = xlv_TEXCOORD2.xy;
        c_7 = xlv_TEXCOORD2.zw;
      } else {
        if ((tmpvar_13 < 3.6652)) {
          a_9 = xlv_TEXCOORD2.xy;
          b_8 = xlv_TEXCOORD2.zw;
          c_7 = xlv_TEXCOORD3.xy;
        } else {
          if ((tmpvar_13 < 4.7124)) {
            a_9 = xlv_TEXCOORD2.zw;
            b_8 = xlv_TEXCOORD3.xy;
            c_7 = xlv_TEXCOORD3.zw;
          } else {
            a_9 = xlv_TEXCOORD3.xy;
            b_8 = xlv_TEXCOORD3.zw;
            c_7 = xlv_TEXCOORD1.xy;
          };
        };
      };
    };
  };
  highp float tmpvar_14;
  tmpvar_14 = (b_8.y - a_9.y);
  highp float tmpvar_15;
  tmpvar_15 = (a_9.x - b_8.x);
  highp float tmpvar_16;
  tmpvar_16 = (c_7.y - b_8.y);
  highp float tmpvar_17;
  tmpvar_17 = (b_8.x - c_7.x);
  highp float tmpvar_18;
  tmpvar_18 = (_MainTex_TexelSize.x * _AntiAliasStrength);
  highp float edge0_19;
  edge0_19 = -(tmpvar_18);
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    ((((tmpvar_14 * uv_4.x) + (tmpvar_15 * uv_4.y)) - ((tmpvar_14 * a_9.x) + (tmpvar_15 * a_9.y))) / max (sqrt((
      (tmpvar_14 * tmpvar_14)
     + 
      (tmpvar_15 * tmpvar_15)
    )), 0.001))
   - edge0_19) / (tmpvar_18 - edge0_19)), 0.0, 1.0);
  dfAB_6 = (1.0 - (tmpvar_20 * (tmpvar_20 * 
    (3.0 - (2.0 * tmpvar_20))
  )));
  highp float edge0_21;
  edge0_21 = -(tmpvar_18);
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    ((((tmpvar_16 * uv_4.x) + (tmpvar_17 * uv_4.y)) - ((tmpvar_16 * b_8.x) + (tmpvar_17 * b_8.y))) / max (sqrt((
      (tmpvar_16 * tmpvar_16)
     + 
      (tmpvar_17 * tmpvar_17)
    )), 0.001))
   - edge0_21) / (tmpvar_18 - edge0_21)), 0.0, 1.0);
  dfBC_5 = (1.0 - (tmpvar_22 * (tmpvar_22 * 
    (3.0 - (2.0 * tmpvar_22))
  )));
  highp float tmpvar_23;
  tmpvar_23 = (((c_7.y - a_9.y) * (b_8.x - a_9.x)) + ((a_9.x - c_7.x) * (b_8.y - a_9.y)));
  highp float tmpvar_24;
  if ((0.0 < tmpvar_23)) {
    tmpvar_24 = min (dfAB_6, dfBC_5);
  } else {
    tmpvar_24 = max (dfAB_6, dfBC_5);
  };
  color_1.w = (tmpvar_3.w * tmpvar_24);
  mediump vec4 tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = clamp (((
    ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_25 = (tmpvar_26 * (tmpvar_26 * (3.0 - 
    (2.0 * tmpvar_26)
  )));
  color_1.w = ((color_1.w * tmpvar_25.x) * ((tmpvar_25.y * tmpvar_25.z) * tmpvar_25.w));
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
Keywords { "RECT_MASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RECT_MASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RECT_MASK" }
""
}
}
}
}
}