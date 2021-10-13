//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Hue and Saturate" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Hue ("Hue", Range(0, 1)) = 0
_Saturate ("Saturate", Range(0, 1)) = 0
_Intensity ("Intensity", Range(0, 1)) = 0
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
  GpuProgramID 40592
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
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = (_glesColor * _Color);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Hue;
uniform mediump float _Saturate;
uniform mediump float _Intensity;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 hsv_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_COLOR);
  color_2 = tmpvar_4;
  mediump vec3 RGB_5;
  RGB_5 = tmpvar_4.xyz;
  mediump float maxChannel_6;
  mediump float minChannel_7;
  mediump vec3 HSV_8;
  if ((tmpvar_4.y < tmpvar_4.x)) {
    maxChannel_6 = RGB_5.x;
    minChannel_7 = RGB_5.y;
  } else {
    maxChannel_6 = RGB_5.y;
    minChannel_7 = RGB_5.x;
  };
  if ((maxChannel_6 < tmpvar_4.z)) {
    maxChannel_6 = RGB_5.z;
  };
  if ((tmpvar_4.z < minChannel_7)) {
    minChannel_7 = RGB_5.z;
  };
  HSV_8.xy = vec2(0.0, 0.0);
  HSV_8.z = maxChannel_6;
  mediump float tmpvar_9;
  tmpvar_9 = (maxChannel_6 - minChannel_7);
  if ((tmpvar_9 != 0.0)) {
    mediump vec3 delRGB_10;
    HSV_8.y = (tmpvar_9 / maxChannel_6);
    delRGB_10 = (((vec3(maxChannel_6) - tmpvar_4.xyz) + (3.0 * tmpvar_9)) / (6.0 * tmpvar_9));
    if ((tmpvar_4.x == maxChannel_6)) {
      HSV_8.x = (delRGB_10.z - delRGB_10.y);
    } else {
      if ((tmpvar_4.y == maxChannel_6)) {
        HSV_8.x = ((0.3333333 + delRGB_10.x) - delRGB_10.z);
      } else {
        if ((tmpvar_4.z == maxChannel_6)) {
          HSV_8.x = ((0.6666667 + delRGB_10.y) - delRGB_10.x);
        };
      };
    };
  };
  hsv_1.z = HSV_8.z;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _Hue;
  tmpvar_11.y = _Saturate;
  hsv_1.xy = mix (HSV_8.xy, tmpvar_11, vec2(_Intensity));
  mediump vec3 RGB_12;
  RGB_12 = hsv_1.zzz;
  mediump float tmpvar_13;
  tmpvar_13 = (hsv_1.x * 6.0);
  mediump float tmpvar_14;
  tmpvar_14 = floor(tmpvar_13);
  mediump float tmpvar_15;
  tmpvar_15 = (maxChannel_6 * (1.0 - hsv_1.y));
  mediump float tmpvar_16;
  tmpvar_16 = (maxChannel_6 * (1.0 - (hsv_1.y * 
    (tmpvar_13 - tmpvar_14)
  )));
  mediump float tmpvar_17;
  tmpvar_17 = (maxChannel_6 * (1.0 - (hsv_1.y * 
    (1.0 - (tmpvar_13 - tmpvar_14))
  )));
  if ((tmpvar_14 == 0.0)) {
    mediump vec3 tmpvar_18;
    tmpvar_18.x = hsv_1.z;
    tmpvar_18.y = tmpvar_17;
    tmpvar_18.z = tmpvar_15;
    RGB_12 = tmpvar_18;
  } else {
    if ((tmpvar_14 == 1.0)) {
      mediump vec3 tmpvar_19;
      tmpvar_19.x = tmpvar_16;
      tmpvar_19.y = hsv_1.z;
      tmpvar_19.z = tmpvar_15;
      RGB_12 = tmpvar_19;
    } else {
      if ((tmpvar_14 == 2.0)) {
        mediump vec3 tmpvar_20;
        tmpvar_20.x = tmpvar_15;
        tmpvar_20.y = hsv_1.z;
        tmpvar_20.z = tmpvar_17;
        RGB_12 = tmpvar_20;
      } else {
        if ((tmpvar_14 == 3.0)) {
          mediump vec3 tmpvar_21;
          tmpvar_21.x = tmpvar_15;
          tmpvar_21.y = tmpvar_16;
          tmpvar_21.z = hsv_1.z;
          RGB_12 = tmpvar_21;
        } else {
          if ((tmpvar_14 == 4.0)) {
            mediump vec3 tmpvar_22;
            tmpvar_22.x = tmpvar_17;
            tmpvar_22.y = tmpvar_15;
            tmpvar_22.z = hsv_1.z;
            RGB_12 = tmpvar_22;
          } else {
            mediump vec3 tmpvar_23;
            tmpvar_23.x = hsv_1.z;
            tmpvar_23.y = tmpvar_15;
            tmpvar_23.z = tmpvar_16;
            RGB_12 = tmpvar_23;
          };
        };
      };
    };
  };
  color_2.xyz = RGB_12;
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
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = (_glesColor * _Color);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Hue;
uniform mediump float _Saturate;
uniform mediump float _Intensity;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 hsv_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_COLOR);
  color_2 = tmpvar_4;
  mediump vec3 RGB_5;
  RGB_5 = tmpvar_4.xyz;
  mediump float maxChannel_6;
  mediump float minChannel_7;
  mediump vec3 HSV_8;
  if ((tmpvar_4.y < tmpvar_4.x)) {
    maxChannel_6 = RGB_5.x;
    minChannel_7 = RGB_5.y;
  } else {
    maxChannel_6 = RGB_5.y;
    minChannel_7 = RGB_5.x;
  };
  if ((maxChannel_6 < tmpvar_4.z)) {
    maxChannel_6 = RGB_5.z;
  };
  if ((tmpvar_4.z < minChannel_7)) {
    minChannel_7 = RGB_5.z;
  };
  HSV_8.xy = vec2(0.0, 0.0);
  HSV_8.z = maxChannel_6;
  mediump float tmpvar_9;
  tmpvar_9 = (maxChannel_6 - minChannel_7);
  if ((tmpvar_9 != 0.0)) {
    mediump vec3 delRGB_10;
    HSV_8.y = (tmpvar_9 / maxChannel_6);
    delRGB_10 = (((vec3(maxChannel_6) - tmpvar_4.xyz) + (3.0 * tmpvar_9)) / (6.0 * tmpvar_9));
    if ((tmpvar_4.x == maxChannel_6)) {
      HSV_8.x = (delRGB_10.z - delRGB_10.y);
    } else {
      if ((tmpvar_4.y == maxChannel_6)) {
        HSV_8.x = ((0.3333333 + delRGB_10.x) - delRGB_10.z);
      } else {
        if ((tmpvar_4.z == maxChannel_6)) {
          HSV_8.x = ((0.6666667 + delRGB_10.y) - delRGB_10.x);
        };
      };
    };
  };
  hsv_1.z = HSV_8.z;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _Hue;
  tmpvar_11.y = _Saturate;
  hsv_1.xy = mix (HSV_8.xy, tmpvar_11, vec2(_Intensity));
  mediump vec3 RGB_12;
  RGB_12 = hsv_1.zzz;
  mediump float tmpvar_13;
  tmpvar_13 = (hsv_1.x * 6.0);
  mediump float tmpvar_14;
  tmpvar_14 = floor(tmpvar_13);
  mediump float tmpvar_15;
  tmpvar_15 = (maxChannel_6 * (1.0 - hsv_1.y));
  mediump float tmpvar_16;
  tmpvar_16 = (maxChannel_6 * (1.0 - (hsv_1.y * 
    (tmpvar_13 - tmpvar_14)
  )));
  mediump float tmpvar_17;
  tmpvar_17 = (maxChannel_6 * (1.0 - (hsv_1.y * 
    (1.0 - (tmpvar_13 - tmpvar_14))
  )));
  if ((tmpvar_14 == 0.0)) {
    mediump vec3 tmpvar_18;
    tmpvar_18.x = hsv_1.z;
    tmpvar_18.y = tmpvar_17;
    tmpvar_18.z = tmpvar_15;
    RGB_12 = tmpvar_18;
  } else {
    if ((tmpvar_14 == 1.0)) {
      mediump vec3 tmpvar_19;
      tmpvar_19.x = tmpvar_16;
      tmpvar_19.y = hsv_1.z;
      tmpvar_19.z = tmpvar_15;
      RGB_12 = tmpvar_19;
    } else {
      if ((tmpvar_14 == 2.0)) {
        mediump vec3 tmpvar_20;
        tmpvar_20.x = tmpvar_15;
        tmpvar_20.y = hsv_1.z;
        tmpvar_20.z = tmpvar_17;
        RGB_12 = tmpvar_20;
      } else {
        if ((tmpvar_14 == 3.0)) {
          mediump vec3 tmpvar_21;
          tmpvar_21.x = tmpvar_15;
          tmpvar_21.y = tmpvar_16;
          tmpvar_21.z = hsv_1.z;
          RGB_12 = tmpvar_21;
        } else {
          if ((tmpvar_14 == 4.0)) {
            mediump vec3 tmpvar_22;
            tmpvar_22.x = tmpvar_17;
            tmpvar_22.y = tmpvar_15;
            tmpvar_22.z = hsv_1.z;
            RGB_12 = tmpvar_22;
          } else {
            mediump vec3 tmpvar_23;
            tmpvar_23.x = hsv_1.z;
            tmpvar_23.y = tmpvar_15;
            tmpvar_23.z = tmpvar_16;
            RGB_12 = tmpvar_23;
          };
        };
      };
    };
  };
  color_2.xyz = RGB_12;
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
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = (_glesColor * _Color);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Hue;
uniform mediump float _Saturate;
uniform mediump float _Intensity;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 hsv_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_COLOR);
  color_2 = tmpvar_4;
  mediump vec3 RGB_5;
  RGB_5 = tmpvar_4.xyz;
  mediump float maxChannel_6;
  mediump float minChannel_7;
  mediump vec3 HSV_8;
  if ((tmpvar_4.y < tmpvar_4.x)) {
    maxChannel_6 = RGB_5.x;
    minChannel_7 = RGB_5.y;
  } else {
    maxChannel_6 = RGB_5.y;
    minChannel_7 = RGB_5.x;
  };
  if ((maxChannel_6 < tmpvar_4.z)) {
    maxChannel_6 = RGB_5.z;
  };
  if ((tmpvar_4.z < minChannel_7)) {
    minChannel_7 = RGB_5.z;
  };
  HSV_8.xy = vec2(0.0, 0.0);
  HSV_8.z = maxChannel_6;
  mediump float tmpvar_9;
  tmpvar_9 = (maxChannel_6 - minChannel_7);
  if ((tmpvar_9 != 0.0)) {
    mediump vec3 delRGB_10;
    HSV_8.y = (tmpvar_9 / maxChannel_6);
    delRGB_10 = (((vec3(maxChannel_6) - tmpvar_4.xyz) + (3.0 * tmpvar_9)) / (6.0 * tmpvar_9));
    if ((tmpvar_4.x == maxChannel_6)) {
      HSV_8.x = (delRGB_10.z - delRGB_10.y);
    } else {
      if ((tmpvar_4.y == maxChannel_6)) {
        HSV_8.x = ((0.3333333 + delRGB_10.x) - delRGB_10.z);
      } else {
        if ((tmpvar_4.z == maxChannel_6)) {
          HSV_8.x = ((0.6666667 + delRGB_10.y) - delRGB_10.x);
        };
      };
    };
  };
  hsv_1.z = HSV_8.z;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _Hue;
  tmpvar_11.y = _Saturate;
  hsv_1.xy = mix (HSV_8.xy, tmpvar_11, vec2(_Intensity));
  mediump vec3 RGB_12;
  RGB_12 = hsv_1.zzz;
  mediump float tmpvar_13;
  tmpvar_13 = (hsv_1.x * 6.0);
  mediump float tmpvar_14;
  tmpvar_14 = floor(tmpvar_13);
  mediump float tmpvar_15;
  tmpvar_15 = (maxChannel_6 * (1.0 - hsv_1.y));
  mediump float tmpvar_16;
  tmpvar_16 = (maxChannel_6 * (1.0 - (hsv_1.y * 
    (tmpvar_13 - tmpvar_14)
  )));
  mediump float tmpvar_17;
  tmpvar_17 = (maxChannel_6 * (1.0 - (hsv_1.y * 
    (1.0 - (tmpvar_13 - tmpvar_14))
  )));
  if ((tmpvar_14 == 0.0)) {
    mediump vec3 tmpvar_18;
    tmpvar_18.x = hsv_1.z;
    tmpvar_18.y = tmpvar_17;
    tmpvar_18.z = tmpvar_15;
    RGB_12 = tmpvar_18;
  } else {
    if ((tmpvar_14 == 1.0)) {
      mediump vec3 tmpvar_19;
      tmpvar_19.x = tmpvar_16;
      tmpvar_19.y = hsv_1.z;
      tmpvar_19.z = tmpvar_15;
      RGB_12 = tmpvar_19;
    } else {
      if ((tmpvar_14 == 2.0)) {
        mediump vec3 tmpvar_20;
        tmpvar_20.x = tmpvar_15;
        tmpvar_20.y = hsv_1.z;
        tmpvar_20.z = tmpvar_17;
        RGB_12 = tmpvar_20;
      } else {
        if ((tmpvar_14 == 3.0)) {
          mediump vec3 tmpvar_21;
          tmpvar_21.x = tmpvar_15;
          tmpvar_21.y = tmpvar_16;
          tmpvar_21.z = hsv_1.z;
          RGB_12 = tmpvar_21;
        } else {
          if ((tmpvar_14 == 4.0)) {
            mediump vec3 tmpvar_22;
            tmpvar_22.x = tmpvar_17;
            tmpvar_22.y = tmpvar_15;
            tmpvar_22.z = hsv_1.z;
            RGB_12 = tmpvar_22;
          } else {
            mediump vec3 tmpvar_23;
            tmpvar_23.x = hsv_1.z;
            tmpvar_23.y = tmpvar_15;
            tmpvar_23.z = tmpvar_16;
            RGB_12 = tmpvar_23;
          };
        };
      };
    };
  };
  color_2.xyz = RGB_12;
  gl_FragData[0] = color_2;
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
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1 = o_4;
  gl_Position = tmpvar_2;
  xlv_COLOR = (_glesColor * _Color);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform sampler2D _MainTex;
