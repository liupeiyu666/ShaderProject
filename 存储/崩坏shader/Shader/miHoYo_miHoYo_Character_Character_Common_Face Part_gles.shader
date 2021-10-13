//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Common/Face Part" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionFactor ("Emission Factor", Range(0, 10)) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_ColorToOffset ("Color To Tune", Color) = (0,0,0,0)
_ColorTolerance ("Color Tolerance", Range(0.01, 1)) = 0
_HueOffset ("Hue Offset", Range(0, 1)) = 0
_SaturateOffset ("Satureate Offset", Range(-1, 1)) = 0
_ValueOffset ("Value Offset", Range(-1, 1)) = 0
[Toggle(REVERSE_HUE)] _ReverseHue ("Reverse Hue", Float) = 0
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
  GpuProgramID 64258
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
uniform mediump vec3 _ColorToOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float maxChannel_5;
  mediump float minChannel_6;
  mediump vec3 HSV_7;
  if ((_ColorToOffset.y < _ColorToOffset.x)) {
    maxChannel_5 = _ColorToOffset.x;
    minChannel_6 = _ColorToOffset.y;
  } else {
    maxChannel_5 = _ColorToOffset.y;
    minChannel_6 = _ColorToOffset.x;
  };
  if ((maxChannel_5 < _ColorToOffset.z)) {
    maxChannel_5 = _ColorToOffset.z;
  };
  if ((_ColorToOffset.z < minChannel_6)) {
    minChannel_6 = _ColorToOffset.z;
  };
  HSV_7.xy = vec2(0.0, 0.0);
  HSV_7.z = maxChannel_5;
  mediump float tmpvar_8;
  tmpvar_8 = (maxChannel_5 - minChannel_6);
  if ((tmpvar_8 != 0.0)) {
    mediump vec3 delRGB_9;
    HSV_7.y = (tmpvar_8 / maxChannel_5);
    delRGB_9 = (((vec3(maxChannel_5) - _ColorToOffset) + (3.0 * tmpvar_8)) / (6.0 * tmpvar_8));
    if ((_ColorToOffset.x == maxChannel_5)) {
      HSV_7.x = (delRGB_9.z - delRGB_9.y);
    } else {
      if ((_ColorToOffset.y == maxChannel_5)) {
        HSV_7.x = ((0.3333333 + delRGB_9.x) - delRGB_9.z);
      } else {
        if ((_ColorToOffset.z == maxChannel_5)) {
          HSV_7.x = ((0.6666667 + delRGB_9.y) - delRGB_9.x);
        };
      };
    };
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_10;
    highp vec4 tmpvar_11;
    tmpvar_11 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_12;
    tmpvar_12.x = tmpvar_11.x;
    tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
    o_10.xy = (tmpvar_12 + tmpvar_11.w);
    o_10.zw = tmpvar_3.zw;
    tmpvar_2.xyw = o_10.xyw;
    tmpvar_2.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = HSV_7;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionFactor;
uniform mediump float _ColorTolerance;
uniform mediump float _HueOffset;
uniform mediump float _SaturateOffset;
uniform mediump float _ValueOffset;
uniform highp float _ReverseHue;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 hsvDst_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_3 = tmpvar_4;
  mediump vec3 RGB_5;
  RGB_5 = outColor_3.xyz;
  mediump float maxChannel_6;
  mediump float minChannel_7;
  mediump vec3 HSV_8;
  if ((outColor_3.y < outColor_3.x)) {
    maxChannel_6 = RGB_5.x;
    minChannel_7 = RGB_5.y;
  } else {
    maxChannel_6 = RGB_5.y;
    minChannel_7 = RGB_5.x;
  };
  if ((maxChannel_6 < outColor_3.z)) {
    maxChannel_6 = RGB_5.z;
  };
  if ((outColor_3.z < minChannel_7)) {
    minChannel_7 = RGB_5.z;
  };
  HSV_8.xy = vec2(0.0, 0.0);
  HSV_8.z = maxChannel_6;
  mediump float tmpvar_9;
  tmpvar_9 = (maxChannel_6 - minChannel_7);
  if ((tmpvar_9 != 0.0)) {
    mediump vec3 delRGB_10;
    HSV_8.y = (tmpvar_9 / maxChannel_6);
    delRGB_10 = (((vec3(maxChannel_6) - outColor_3.xyz) + (3.0 * tmpvar_9)) / (6.0 * tmpvar_9));
    if ((outColor_3.x == maxChannel_6)) {
      HSV_8.x = (delRGB_10.z - delRGB_10.y);
    } else {
      if ((outColor_3.y == maxChannel_6)) {
        HSV_8.x = ((0.3333333 + delRGB_10.x) - delRGB_10.z);
      } else {
        if ((outColor_3.z == maxChannel_6)) {
          HSV_8.x = ((0.6666667 + delRGB_10.y) - delRGB_10.x);
        };
      };
    };
  };
  mediump float tmpvar_11;
  mediump vec3 x_12;
  x_12 = (HSV_8 - xlv_TEXCOORD1);
  tmpvar_11 = sqrt(dot (x_12, x_12));
  if (bool(_ReverseHue)) {
    mediump vec3 tmpvar_13;
    tmpvar_13.x = fract(((1.0 - HSV_8.x) + _HueOffset));
    tmpvar_13.y = clamp ((HSV_8.y + _SaturateOffset), 0.0, 1.0);
    tmpvar_13.z = clamp ((maxChannel_6 + _ValueOffset), 0.0, 1.0);
    hsvDst_2 = tmpvar_13;
  } else {
    mediump vec3 tmpvar_14;
    tmpvar_14.x = fract((HSV_8.x + _HueOffset));
    tmpvar_14.y = clamp ((HSV_8.y + _SaturateOffset), 0.0, 1.0);
    tmpvar_14.z = clamp ((maxChannel_6 + _ValueOffset), 0.0, 1.0);
    hsvDst_2 = tmpvar_14;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (hsvDst_2, HSV_8, vec3(float((tmpvar_11 >= _ColorTolerance))));
  hsvDst_2 = tmpvar_15;
  mediump vec3 RGB_16;
  RGB_16 = tmpvar_15.zzz;
  mediump float tmpvar_17;
  tmpvar_17 = (tmpvar_15.x * 6.0);
  mediump float tmpvar_18;
  tmpvar_18 = floor(tmpvar_17);
  mediump float tmpvar_19;
  tmpvar_19 = (tmpvar_15.z * (1.0 - tmpvar_15.y));
  mediump float tmpvar_20;
  tmpvar_20 = (tmpvar_15.z * (1.0 - (tmpvar_15.y * 
    (tmpvar_17 - tmpvar_18)
  )));
  mediump float tmpvar_21;
  tmpvar_21 = (tmpvar_15.z * (1.0 - (tmpvar_15.y * 
    (1.0 - (tmpvar_17 - tmpvar_18))
  )));
  if ((tmpvar_18 == 0.0)) {
    mediump vec3 tmpvar_22;
    tmpvar_22.x = tmpvar_15.z;
    tmpvar_22.y = tmpvar_21;
    tmpvar_22.z = tmpvar_19;
    RGB_16 = tmpvar_22;
  } else {
    if ((tmpvar_18 == 1.0)) {
      mediump vec3 tmpvar_23;
      tmpvar_23.x = tmpvar_20;
      tmpvar_23.y = tmpvar_15.z;
      tmpvar_23.z = tmpvar_19;
      RGB_16 = tmpvar_23;
    } else {
      if ((tmpvar_18 == 2.0)) {
        mediump vec3 tmpvar_24;
        tmpvar_24.x = tmpvar_19;
        tmpvar_24.y = tmpvar_15.z;
        tmpvar_24.z = tmpvar_21;
        RGB_16 = tmpvar_24;
      } else {
        if ((tmpvar_18 == 3.0)) {
          mediump vec3 tmpvar_25;
          tmpvar_25.x = tmpvar_19;
          tmpvar_25.y = tmpvar_20;
          tmpvar_25.z = tmpvar_15.z;
          RGB_16 = tmpvar_25;
        } else {
          if ((tmpvar_18 == 4.0)) {
            mediump vec3 tmpvar_26;
            tmpvar_26.x = tmpvar_21;
            tmpvar_26.y = tmpvar_19;
            tmpvar_26.z = tmpvar_15.z;
            RGB_16 = tmpvar_26;
          } else {
            mediump vec3 tmpvar_27;
            tmpvar_27.x = tmpvar_15.z;
            tmpvar_27.y = tmpvar_19;
            tmpvar_27.z = tmpvar_20;
            RGB_16 = tmpvar_27;
          };
        };
      };
    };
  };
  outColor_3.xyz = ((RGB_16 * _Color.xyz) * (_EmissionFactor * _EnvColor.xyz));
  mediump vec3 color_28;
  color_28 = outColor_3.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_3.xyz * tmpvar_29);
  outColor_3.xyz = color_28;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_30;
    scrpos_30 = xlv_TEXCOORD2;
    mediump float a_31;
    a_31 = xlv_TEXCOORD2.z;
    if ((a_31 < 0.95)) {
      scrpos_30.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_31 = (a_31 * 17.0);
      highp float tmpvar_32;
      tmpvar_32 = (scrpos_30.y / 4.0);
      highp float tmpvar_33;
      tmpvar_33 = (fract(abs(tmpvar_32)) * 4.0);
      highp float tmpvar_34;
      if ((tmpvar_32 >= 0.0)) {
        tmpvar_34 = tmpvar_33;
      } else {
        tmpvar_34 = -(tmpvar_33);
      };
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_30.x / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float x_38;
      x_38 = ((a_31 - _DITHERMATRIX[
        int(tmpvar_34)
      ][
        int(tmpvar_37)
      ]) - 0.01);
      if ((x_38 < 0.0)) {
        discard;
      };
    };
  };
  outColor_3.w = clamp (outColor_3.w, 0.0, 1.0);
  tmpvar_1 = outColor_3;
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
uniform mediump vec3 _ColorToOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float maxChannel_5;
  mediump float minChannel_6;
  mediump vec3 HSV_7;
  if ((_ColorToOffset.y < _ColorToOffset.x)) {
    maxChannel_5 = _ColorToOffset.x;
    minChannel_6 = _ColorToOffset.y;
  } else {
    maxChannel_5 = _ColorToOffset.y;
    minChannel_6 = _ColorToOffset.x;
  };
  if ((maxChannel_5 < _ColorToOffset.z)) {
    maxChannel_5 = _ColorToOffset.z;
  };
  if ((_ColorToOffset.z < minChannel_6)) {
    minChannel_6 = _ColorToOffset.z;
  };
  HSV_7.xy = vec2(0.0, 0.0);
  HSV_7.z = maxChannel_5;
  mediump float tmpvar_8;
  tmpvar_8 = (maxChannel_5 - minChannel_6);
  if ((tmpvar_8 != 0.0)) {
    mediump vec3 delRGB_9;
    HSV_7.y = (tmpvar_8 / maxChannel_5);
    delRGB_9 = (((vec3(maxChannel_5) - _ColorToOffset) + (3.0 * tmpvar_8)) / (6.0 * tmpvar_8));
    if ((_ColorToOffset.x == maxChannel_5)) {
      HSV_7.x = (delRGB_9.z - delRGB_9.y);
    } else {
      if ((_ColorToOffset.y == maxChannel_5)) {
        HSV_7.x = ((0.3333333 + delRGB_9.x) - delRGB_9.z);
      } else {
        if ((_ColorToOffset.z == maxChannel_5)) {
          HSV_7.x = ((0.6666667 + delRGB_9.y) - delRGB_9.x);
        };
      };
    };
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_10;
    highp vec4 tmpvar_11;
    tmpvar_11 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_12;
    tmpvar_12.x = tmpvar_11.x;
    tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
    o_10.xy = (tmpvar_12 + tmpvar_11.w);
    o_10.zw = tmpvar_3.zw;
    tmpvar_2.xyw = o_10.xyw;
    tmpvar_2.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = HSV_7;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionFactor;
uniform mediump float _ColorTolerance;
uniform mediump float _HueOffset;
uniform mediump float _SaturateOffset;
uniform mediump float _ValueOffset;
uniform highp float _ReverseHue;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 hsvDst_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_3 = tmpvar_4;
  mediump vec3 RGB_5;
  RGB_5 = outColor_3.xyz;
  mediump float maxChannel_6;
  mediump float minChannel_7;
  mediump vec3 HSV_8;
  if ((outColor_3.y < outColor_3.x)) {
    maxChannel_6 = RGB_5.x;
    minChannel_7 = RGB_5.y;
  } else {
    maxChannel_6 = RGB_5.y;
    minChannel_7 = RGB_5.x;
  };
  if ((maxChannel_6 < outColor_3.z)) {
    maxChannel_6 = RGB_5.z;
  };
  if ((outColor_3.z < minChannel_7)) {
    minChannel_7 = RGB_5.z;
  };
  HSV_8.xy = vec2(0.0, 0.0);
  HSV_8.z = maxChannel_6;
  mediump float tmpvar_9;
  tmpvar_9 = (maxChannel_6 - minChannel_7);
  if ((tmpvar_9 != 0.0)) {
    mediump vec3 delRGB_10;
    HSV_8.y = (tmpvar_9 / maxChannel_6);
    delRGB_10 = (((vec3(maxChannel_6) - outColor_3.xyz) + (3.0 * tmpvar_9)) / (6.0 * tmpvar_9));
    if ((outColor_3.x == maxChannel_6)) {
      HSV_8.x = (delRGB_10.z - delRGB_10.y);
    } else {
      if ((outColor_3.y == maxChannel_6)) {
        HSV_8.x = ((0.3333333 + delRGB_10.x) - delRGB_10.z);
      } else {
        if ((outColor_3.z == maxChannel_6)) {
          HSV_8.x = ((0.6666667 + delRGB_10.y) - delRGB_10.x);
        };
      };
    };
  };
  mediump float tmpvar_11;
  mediump vec3 x_12;
  x_12 = (HSV_8 - xlv_TEXCOORD1);
  tmpvar_11 = sqrt(dot (x_12, x_12));
  if (bool(_ReverseHue)) {
    mediump vec3 tmpvar_13;
    tmpvar_13.x = fract(((1.0 - HSV_8.x) + _HueOffset));
    tmpvar_13.y = clamp ((HSV_8.y + _SaturateOffset), 0.0, 1.0);
    tmpvar_13.z = clamp ((maxChannel_6 + _ValueOffset), 0.0, 1.0);
    hsvDst_2 = tmpvar_13;
  } else {
    mediump vec3 tmpvar_14;
    tmpvar_14.x = fract((HSV_8.x + _HueOffset));
    tmpvar_14.y = clamp ((HSV_8.y + _SaturateOffset), 0.0, 1.0);
    tmpvar_14.z = clamp ((maxChannel_6 + _ValueOffset), 0.0, 1.0);
    hsvDst_2 = tmpvar_14;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (hsvDst_2, HSV_8, vec3(float((tmpvar_11 >= _ColorTolerance))));
  hsvDst_2 = tmpvar_15;
  mediump vec3 RGB_16;
  RGB_16 = tmpvar_15.zzz;
  mediump float tmpvar_17;
  tmpvar_17 = (tmpvar_15.x * 6.0);
  mediump float tmpvar_18;
  tmpvar_18 = floor(tmpvar_17);
  mediump float tmpvar_19;
  tmpvar_19 = (tmpvar_15.z * (1.0 - tmpvar_15.y));
  mediump float tmpvar_20;
  tmpvar_20 = (tmpvar_15.z * (1.0 - (tmpvar_15.y * 
    (tmpvar_17 - tmpvar_18)
  )));
  mediump float tmpvar_21;
  tmpvar_21 = (tmpvar_15.z * (1.0 - (tmpvar_15.y * 
    (1.0 - (tmpvar_17 - tmpvar_18))
  )));
  if ((tmpvar_18 == 0.0)) {
    mediump vec3 tmpvar_22;
    tmpvar_22.x = tmpvar_15.z;
    tmpvar_22.y = tmpvar_21;
    tmpvar_22.z = tmpvar_19;
    RGB_16 = tmpvar_22;
  } else {
    if ((tmpvar_18 == 1.0)) {
      mediump vec3 tmpvar_23;
      tmpvar_23.x = tmpvar_20;
      tmpvar_23.y = tmpvar_15.z;
      tmpvar_23.z = tmpvar_19;
      RGB_16 = tmpvar_23;
    } else {
      if ((tmpvar_18 == 2.0)) {
        mediump vec3 tmpvar_24;
        tmpvar_24.x = tmpvar_19;
        tmpvar_24.y = tmpvar_15.z;
        tmpvar_24.z = tmpvar_21;
        RGB_16 = tmpvar_24;
      } else {
        if ((tmpvar_18 == 3.0)) {
          mediump vec3 tmpvar_25;
          tmpvar_25.x = tmpvar_19;
          tmpvar_25.y = tmpvar_20;
          tmpvar_25.z = tmpvar_15.z;
          RGB_16 = tmpvar_25;
        } else {
          if ((tmpvar_18 == 4.0)) {
            mediump vec3 tmpvar_26;
            tmpvar_26.x = tmpvar_21;
            tmpvar_26.y = tmpvar_19;
            tmpvar_26.z = tmpvar_15.z;
            RGB_16 = tmpvar_26;
          } else {
            mediump vec3 tmpvar_27;
            tmpvar_27.x = tmpvar_15.z;
            tmpvar_27.y = tmpvar_19;
            tmpvar_27.z = tmpvar_20;
            RGB_16 = tmpvar_27;
          };
        };
      };
    };
  };
  outColor_3.xyz = ((RGB_16 * _Color.xyz) * (_EmissionFactor * _EnvColor.xyz));
  mediump vec3 color_28;
  color_28 = outColor_3.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_3.xyz * tmpvar_29);
  outColor_3.xyz = color_28;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_30;
    scrpos_30 = xlv_TEXCOORD2;
    mediump float a_31;
    a_31 = xlv_TEXCOORD2.z;
    if ((a_31 < 0.95)) {
      scrpos_30.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_31 = (a_31 * 17.0);
      highp float tmpvar_32;
      tmpvar_32 = (scrpos_30.y / 4.0);
      highp float tmpvar_33;
      tmpvar_33 = (fract(abs(tmpvar_32)) * 4.0);
      highp float tmpvar_34;
      if ((tmpvar_32 >= 0.0)) {
        tmpvar_34 = tmpvar_33;
      } else {
        tmpvar_34 = -(tmpvar_33);
      };
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_30.x / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float x_38;
      x_38 = ((a_31 - _DITHERMATRIX[
        int(tmpvar_34)
      ][
        int(tmpvar_37)
      ]) - 0.01);
      if ((x_38 < 0.0)) {
        discard;
      };
    };
  };
  outColor_3.w = clamp (outColor_3.w, 0.0, 1.0);
  tmpvar_1 = outColor_3;
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
uniform mediump vec3 _ColorToOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float maxChannel_5;
  mediump float minChannel_6;
  mediump vec3 HSV_7;
  if ((_ColorToOffset.y < _ColorToOffset.x)) {
    maxChannel_5 = _ColorToOffset.x;
    minChannel_6 = _ColorToOffset.y;
  } else {
    maxChannel_5 = _ColorToOffset.y;
    minChannel_6 = _ColorToOffset.x;
  };
  if ((maxChannel_5 < _ColorToOffset.z)) {
    maxChannel_5 = _ColorToOffset.z;
  };
  if ((_ColorToOffset.z < minChannel_6)) {
    minChannel_6 = _ColorToOffset.z;
  };
  HSV_7.xy = vec2(0.0, 0.0);
  HSV_7.z = maxChannel_5;
  mediump float tmpvar_8;
  tmpvar_8 = (maxChannel_5 - minChannel_6);
  if ((tmpvar_8 != 0.0)) {
    mediump vec3 delRGB_9;
    HSV_7.y = (tmpvar_8 / maxChannel_5);
    delRGB_9 = (((vec3(maxChannel_5) - _ColorToOffset) + (3.0 * tmpvar_8)) / (6.0 * tmpvar_8));
    if ((_ColorToOffset.x == maxChannel_5)) {
      HSV_7.x = (delRGB_9.z - delRGB_9.y);
    } else {
      if ((_ColorToOffset.y == maxChannel_5)) {
        HSV_7.x = ((0.3333333 + delRGB_9.x) - delRGB_9.z);
      } else {
        if ((_ColorToOffset.z == maxChannel_5)) {
          HSV_7.x = ((0.6666667 + delRGB_9.y) - delRGB_9.x);
        };
      };
    };
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_10;
    highp vec4 tmpvar_11;
    tmpvar_11 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_12;
    tmpvar_12.x = tmpvar_11.x;
    tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
    o_10.xy = (tmpvar_12 + tmpvar_11.w);
    o_10.zw = tmpvar_3.zw;
    tmpvar_2.xyw = o_10.xyw;
    tmpvar_2.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = HSV_7;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionFactor;
uniform mediump float _ColorTolerance;
uniform mediump float _HueOffset;
uniform mediump float _SaturateOffset;
uniform mediump float _ValueOffset;
uniform highp float _ReverseHue;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 hsvDst_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_3 = tmpvar_4;
  mediump vec3 RGB_5;
  RGB_5 = outColor_3.xyz;
  mediump float maxChannel_6;
  mediump float minChannel_7;
  mediump vec3 HSV_8;
  if ((outColor_3.y < outColor_3.x)) {
    maxChannel_6 = RGB_5.x;
    minChannel_7 = RGB_5.y;
  } else {
    maxChannel_6 = RGB_5.y;
    minChannel_7 = RGB_5.x;
  };
  if ((maxChannel_6 < outColor_3.z)) {
    maxChannel_6 = RGB_5.z;
  };
  if ((outColor_3.z < minChannel_7)) {
    minChannel_7 = RGB_5.z;
  };
  HSV_8.xy = vec2(0.0, 0.0);
  HSV_8.z = maxChannel_6;
  mediump float tmpvar_9;
  tmpvar_9 = (maxChannel_6 - minChannel_7);
  if ((tmpvar_9 != 0.0)) {
    mediump vec3 delRGB_10;
    HSV_8.y = (tmpvar_9 / maxChannel_6);
    delRGB_10 = (((vec3(maxChannel_6) - outColor_3.xyz) + (3.0 * tmpvar_9)) / (6.0 * tmpvar_9));
    if ((outColor_3.x == maxChannel_6)) {
      HSV_8.x = (delRGB_10.z - delRGB_10.y);
    } else {
      if ((outColor_3.y == maxChannel_6)) {
        HSV_8.x = ((0.3333333 + delRGB_10.x) - delRGB_10.z);
      } else {
        if ((outColor_3.z == maxChannel_6)) {
          HSV_8.x = ((0.6666667 + delRGB_10.y) - delRGB_10.x);
        };
      };
    };
  };
  mediump float tmpvar_11;
  mediump vec3 x_12;
  x_12 = (HSV_8 - xlv_TEXCOORD1);
  tmpvar_11 = sqrt(dot (x_12, x_12));
  if (bool(_ReverseHue)) {
    mediump vec3 tmpvar_13;
    tmpvar_13.x = fract(((1.0 - HSV_8.x) + _HueOffset));
    tmpvar_13.y = clamp ((HSV_8.y + _SaturateOffset), 0.0, 1.0);
    tmpvar_13.z = clamp ((maxChannel_6 + _ValueOffset), 0.0, 1.0);
    hsvDst_2 = tmpvar_13;
  } else {
    mediump vec3 tmpvar_14;
    tmpvar_14.x = fract((HSV_8.x + _HueOffset));
    tmpvar_14.y = clamp ((HSV_8.y + _SaturateOffset), 0.0, 1.0);
    tmpvar_14.z = clamp ((maxChannel_6 + _ValueOffset), 0.0, 1.0);
    hsvDst_2 = tmpvar_14;
  };
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (hsvDst_2, HSV_8, vec3(float((tmpvar_11 >= _ColorTolerance))));
  hsvDst_2 = tmpvar_15;
  mediump vec3 RGB_16;
  RGB_16 = tmpvar_15.zzz;
  mediump float tmpvar_17;
  tmpvar_17 = (tmpvar_15.x * 6.0);
  mediump float tmpvar_18;
  tmpvar_18 = floor(tmpvar_17);
  mediump float tmpvar_19;
  tmpvar_19 = (tmpvar_15.z * (1.0 - tmpvar_15.y));
  mediump float tmpvar_20;
  tmpvar_20 = (tmpvar_15.z * (1.0 - (tmpvar_15.y * 
    (tmpvar_17 - tmpvar_18)
  )));
  mediump float tmpvar_21;
  tmpvar_21 = (tmpvar_15.z * (1.0 - (tmpvar_15.y * 
    (1.0 - (tmpvar_17 - tmpvar_18))
  )));
  if ((tmpvar_18 == 0.0)) {
    mediump vec3 tmpvar_22;
    tmpvar_22.x = tmpvar_15.z;
    tmpvar_22.y = tmpvar_21;
    tmpvar_22.z = tmpvar_19;
    RGB_16 = tmpvar_22;
  } else {
    if ((tmpvar_18 == 1.0)) {
      mediump vec3 tmpvar_23;
      tmpvar_23.x = tmpvar_20;
      tmpvar_23.y = tmpvar_15.z;
      tmpvar_23.z = tmpvar_19;
      RGB_16 = tmpvar_23;
    } else {
      if ((tmpvar_18 == 2.0)) {
        mediump vec3 tmpvar_24;
        tmpvar_24.x = tmpvar_19;
        tmpvar_24.y = tmpvar_15.z;
        tmpvar_24.z = tmpvar_21;
        RGB_16 = tmpvar_24;
      } else {
        if ((tmpvar_18 == 3.0)) {
          mediump vec3 tmpvar_25;
          tmpvar_25.x = tmpvar_19;
          tmpvar_25.y = tmpvar_20;
          tmpvar_25.z = tmpvar_15.z;
          RGB_16 = tmpvar_25;
        } else {
          if ((tmpvar_18 == 4.0)) {
            mediump vec3 tmpvar_26;
            tmpvar_26.x = tmpvar_21;
            tmpvar_26.y = tmpvar_19;
            tmpvar_26.z = tmpvar_15.z;
            RGB_16 = tmpvar_26;
          } else {
            mediump vec3 tmpvar_27;
            tmpvar_27.x = tmpvar_15.z;
            tmpvar_27.y = tmpvar_19;
            tmpvar_27.z = tmpvar_20;
            RGB_16 = tmpvar_27;
          };
        };
      };
    };
  };
  outColor_3.xyz = ((RGB_16 * _Color.xyz) * (_EmissionFactor * _EnvColor.xyz));
  mediump vec3 color_28;
  color_28 = outColor_3.xyz;
  mediump vec3 tmpvar_29;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_29 = _lightProbColor.xyz;
  } else {
    tmpvar_29 = vec3(1.0, 1.0, 1.0);
  };
  color_28 = (outColor_3.xyz * tmpvar_29);
  outColor_3.xyz = color_28;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_30;
    scrpos_30 = xlv_TEXCOORD2;
    mediump float a_31;
    a_31 = xlv_TEXCOORD2.z;
    if ((a_31 < 0.95)) {
      scrpos_30.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_31 = (a_31 * 17.0);
      highp float tmpvar_32;
      tmpvar_32 = (scrpos_30.y / 4.0);
      highp float tmpvar_33;
      tmpvar_33 = (fract(abs(tmpvar_32)) * 4.0);
      highp float tmpvar_34;
      if ((tmpvar_32 >= 0.0)) {
        tmpvar_34 = tmpvar_33;
      } else {
        tmpvar_34 = -(tmpvar_33);
      };
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_30.x / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float x_38;
      x_38 = ((a_31 - _DITHERMATRIX[
        int(tmpvar_34)
      ][
        int(tmpvar_37)
      ]) - 0.01);
      if ((x_38 < 0.0)) {
        discard;
      };
    };
  };
  outColor_3.w = clamp (outColor_3.w, 0.0, 1.0);
  tmpvar_1 = outColor_3;
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
  GpuProgramID 126225
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