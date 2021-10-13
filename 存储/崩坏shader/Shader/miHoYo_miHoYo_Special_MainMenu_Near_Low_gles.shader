//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/MainMenu/Near_Low" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_NormalMap ("Normal Map", 2D) = "green" { }
_BrushedNormalMap ("Brushed Normal Map", 2D) = "green" { }
_ReflectionMap ("Reflection Map", 2D) = "white" { }
_FresnelParams ("Fresnel Parameters", Vector) = (5,1,0,0)
_OutlineWidth ("Outline Width", Range(0, 1)) = 0.1
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Reflectivity ("Reflectivity", Range(0, 1)) = 0.5
_BrushScaleX ("Brush Scale X", Range(0, 1)) = 1
_BrushScaleY ("Brush Scale Y", Range(0, 1)) = 1
_BrushUVScaleX ("Brush UV Scale X", Range(0, 2)) = 1
_BrushUVScaleY ("Brush UV Scale Y", Range(0, 2)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZTest Less
  GpuProgramID 26320
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_5[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_5[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_1 = (tmpvar_5 * _glesNormal);
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(tmpvar_1);
  tmpvar_1 = tmpvar_6;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord1.xy;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (tmpvar_4.xyz / tmpvar_4.w);
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _NormalMap;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _ReflectionMap;
uniform sampler2D _miHoYo_NearEnvMap;
uniform highp vec4 _FresnelParams;
uniform mediump float _Reflectivity;
uniform mediump float _BrushScaleX;
uniform mediump float _BrushScaleY;
uniform mediump float _BrushUVScaleX;
uniform mediump float _BrushUVScaleY;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float reflMask_1;
  mediump vec4 reflColor_2;
  highp vec2 nearUV_3;
  highp vec2 scrUV_4;
  mediump vec4 baseTexColor_5;
  mediump vec3 normal_6;
  mediump vec4 brushedColor_7;
  mediump vec4 normalMapColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_NormalMap, xlv_TEXCOORD0);
  normalMapColor_8 = tmpvar_10;
  normalMapColor_8.xy = ((normalMapColor_8.xy * 2.0) - 1.0);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _BrushUVScaleX;
  tmpvar_11.y = _BrushUVScaleY;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD1 * tmpvar_11);
  tmpvar_12 = texture2D (_BrushedNormalMap, P_13);
  brushedColor_7 = tmpvar_12;
  brushedColor_7.xy = ((brushedColor_7.xy * 2.0) - 1.0);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _BrushScaleX;
  tmpvar_14.y = _BrushScaleY;
  brushedColor_7.xy = (brushedColor_7.xy * tmpvar_14);
  normal_6 = (normalMapColor_8.xyz + brushedColor_7.xyz);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  normal_6 = normal_6.xzy;
  normal_6.x = -(normal_6.x);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_5 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  mediump vec3 I_17;
  I_17 = tmpvar_16;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  scrUV_4 = (((
    (xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w)
   * 0.5) + 0.5) + normal_6.xz);
  scrUV_4.x = (scrUV_4.x - 0.007);
  nearUV_3.x = scrUV_4.x;
  nearUV_3.y = (scrUV_4.y * 2.0);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_miHoYo_NearEnvMap, nearUV_3);
  reflColor_2 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionMap, xlv_TEXCOORD0).x;
  reflMask_1 = tmpvar_22;
  reflColor_2 = (reflColor_2 * ((reflMask_1 * _Reflectivity) * (bias_20 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_17, xlv_TEXCOORD3))
    , 0.001, 1.0), power_18) * scale_19))
  )));
  outColor_9.xyz = ((baseTexColor_5.xyz * _MainColor.xyz) + reflColor_2.xyz);
  outColor_9.w = (_BloomFactor + reflColor_2.w);
  gl_FragData[0] = outColor_9;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_5[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_5[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_1 = (tmpvar_5 * _glesNormal);
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(tmpvar_1);
  tmpvar_1 = tmpvar_6;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord1.xy;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (tmpvar_4.xyz / tmpvar_4.w);
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _NormalMap;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _ReflectionMap;
uniform sampler2D _miHoYo_NearEnvMap;
uniform highp vec4 _FresnelParams;
uniform mediump float _Reflectivity;
uniform mediump float _BrushScaleX;
uniform mediump float _BrushScaleY;
uniform mediump float _BrushUVScaleX;
uniform mediump float _BrushUVScaleY;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float reflMask_1;
  mediump vec4 reflColor_2;
  highp vec2 nearUV_3;
  highp vec2 scrUV_4;
  mediump vec4 baseTexColor_5;
  mediump vec3 normal_6;
  mediump vec4 brushedColor_7;
  mediump vec4 normalMapColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_NormalMap, xlv_TEXCOORD0);
  normalMapColor_8 = tmpvar_10;
  normalMapColor_8.xy = ((normalMapColor_8.xy * 2.0) - 1.0);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _BrushUVScaleX;
  tmpvar_11.y = _BrushUVScaleY;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD1 * tmpvar_11);
  tmpvar_12 = texture2D (_BrushedNormalMap, P_13);
  brushedColor_7 = tmpvar_12;
  brushedColor_7.xy = ((brushedColor_7.xy * 2.0) - 1.0);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _BrushScaleX;
  tmpvar_14.y = _BrushScaleY;
  brushedColor_7.xy = (brushedColor_7.xy * tmpvar_14);
  normal_6 = (normalMapColor_8.xyz + brushedColor_7.xyz);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  normal_6 = normal_6.xzy;
  normal_6.x = -(normal_6.x);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_5 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  mediump vec3 I_17;
  I_17 = tmpvar_16;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  scrUV_4 = (((
    (xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w)
   * 0.5) + 0.5) + normal_6.xz);
  scrUV_4.x = (scrUV_4.x - 0.007);
  nearUV_3.x = scrUV_4.x;
  nearUV_3.y = (scrUV_4.y * 2.0);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_miHoYo_NearEnvMap, nearUV_3);
  reflColor_2 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionMap, xlv_TEXCOORD0).x;
  reflMask_1 = tmpvar_22;
  reflColor_2 = (reflColor_2 * ((reflMask_1 * _Reflectivity) * (bias_20 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_17, xlv_TEXCOORD3))
    , 0.001, 1.0), power_18) * scale_19))
  )));
  outColor_9.xyz = ((baseTexColor_5.xyz * _MainColor.xyz) + reflColor_2.xyz);
  outColor_9.w = (_BloomFactor + reflColor_2.w);
  gl_FragData[0] = outColor_9;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_5[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_5[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_1 = (tmpvar_5 * _glesNormal);
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(tmpvar_1);
  tmpvar_1 = tmpvar_6;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord1.xy;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (tmpvar_4.xyz / tmpvar_4.w);
  xlv_TEXCOORD5 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _NormalMap;
uniform sampler2D _BrushedNormalMap;
uniform sampler2D _ReflectionMap;
uniform sampler2D _miHoYo_NearEnvMap;
uniform highp vec4 _FresnelParams;
uniform mediump float _Reflectivity;
uniform mediump float _BrushScaleX;
uniform mediump float _BrushScaleY;
uniform mediump float _BrushUVScaleX;
uniform mediump float _BrushUVScaleY;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float reflMask_1;
  mediump vec4 reflColor_2;
  highp vec2 nearUV_3;
  highp vec2 scrUV_4;
  mediump vec4 baseTexColor_5;
  mediump vec3 normal_6;
  mediump vec4 brushedColor_7;
  mediump vec4 normalMapColor_8;
  mediump vec4 outColor_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_NormalMap, xlv_TEXCOORD0);
  normalMapColor_8 = tmpvar_10;
  normalMapColor_8.xy = ((normalMapColor_8.xy * 2.0) - 1.0);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _BrushUVScaleX;
  tmpvar_11.y = _BrushUVScaleY;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD1 * tmpvar_11);
  tmpvar_12 = texture2D (_BrushedNormalMap, P_13);
  brushedColor_7 = tmpvar_12;
  brushedColor_7.xy = ((brushedColor_7.xy * 2.0) - 1.0);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _BrushScaleX;
  tmpvar_14.y = _BrushScaleY;
  brushedColor_7.xy = (brushedColor_7.xy * tmpvar_14);
  normal_6 = (normalMapColor_8.xyz + brushedColor_7.xyz);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  normal_6 = normal_6.xzy;
  normal_6.x = -(normal_6.x);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_5 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  mediump vec3 I_17;
  I_17 = tmpvar_16;
  mediump float power_18;
  power_18 = _FresnelParams.x;
  mediump float scale_19;
  scale_19 = _FresnelParams.y;
  mediump float bias_20;
  bias_20 = _FresnelParams.z;
  scrUV_4 = (((
    (xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w)
   * 0.5) + 0.5) + normal_6.xz);
  scrUV_4.x = (scrUV_4.x - 0.007);
  nearUV_3.x = scrUV_4.x;
  nearUV_3.y = (scrUV_4.y * 2.0);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_miHoYo_NearEnvMap, nearUV_3);
  reflColor_2 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ReflectionMap, xlv_TEXCOORD0).x;
  reflMask_1 = tmpvar_22;
  reflColor_2 = (reflColor_2 * ((reflMask_1 * _Reflectivity) * (bias_20 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_17, xlv_TEXCOORD3))
    , 0.001, 1.0), power_18) * scale_19))
  )));
  outColor_9.xyz = ((baseTexColor_5.xyz * _MainColor.xyz) + reflColor_2.xyz);
  outColor_9.w = (_BloomFactor + reflColor_2.w);
  gl_FragData[0] = outColor_9;
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
  Name "SIMPLE"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 130355
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
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
  tmpvar_9 = (tmpvar_8 * _glesTANGENT.xyz);
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
  tmpvar_4.w = (tmpvar_4.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
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
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
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
  tmpvar_9 = (tmpvar_8 * _glesTANGENT.xyz);
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
  tmpvar_4.w = (tmpvar_4.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
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
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
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
  tmpvar_9 = (tmpvar_8 * _glesTANGENT.xyz);
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
  tmpvar_4.w = (tmpvar_4.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
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