uniform mediump float _Hue;
uniform mediump float _Saturate;
uniform mediump float _Intensity;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 hsv_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_COLOR);
  color_2 = tmpvar_4;
  mediump vec3 RGB_5;
  RGB_5 = tmpvar_4.xyz;
  mediump float maxChannel_6;
  mediump float minChannel_7;
  mediump vec3 HSV_8;
  if ((tmpvar_4.y < tmpvar_4.x)) {
    maxChannel_6 = RGB_5.x;
    minChannel_7 = RGB_5.y;
  } else {
    maxChannel_6 = RGB_5.y;
    minChannel_7 = RGB_5.x;
  };
  if ((maxChannel_6 < tmpvar_4.z)) {
    maxChannel_6 = RGB_5.z;
  };
  if ((tmpvar_4.z < minChannel_7)) {
    minChannel_7 = RGB_5.z;
  };
  HSV_8.xy = vec2(0.0, 0.0);
  HSV_8.z = maxChannel_6;
  mediump float tmpvar_9;
  tmpvar_9 = (maxChannel_6 - minChannel_7);
  if ((tmpvar_9 != 0.0)) {
    mediump vec3 delRGB_10;
    HSV_8.y = (tmpvar_9 / maxChannel_6);
    delRGB_10 = (((vec3(maxChannel_6) - tmpvar_4.xyz) + (3.0 * tmpvar_9)) / (6.0 * tmpvar_9));
    if ((tmpvar_4.x == maxChannel_6)) {
      HSV_8.x = (delRGB_10.z - delRGB_10.y);
    } else {
      if ((tmpvar_4.y == maxChannel_6)) {
        HSV_8.x = ((0.3333333 + delRGB_10.x) - delRGB_10.z);
      } else {
        if ((tmpvar_4.z == maxChannel_6)) {
          HSV_8.x = ((0.6666667 + delRGB_10.y) - delRGB_10.x);
        };
      };
    };
  };
  hsv_1.z = HSV_8.z;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _Hue;
  tmpvar_11.y = _Saturate;
  hsv_1.xy = mix (HSV_8.xy, tmpvar_11, vec2(_Intensity));
  mediump vec3 RGB_12;
  RGB_12 = hsv_1.zzz;
  mediump float tmpvar_13;
  tmpvar_13 = (hsv_1.x * 6.0);
  mediump float tmpvar_14;
  tmpvar_14 = floor(tmpvar_13);
  mediump float tmpvar_15;
  tmpvar_15 = (maxChannel_6 * (1.0 - hsv_1.y));
  mediump float tmpvar_16;
  tmpvar_16 = (maxChannel_6 * (1.0 - (hsv_1.y * 
    (tmpvar_13 - tmpvar_14)
  )));
  mediump float tmpvar_17;
  tmpvar_17 = (maxChannel_6 * (1.0 - (hsv_1.y * 
    (1.0 - (tmpvar_13 - tmpvar_14))
  )));
  if ((tmpvar_14 == 0.0)) {
    mediump vec3 tmpvar_18;
    tmpvar_18.x = hsv_1.z;
    tmpvar_18.y = tmpvar_17;
    tmpvar_18.z = tmpvar_15;
    RGB_12 = tmpvar_18;
  } else {
    if ((tmpvar_14 == 1.0)) {
      mediump vec3 tmpvar_19;
      tmpvar_19.x = tmpvar_16;
      tmpvar_19.y = hsv_1.z;
      tmpvar_19.z = tmpvar_15;
      RGB_12 = tmpvar_19;
    } else {
      if ((tmpvar_14 == 2.0)) {
        mediump vec3 tmpvar_20;
        tmpvar_20.x = tmpvar_15;
        tmpvar_20.y = hsv_1.z;
        tmpvar_20.z = tmpvar_17;
        RGB_12 = tmpvar_20;
      } else {
        if ((tmpvar_14 == 3.0)) {
          mediump vec3 tmpvar_21;
          tmpvar_21.x = tmpvar_15;
          tmpvar_21.y = tmpvar_16;
          tmpvar_21.z = hsv_1.z;
          RGB_12 = tmpvar_21;
        } else {
          if ((tmpvar_14 == 4.0)) {
            mediump vec3 tmpvar_22;
            tmpvar_22.x = tmpvar_17;
            tmpvar_22.y = tmpvar_15;
            tmpvar_22.z = hsv_1.z;
            RGB_12 = tmpvar_22;
          } else {
            mediump vec3 tmpvar_23;
            tmpvar_23.x = hsv_1.z;
            tmpvar_23.y = tmpvar_15;
            tmpvar_23.z = tmpvar_16;
            RGB_12 = tmpvar_23;
          };
        };
      };
    };
  };
  color_2.xyz = RGB_12;
  mediump vec4 tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  color_2.w = ((tmpvar_4.w * tmpvar_24.x) * ((tmpvar_24.y * tmpvar_24.z) * tmpvar_24.w));
  gl_FragData[0] = color_2;
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
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1 = o_4;
  gl_Position = tmpvar_2;
  xlv_COLOR = (_glesColor * _Color);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform sampler2D _MainTex;
