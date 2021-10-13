//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/OutlineEffect" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 3776
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _MainTex_ST;
uniform sampler2D _OutlineSource;
uniform highp float _LineThicknessX;
uniform highp float _LineThicknessY;
uniform highp int _FlipY;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 sample4_2;
  mediump vec4 sample3_3;
  mediump vec4 sample2_4;
  mediump vec4 sample1_5;
  mediump vec4 outlineSource_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  if ((_FlipY == 1)) {
    uv_7.y = xlv_TEXCOORD0.y;
  };
  highp vec2 tmpvar_8;
  tmpvar_8 = ((uv_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_OutlineSource, tmpvar_8);
  outlineSource_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.y = 0.0;
  tmpvar_10.x = _LineThicknessX;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (uv_7 + tmpvar_10);
  tmpvar_11 = texture2D (_OutlineSource, P_12);
  sample1_5 = tmpvar_11;
  highp vec2 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.x = -(_LineThicknessX);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (uv_7 + tmpvar_13);
  tmpvar_14 = texture2D (_OutlineSource, P_15);
  sample2_4 = tmpvar_14;
  highp vec2 tmpvar_16;
  tmpvar_16.x = 0.0;
  tmpvar_16.y = _LineThicknessY;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (uv_7 + tmpvar_16);
  tmpvar_17 = texture2D (_OutlineSource, P_18);
  sample3_3 = tmpvar_17;
  highp vec2 tmpvar_19;
  tmpvar_19.x = 0.0;
  tmpvar_19.y = -(_LineThicknessY);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (uv_7 + tmpvar_19);
  tmpvar_20 = texture2D (_OutlineSource, P_21);
  sample4_2 = tmpvar_20;
  bool tmpvar_22;
  tmpvar_22 = (((
    (sample1_5.x > 0.95)
   || 
    (sample2_4.x > 0.95)
  ) || (sample3_3.x > 0.95)) || (sample4_2.x > 0.95));
  bool tmpvar_23;
  tmpvar_23 = (((
    (sample1_5.y > 0.95)
   || 
    (sample2_4.y > 0.95)
  ) || (sample3_3.y > 0.95)) || (sample4_2.y > 0.95));
  bool tmpvar_24;
  tmpvar_24 = (((
    (sample1_5.z > 0.95)
   || 
    (sample2_4.z > 0.95)
  ) || (sample3_3.z > 0.95)) || (sample4_2.z > 0.95));
  if ((((tmpvar_22 && tmpvar_24) || (tmpvar_23 && tmpvar_24)) || (tmpvar_22 && tmpvar_23))) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    tmpvar_1 = outlineSource_6;
  };
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _MainTex_ST;
uniform sampler2D _OutlineSource;
uniform highp float _LineThicknessX;
uniform highp float _LineThicknessY;
uniform highp int _FlipY;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 sample4_2;
  mediump vec4 sample3_3;
  mediump vec4 sample2_4;
  mediump vec4 sample1_5;
  mediump vec4 outlineSource_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  if ((_FlipY == 1)) {
    uv_7.y = xlv_TEXCOORD0.y;
  };
  highp vec2 tmpvar_8;
  tmpvar_8 = ((uv_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_OutlineSource, tmpvar_8);
  outlineSource_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.y = 0.0;
  tmpvar_10.x = _LineThicknessX;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (uv_7 + tmpvar_10);
  tmpvar_11 = texture2D (_OutlineSource, P_12);
  sample1_5 = tmpvar_11;
  highp vec2 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.x = -(_LineThicknessX);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (uv_7 + tmpvar_13);
  tmpvar_14 = texture2D (_OutlineSource, P_15);
  sample2_4 = tmpvar_14;
  highp vec2 tmpvar_16;
  tmpvar_16.x = 0.0;
  tmpvar_16.y = _LineThicknessY;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (uv_7 + tmpvar_16);
  tmpvar_17 = texture2D (_OutlineSource, P_18);
  sample3_3 = tmpvar_17;
  highp vec2 tmpvar_19;
  tmpvar_19.x = 0.0;
  tmpvar_19.y = -(_LineThicknessY);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (uv_7 + tmpvar_19);
  tmpvar_20 = texture2D (_OutlineSource, P_21);
  sample4_2 = tmpvar_20;
  bool tmpvar_22;
  tmpvar_22 = (((
    (sample1_5.x > 0.95)
   || 
    (sample2_4.x > 0.95)
  ) || (sample3_3.x > 0.95)) || (sample4_2.x > 0.95));
  bool tmpvar_23;
  tmpvar_23 = (((
    (sample1_5.y > 0.95)
   || 
    (sample2_4.y > 0.95)
  ) || (sample3_3.y > 0.95)) || (sample4_2.y > 0.95));
  bool tmpvar_24;
  tmpvar_24 = (((
    (sample1_5.z > 0.95)
   || 
    (sample2_4.z > 0.95)
  ) || (sample3_3.z > 0.95)) || (sample4_2.z > 0.95));
  if ((((tmpvar_22 && tmpvar_24) || (tmpvar_23 && tmpvar_24)) || (tmpvar_22 && tmpvar_23))) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    tmpvar_1 = outlineSource_6;
  };
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _MainTex_ST;
uniform sampler2D _OutlineSource;
uniform highp float _LineThicknessX;
uniform highp float _LineThicknessY;
uniform highp int _FlipY;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 sample4_2;
  mediump vec4 sample3_3;
  mediump vec4 sample2_4;
  mediump vec4 sample1_5;
  mediump vec4 outlineSource_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  if ((_FlipY == 1)) {
    uv_7.y = xlv_TEXCOORD0.y;
  };
  highp vec2 tmpvar_8;
  tmpvar_8 = ((uv_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_OutlineSource, tmpvar_8);
  outlineSource_6 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.y = 0.0;
  tmpvar_10.x = _LineThicknessX;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (uv_7 + tmpvar_10);
  tmpvar_11 = texture2D (_OutlineSource, P_12);
  sample1_5 = tmpvar_11;
  highp vec2 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.x = -(_LineThicknessX);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (uv_7 + tmpvar_13);
  tmpvar_14 = texture2D (_OutlineSource, P_15);
  sample2_4 = tmpvar_14;
  highp vec2 tmpvar_16;
  tmpvar_16.x = 0.0;
  tmpvar_16.y = _LineThicknessY;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (uv_7 + tmpvar_16);
  tmpvar_17 = texture2D (_OutlineSource, P_18);
  sample3_3 = tmpvar_17;
  highp vec2 tmpvar_19;
  tmpvar_19.x = 0.0;
  tmpvar_19.y = -(_LineThicknessY);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (uv_7 + tmpvar_19);
  tmpvar_20 = texture2D (_OutlineSource, P_21);
  sample4_2 = tmpvar_20;
  bool tmpvar_22;
  tmpvar_22 = (((
    (sample1_5.x > 0.95)
   || 
    (sample2_4.x > 0.95)
  ) || (sample3_3.x > 0.95)) || (sample4_2.x > 0.95));
  bool tmpvar_23;
  tmpvar_23 = (((
    (sample1_5.y > 0.95)
   || 
    (sample2_4.y > 0.95)
  ) || (sample3_3.y > 0.95)) || (sample4_2.y > 0.95));
  bool tmpvar_24;
  tmpvar_24 = (((
    (sample1_5.z > 0.95)
   || 
    (sample2_4.z > 0.95)
  ) || (sample3_3.z > 0.95)) || (sample4_2.z > 0.95));
  if ((((tmpvar_22 && tmpvar_24) || (tmpvar_23 && tmpvar_24)) || (tmpvar_22 && tmpvar_23))) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    tmpvar_1 = outlineSource_6;
  };
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
  LOD 200
  Tags { "RenderType" = "Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 80399
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _OutlineSource;
uniform highp float _LineThicknessX;
uniform highp float _LineThicknessY;
uniform highp float _LineIntensity;
uniform mediump vec4 _LineColor1;
uniform mediump vec4 _LineColor2;
uniform mediump vec4 _LineColor3;
uniform highp int _FlipY;
uniform highp int _Dark;
uniform highp float _FillAmount;
uniform highp int _CornerOutlines;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 sample4_2;
  mediump vec4 sample3_3;
  mediump vec4 sample2_4;
  mediump vec4 sample1_5;
  bool hasOutline_6;
  mediump vec4 outline_7;
  mediump vec4 outlineSource_8;
  mediump vec4 originalPixel_9;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0;
  if ((_FlipY == 1)) {
    uv_10.y = (1.0 - xlv_TEXCOORD0.y);
  };
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, tmpvar_11);
  originalPixel_9 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((uv_10 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_OutlineSource, tmpvar_13);
  outlineSource_8 = tmpvar_14;
  outline_7 = vec4(0.0, 0.0, 0.0, 0.0);
  hasOutline_6 = bool(0);
  highp vec2 tmpvar_15;
  tmpvar_15.y = 0.0;
  tmpvar_15.x = _LineThicknessX;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (uv_10 + tmpvar_15);
  tmpvar_16 = texture2D (_OutlineSource, P_17);
  sample1_5 = tmpvar_16;
  highp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = -(_LineThicknessX);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (uv_10 + tmpvar_18);
  tmpvar_19 = texture2D (_OutlineSource, P_20);
  sample2_4 = tmpvar_19;
  highp vec2 tmpvar_21;
  tmpvar_21.x = 0.0;
  tmpvar_21.y = _LineThicknessY;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (uv_10 + tmpvar_21);
  tmpvar_22 = texture2D (_OutlineSource, P_23);
  sample3_3 = tmpvar_22;
  highp vec2 tmpvar_24;
  tmpvar_24.x = 0.0;
  tmpvar_24.y = -(_LineThicknessY);
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (uv_10 + tmpvar_24);
  tmpvar_25 = texture2D (_OutlineSource, P_26);
  sample4_2 = tmpvar_25;
  bool tmpvar_27;
  tmpvar_27 = (outlineSource_8.w < 0.95);
  bool tmpvar_28;
  tmpvar_28 = (tmpvar_27 && bool(_Dark));
  if (bool(_CornerOutlines)) {
    mediump vec4 sample8_29;
    mediump vec4 sample7_30;
    mediump vec4 sample6_31;
    mediump vec4 sample5_32;
    highp vec2 tmpvar_33;
    tmpvar_33.x = _LineThicknessX;
    tmpvar_33.y = _LineThicknessY;
    lowp vec4 tmpvar_34;
    highp vec2 P_35;
    P_35 = (uv_10 + tmpvar_33);
    tmpvar_34 = texture2D (_OutlineSource, P_35);
    sample5_32 = tmpvar_34;
    highp vec2 tmpvar_36;
    highp float tmpvar_37;
    tmpvar_37 = -(_LineThicknessX);
    tmpvar_36.x = tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = -(_LineThicknessY);
    tmpvar_36.y = tmpvar_38;
    lowp vec4 tmpvar_39;
    highp vec2 P_40;
    P_40 = (uv_10 + tmpvar_36);
    tmpvar_39 = texture2D (_OutlineSource, P_40);
    sample6_31 = tmpvar_39;
    highp vec2 tmpvar_41;
    tmpvar_41.x = _LineThicknessX;
    tmpvar_41.y = tmpvar_38;
    lowp vec4 tmpvar_42;
    highp vec2 P_43;
    P_43 = (uv_10 + tmpvar_41);
    tmpvar_42 = texture2D (_OutlineSource, P_43);
    sample7_30 = tmpvar_42;
    highp vec2 tmpvar_44;
    tmpvar_44.x = tmpvar_37;
    tmpvar_44.y = _LineThicknessY;
    lowp vec4 tmpvar_45;
    highp vec2 P_46;
    P_46 = (uv_10 + tmpvar_44);
    tmpvar_45 = texture2D (_OutlineSource, P_46);
    sample8_29 = tmpvar_45;
    if ((((
      ((((
        (sample1_5.x > 0.95)
       || 
        (sample2_4.x > 0.95)
      ) || (sample3_3.x > 0.95)) || (sample4_2.x > 0.95)) || (sample5_32.x > 0.95))
     || 
      (sample6_31.x > 0.95)
    ) || (sample7_30.x > 0.95)) || (sample8_29.x > 0.95))) {
      outline_7 = ((_LineColor1 * _LineIntensity) * _LineColor1.w);
      if (tmpvar_28) {
        originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor1.w));
      };
      hasOutline_6 = bool(1);
    } else {
      if ((((
        ((((
          (sample1_5.y > 0.95)
         || 
          (sample2_4.y > 0.95)
        ) || (sample3_3.y > 0.95)) || (sample4_2.y > 0.95)) || (sample5_32.y > 0.95))
       || 
        (sample6_31.y > 0.95)
      ) || (sample7_30.y > 0.95)) || (sample8_29.y > 0.95))) {
        outline_7 = ((_LineColor2 * _LineIntensity) * _LineColor2.w);
        if (tmpvar_28) {
          originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor2.w));
        };
        hasOutline_6 = bool(1);
      } else {
        if ((((
          ((((
            (sample1_5.z > 0.95)
           || 
            (sample2_4.z > 0.95)
          ) || (sample3_3.z > 0.95)) || (sample4_2.z > 0.95)) || (sample5_32.z > 0.95))
         || 
          (sample6_31.z > 0.95)
        ) || (sample7_30.z > 0.95)) || (sample8_29.z > 0.95))) {
          outline_7 = ((_LineColor3 * _LineIntensity) * _LineColor3.w);
          if (tmpvar_28) {
            originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor3.w));
          };
          hasOutline_6 = bool(1);
        };
      };
    };
    if (!(tmpvar_27)) {
      outline_7 = (outline_7 * _FillAmount);
    };
  } else {
    if ((((
      (sample1_5.x > 0.95)
     || 
      (sample2_4.x > 0.95)
    ) || (sample3_3.x > 0.95)) || (sample4_2.x > 0.95))) {
      outline_7 = ((_LineColor1 * _LineIntensity) * _LineColor1.w);
      if (tmpvar_28) {
        originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor1.w));
      };
      hasOutline_6 = bool(1);
    } else {
      if ((((
        (sample1_5.y > 0.95)
       || 
        (sample2_4.y > 0.95)
      ) || (sample3_3.y > 0.95)) || (sample4_2.y > 0.95))) {
        outline_7 = ((_LineColor2 * _LineIntensity) * _LineColor2.w);
        if (tmpvar_28) {
          originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor2.w));
        };
        hasOutline_6 = bool(1);
      } else {
        if ((((
          (sample1_5.z > 0.95)
         || 
          (sample2_4.z > 0.95)
        ) || (sample3_3.z > 0.95)) || (sample4_2.z > 0.95))) {
          outline_7 = ((_LineColor3 * _LineIntensity) * _LineColor3.w);
          if (tmpvar_28) {
            originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor3.w));
          };
          hasOutline_6 = bool(1);
        };
      };
    };
    if (!(tmpvar_27)) {
      outline_7 = (outline_7 * _FillAmount);
    };
  };
  if (hasOutline_6) {
    highp vec4 tmpvar_47;
    mediump vec4 x_48;
    x_48 = (originalPixel_9 + outline_7);
    tmpvar_47 = mix (x_48, outline_7, vec4(_FillAmount));
    tmpvar_1 = tmpvar_47;
  } else {
    tmpvar_1 = originalPixel_9;
  };
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _OutlineSource;
uniform highp float _LineThicknessX;
uniform highp float _LineThicknessY;
uniform highp float _LineIntensity;
uniform mediump vec4 _LineColor1;
uniform mediump vec4 _LineColor2;
uniform mediump vec4 _LineColor3;
uniform highp int _FlipY;
uniform highp int _Dark;
uniform highp float _FillAmount;
uniform highp int _CornerOutlines;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 sample4_2;
  mediump vec4 sample3_3;
  mediump vec4 sample2_4;
  mediump vec4 sample1_5;
  bool hasOutline_6;
  mediump vec4 outline_7;
  mediump vec4 outlineSource_8;
  mediump vec4 originalPixel_9;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0;
  if ((_FlipY == 1)) {
    uv_10.y = (1.0 - xlv_TEXCOORD0.y);
  };
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, tmpvar_11);
  originalPixel_9 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((uv_10 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_OutlineSource, tmpvar_13);
  outlineSource_8 = tmpvar_14;
  outline_7 = vec4(0.0, 0.0, 0.0, 0.0);
  hasOutline_6 = bool(0);
  highp vec2 tmpvar_15;
  tmpvar_15.y = 0.0;
  tmpvar_15.x = _LineThicknessX;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (uv_10 + tmpvar_15);
  tmpvar_16 = texture2D (_OutlineSource, P_17);
  sample1_5 = tmpvar_16;
  highp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = -(_LineThicknessX);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (uv_10 + tmpvar_18);
  tmpvar_19 = texture2D (_OutlineSource, P_20);
  sample2_4 = tmpvar_19;
  highp vec2 tmpvar_21;
  tmpvar_21.x = 0.0;
  tmpvar_21.y = _LineThicknessY;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (uv_10 + tmpvar_21);
  tmpvar_22 = texture2D (_OutlineSource, P_23);
  sample3_3 = tmpvar_22;
  highp vec2 tmpvar_24;
  tmpvar_24.x = 0.0;
  tmpvar_24.y = -(_LineThicknessY);
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (uv_10 + tmpvar_24);
  tmpvar_25 = texture2D (_OutlineSource, P_26);
  sample4_2 = tmpvar_25;
  bool tmpvar_27;
  tmpvar_27 = (outlineSource_8.w < 0.95);
  bool tmpvar_28;
  tmpvar_28 = (tmpvar_27 && bool(_Dark));
  if (bool(_CornerOutlines)) {
    mediump vec4 sample8_29;
    mediump vec4 sample7_30;
    mediump vec4 sample6_31;
    mediump vec4 sample5_32;
    highp vec2 tmpvar_33;
    tmpvar_33.x = _LineThicknessX;
    tmpvar_33.y = _LineThicknessY;
    lowp vec4 tmpvar_34;
    highp vec2 P_35;
    P_35 = (uv_10 + tmpvar_33);
    tmpvar_34 = texture2D (_OutlineSource, P_35);
    sample5_32 = tmpvar_34;
    highp vec2 tmpvar_36;
    highp float tmpvar_37;
    tmpvar_37 = -(_LineThicknessX);
    tmpvar_36.x = tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = -(_LineThicknessY);
    tmpvar_36.y = tmpvar_38;
    lowp vec4 tmpvar_39;
    highp vec2 P_40;
    P_40 = (uv_10 + tmpvar_36);
    tmpvar_39 = texture2D (_OutlineSource, P_40);
    sample6_31 = tmpvar_39;
    highp vec2 tmpvar_41;
    tmpvar_41.x = _LineThicknessX;
    tmpvar_41.y = tmpvar_38;
    lowp vec4 tmpvar_42;
    highp vec2 P_43;
    P_43 = (uv_10 + tmpvar_41);
    tmpvar_42 = texture2D (_OutlineSource, P_43);
    sample7_30 = tmpvar_42;
    highp vec2 tmpvar_44;
    tmpvar_44.x = tmpvar_37;
    tmpvar_44.y = _LineThicknessY;
    lowp vec4 tmpvar_45;
    highp vec2 P_46;
    P_46 = (uv_10 + tmpvar_44);
    tmpvar_45 = texture2D (_OutlineSource, P_46);
    sample8_29 = tmpvar_45;
    if ((((
      ((((
        (sample1_5.x > 0.95)
       || 
        (sample2_4.x > 0.95)
      ) || (sample3_3.x > 0.95)) || (sample4_2.x > 0.95)) || (sample5_32.x > 0.95))
     || 
      (sample6_31.x > 0.95)
    ) || (sample7_30.x > 0.95)) || (sample8_29.x > 0.95))) {
      outline_7 = ((_LineColor1 * _LineIntensity) * _LineColor1.w);
      if (tmpvar_28) {
        originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor1.w));
      };
      hasOutline_6 = bool(1);
    } else {
      if ((((
        ((((
          (sample1_5.y > 0.95)
         || 
          (sample2_4.y > 0.95)
        ) || (sample3_3.y > 0.95)) || (sample4_2.y > 0.95)) || (sample5_32.y > 0.95))
       || 
        (sample6_31.y > 0.95)
      ) || (sample7_30.y > 0.95)) || (sample8_29.y > 0.95))) {
        outline_7 = ((_LineColor2 * _LineIntensity) * _LineColor2.w);
        if (tmpvar_28) {
          originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor2.w));
        };
        hasOutline_6 = bool(1);
      } else {
        if ((((
          ((((
            (sample1_5.z > 0.95)
           || 
            (sample2_4.z > 0.95)
          ) || (sample3_3.z > 0.95)) || (sample4_2.z > 0.95)) || (sample5_32.z > 0.95))
         || 
          (sample6_31.z > 0.95)
        ) || (sample7_30.z > 0.95)) || (sample8_29.z > 0.95))) {
          outline_7 = ((_LineColor3 * _LineIntensity) * _LineColor3.w);
          if (tmpvar_28) {
            originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor3.w));
          };
          hasOutline_6 = bool(1);
        };
      };
    };
    if (!(tmpvar_27)) {
      outline_7 = (outline_7 * _FillAmount);
    };
  } else {
    if ((((
      (sample1_5.x > 0.95)
     || 
      (sample2_4.x > 0.95)
    ) || (sample3_3.x > 0.95)) || (sample4_2.x > 0.95))) {
      outline_7 = ((_LineColor1 * _LineIntensity) * _LineColor1.w);
      if (tmpvar_28) {
        originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor1.w));
      };
      hasOutline_6 = bool(1);
    } else {
      if ((((
        (sample1_5.y > 0.95)
       || 
        (sample2_4.y > 0.95)
      ) || (sample3_3.y > 0.95)) || (sample4_2.y > 0.95))) {
        outline_7 = ((_LineColor2 * _LineIntensity) * _LineColor2.w);
        if (tmpvar_28) {
          originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor2.w));
        };
        hasOutline_6 = bool(1);
      } else {
        if ((((
          (sample1_5.z > 0.95)
         || 
          (sample2_4.z > 0.95)
        ) || (sample3_3.z > 0.95)) || (sample4_2.z > 0.95))) {
          outline_7 = ((_LineColor3 * _LineIntensity) * _LineColor3.w);
          if (tmpvar_28) {
            originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor3.w));
          };
          hasOutline_6 = bool(1);
        };
      };
    };
    if (!(tmpvar_27)) {
      outline_7 = (outline_7 * _FillAmount);
    };
  };
  if (hasOutline_6) {
    highp vec4 tmpvar_47;
    mediump vec4 x_48;
    x_48 = (originalPixel_9 + outline_7);
    tmpvar_47 = mix (x_48, outline_7, vec4(_FillAmount));
    tmpvar_1 = tmpvar_47;
  } else {
    tmpvar_1 = originalPixel_9;
  };
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _OutlineSource;
uniform highp float _LineThicknessX;
uniform highp float _LineThicknessY;
uniform highp float _LineIntensity;
uniform mediump vec4 _LineColor1;
uniform mediump vec4 _LineColor2;
uniform mediump vec4 _LineColor3;
uniform highp int _FlipY;
uniform highp int _Dark;
uniform highp float _FillAmount;
uniform highp int _CornerOutlines;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 sample4_2;
  mediump vec4 sample3_3;
  mediump vec4 sample2_4;
  mediump vec4 sample1_5;
  bool hasOutline_6;
  mediump vec4 outline_7;
  mediump vec4 outlineSource_8;
  mediump vec4 originalPixel_9;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0;
  if ((_FlipY == 1)) {
    uv_10.y = (1.0 - xlv_TEXCOORD0.y);
  };
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, tmpvar_11);
  originalPixel_9 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((uv_10 * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_OutlineSource, tmpvar_13);
  outlineSource_8 = tmpvar_14;
  outline_7 = vec4(0.0, 0.0, 0.0, 0.0);
  hasOutline_6 = bool(0);
  highp vec2 tmpvar_15;
  tmpvar_15.y = 0.0;
  tmpvar_15.x = _LineThicknessX;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (uv_10 + tmpvar_15);
  tmpvar_16 = texture2D (_OutlineSource, P_17);
  sample1_5 = tmpvar_16;
  highp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = -(_LineThicknessX);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (uv_10 + tmpvar_18);
  tmpvar_19 = texture2D (_OutlineSource, P_20);
  sample2_4 = tmpvar_19;
  highp vec2 tmpvar_21;
  tmpvar_21.x = 0.0;
  tmpvar_21.y = _LineThicknessY;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (uv_10 + tmpvar_21);
  tmpvar_22 = texture2D (_OutlineSource, P_23);
  sample3_3 = tmpvar_22;
  highp vec2 tmpvar_24;
  tmpvar_24.x = 0.0;
  tmpvar_24.y = -(_LineThicknessY);
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (uv_10 + tmpvar_24);
  tmpvar_25 = texture2D (_OutlineSource, P_26);
  sample4_2 = tmpvar_25;
  bool tmpvar_27;
  tmpvar_27 = (outlineSource_8.w < 0.95);
  bool tmpvar_28;
  tmpvar_28 = (tmpvar_27 && bool(_Dark));
  if (bool(_CornerOutlines)) {
    mediump vec4 sample8_29;
    mediump vec4 sample7_30;
    mediump vec4 sample6_31;
    mediump vec4 sample5_32;
    highp vec2 tmpvar_33;
    tmpvar_33.x = _LineThicknessX;
    tmpvar_33.y = _LineThicknessY;
    lowp vec4 tmpvar_34;
    highp vec2 P_35;
    P_35 = (uv_10 + tmpvar_33);
    tmpvar_34 = texture2D (_OutlineSource, P_35);
    sample5_32 = tmpvar_34;
    highp vec2 tmpvar_36;
    highp float tmpvar_37;
    tmpvar_37 = -(_LineThicknessX);
    tmpvar_36.x = tmpvar_37;
    highp float tmpvar_38;
    tmpvar_38 = -(_LineThicknessY);
    tmpvar_36.y = tmpvar_38;
    lowp vec4 tmpvar_39;
    highp vec2 P_40;
    P_40 = (uv_10 + tmpvar_36);
    tmpvar_39 = texture2D (_OutlineSource, P_40);
    sample6_31 = tmpvar_39;
    highp vec2 tmpvar_41;
    tmpvar_41.x = _LineThicknessX;
    tmpvar_41.y = tmpvar_38;
    lowp vec4 tmpvar_42;
    highp vec2 P_43;
    P_43 = (uv_10 + tmpvar_41);
    tmpvar_42 = texture2D (_OutlineSource, P_43);
    sample7_30 = tmpvar_42;
    highp vec2 tmpvar_44;
    tmpvar_44.x = tmpvar_37;
    tmpvar_44.y = _LineThicknessY;
    lowp vec4 tmpvar_45;
    highp vec2 P_46;
    P_46 = (uv_10 + tmpvar_44);
    tmpvar_45 = texture2D (_OutlineSource, P_46);
    sample8_29 = tmpvar_45;
    if ((((
      ((((
        (sample1_5.x > 0.95)
       || 
        (sample2_4.x > 0.95)
      ) || (sample3_3.x > 0.95)) || (sample4_2.x > 0.95)) || (sample5_32.x > 0.95))
     || 
      (sample6_31.x > 0.95)
    ) || (sample7_30.x > 0.95)) || (sample8_29.x > 0.95))) {
      outline_7 = ((_LineColor1 * _LineIntensity) * _LineColor1.w);
      if (tmpvar_28) {
        originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor1.w));
      };
      hasOutline_6 = bool(1);
    } else {
      if ((((
        ((((
          (sample1_5.y > 0.95)
         || 
          (sample2_4.y > 0.95)
        ) || (sample3_3.y > 0.95)) || (sample4_2.y > 0.95)) || (sample5_32.y > 0.95))
       || 
        (sample6_31.y > 0.95)
      ) || (sample7_30.y > 0.95)) || (sample8_29.y > 0.95))) {
        outline_7 = ((_LineColor2 * _LineIntensity) * _LineColor2.w);
        if (tmpvar_28) {
          originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor2.w));
        };
        hasOutline_6 = bool(1);
      } else {
        if ((((
          ((((
            (sample1_5.z > 0.95)
           || 
            (sample2_4.z > 0.95)
          ) || (sample3_3.z > 0.95)) || (sample4_2.z > 0.95)) || (sample5_32.z > 0.95))
         || 
          (sample6_31.z > 0.95)
        ) || (sample7_30.z > 0.95)) || (sample8_29.z > 0.95))) {
          outline_7 = ((_LineColor3 * _LineIntensity) * _LineColor3.w);
          if (tmpvar_28) {
            originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor3.w));
          };
          hasOutline_6 = bool(1);
        };
      };
    };
    if (!(tmpvar_27)) {
      outline_7 = (outline_7 * _FillAmount);
    };
  } else {
    if ((((
      (sample1_5.x > 0.95)
     || 
      (sample2_4.x > 0.95)
    ) || (sample3_3.x > 0.95)) || (sample4_2.x > 0.95))) {
      outline_7 = ((_LineColor1 * _LineIntensity) * _LineColor1.w);
      if (tmpvar_28) {
        originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor1.w));
      };
      hasOutline_6 = bool(1);
    } else {
      if ((((
        (sample1_5.y > 0.95)
       || 
        (sample2_4.y > 0.95)
      ) || (sample3_3.y > 0.95)) || (sample4_2.y > 0.95))) {
        outline_7 = ((_LineColor2 * _LineIntensity) * _LineColor2.w);
        if (tmpvar_28) {
          originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor2.w));
        };
        hasOutline_6 = bool(1);
      } else {
        if ((((
          (sample1_5.z > 0.95)
         || 
          (sample2_4.z > 0.95)
        ) || (sample3_3.z > 0.95)) || (sample4_2.z > 0.95))) {
          outline_7 = ((_LineColor3 * _LineIntensity) * _LineColor3.w);
          if (tmpvar_28) {
            originalPixel_9 = (originalPixel_9 * (1.0 - _LineColor3.w));
          };
          hasOutline_6 = bool(1);
        };
      };
    };
    if (!(tmpvar_27)) {
      outline_7 = (outline_7 * _FillAmount);
    };
  };
  if (hasOutline_6) {
    highp vec4 tmpvar_47;
    mediump vec4 x_48;
    x_48 = (originalPixel_9 + outline_7);
    tmpvar_47 = mix (x_48, outline_7, vec4(_FillAmount));
    tmpvar_1 = tmpvar_47;
  } else {
    tmpvar_1 = originalPixel_9;
  };
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