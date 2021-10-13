//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Face/Face Part Eye with Light" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionFactor ("Emission Factor", Range(0, 10)) = 1
_Blend ("Switch to closed eye textures", Range(0, 1)) = 0
_MainTex ("Main Mouth (RGB)", 2D) = "white" { }
_EyeLidTex ("Eye lid (RGB)", 2D) = "white" { }
_EyePupilTex ("EyePupil (RGB)", 2D) = "white" { }
_ClosedEyeTex ("ClosedEye (RGB)", 2D) = "white" { }
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
  GpuProgramID 54162
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
uniform mediump vec4 _EyeLidTex_ST;
uniform mediump vec4 _EyePupilTex_ST;
uniform mediump vec3 _ColorToOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_1 = vec2(0.0, 0.0);
  tmpvar_2 = vec2(0.0, 0.0);
  tmpvar_3 = vec2(0.0, 0.0);
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  mediump float maxChannel_7;
  mediump float minChannel_8;
  mediump vec3 HSV_9;
  if ((_ColorToOffset.y < _ColorToOffset.x)) {
    maxChannel_7 = _ColorToOffset.x;
    minChannel_8 = _ColorToOffset.y;
  } else {
    maxChannel_7 = _ColorToOffset.y;
    minChannel_8 = _ColorToOffset.x;
  };
  if ((maxChannel_7 < _ColorToOffset.z)) {
    maxChannel_7 = _ColorToOffset.z;
  };
  if ((_ColorToOffset.z < minChannel_8)) {
    minChannel_8 = _ColorToOffset.z;
  };
  HSV_9.xy = vec2(0.0, 0.0);
  HSV_9.z = maxChannel_7;
  mediump float tmpvar_10;
  tmpvar_10 = (maxChannel_7 - minChannel_8);
  if ((tmpvar_10 != 0.0)) {
    mediump vec3 delRGB_11;
    HSV_9.y = (tmpvar_10 / maxChannel_7);
    delRGB_11 = (((vec3(maxChannel_7) - _ColorToOffset) + (3.0 * tmpvar_10)) / (6.0 * tmpvar_10));
    if ((_ColorToOffset.x == maxChannel_7)) {
      HSV_9.x = (delRGB_11.z - delRGB_11.y);
    } else {
      if ((_ColorToOffset.y == maxChannel_7)) {
        HSV_9.x = ((0.3333333 + delRGB_11.x) - delRGB_11.z);
      } else {
        if ((_ColorToOffset.z == maxChannel_7)) {
          HSV_9.x = ((0.6666667 + delRGB_11.y) - delRGB_11.x);
        };
      };
    };
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_12;
    highp vec4 tmpvar_13;
    tmpvar_13 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_14;
    tmpvar_14.x = tmpvar_13.x;
    tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
    o_12.xy = (tmpvar_14 + tmpvar_13.w);
    o_12.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_12.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _EyeLidTex_ST.xy) + _EyeLidTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _EyePupilTex_ST.xy) + _EyePupilTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = HSV_9;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _EyeLidTex;