uniform mediump float _Hue;
uniform mediump float _Saturate;
uniform mediump float _Intensity;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 hsv_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_COLOR);
  color_2 = tmpvar_4;
  mediump vec3 RGB_5;
  RGB_5 = tmpvar_4.xyz;
  mediump float maxChannel_6;
  mediump float minChannel_7;
  mediump vec3 HSV_8;
  if ((tmpvar_4.y < tmpvar_4.x)) {
    maxChannel_6 = RGB_5.x;
    minChannel_7 = RGB_5.y;
  } else {
    maxChannel_6 = RGB_5.y;
    minChannel_7 = RGB_5.x;
  };
  if ((maxChannel_6 < tmpvar_4.z)) {
    maxChannel_6 = RGB_5.z;
  };
  if ((tmpvar_4.z < minChannel_7)) {
    minChannel_7 = RGB_5.z;
  };
  HSV_8.xy = vec2(0.0, 0.0);
  HSV_8.z = maxChannel_6;
  mediump float tmpvar_9;
  tmpvar_9 = (maxChannel_6 - minChannel_7);
  if ((tmpvar_9 != 0.0)) {
    mediump vec3 delRGB_10;
    HSV_8.y = (tmpvar_9 / maxChannel_6);
    delRGB_10 = (((vec3(maxChannel_6) - tmpvar_4.xyz) + (3.0 * tmpvar_9)) / (6.0 * tmpvar_9));
    if ((tmpvar_4.x == maxChannel_6)) {
      HSV_8.x = (delRGB_10.z - delRGB_10.y);
    } else {
      if ((tmpvar_4.y == maxChannel_6)) {
        HSV_8.x = ((0.3333333 + delRGB_10.x) - delRGB_10.z);
      } else {
        if ((tmpvar_4.z == maxChannel_6)) {
          HSV_8.x = ((0.6666667 + delRGB_10.y) - delRGB_10.x);
        };
      };
    };
  };
  hsv_1.z = HSV_8.z;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _Hue;
  tmpvar_11.y = _Saturate;
  hsv_1.xy = mix (HSV_8.xy, tmpvar_11, vec2(_Intensity));
  mediump vec3 RGB_12;
  RGB_12 = hsv_1.zzz;
  mediump float tmpvar_13;
  tmpvar_13 = (hsv_1.x * 6.0);
  mediump float tmpvar_14;
  tmpvar_14 = floor(tmpvar_13);
  mediump float tmpvar_15;
  tmpvar_15 = (maxChannel_6 * (1.0 - hsv_1.y));
  mediump float tmpvar_16;
  tmpvar_16 = (maxChannel_6 * (1.0 - (hsv_1.y * 
    (tmpvar_13 - tmpvar_14)
  )));
  mediump float tmpvar_17;
  tmpvar_17 = (maxChannel_6 * (1.0 - (hsv_1.y * 
    (1.0 - (tmpvar_13 - tmpvar_14))
  )));
  if ((tmpvar_14 == 0.0)) {
    mediump vec3 tmpvar_18;
    tmpvar_18.x = hsv_1.z;
    tmpvar_18.y = tmpvar_17;
    tmpvar_18.z = tmpvar_15;
    RGB_12 = tmpvar_18;
  } else {
    if ((tmpvar_14 == 1.0)) {
      mediump vec3 tmpvar_19;
      tmpvar_19.x = tmpvar_16;
      tmpvar_19.y = hsv_1.z;
      tmpvar_19.z = tmpvar_15;
      RGB_12 = tmpvar_19;
    } else {
      if ((tmpvar_14 == 2.0)) {
        mediump vec3 tmpvar_20;
        tmpvar_20.x = tmpvar_15;
        tmpvar_20.y = hsv_1.z;
        tmpvar_20.z = tmpvar_17;
        RGB_12 = tmpvar_20;
      } else {
        if ((tmpvar_14 == 3.0)) {
          mediump vec3 tmpvar_21;
          tmpvar_21.x = tmpvar_15;
          tmpvar_21.y = tmpvar_16;
          tmpvar_21.z = hsv_1.z;
          RGB_12 = tmpvar_21;
        } else {
          if ((tmpvar_14 == 4.0)) {
            mediump vec3 tmpvar_22;
            tmpvar_22.x = tmpvar_17;
            tmpvar_22.y = tmpvar_15;
            tmpvar_22.z = hsv_1.z;
            RGB_12 = tmpvar_22;
          } else {
            mediump vec3 tmpvar_23;
            tmpvar_23.x = hsv_1.z;
            tmpvar_23.y = tmpvar_15;
            tmpvar_23.z = tmpvar_16;
            RGB_12 = tmpvar_23;
          };
        };
      };
    };
  };
  color_2.xyz = RGB_12;
  mediump vec4 tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  color_2.w = ((tmpvar_4.w * tmpvar_24.x) * ((tmpvar_24.y * tmpvar_24.z) * tmpvar_24.w));
  gl_FragData[0] = color_2;
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
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1 = o_4;
  gl_Position = tmpvar_2;
  xlv_COLOR = (_glesColor * _Color);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform sampler2D _MainTex;
