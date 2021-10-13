//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Special/Plane_Clip" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_EmissionColor ("Emmisive Color", Color) = (0.5,0.5,0.5,1)
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Outline ("Outline Width", Float) = 0.02
_SpecMulti ("Specular Multiply", Float) = 1
_Shininess ("Shininess", Range(0.1, 100)) = 2
_FadeDistance ("Fade Start Distance", Float) = 0.5
_FadeOffset ("Fade Start Offset", Float) = 1
_ClipPlane ("Clip Plane", Vector) = (0,1,0,0)
_MainTex ("Base (RGB)", 2D) = "white" { }
_Ramp ("Toon Ramp (RGB)", 2D) = "gray" { }
_SpecRamp ("Specular Ramp (RGB)", 2D) = "black" { }
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 2158
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  highp float tmpvar_11;
  tmpvar_11 = ((dot (tmpvar_10, tmpvar_8.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = d_2;
  tmpvar_12.y = d_2;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_10, 
    normalize((tmpvar_8.xyz + normalize((_WorldSpaceCameraPos - tmpvar_13.xyz))))
  ), 0.0), _Shininess);
  s_1 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_2 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_1;
  };
  mediump vec3 tmpvar_16;
  tmpvar_16 = vec3(tmpvar_15);
  tmpvar_3.xyz = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = s_1;
  tmpvar_17.y = s_1;
  highp float tmpvar_18;
  tmpvar_18 = min (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 1.0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_13, _ClipPlane);
  highp float tmpvar_20;
  if ((tmpvar_19 < 0.0)) {
    tmpvar_20 = 0.0;
  } else {
    tmpvar_20 = tmpvar_18;
  };
  tmpvar_3.w = tmpvar_20;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_23;
    tmpvar_23.x = tmpvar_22.x;
    tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
    o_21.xy = (tmpvar_23 + tmpvar_22.w);
    o_21.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_21.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform highp float _UsingDitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 ramp_1;
  highp vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * _Color) * _EnvColor);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_1 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  outColor_2.xyz = ((tmpvar_4.xyz * (
    (tmpvar_6.xyz * _SpecMulti)
   + 1.0)) * ramp_1);
  outColor_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD3;
    mediump float a_8;
    a_8 = xlv_TEXCOORD3.z;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_8 = (a_8 * 17.0);
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_7.y / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_7.x / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float x_15;
      x_15 = ((a_8 - _DITHERMATRIX[
        int(tmpvar_11)
      ][
        int(tmpvar_14)
      ]) - 0.01);
      if ((x_15 < 0.0)) {
        discard;
      };
    };
  };
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  highp float tmpvar_11;
  tmpvar_11 = ((dot (tmpvar_10, tmpvar_8.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = d_2;
  tmpvar_12.y = d_2;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_10, 
    normalize((tmpvar_8.xyz + normalize((_WorldSpaceCameraPos - tmpvar_13.xyz))))
  ), 0.0), _Shininess);
  s_1 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_2 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_1;
  };
  mediump vec3 tmpvar_16;
  tmpvar_16 = vec3(tmpvar_15);
  tmpvar_3.xyz = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = s_1;
  tmpvar_17.y = s_1;
  highp float tmpvar_18;
  tmpvar_18 = min (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 1.0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_13, _ClipPlane);
  highp float tmpvar_20;
  if ((tmpvar_19 < 0.0)) {
    tmpvar_20 = 0.0;
  } else {
    tmpvar_20 = tmpvar_18;
  };
  tmpvar_3.w = tmpvar_20;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_23;
    tmpvar_23.x = tmpvar_22.x;
    tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
    o_21.xy = (tmpvar_23 + tmpvar_22.w);
    o_21.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_21.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform highp float _UsingDitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 ramp_1;
  highp vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * _Color) * _EnvColor);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_1 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  outColor_2.xyz = ((tmpvar_4.xyz * (
    (tmpvar_6.xyz * _SpecMulti)
   + 1.0)) * ramp_1);
  outColor_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD3;
    mediump float a_8;
    a_8 = xlv_TEXCOORD3.z;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_8 = (a_8 * 17.0);
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_7.y / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_7.x / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float x_15;
      x_15 = ((a_8 - _DITHERMATRIX[
        int(tmpvar_11)
      ][
        int(tmpvar_14)
      ]) - 0.01);
      if ((x_15 < 0.0)) {
        discard;
      };
    };
  };
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  highp float tmpvar_11;
  tmpvar_11 = ((dot (tmpvar_10, tmpvar_8.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = d_2;
  tmpvar_12.y = d_2;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_10, 
    normalize((tmpvar_8.xyz + normalize((_WorldSpaceCameraPos - tmpvar_13.xyz))))
  ), 0.0), _Shininess);
  s_1 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_2 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_1;
  };
  mediump vec3 tmpvar_16;
  tmpvar_16 = vec3(tmpvar_15);
  tmpvar_3.xyz = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = s_1;
  tmpvar_17.y = s_1;
  highp float tmpvar_18;
  tmpvar_18 = min (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 1.0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_13, _ClipPlane);
  highp float tmpvar_20;
  if ((tmpvar_19 < 0.0)) {
    tmpvar_20 = 0.0;
  } else {
    tmpvar_20 = tmpvar_18;
  };
  tmpvar_3.w = tmpvar_20;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_23;
    tmpvar_23.x = tmpvar_22.x;
    tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
    o_21.xy = (tmpvar_23 + tmpvar_22.w);
    o_21.zw = tmpvar_6.zw;
    tmpvar_5.xyw = o_21.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform highp float _UsingDitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 ramp_1;
  highp vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * _Color) * _EnvColor);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_1 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  outColor_2.xyz = ((tmpvar_4.xyz * (
    (tmpvar_6.xyz * _SpecMulti)
   + 1.0)) * ramp_1);
  outColor_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD3;
    mediump float a_8;
    a_8 = xlv_TEXCOORD3.z;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_8 = (a_8 * 17.0);
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_7.y / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_7.x / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float x_15;
      x_15 = ((a_8 - _DITHERMATRIX[
        int(tmpvar_11)
      ][
        int(tmpvar_14)
      ]) - 0.01);
      if ((x_15 < 0.0)) {
        discard;
      };
    };
  };
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
  Name "OUTLINE"
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 119155
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    normalize((tmpvar_10 * _glesNormal))
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  tmpvar_6.w = (_OutlineColor.w * min ((
    ((-((
      (unity_MatrixV * unity_ObjectToWorld)
     * _glesVertex).z) - _ProjectionParams.y) - _FadeOffset)
   / _FadeDistance), 1.0));
  highp float tmpvar_12;
  tmpvar_12 = dot ((unity_ObjectToWorld * _glesVertex), _ClipPlane);
  if ((tmpvar_12 < 0.0)) {
    tmpvar_6.w = 0.0;
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_7.xyw = o_13.xyw;
    tmpvar_7.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _UsingDitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 outColor_1;
  outColor_1 = xlv_COLOR0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD0;
    mediump float a_3;
    a_3 = xlv_TEXCOORD0.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  outColor_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    normalize((tmpvar_10 * _glesNormal))
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  tmpvar_6.w = (_OutlineColor.w * min ((
    ((-((
      (unity_MatrixV * unity_ObjectToWorld)
     * _glesVertex).z) - _ProjectionParams.y) - _FadeOffset)
   / _FadeDistance), 1.0));
  highp float tmpvar_12;
  tmpvar_12 = dot ((unity_ObjectToWorld * _glesVertex), _ClipPlane);
  if ((tmpvar_12 < 0.0)) {
    tmpvar_6.w = 0.0;
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_7.xyw = o_13.xyw;
    tmpvar_7.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _UsingDitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 outColor_1;
  outColor_1 = xlv_COLOR0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD0;
    mediump float a_3;
    a_3 = xlv_TEXCOORD0.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  outColor_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    normalize((tmpvar_10 * _glesNormal))
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  tmpvar_6.w = (_OutlineColor.w * min ((
    ((-((
      (unity_MatrixV * unity_ObjectToWorld)
     * _glesVertex).z) - _ProjectionParams.y) - _FadeOffset)
   / _FadeDistance), 1.0));
  highp float tmpvar_12;
  tmpvar_12 = dot ((unity_ObjectToWorld * _glesVertex), _ClipPlane);
  if ((tmpvar_12 < 0.0)) {
    tmpvar_6.w = 0.0;
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_7.xyw = o_13.xyw;
    tmpvar_7.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _UsingDitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 outColor_1;
  outColor_1 = xlv_COLOR0;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD0;
    mediump float a_3;
    a_3 = xlv_TEXCOORD0.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  outColor_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
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
  GpuProgramID 141036
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
}