uniform sampler2D _EyePupilTex;
uniform sampler2D _ClosedEyeTex;
uniform highp float _Blend;
uniform mediump float _EmissionFactor;
uniform mediump float _ColorTolerance;
uniform mediump float _HueOffset;
uniform mediump float _SaturateOffset;
uniform mediump float _ValueOffset;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  if ((_Blend < 0.5)) {
    mediump vec4 eyepupilTex_3;
    mediump vec4 eyelidTex_4;
    mediump vec4 mainTex_5;
    lowp vec4 tmpvar_6;
    tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
    mainTex_5 = tmpvar_6;
    lowp vec4 tmpvar_7;
    tmpvar_7 = texture2D (_EyeLidTex, xlv_TEXCOORD1);
    eyelidTex_4 = tmpvar_7;
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_EyePupilTex, xlv_TEXCOORD2);
    eyepupilTex_3 = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = (((mainTex_5.xyz * 
      (1.0 - (eyepupilTex_3.w * mainTex_5.w))
    ) + (eyepupilTex_3.xyz * mainTex_5.w)) + (eyelidTex_4.xyz * eyelidTex_4.w));
    outColor_2 = tmpvar_9;
  } else {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_ClosedEyeTex, xlv_TEXCOORD0);
    outColor_2 = tmpvar_10;
  };
  mediump vec3 RGB_11;
  RGB_11 = outColor_2.xyz;
  mediump float maxChannel_12;
  mediump float minChannel_13;
  mediump vec3 HSV_14;
  if ((outColor_2.y < outColor_2.x)) {
    maxChannel_12 = RGB_11.x;
    minChannel_13 = RGB_11.y;
  } else {
    maxChannel_12 = RGB_11.y;
    minChannel_13 = RGB_11.x;
  };
  if ((maxChannel_12 < outColor_2.z)) {
    maxChannel_12 = RGB_11.z;
  };
  if ((outColor_2.z < minChannel_13)) {
    minChannel_13 = RGB_11.z;
  };
  HSV_14.xy = vec2(0.0, 0.0);
  HSV_14.z = maxChannel_12;
  mediump float tmpvar_15;
  tmpvar_15 = (maxChannel_12 - minChannel_13);
  if ((tmpvar_15 != 0.0)) {
    mediump vec3 delRGB_16;
    HSV_14.y = (tmpvar_15 / maxChannel_12);
    delRGB_16 = (((vec3(maxChannel_12) - outColor_2.xyz) + (3.0 * tmpvar_15)) / (6.0 * tmpvar_15));
    if ((outColor_2.x == maxChannel_12)) {
      HSV_14.x = (delRGB_16.z - delRGB_16.y);
    } else {
      if ((outColor_2.y == maxChannel_12)) {
        HSV_14.x = ((0.3333333 + delRGB_16.x) - delRGB_16.z);
      } else {
        if ((outColor_2.z == maxChannel_12)) {
          HSV_14.x = ((0.6666667 + delRGB_16.y) - delRGB_16.x);
        };
      };
    };
  };
  mediump vec3 x_17;
  x_17 = (HSV_14 - xlv_TEXCOORD3);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = fract((HSV_14.x + _HueOffset));
  tmpvar_18.y = clamp ((HSV_14.y + _SaturateOffset), 0.0, 1.0);
  tmpvar_18.z = clamp ((maxChannel_12 + _ValueOffset), 0.0, 1.0);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (tmpvar_18, HSV_14, vec3(float((
    sqrt(dot (x_17, x_17))
   >= _ColorTolerance))));
  mediump vec3 RGB_20;
  RGB_20 = tmpvar_19.zzz;
  mediump float tmpvar_21;
  tmpvar_21 = (tmpvar_19.x * 6.0);
  mediump float tmpvar_22;
  tmpvar_22 = floor(tmpvar_21);
  mediump float tmpvar_23;
  tmpvar_23 = (tmpvar_19.z * (1.0 - tmpvar_19.y));
  mediump float tmpvar_24;
  tmpvar_24 = (tmpvar_19.z * (1.0 - (tmpvar_19.y * 
    (tmpvar_21 - tmpvar_22)
  )));
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_19.z * (1.0 - (tmpvar_19.y * 
    (1.0 - (tmpvar_21 - tmpvar_22))
  )));
  if ((tmpvar_22 == 0.0)) {
    mediump vec3 tmpvar_26;
    tmpvar_26.x = tmpvar_19.z;
    tmpvar_26.y = tmpvar_25;
    tmpvar_26.z = tmpvar_23;
    RGB_20 = tmpvar_26;
  } else {
    if ((tmpvar_22 == 1.0)) {
      mediump vec3 tmpvar_27;
      tmpvar_27.x = tmpvar_24;
      tmpvar_27.y = tmpvar_19.z;
      tmpvar_27.z = tmpvar_23;
      RGB_20 = tmpvar_27;
    } else {
      if ((tmpvar_22 == 2.0)) {
        mediump vec3 tmpvar_28;
        tmpvar_28.x = tmpvar_23;
        tmpvar_28.y = tmpvar_19.z;
        tmpvar_28.z = tmpvar_25;
        RGB_20 = tmpvar_28;
      } else {
        if ((tmpvar_22 == 3.0)) {
          mediump vec3 tmpvar_29;
          tmpvar_29.x = tmpvar_23;
          tmpvar_29.y = tmpvar_24;
          tmpvar_29.z = tmpvar_19.z;
          RGB_20 = tmpvar_29;
        } else {
          if ((tmpvar_22 == 4.0)) {
            mediump vec3 tmpvar_30;
            tmpvar_30.x = tmpvar_25;
            tmpvar_30.y = tmpvar_23;
            tmpvar_30.z = tmpvar_19.z;
            RGB_20 = tmpvar_30;
          } else {
            mediump vec3 tmpvar_31;
            tmpvar_31.x = tmpvar_19.z;
            tmpvar_31.y = tmpvar_23;
            tmpvar_31.z = tmpvar_24;
            RGB_20 = tmpvar_31;
          };
        };
      };
    };
  };
  outColor_2.xyz = ((RGB_20 * _Color.xyz) * (_EmissionFactor * _EnvColor.xyz));
  mediump vec3 color_32;
  color_32 = outColor_2.xyz;
  mediump vec3 tmpvar_33;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_33 = _lightProbColor.xyz;
  } else {
    tmpvar_33 = vec3(1.0, 1.0, 1.0);
  };
  color_32 = (outColor_2.xyz * tmpvar_33);
  outColor_2.xyz = color_32;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_34;
    scrpos_34 = xlv_TEXCOORD4;
    mediump float a_35;
    a_35 = xlv_TEXCOORD4.z;
    if ((a_35 < 0.95)) {
      scrpos_34.xy = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) * _ScreenParams.xy);
      a_35 = (a_35 * 17.0);
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_34.y / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_34.x / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float x_42;
      x_42 = ((a_35 - _DITHERMATRIX[
        int(tmpvar_38)
      ][
        int(tmpvar_41)
      ]) - 0.01);
      if ((x_42 < 0.0)) {
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
uniform mediump vec4 _EyeLidTex_ST;
uniform mediump vec4 _EyePupilTex_ST;
uniform mediump vec3 _ColorToOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_1 = vec2(0.0, 0.0);
  tmpvar_2 = vec2(0.0, 0.0);
  tmpvar_3 = vec2(0.0, 0.0);
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  mediump float maxChannel_7;
  mediump float minChannel_8;
  mediump vec3 HSV_9;
  if ((_ColorToOffset.y < _ColorToOffset.x)) {
    maxChannel_7 = _ColorToOffset.x;
    minChannel_8 = _ColorToOffset.y;
  } else {
    maxChannel_7 = _ColorToOffset.y;
    minChannel_8 = _ColorToOffset.x;
  };
  if ((maxChannel_7 < _ColorToOffset.z)) {
    maxChannel_7 = _ColorToOffset.z;
  };
  if ((_ColorToOffset.z < minChannel_8)) {
    minChannel_8 = _ColorToOffset.z;
  };
  HSV_9.xy = vec2(0.0, 0.0);
  HSV_9.z = maxChannel_7;
  mediump float tmpvar_10;
  tmpvar_10 = (maxChannel_7 - minChannel_8);
  if ((tmpvar_10 != 0.0)) {
    mediump vec3 delRGB_11;
    HSV_9.y = (tmpvar_10 / maxChannel_7);
    delRGB_11 = (((vec3(maxChannel_7) - _ColorToOffset) + (3.0 * tmpvar_10)) / (6.0 * tmpvar_10));
    if ((_ColorToOffset.x == maxChannel_7)) {
      HSV_9.x = (delRGB_11.z - delRGB_11.y);
    } else {
      if ((_ColorToOffset.y == maxChannel_7)) {
        HSV_9.x = ((0.3333333 + delRGB_11.x) - delRGB_11.z);
      } else {
        if ((_ColorToOffset.z == maxChannel_7)) {
          HSV_9.x = ((0.6666667 + delRGB_11.y) - delRGB_11.x);
        };
      };
    };
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_12;
    highp vec4 tmpvar_13;
    tmpvar_13 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_14;
    tmpvar_14.x = tmpvar_13.x;
    tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
    o_12.xy = (tmpvar_14 + tmpvar_13.w);
    o_12.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_12.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _EyeLidTex_ST.xy) + _EyeLidTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _EyePupilTex_ST.xy) + _EyePupilTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = HSV_9;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _EyeLidTex;