uniform mediump float _Hue;
uniform mediump float _Saturate;
uniform mediump float _Intensity;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 hsv_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_COLOR);
  color_2 = tmpvar_4;
  mediump vec3 RGB_5;
  RGB_5 = tmpvar_4.xyz;
  mediump float maxChannel_6;
  mediump float minChannel_7;
  mediump vec3 HSV_8;
  if ((tmpvar_4.y < tmpvar_4.x)) {
    maxChannel_6 = RGB_5.x;
    minChannel_7 = RGB_5.y;
  } else {
    maxChannel_6 = RGB_5.y;
    minChannel_7 = RGB_5.x;
  };
  if ((maxChannel_6 < tmpvar_4.z)) {
    maxChannel_6 = RGB_5.z;
  };
  if ((tmpvar_4.z < minChannel_7)) {
    minChannel_7 = RGB_5.z;
  };
  HSV_8.xy = vec2(0.0, 0.0);
  HSV_8.z = maxChannel_6;
  mediump float tmpvar_9;
  tmpvar_9 = (maxChannel_6 - minChannel_7);
  if ((tmpvar_9 != 0.0)) {
    mediump vec3 delRGB_10;
    HSV_8.y = (tmpvar_9 / maxChannel_6);
    delRGB_10 = (((vec3(maxChannel_6) - tmpvar_4.xyz) + (3.0 * tmpvar_9)) / (6.0 * tmpvar_9));
    if ((tmpvar_4.x == maxChannel_6)) {
      HSV_8.x = (delRGB_10.z - delRGB_10.y);
    } else {
      if ((tmpvar_4.y == maxChannel_6)) {
        HSV_8.x = ((0.3333333 + delRGB_10.x) - delRGB_10.z);
      } else {
        if ((tmpvar_4.z == maxChannel_6)) {
          HSV_8.x = ((0.6666667 + delRGB_10.y) - delRGB_10.x);
        };
      };
    };
  };
  hsv_1.z = HSV_8.z;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _Hue;
  tmpvar_11.y = _Saturate;
  hsv_1.xy = mix (HSV_8.xy, tmpvar_11, vec2(_Intensity));
  mediump vec3 RGB_12;
  RGB_12 = hsv_1.zzz;
  mediump float tmpvar_13;
  tmpvar_13 = (hsv_1.x * 6.0);
  mediump float tmpvar_14;
  tmpvar_14 = floor(tmpvar_13);
  mediump float tmpvar_15;
  tmpvar_15 = (maxChannel_6 * (1.0 - hsv_1.y));
  mediump float tmpvar_16;
  tmpvar_16 = (maxChannel_6 * (1.0 - (hsv_1.y * 
    (tmpvar_13 - tmpvar_14)
  )));
  mediump float tmpvar_17;
  tmpvar_17 = (maxChannel_6 * (1.0 - (hsv_1.y * 
    (1.0 - (tmpvar_13 - tmpvar_14))
  )));
  if ((tmpvar_14 == 0.0)) {
    mediump vec3 tmpvar_18;
    tmpvar_18.x = hsv_1.z;
    tmpvar_18.y = tmpvar_17;
    tmpvar_18.z = tmpvar_15;
    RGB_12 = tmpvar_18;
  } else {
    if ((tmpvar_14 == 1.0)) {
      mediump vec3 tmpvar_19;
      tmpvar_19.x = tmpvar_16;
      tmpvar_19.y = hsv_1.z;
      tmpvar_19.z = tmpvar_15;
      RGB_12 = tmpvar_19;
    } else {
      if ((tmpvar_14 == 2.0)) {
        mediump vec3 tmpvar_20;
        tmpvar_20.x = tmpvar_15;
        tmpvar_20.y = hsv_1.z;
        tmpvar_20.z = tmpvar_17;
        RGB_12 = tmpvar_20;
      } else {
        if ((tmpvar_14 == 3.0)) {
          mediump vec3 tmpvar_21;
          tmpvar_21.x = tmpvar_15;
          tmpvar_21.y = tmpvar_16;
          tmpvar_21.z = hsv_1.z;
          RGB_12 = tmpvar_21;
        } else {
          if ((tmpvar_14 == 4.0)) {
            mediump vec3 tmpvar_22;
            tmpvar_22.x = tmpvar_17;
            tmpvar_22.y = tmpvar_15;
            tmpvar_22.z = hsv_1.z;
            RGB_12 = tmpvar_22;
          } else {
            mediump vec3 tmpvar_23;
            tmpvar_23.x = hsv_1.z;
            tmpvar_23.y = tmpvar_15;
            tmpvar_23.z = tmpvar_16;
            RGB_12 = tmpvar_23;
          };
        };
      };
    };
  };
  color_2.xyz = RGB_12;
  mediump vec4 tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  color_2.w = ((tmpvar_4.w * tmpvar_24.x) * ((tmpvar_24.y * tmpvar_24.z) * tmpvar_24.w));
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