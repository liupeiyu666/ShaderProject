//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Armada/Base" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_EmissionScaler ("Emission Scaler", Range(0, 10)) = 1
_EmissionBloomFactor ("Emission Bloom Factor", Float) = 1
_OutlineWidth ("Outline Width", Range(0, 1)) = 0.1
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
[Toggle] _PerspectiveDeformation ("Perspective Deformation", Float) = 0
_Vanishpoint ("Vanishpoint Position (Local Space)", Vector) = (0,0,10000,0)
_InvariantPlaneZ ("Invariant Plane Z Position (Local Space)", Float) = 0
_ScaleInZ ("Scale In Z", Range(0.01, 2)) = 1
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "Reflected" = "Far" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "Reflected" = "Far" "RenderType" = "Opaque" }
  ZTest Less
  GpuProgramID 63343
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_3;
    highp vec3 tmpvar_4;
    tmpvar_4 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_3.z = tmpvar_4.z;
    posInPerp_3.xy = (tmpvar_4.xy * (tmpvar_4.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_3 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionBloomFactor;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 baseColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseColor_1 = tmpvar_3;
  outColor_2.xyz = (baseColor_1.xyz * vec3(mix (1.0, _EmissionScaler, baseColor_1.w)));
  highp float tmpvar_4;
  tmpvar_4 = mix (_BloomFactor, _EmissionBloomFactor, baseColor_1.w);
  outColor_2.w = tmpvar_4;
  gl_FragData[0] = outColor_2;
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
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_3;
    highp vec3 tmpvar_4;
    tmpvar_4 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_3.z = tmpvar_4.z;
    posInPerp_3.xy = (tmpvar_4.xy * (tmpvar_4.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_3 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionBloomFactor;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 baseColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseColor_1 = tmpvar_3;
  outColor_2.xyz = (baseColor_1.xyz * vec3(mix (1.0, _EmissionScaler, baseColor_1.w)));
  highp float tmpvar_4;
  tmpvar_4 = mix (_BloomFactor, _EmissionBloomFactor, baseColor_1.w);
  outColor_2.w = tmpvar_4;
  gl_FragData[0] = outColor_2;
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
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_3;
    highp vec3 tmpvar_4;
    tmpvar_4 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_3.z = tmpvar_4.z;
    posInPerp_3.xy = (tmpvar_4.xy * (tmpvar_4.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_3 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionBloomFactor;
uniform highp float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 baseColor_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseColor_1 = tmpvar_3;
  outColor_2.xyz = (baseColor_1.xyz * vec3(mix (1.0, _EmissionScaler, baseColor_1.w)));
  highp float tmpvar_4;
  tmpvar_4 = mix (_BloomFactor, _EmissionBloomFactor, baseColor_1.w);
  outColor_2.w = tmpvar_4;
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
  Name "COMPLEX"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "Reflected" = "Far" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 120945
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
uniform mediump float _PerspectiveDeformation;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_6.z = tmpvar_7.z;
    posInPerp_6.xy = (tmpvar_7.xy * (tmpvar_7.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_6 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  tmpvar_4 = (unity_MatrixMV * tmpvar_1);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_8;
  tmpvar_8 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_8;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_MatrixMV[0].xyz;
  tmpvar_9[1] = unity_MatrixMV[1].xyz;
  tmpvar_9[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  N_2.xy = tmpvar_10.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(N_2);
  N_2 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_12));
  tmpvar_4.xyz = (tmpvar_4.xyz + ((
    (normalize(tmpvar_4.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_11.xy * tmpvar_13));
  tmpvar_5.xyz = _OutlineColor.xyz;
  tmpvar_5.w = 1.0;
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
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
attribute vec3 _glesNormal;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
uniform mediump float _PerspectiveDeformation;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_6.z = tmpvar_7.z;
    posInPerp_6.xy = (tmpvar_7.xy * (tmpvar_7.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_6 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  tmpvar_4 = (unity_MatrixMV * tmpvar_1);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_8;
  tmpvar_8 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_8;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_MatrixMV[0].xyz;
  tmpvar_9[1] = unity_MatrixMV[1].xyz;
  tmpvar_9[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  N_2.xy = tmpvar_10.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(N_2);
  N_2 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_12));
  tmpvar_4.xyz = (tmpvar_4.xyz + ((
    (normalize(tmpvar_4.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_11.xy * tmpvar_13));
  tmpvar_5.xyz = _OutlineColor.xyz;
  tmpvar_5.w = 1.0;
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
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
attribute vec3 _glesNormal;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
uniform mediump float _PerspectiveDeformation;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_6.z = tmpvar_7.z;
    posInPerp_6.xy = (tmpvar_7.xy * (tmpvar_7.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_6 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  tmpvar_4 = (unity_MatrixMV * tmpvar_1);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_8;
  tmpvar_8 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_8;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_MatrixMV[0].xyz;
  tmpvar_9[1] = unity_MatrixMV[1].xyz;
  tmpvar_9[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  N_2.xy = tmpvar_10.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(N_2);
  N_2 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_12));
  tmpvar_4.xyz = (tmpvar_4.xyz + ((
    (normalize(tmpvar_4.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_11.xy * tmpvar_13));
  tmpvar_5.xyz = _OutlineColor.xyz;
  tmpvar_5.w = 1.0;
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
uniform mediump float _PerspectiveDeformation;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_6.z = tmpvar_7.z;
    posInPerp_6.xy = (tmpvar_7.xy * (tmpvar_7.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_6 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  tmpvar_4 = (unity_MatrixMV * tmpvar_1);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_8;
  tmpvar_8 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_8;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_MatrixMV[0].xyz;
  tmpvar_9[1] = unity_MatrixMV[1].xyz;
  tmpvar_9[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  N_2.xy = tmpvar_10.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(N_2);
  N_2 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_12));
  tmpvar_4.xyz = (tmpvar_4.xyz + ((
    (normalize(tmpvar_4.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_11.xy * tmpvar_13));
  tmpvar_5.xyz = _OutlineColor.xyz;
  tmpvar_5.w = 1.0;
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  xlv_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = xlv_COLOR0;
  };
  color_1.w = outColor_4.w;
  color_1.xyz = (outColor_4.xyz * _Color.xyz);
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
  color_1.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
uniform mediump float _PerspectiveDeformation;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_6.z = tmpvar_7.z;
    posInPerp_6.xy = (tmpvar_7.xy * (tmpvar_7.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_6 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  tmpvar_4 = (unity_MatrixMV * tmpvar_1);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_8;
  tmpvar_8 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_8;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_MatrixMV[0].xyz;
  tmpvar_9[1] = unity_MatrixMV[1].xyz;
  tmpvar_9[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  N_2.xy = tmpvar_10.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(N_2);
  N_2 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_12));
  tmpvar_4.xyz = (tmpvar_4.xyz + ((
    (normalize(tmpvar_4.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_11.xy * tmpvar_13));
  tmpvar_5.xyz = _OutlineColor.xyz;
  tmpvar_5.w = 1.0;
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  xlv_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = xlv_COLOR0;
  };
  color_1.w = outColor_4.w;
  color_1.xyz = (outColor_4.xyz * _Color.xyz);
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
  color_1.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
uniform mediump float _PerspectiveDeformation;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_6;
    highp vec3 tmpvar_7;
    tmpvar_7 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_6.z = tmpvar_7.z;
    posInPerp_6.xy = (tmpvar_7.xy * (tmpvar_7.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_6 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  tmpvar_4 = (unity_MatrixMV * tmpvar_1);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_8;
  tmpvar_8 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_8;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_MatrixMV[0].xyz;
  tmpvar_9[1] = unity_MatrixMV[1].xyz;
  tmpvar_9[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  N_2.xy = tmpvar_10.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(N_2);
  N_2 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_12));
  tmpvar_4.xyz = (tmpvar_4.xyz + ((
    (normalize(tmpvar_4.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_11.xy * tmpvar_13));
  tmpvar_5.xyz = _OutlineColor.xyz;
  tmpvar_5.w = 1.0;
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (tmpvar_14.x + (tmpvar_14.z * tmpvar_14.z));
  tmpvar_15.y = ((tmpvar_14.y + (0.5 * tmpvar_14.z)) + ((0.5 * tmpvar_14.x) * tmpvar_14.x));
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = ((tmpvar_15 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  xlv_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = xlv_COLOR0;
  };
  color_1.w = outColor_4.w;
  color_1.xyz = (outColor_4.xyz * _Color.xyz);
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
  color_1.w = clamp (outColor_4.w, 0.0, 1.0);
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
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
}
}
}
Fallback "Diffuse"
}