uniform sampler2D _EyePupilTex;
uniform sampler2D _ClosedEyeTex;
uniform highp float _Blend;
uniform mediump float _EmissionFactor;
uniform mediump float _ColorTolerance;
uniform mediump float _HueOffset;
uniform mediump float _SaturateOffset;
uniform mediump float _ValueOffset;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  if ((_Blend < 0.5)) {
    mediump vec4 eyepupilTex_3;
    mediump vec4 eyelidTex_4;
    mediump vec4 mainTex_5;
    lowp vec4 tmpvar_6;
    tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
    mainTex_5 = tmpvar_6;
    lowp vec4 tmpvar_7;
    tmpvar_7 = texture2D (_EyeLidTex, xlv_TEXCOORD1);
    eyelidTex_4 = tmpvar_7;
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_EyePupilTex, xlv_TEXCOORD2);
    eyepupilTex_3 = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = (((mainTex_5.xyz * 
      (1.0 - (eyepupilTex_3.w * mainTex_5.w))
    ) + (eyepupilTex_3.xyz * mainTex_5.w)) + (eyelidTex_4.xyz * eyelidTex_4.w));
    outColor_2 = tmpvar_9;
  } else {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_ClosedEyeTex, xlv_TEXCOORD0);
    outColor_2 = tmpvar_10;
  };
  mediump vec3 RGB_11;
  RGB_11 = outColor_2.xyz;
  mediump float maxChannel_12;
  mediump float minChannel_13;
  mediump vec3 HSV_14;
  if ((outColor_2.y < outColor_2.x)) {
    maxChannel_12 = RGB_11.x;
    minChannel_13 = RGB_11.y;
  } else {
    maxChannel_12 = RGB_11.y;
    minChannel_13 = RGB_11.x;
  };
  if ((maxChannel_12 < outColor_2.z)) {
    maxChannel_12 = RGB_11.z;
  };
  if ((outColor_2.z < minChannel_13)) {
    minChannel_13 = RGB_11.z;
  };
  HSV_14.xy = vec2(0.0, 0.0);
  HSV_14.z = maxChannel_12;
  mediump float tmpvar_15;
  tmpvar_15 = (maxChannel_12 - minChannel_13);
  if ((tmpvar_15 != 0.0)) {
    mediump vec3 delRGB_16;
    HSV_14.y = (tmpvar_15 / maxChannel_12);
    delRGB_16 = (((vec3(maxChannel_12) - outColor_2.xyz) + (3.0 * tmpvar_15)) / (6.0 * tmpvar_15));
    if ((outColor_2.x == maxChannel_12)) {
      HSV_14.x = (delRGB_16.z - delRGB_16.y);
    } else {
      if ((outColor_2.y == maxChannel_12)) {
        HSV_14.x = ((0.3333333 + delRGB_16.x) - delRGB_16.z);
      } else {
        if ((outColor_2.z == maxChannel_12)) {
          HSV_14.x = ((0.6666667 + delRGB_16.y) - delRGB_16.x);
        };
      };
    };
  };
  mediump vec3 x_17;
  x_17 = (HSV_14 - xlv_TEXCOORD3);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = fract((HSV_14.x + _HueOffset));
  tmpvar_18.y = clamp ((HSV_14.y + _SaturateOffset), 0.0, 1.0);
  tmpvar_18.z = clamp ((maxChannel_12 + _ValueOffset), 0.0, 1.0);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (tmpvar_18, HSV_14, vec3(float((
    sqrt(dot (x_17, x_17))
   >= _ColorTolerance))));
  mediump vec3 RGB_20;
  RGB_20 = tmpvar_19.zzz;
  mediump float tmpvar_21;
  tmpvar_21 = (tmpvar_19.x * 6.0);
  mediump float tmpvar_22;
  tmpvar_22 = floor(tmpvar_21);
  mediump float tmpvar_23;
  tmpvar_23 = (tmpvar_19.z * (1.0 - tmpvar_19.y));
  mediump float tmpvar_24;
  tmpvar_24 = (tmpvar_19.z * (1.0 - (tmpvar_19.y * 
    (tmpvar_21 - tmpvar_22)
  )));
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_19.z * (1.0 - (tmpvar_19.y * 
    (1.0 - (tmpvar_21 - tmpvar_22))
  )));
  if ((tmpvar_22 == 0.0)) {
    mediump vec3 tmpvar_26;
    tmpvar_26.x = tmpvar_19.z;
    tmpvar_26.y = tmpvar_25;
    tmpvar_26.z = tmpvar_23;
    RGB_20 = tmpvar_26;
  } else {
    if ((tmpvar_22 == 1.0)) {
      mediump vec3 tmpvar_27;
      tmpvar_27.x = tmpvar_24;
      tmpvar_27.y = tmpvar_19.z;
      tmpvar_27.z = tmpvar_23;
      RGB_20 = tmpvar_27;
    } else {
      if ((tmpvar_22 == 2.0)) {
        mediump vec3 tmpvar_28;
        tmpvar_28.x = tmpvar_23;
        tmpvar_28.y = tmpvar_19.z;
        tmpvar_28.z = tmpvar_25;
        RGB_20 = tmpvar_28;
      } else {
        if ((tmpvar_22 == 3.0)) {
          mediump vec3 tmpvar_29;
          tmpvar_29.x = tmpvar_23;
          tmpvar_29.y = tmpvar_24;
          tmpvar_29.z = tmpvar_19.z;
          RGB_20 = tmpvar_29;
        } else {
          if ((tmpvar_22 == 4.0)) {
            mediump vec3 tmpvar_30;
            tmpvar_30.x = tmpvar_25;
            tmpvar_30.y = tmpvar_23;
            tmpvar_30.z = tmpvar_19.z;
            RGB_20 = tmpvar_30;
          } else {
            mediump vec3 tmpvar_31;
            tmpvar_31.x = tmpvar_19.z;
            tmpvar_31.y = tmpvar_23;
            tmpvar_31.z = tmpvar_24;
            RGB_20 = tmpvar_31;
          };
        };
      };
    };
  };
  outColor_2.xyz = ((RGB_20 * _Color.xyz) * (_EmissionFactor * _EnvColor.xyz));
  mediump vec3 color_32;
  color_32 = outColor_2.xyz;
  mediump vec3 tmpvar_33;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_33 = _lightProbColor.xyz;
  } else {
    tmpvar_33 = vec3(1.0, 1.0, 1.0);
  };
  color_32 = (outColor_2.xyz * tmpvar_33);
  outColor_2.xyz = color_32;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_34;
    scrpos_34 = xlv_TEXCOORD4;
    mediump float a_35;
    a_35 = xlv_TEXCOORD4.z;
    if ((a_35 < 0.95)) {
      scrpos_34.xy = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) * _ScreenParams.xy);
      a_35 = (a_35 * 17.0);
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_34.y / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_34.x / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float x_42;
      x_42 = ((a_35 - _DITHERMATRIX[
        int(tmpvar_38)
      ][
        int(tmpvar_41)
      ]) - 0.01);
      if ((x_42 < 0.0)) {
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
uniform mediump vec4 _EyeLidTex_ST;
uniform mediump vec4 _EyePupilTex_ST;
uniform mediump vec3 _ColorToOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_1 = vec2(0.0, 0.0);
  tmpvar_2 = vec2(0.0, 0.0);
  tmpvar_3 = vec2(0.0, 0.0);
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  mediump float maxChannel_7;
  mediump float minChannel_8;
  mediump vec3 HSV_9;
  if ((_ColorToOffset.y < _ColorToOffset.x)) {
    maxChannel_7 = _ColorToOffset.x;
    minChannel_8 = _ColorToOffset.y;
  } else {
    maxChannel_7 = _ColorToOffset.y;
    minChannel_8 = _ColorToOffset.x;
  };
  if ((maxChannel_7 < _ColorToOffset.z)) {
    maxChannel_7 = _ColorToOffset.z;
  };
  if ((_ColorToOffset.z < minChannel_8)) {
    minChannel_8 = _ColorToOffset.z;
  };
  HSV_9.xy = vec2(0.0, 0.0);
  HSV_9.z = maxChannel_7;
  mediump float tmpvar_10;
  tmpvar_10 = (maxChannel_7 - minChannel_8);
  if ((tmpvar_10 != 0.0)) {
    mediump vec3 delRGB_11;
    HSV_9.y = (tmpvar_10 / maxChannel_7);
    delRGB_11 = (((vec3(maxChannel_7) - _ColorToOffset) + (3.0 * tmpvar_10)) / (6.0 * tmpvar_10));
    if ((_ColorToOffset.x == maxChannel_7)) {
      HSV_9.x = (delRGB_11.z - delRGB_11.y);
    } else {
      if ((_ColorToOffset.y == maxChannel_7)) {
        HSV_9.x = ((0.3333333 + delRGB_11.x) - delRGB_11.z);
      } else {
        if ((_ColorToOffset.z == maxChannel_7)) {
          HSV_9.x = ((0.6666667 + delRGB_11.y) - delRGB_11.x);
        };
      };
    };
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_12;
    highp vec4 tmpvar_13;
    tmpvar_13 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_14;
    tmpvar_14.x = tmpvar_13.x;
    tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
    o_12.xy = (tmpvar_14 + tmpvar_13.w);
    o_12.zw = tmpvar_5.zw;
    tmpvar_4.xyw = o_12.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _EyeLidTex_ST.xy) + _EyeLidTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _EyePupilTex_ST.xy) + _EyePupilTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = HSV_9;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _EyeLidTex;
