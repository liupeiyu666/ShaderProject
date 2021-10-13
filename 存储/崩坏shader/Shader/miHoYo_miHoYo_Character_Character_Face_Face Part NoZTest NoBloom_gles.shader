//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Face/Face Part NoZTest NoBloom" {
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
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Offset -20, -20
  GpuProgramID 22430
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
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionFactor;
uniform mediump float _ColorTolerance;
uniform mediump float _HueOffset;
uniform mediump float _SaturateOffset;
uniform mediump float _ValueOffset;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_2 = tmpvar_3;
  mediump vec3 RGB_4;
  RGB_4 = outColor_2.xyz;
  mediump float maxChannel_5;
  mediump float minChannel_6;
  mediump vec3 HSV_7;
  if ((outColor_2.y < outColor_2.x)) {
    maxChannel_5 = RGB_4.x;
    minChannel_6 = RGB_4.y;
  } else {
    maxChannel_5 = RGB_4.y;
    minChannel_6 = RGB_4.x;
  };
  if ((maxChannel_5 < outColor_2.z)) {
    maxChannel_5 = RGB_4.z;
  };
  if ((outColor_2.z < minChannel_6)) {
    minChannel_6 = RGB_4.z;
  };
  HSV_7.xy = vec2(0.0, 0.0);
  HSV_7.z = maxChannel_5;
  mediump float tmpvar_8;
  tmpvar_8 = (maxChannel_5 - minChannel_6);
  if ((tmpvar_8 != 0.0)) {
    mediump vec3 delRGB_9;
    HSV_7.y = (tmpvar_8 / maxChannel_5);
    delRGB_9 = (((vec3(maxChannel_5) - outColor_2.xyz) + (3.0 * tmpvar_8)) / (6.0 * tmpvar_8));
    if ((outColor_2.x == maxChannel_5)) {
      HSV_7.x = (delRGB_9.z - delRGB_9.y);
    } else {
      if ((outColor_2.y == maxChannel_5)) {
        HSV_7.x = ((0.3333333 + delRGB_9.x) - delRGB_9.z);
      } else {
        if ((outColor_2.z == maxChannel_5)) {
          HSV_7.x = ((0.6666667 + delRGB_9.y) - delRGB_9.x);
        };
      };
    };
  };
  mediump vec3 x_10;
  x_10 = (HSV_7 - xlv_TEXCOORD1);
  mediump vec3 tmpvar_11;
  tmpvar_11.x = fract((HSV_7.x + _HueOffset));
  tmpvar_11.y = clamp ((HSV_7.y + _SaturateOffset), 0.0, 1.0);
  tmpvar_11.z = clamp ((maxChannel_5 + _ValueOffset), 0.0, 1.0);
  mediump vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_11, HSV_7, vec3(float((
    sqrt(dot (x_10, x_10))
   >= _ColorTolerance))));
  mediump vec3 RGB_13;
  RGB_13 = tmpvar_12.zzz;
  mediump float tmpvar_14;
  tmpvar_14 = (tmpvar_12.x * 6.0);
  mediump float tmpvar_15;
  tmpvar_15 = floor(tmpvar_14);
  mediump float tmpvar_16;
  tmpvar_16 = (tmpvar_12.z * (1.0 - tmpvar_12.y));
  mediump float tmpvar_17;
  tmpvar_17 = (tmpvar_12.z * (1.0 - (tmpvar_12.y * 
    (tmpvar_14 - tmpvar_15)
  )));
  mediump float tmpvar_18;
  tmpvar_18 = (tmpvar_12.z * (1.0 - (tmpvar_12.y * 
    (1.0 - (tmpvar_14 - tmpvar_15))
  )));
  if ((tmpvar_15 == 0.0)) {
    mediump vec3 tmpvar_19;
    tmpvar_19.x = tmpvar_12.z;
    tmpvar_19.y = tmpvar_18;
    tmpvar_19.z = tmpvar_16;
    RGB_13 = tmpvar_19;
  } else {
    if ((tmpvar_15 == 1.0)) {
      mediump vec3 tmpvar_20;
      tmpvar_20.x = tmpvar_17;
      tmpvar_20.y = tmpvar_12.z;
      tmpvar_20.z = tmpvar_16;
      RGB_13 = tmpvar_20;
    } else {
      if ((tmpvar_15 == 2.0)) {
        mediump vec3 tmpvar_21;
        tmpvar_21.x = tmpvar_16;
        tmpvar_21.y = tmpvar_12.z;
        tmpvar_21.z = tmpvar_18;
        RGB_13 = tmpvar_21;
      } else {
        if ((tmpvar_15 == 3.0)) {
          mediump vec3 tmpvar_22;
          tmpvar_22.x = tmpvar_16;
          tmpvar_22.y = tmpvar_17;
          tmpvar_22.z = tmpvar_12.z;
          RGB_13 = tmpvar_22;
        } else {
          if ((tmpvar_15 == 4.0)) {
            mediump vec3 tmpvar_23;
            tmpvar_23.x = tmpvar_18;
            tmpvar_23.y = tmpvar_16;
            tmpvar_23.z = tmpvar_12.z;
            RGB_13 = tmpvar_23;
          } else {
            mediump vec3 tmpvar_24;
            tmpvar_24.x = tmpvar_12.z;
            tmpvar_24.y = tmpvar_16;
            tmpvar_24.z = tmpvar_17;
            RGB_13 = tmpvar_24;
          };
        };
      };
    };
  };
  outColor_2.xyz = ((RGB_13 * _Color.xyz) * (_EmissionFactor * _EnvColor.xyz));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_25;
    scrpos_25 = xlv_TEXCOORD2;
    mediump float a_26;
    a_26 = xlv_TEXCOORD2.z;
    if ((a_26 < 0.95)) {
      scrpos_25.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_26 = (a_26 * 17.0);
      highp float tmpvar_27;
      tmpvar_27 = (scrpos_25.y / 4.0);
      highp float tmpvar_28;
      tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
      highp float tmpvar_29;
      if ((tmpvar_27 >= 0.0)) {
        tmpvar_29 = tmpvar_28;
      } else {
        tmpvar_29 = -(tmpvar_28);
      };
      highp float tmpvar_30;
      tmpvar_30 = (scrpos_25.x / 4.0);
      highp float tmpvar_31;
      tmpvar_31 = (fract(abs(tmpvar_30)) * 4.0);
      highp float tmpvar_32;
      if ((tmpvar_30 >= 0.0)) {
        tmpvar_32 = tmpvar_31;
      } else {
        tmpvar_32 = -(tmpvar_31);
      };
      highp float x_33;
      x_33 = ((a_26 - _DITHERMATRIX[
        int(tmpvar_29)
      ][
        int(tmpvar_32)
      ]) - 0.01);
      if ((x_33 < 0.0)) {
        discard;
      };
    };
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
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionFactor;
uniform mediump float _ColorTolerance;
uniform mediump float _HueOffset;
uniform mediump float _SaturateOffset;
uniform mediump float _ValueOffset;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_2 = tmpvar_3;
  mediump vec3 RGB_4;
  RGB_4 = outColor_2.xyz;
  mediump float maxChannel_5;
  mediump float minChannel_6;
  mediump vec3 HSV_7;
  if ((outColor_2.y < outColor_2.x)) {
    maxChannel_5 = RGB_4.x;
    minChannel_6 = RGB_4.y;
  } else {
    maxChannel_5 = RGB_4.y;
    minChannel_6 = RGB_4.x;
  };
  if ((maxChannel_5 < outColor_2.z)) {
    maxChannel_5 = RGB_4.z;
  };
  if ((outColor_2.z < minChannel_6)) {
    minChannel_6 = RGB_4.z;
  };
  HSV_7.xy = vec2(0.0, 0.0);
  HSV_7.z = maxChannel_5;
  mediump float tmpvar_8;
  tmpvar_8 = (maxChannel_5 - minChannel_6);
  if ((tmpvar_8 != 0.0)) {
    mediump vec3 delRGB_9;
    HSV_7.y = (tmpvar_8 / maxChannel_5);
    delRGB_9 = (((vec3(maxChannel_5) - outColor_2.xyz) + (3.0 * tmpvar_8)) / (6.0 * tmpvar_8));
    if ((outColor_2.x == maxChannel_5)) {
      HSV_7.x = (delRGB_9.z - delRGB_9.y);
    } else {
      if ((outColor_2.y == maxChannel_5)) {
        HSV_7.x = ((0.3333333 + delRGB_9.x) - delRGB_9.z);
      } else {
        if ((outColor_2.z == maxChannel_5)) {
          HSV_7.x = ((0.6666667 + delRGB_9.y) - delRGB_9.x);
        };
      };
    };
  };
  mediump vec3 x_10;
  x_10 = (HSV_7 - xlv_TEXCOORD1);
  mediump vec3 tmpvar_11;
  tmpvar_11.x = fract((HSV_7.x + _HueOffset));
  tmpvar_11.y = clamp ((HSV_7.y + _SaturateOffset), 0.0, 1.0);
  tmpvar_11.z = clamp ((maxChannel_5 + _ValueOffset), 0.0, 1.0);
  mediump vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_11, HSV_7, vec3(float((
    sqrt(dot (x_10, x_10))
   >= _ColorTolerance))));
  mediump vec3 RGB_13;
  RGB_13 = tmpvar_12.zzz;
  mediump float tmpvar_14;
  tmpvar_14 = (tmpvar_12.x * 6.0);
  mediump float tmpvar_15;
  tmpvar_15 = floor(tmpvar_14);
  mediump float tmpvar_16;
  tmpvar_16 = (tmpvar_12.z * (1.0 - tmpvar_12.y));
  mediump float tmpvar_17;
  tmpvar_17 = (tmpvar_12.z * (1.0 - (tmpvar_12.y * 
    (tmpvar_14 - tmpvar_15)
  )));
  mediump float tmpvar_18;
  tmpvar_18 = (tmpvar_12.z * (1.0 - (tmpvar_12.y * 
    (1.0 - (tmpvar_14 - tmpvar_15))
  )));
  if ((tmpvar_15 == 0.0)) {
    mediump vec3 tmpvar_19;
    tmpvar_19.x = tmpvar_12.z;
    tmpvar_19.y = tmpvar_18;
    tmpvar_19.z = tmpvar_16;
    RGB_13 = tmpvar_19;
  } else {
    if ((tmpvar_15 == 1.0)) {
      mediump vec3 tmpvar_20;
      tmpvar_20.x = tmpvar_17;
      tmpvar_20.y = tmpvar_12.z;
      tmpvar_20.z = tmpvar_16;
      RGB_13 = tmpvar_20;
    } else {
      if ((tmpvar_15 == 2.0)) {
        mediump vec3 tmpvar_21;
        tmpvar_21.x = tmpvar_16;
        tmpvar_21.y = tmpvar_12.z;
        tmpvar_21.z = tmpvar_18;
        RGB_13 = tmpvar_21;
      } else {
        if ((tmpvar_15 == 3.0)) {
          mediump vec3 tmpvar_22;
          tmpvar_22.x = tmpvar_16;
          tmpvar_22.y = tmpvar_17;
          tmpvar_22.z = tmpvar_12.z;
          RGB_13 = tmpvar_22;
        } else {
          if ((tmpvar_15 == 4.0)) {
            mediump vec3 tmpvar_23;
            tmpvar_23.x = tmpvar_18;
            tmpvar_23.y = tmpvar_16;
            tmpvar_23.z = tmpvar_12.z;
            RGB_13 = tmpvar_23;
          } else {
            mediump vec3 tmpvar_24;
            tmpvar_24.x = tmpvar_12.z;
            tmpvar_24.y = tmpvar_16;
            tmpvar_24.z = tmpvar_17;
            RGB_13 = tmpvar_24;
          };
        };
      };
    };
  };
  outColor_2.xyz = ((RGB_13 * _Color.xyz) * (_EmissionFactor * _EnvColor.xyz));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_25;
    scrpos_25 = xlv_TEXCOORD2;
    mediump float a_26;
    a_26 = xlv_TEXCOORD2.z;
    if ((a_26 < 0.95)) {
      scrpos_25.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_26 = (a_26 * 17.0);
      highp float tmpvar_27;
      tmpvar_27 = (scrpos_25.y / 4.0);
      highp float tmpvar_28;
      tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
      highp float tmpvar_29;
      if ((tmpvar_27 >= 0.0)) {
        tmpvar_29 = tmpvar_28;
      } else {
        tmpvar_29 = -(tmpvar_28);
      };
      highp float tmpvar_30;
      tmpvar_30 = (scrpos_25.x / 4.0);
      highp float tmpvar_31;
      tmpvar_31 = (fract(abs(tmpvar_30)) * 4.0);
      highp float tmpvar_32;
      if ((tmpvar_30 >= 0.0)) {
        tmpvar_32 = tmpvar_31;
      } else {
        tmpvar_32 = -(tmpvar_31);
      };
      highp float x_33;
      x_33 = ((a_26 - _DITHERMATRIX[
        int(tmpvar_29)
      ][
        int(tmpvar_32)
      ]) - 0.01);
      if ((x_33 < 0.0)) {
        discard;
      };
    };
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
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionFactor;
uniform mediump float _ColorTolerance;
uniform mediump float _HueOffset;
uniform mediump float _SaturateOffset;
uniform mediump float _ValueOffset;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_2 = tmpvar_3;
  mediump vec3 RGB_4;
  RGB_4 = outColor_2.xyz;
  mediump float maxChannel_5;
  mediump float minChannel_6;
  mediump vec3 HSV_7;
  if ((outColor_2.y < outColor_2.x)) {
    maxChannel_5 = RGB_4.x;
    minChannel_6 = RGB_4.y;
  } else {
    maxChannel_5 = RGB_4.y;
    minChannel_6 = RGB_4.x;
  };
  if ((maxChannel_5 < outColor_2.z)) {
    maxChannel_5 = RGB_4.z;
  };
  if ((outColor_2.z < minChannel_6)) {
    minChannel_6 = RGB_4.z;
  };
  HSV_7.xy = vec2(0.0, 0.0);
  HSV_7.z = maxChannel_5;
  mediump float tmpvar_8;
  tmpvar_8 = (maxChannel_5 - minChannel_6);
  if ((tmpvar_8 != 0.0)) {
    mediump vec3 delRGB_9;
    HSV_7.y = (tmpvar_8 / maxChannel_5);
    delRGB_9 = (((vec3(maxChannel_5) - outColor_2.xyz) + (3.0 * tmpvar_8)) / (6.0 * tmpvar_8));
    if ((outColor_2.x == maxChannel_5)) {
      HSV_7.x = (delRGB_9.z - delRGB_9.y);
    } else {
      if ((outColor_2.y == maxChannel_5)) {
        HSV_7.x = ((0.3333333 + delRGB_9.x) - delRGB_9.z);
      } else {
        if ((outColor_2.z == maxChannel_5)) {
          HSV_7.x = ((0.6666667 + delRGB_9.y) - delRGB_9.x);
        };
      };
    };
  };
  mediump vec3 x_10;
  x_10 = (HSV_7 - xlv_TEXCOORD1);
  mediump vec3 tmpvar_11;
  tmpvar_11.x = fract((HSV_7.x + _HueOffset));
  tmpvar_11.y = clamp ((HSV_7.y + _SaturateOffset), 0.0, 1.0);
  tmpvar_11.z = clamp ((maxChannel_5 + _ValueOffset), 0.0, 1.0);
  mediump vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_11, HSV_7, vec3(float((
    sqrt(dot (x_10, x_10))
   >= _ColorTolerance))));
  mediump vec3 RGB_13;
  RGB_13 = tmpvar_12.zzz;
  mediump float tmpvar_14;
  tmpvar_14 = (tmpvar_12.x * 6.0);
  mediump float tmpvar_15;
  tmpvar_15 = floor(tmpvar_14);
  mediump float tmpvar_16;
  tmpvar_16 = (tmpvar_12.z * (1.0 - tmpvar_12.y));
  mediump float tmpvar_17;
  tmpvar_17 = (tmpvar_12.z * (1.0 - (tmpvar_12.y * 
    (tmpvar_14 - tmpvar_15)
  )));
  mediump float tmpvar_18;
  tmpvar_18 = (tmpvar_12.z * (1.0 - (tmpvar_12.y * 
    (1.0 - (tmpvar_14 - tmpvar_15))
  )));
  if ((tmpvar_15 == 0.0)) {
    mediump vec3 tmpvar_19;
    tmpvar_19.x = tmpvar_12.z;
    tmpvar_19.y = tmpvar_18;
    tmpvar_19.z = tmpvar_16;
    RGB_13 = tmpvar_19;
  } else {
    if ((tmpvar_15 == 1.0)) {
      mediump vec3 tmpvar_20;
      tmpvar_20.x = tmpvar_17;
      tmpvar_20.y = tmpvar_12.z;
      tmpvar_20.z = tmpvar_16;
      RGB_13 = tmpvar_20;
    } else {
      if ((tmpvar_15 == 2.0)) {
        mediump vec3 tmpvar_21;
        tmpvar_21.x = tmpvar_16;
        tmpvar_21.y = tmpvar_12.z;
        tmpvar_21.z = tmpvar_18;
        RGB_13 = tmpvar_21;
      } else {
        if ((tmpvar_15 == 3.0)) {
          mediump vec3 tmpvar_22;
          tmpvar_22.x = tmpvar_16;
          tmpvar_22.y = tmpvar_17;
          tmpvar_22.z = tmpvar_12.z;
          RGB_13 = tmpvar_22;
        } else {
          if ((tmpvar_15 == 4.0)) {
            mediump vec3 tmpvar_23;
            tmpvar_23.x = tmpvar_18;
            tmpvar_23.y = tmpvar_16;
            tmpvar_23.z = tmpvar_12.z;
            RGB_13 = tmpvar_23;
          } else {
            mediump vec3 tmpvar_24;
            tmpvar_24.x = tmpvar_12.z;
            tmpvar_24.y = tmpvar_16;
            tmpvar_24.z = tmpvar_17;
            RGB_13 = tmpvar_24;
          };
        };
      };
    };
  };
  outColor_2.xyz = ((RGB_13 * _Color.xyz) * (_EmissionFactor * _EnvColor.xyz));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_25;
    scrpos_25 = xlv_TEXCOORD2;
    mediump float a_26;
    a_26 = xlv_TEXCOORD2.z;
    if ((a_26 < 0.95)) {
      scrpos_25.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_26 = (a_26 * 17.0);
      highp float tmpvar_27;
      tmpvar_27 = (scrpos_25.y / 4.0);
      highp float tmpvar_28;
      tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
      highp float tmpvar_29;
      if ((tmpvar_27 >= 0.0)) {
        tmpvar_29 = tmpvar_28;
      } else {
        tmpvar_29 = -(tmpvar_28);
      };
      highp float tmpvar_30;
      tmpvar_30 = (scrpos_25.x / 4.0);
      highp float tmpvar_31;
      tmpvar_31 = (fract(abs(tmpvar_30)) * 4.0);
      highp float tmpvar_32;
      if ((tmpvar_30 >= 0.0)) {
        tmpvar_32 = tmpvar_31;
      } else {
        tmpvar_32 = -(tmpvar_31);
      };
      highp float x_33;
      x_33 = ((a_26 - _DITHERMATRIX[
        int(tmpvar_29)
      ][
        int(tmpvar_32)
      ]) - 0.01);
      if ((x_33 < 0.0)) {
        discard;
      };
    };
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
}
Fallback "Diffuse"
}