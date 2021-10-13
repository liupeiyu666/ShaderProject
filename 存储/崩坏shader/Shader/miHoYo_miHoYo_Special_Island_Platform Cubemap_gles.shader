//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Island/Platform Cubemap" {
Properties {
_BaseColor ("Base Color (RGB)", Color) = (1,1,1,1)
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
_CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
_Scale ("Scale Compared to Maya", Float) = 0.01
_Color ("Main Color", Color) = (1,1,1,1)
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_PolygonOffset ("Polygon Offset", Float) = 0
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 53215
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_5 = tmpvar_1;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  adjCamPos_4.xz = (tmpvar_8.xz - ((tmpvar_8.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_ObjectToWorld * _glesVertex).xyz - adjCamPos_4));
  tmpvar_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = cos(_CamRotate);
  cost_3 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = sin(_CamRotate);
  sint_2 = tmpvar_11;
  highp mat2 tmpvar_12;
  tmpvar_12[0].x = cost_3;
  tmpvar_12[0].y = -(sint_2);
  tmpvar_12[1].x = sint_2;
  tmpvar_12[1].y = cost_3;
  tmpvar_6.xz = (tmpvar_12 * tmpvar_6.xz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 outColor_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1).xyz;
  tex_S_Color_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = textureCube (_EnvTex, tmpvar_4);
  tex_C_Color_2.xyz = (tex_C_Color_2.xyz + ((tmpvar_7.xyz * tex_C_Color_2.w) * _Reflectivity));
  outColor_3.xyz = ((tex_C_Color_2.xyz * 2.0) * (tex_S_Color_1 * _LightMapIntensity));
  outColor_3.w = _BloomFactor;
  gl_FragData[0] = outColor_3;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_5 = tmpvar_1;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  adjCamPos_4.xz = (tmpvar_8.xz - ((tmpvar_8.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_ObjectToWorld * _glesVertex).xyz - adjCamPos_4));
  tmpvar_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = cos(_CamRotate);
  cost_3 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = sin(_CamRotate);
  sint_2 = tmpvar_11;
  highp mat2 tmpvar_12;
  tmpvar_12[0].x = cost_3;
  tmpvar_12[0].y = -(sint_2);
  tmpvar_12[1].x = sint_2;
  tmpvar_12[1].y = cost_3;
  tmpvar_6.xz = (tmpvar_12 * tmpvar_6.xz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 outColor_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1).xyz;
  tex_S_Color_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = textureCube (_EnvTex, tmpvar_4);
  tex_C_Color_2.xyz = (tex_C_Color_2.xyz + ((tmpvar_7.xyz * tex_C_Color_2.w) * _Reflectivity));
  outColor_3.xyz = ((tex_C_Color_2.xyz * 2.0) * (tex_S_Color_1 * _LightMapIntensity));
  outColor_3.w = _BloomFactor;
  gl_FragData[0] = outColor_3;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp float sint_2;
  highp float cost_3;
  highp vec3 adjCamPos_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_5 = tmpvar_1;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  adjCamPos_4.xz = (tmpvar_8.xz - ((tmpvar_8.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_4.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((unity_ObjectToWorld * _glesVertex).xyz - adjCamPos_4));
  tmpvar_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = cos(_CamRotate);
  cost_3 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = sin(_CamRotate);
  sint_2 = tmpvar_11;
  highp mat2 tmpvar_12;
  tmpvar_12[0].x = cost_3;
  tmpvar_12[0].y = -(sint_2);
  tmpvar_12[1].x = sint_2;
  tmpvar_12[1].y = cost_3;
  tmpvar_6.xz = (tmpvar_12 * tmpvar_6.xz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tex_S_Color_1;
  mediump vec4 tex_C_Color_2;
  mediump vec4 outColor_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_2 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1).xyz;
  tex_S_Color_1 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = textureCube (_EnvTex, tmpvar_4);
  tex_C_Color_2.xyz = (tex_C_Color_2.xyz + ((tmpvar_7.xyz * tex_C_Color_2.w) * _Reflectivity));
  outColor_3.xyz = ((tex_C_Color_2.xyz * 2.0) * (tex_S_Color_1 * _LightMapIntensity));
  outColor_3.w = _BloomFactor;
  gl_FragData[0] = outColor_3;
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
  Name "SIMPLE_NORMAL"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 94533
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_MatrixMV[0].xyz;
  tmpvar_8[1] = unity_MatrixMV[1].xyz;
  tmpvar_8[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * _glesNormal);
  N_1.xy = tmpvar_9.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(N_1);
  N_1 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * tmpvar_7);
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_10.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  highp float fadeOffset_12;
  fadeOffset_12 = _FadeOffset;
  highp float fadeDistance_13;
  fadeDistance_13 = _FadeDistance;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_12) / fadeDistance_13), 0.0, 1.0);
  tmpvar_4.w = tmpvar_14;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_15.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
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
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_MatrixMV[0].xyz;
  tmpvar_8[1] = unity_MatrixMV[1].xyz;
  tmpvar_8[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * _glesNormal);
  N_1.xy = tmpvar_9.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(N_1);
  N_1 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * tmpvar_7);
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_10.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  highp float fadeOffset_12;
  fadeOffset_12 = _FadeOffset;
  highp float fadeDistance_13;
  fadeDistance_13 = _FadeDistance;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_12) / fadeDistance_13), 0.0, 1.0);
  tmpvar_4.w = tmpvar_14;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_15.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
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
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_MatrixMV[0].xyz;
  tmpvar_8[1] = unity_MatrixMV[1].xyz;
  tmpvar_8[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * _glesNormal);
  N_1.xy = tmpvar_9.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(N_1);
  N_1 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * tmpvar_7);
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_10.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  highp float fadeOffset_12;
  fadeOffset_12 = _FadeOffset;
  highp float fadeDistance_13;
  fadeDistance_13 = _FadeDistance;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_12) / fadeDistance_13), 0.0, 1.0);
  tmpvar_4.w = tmpvar_14;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_15.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
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