uniform sampler2D _EyePupilTex;
uniform sampler2D _ClosedEyeTex;
uniform highp float _Blend;
uniform mediump float _EmissionFactor;
uniform mediump float _ColorTolerance;
uniform mediump float _HueOffset;
uniform mediump float _SaturateOffset;
uniform mediump float _ValueOffset;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  if ((_Blend < 0.5)) {
    mediump vec4 eyepupilTex_3;
    mediump vec4 eyelidTex_4;
    mediump vec4 mainTex_5;
    lowp vec4 tmpvar_6;
    tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
    mainTex_5 = tmpvar_6;
    lowp vec4 tmpvar_7;
    tmpvar_7 = texture2D (_EyeLidTex, xlv_TEXCOORD1);
    eyelidTex_4 = tmpvar_7;
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_EyePupilTex, xlv_TEXCOORD2);
    eyepupilTex_3 = tmpvar_8;
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = (((mainTex_5.xyz * 
      (1.0 - (eyepupilTex_3.w * mainTex_5.w))
    ) + (eyepupilTex_3.xyz * mainTex_5.w)) + (eyelidTex_4.xyz * eyelidTex_4.w));
    outColor_2 = tmpvar_9;
  } else {
    lowp vec4 tmpvar_10;
    tmpvar_10 = texture2D (_ClosedEyeTex, xlv_TEXCOORD0);
    outColor_2 = tmpvar_10;
  };
  mediump vec3 RGB_11;
  RGB_11 = outColor_2.xyz;
  mediump float maxChannel_12;
  mediump float minChannel_13;
  mediump vec3 HSV_14;
  if ((outColor_2.y < outColor_2.x)) {
    maxChannel_12 = RGB_11.x;
    minChannel_13 = RGB_11.y;
  } else {
    maxChannel_12 = RGB_11.y;
    minChannel_13 = RGB_11.x;
  };
  if ((maxChannel_12 < outColor_2.z)) {
    maxChannel_12 = RGB_11.z;
  };
  if ((outColor_2.z < minChannel_13)) {
    minChannel_13 = RGB_11.z;
  };
  HSV_14.xy = vec2(0.0, 0.0);
  HSV_14.z = maxChannel_12;
  mediump float tmpvar_15;
  tmpvar_15 = (maxChannel_12 - minChannel_13);
  if ((tmpvar_15 != 0.0)) {
    mediump vec3 delRGB_16;
    HSV_14.y = (tmpvar_15 / maxChannel_12);
    delRGB_16 = (((vec3(maxChannel_12) - outColor_2.xyz) + (3.0 * tmpvar_15)) / (6.0 * tmpvar_15));
    if ((outColor_2.x == maxChannel_12)) {
      HSV_14.x = (delRGB_16.z - delRGB_16.y);
    } else {
      if ((outColor_2.y == maxChannel_12)) {
        HSV_14.x = ((0.3333333 + delRGB_16.x) - delRGB_16.z);
      } else {
        if ((outColor_2.z == maxChannel_12)) {
          HSV_14.x = ((0.6666667 + delRGB_16.y) - delRGB_16.x);
        };
      };
    };
  };
  mediump vec3 x_17;
  x_17 = (HSV_14 - xlv_TEXCOORD3);
  mediump vec3 tmpvar_18;
  tmpvar_18.x = fract((HSV_14.x + _HueOffset));
  tmpvar_18.y = clamp ((HSV_14.y + _SaturateOffset), 0.0, 1.0);
  tmpvar_18.z = clamp ((maxChannel_12 + _ValueOffset), 0.0, 1.0);
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (tmpvar_18, HSV_14, vec3(float((
    sqrt(dot (x_17, x_17))
   >= _ColorTolerance))));
  mediump vec3 RGB_20;
  RGB_20 = tmpvar_19.zzz;
  mediump float tmpvar_21;
  tmpvar_21 = (tmpvar_19.x * 6.0);
  mediump float tmpvar_22;
  tmpvar_22 = floor(tmpvar_21);
  mediump float tmpvar_23;
  tmpvar_23 = (tmpvar_19.z * (1.0 - tmpvar_19.y));
  mediump float tmpvar_24;
  tmpvar_24 = (tmpvar_19.z * (1.0 - (tmpvar_19.y * 
    (tmpvar_21 - tmpvar_22)
  )));
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_19.z * (1.0 - (tmpvar_19.y * 
    (1.0 - (tmpvar_21 - tmpvar_22))
  )));
  if ((tmpvar_22 == 0.0)) {
    mediump vec3 tmpvar_26;
    tmpvar_26.x = tmpvar_19.z;
    tmpvar_26.y = tmpvar_25;
    tmpvar_26.z = tmpvar_23;
    RGB_20 = tmpvar_26;
  } else {
    if ((tmpvar_22 == 1.0)) {
      mediump vec3 tmpvar_27;
      tmpvar_27.x = tmpvar_24;
      tmpvar_27.y = tmpvar_19.z;
      tmpvar_27.z = tmpvar_23;
      RGB_20 = tmpvar_27;
    } else {
      if ((tmpvar_22 == 2.0)) {
        mediump vec3 tmpvar_28;
        tmpvar_28.x = tmpvar_23;
        tmpvar_28.y = tmpvar_19.z;
        tmpvar_28.z = tmpvar_25;
        RGB_20 = tmpvar_28;
      } else {
        if ((tmpvar_22 == 3.0)) {
          mediump vec3 tmpvar_29;
          tmpvar_29.x = tmpvar_23;
          tmpvar_29.y = tmpvar_24;
          tmpvar_29.z = tmpvar_19.z;
          RGB_20 = tmpvar_29;
        } else {
          if ((tmpvar_22 == 4.0)) {
            mediump vec3 tmpvar_30;
            tmpvar_30.x = tmpvar_25;
            tmpvar_30.y = tmpvar_23;
            tmpvar_30.z = tmpvar_19.z;
            RGB_20 = tmpvar_30;
          } else {
            mediump vec3 tmpvar_31;
            tmpvar_31.x = tmpvar_19.z;
            tmpvar_31.y = tmpvar_23;
            tmpvar_31.z = tmpvar_24;
            RGB_20 = tmpvar_31;
          };
        };
      };
    };
  };
  outColor_2.xyz = ((RGB_20 * _Color.xyz) * (_EmissionFactor * _EnvColor.xyz));
  mediump vec3 color_32;
  color_32 = outColor_2.xyz;
  mediump vec3 tmpvar_33;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_33 = _lightProbColor.xyz;
  } else {
    tmpvar_33 = vec3(1.0, 1.0, 1.0);
  };
  color_32 = (outColor_2.xyz * tmpvar_33);
  outColor_2.xyz = color_32;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_34;
    scrpos_34 = xlv_TEXCOORD4;
    mediump float a_35;
    a_35 = xlv_TEXCOORD4.z;
    if ((a_35 < 0.95)) {
      scrpos_34.xy = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) * _ScreenParams.xy);
      a_35 = (a_35 * 17.0);
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_34.y / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_34.x / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float x_42;
      x_42 = ((a_35 - _DITHERMATRIX[
        int(tmpvar_38)
      ][
        int(tmpvar_41)
      ]) - 0.01);
      if ((x_42 < 0.0)) {
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
 Pass {
  Name "CONSTANT_REPLACE"
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 108127
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