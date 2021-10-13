//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/MainMenu/Near2" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_NormalMap ("Normal Map", 2D) = "green" { }
_ReflectionMap ("Reflection Map", 2D) = "white" { }
_EnvTex ("Environment Texture", Cube) = "black" { }
_FresnelParams ("Fresnel Parameters", Vector) = (5,1,0,0)
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Reflectivity ("Reflectivity", Range(0, 1)) = 0.5
_CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZTest Less
  GpuProgramID 39555
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9.xyz - adjCamPos_3));
  tmpvar_7 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = cos(_CamRotate);
  cost_2 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = sin(_CamRotate);
  sint_1 = tmpvar_12;
  highp mat2 tmpvar_13;
  tmpvar_13[0].x = cost_2;
  tmpvar_13[0].y = -(sint_1);
  tmpvar_13[1].x = sint_1;
  tmpvar_13[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_13 * tmpvar_7.xz);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_4 = (tmpvar_14 * _glesTANGENT.xyz);
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_6 = (tmpvar_16 * _glesNormal);
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_6);
  tmpvar_6 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  tmpvar_5 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_5);
  tmpvar_5 = tmpvar_19;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord1.xy;
  xlv_TEXCOORD2 = tmpvar_15;
  xlv_TEXCOORD3 = tmpvar_19;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = (tmpvar_9.xyz / tmpvar_9.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _NormalMap;
uniform lowp samplerCube _EnvTex;
uniform highp vec4 _FresnelParams;
uniform mediump float _Reflectivity;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 reflColor_1;
  mediump vec4 baseTexColor_2;
  mediump vec3 normal_3;
  mediump vec4 outColor_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  normal_3 = tmpvar_5;
  mediump mat3 tmpvar_6;
  tmpvar_6[0].x = xlv_TEXCOORD2.x;
  tmpvar_6[0].y = xlv_TEXCOORD2.y;
  tmpvar_6[0].z = xlv_TEXCOORD2.z;
  tmpvar_6[1].x = xlv_TEXCOORD3.x;
  tmpvar_6[1].y = xlv_TEXCOORD3.y;
  tmpvar_6[1].z = xlv_TEXCOORD3.z;
  tmpvar_6[2].x = xlv_TEXCOORD4.x;
  tmpvar_6[2].y = xlv_TEXCOORD4.y;
  tmpvar_6[2].z = xlv_TEXCOORD4.z;
  normal_3 = (tmpvar_6 * normal_3);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_2 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD5 - (2.0 * (
    dot (normal_3, xlv_TEXCOORD5)
   * normal_3)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  reflColor_1 = tmpvar_9;
  mediump float power_10;
  power_10 = _FresnelParams.x;
  mediump float scale_11;
  scale_11 = _FresnelParams.y;
  mediump float bias_12;
  bias_12 = _FresnelParams.z;
  reflColor_1 = (reflColor_1 * (_Reflectivity * (bias_12 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (xlv_TEXCOORD5, xlv_TEXCOORD4))
    , 0.001, 1.0), power_10) * scale_11))
  )));
  outColor_4.xyz = ((baseTexColor_2.xyz * _MainColor.xyz) + reflColor_1.xyz);
  outColor_4.w = (_BloomFactor + reflColor_1.w);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9.xyz - adjCamPos_3));
  tmpvar_7 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = cos(_CamRotate);
  cost_2 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = sin(_CamRotate);
  sint_1 = tmpvar_12;
  highp mat2 tmpvar_13;
  tmpvar_13[0].x = cost_2;
  tmpvar_13[0].y = -(sint_1);
  tmpvar_13[1].x = sint_1;
  tmpvar_13[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_13 * tmpvar_7.xz);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_4 = (tmpvar_14 * _glesTANGENT.xyz);
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_6 = (tmpvar_16 * _glesNormal);
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_6);
  tmpvar_6 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  tmpvar_5 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_5);
  tmpvar_5 = tmpvar_19;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord1.xy;
  xlv_TEXCOORD2 = tmpvar_15;
  xlv_TEXCOORD3 = tmpvar_19;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = (tmpvar_9.xyz / tmpvar_9.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _NormalMap;
uniform lowp samplerCube _EnvTex;
uniform highp vec4 _FresnelParams;
uniform mediump float _Reflectivity;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 reflColor_1;
  mediump vec4 baseTexColor_2;
  mediump vec3 normal_3;
  mediump vec4 outColor_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  normal_3 = tmpvar_5;
  mediump mat3 tmpvar_6;
  tmpvar_6[0].x = xlv_TEXCOORD2.x;
  tmpvar_6[0].y = xlv_TEXCOORD2.y;
  tmpvar_6[0].z = xlv_TEXCOORD2.z;
  tmpvar_6[1].x = xlv_TEXCOORD3.x;
  tmpvar_6[1].y = xlv_TEXCOORD3.y;
  tmpvar_6[1].z = xlv_TEXCOORD3.z;
  tmpvar_6[2].x = xlv_TEXCOORD4.x;
  tmpvar_6[2].y = xlv_TEXCOORD4.y;
  tmpvar_6[2].z = xlv_TEXCOORD4.z;
  normal_3 = (tmpvar_6 * normal_3);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_2 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD5 - (2.0 * (
    dot (normal_3, xlv_TEXCOORD5)
   * normal_3)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  reflColor_1 = tmpvar_9;
  mediump float power_10;
  power_10 = _FresnelParams.x;
  mediump float scale_11;
  scale_11 = _FresnelParams.y;
  mediump float bias_12;
  bias_12 = _FresnelParams.z;
  reflColor_1 = (reflColor_1 * (_Reflectivity * (bias_12 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (xlv_TEXCOORD5, xlv_TEXCOORD4))
    , 0.001, 1.0), power_10) * scale_11))
  )));
  outColor_4.xyz = ((baseTexColor_2.xyz * _MainColor.xyz) + reflColor_1.xyz);
  outColor_4.w = (_BloomFactor + reflColor_1.w);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  highp float sint_1;
  highp float cost_2;
  highp vec3 adjCamPos_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_3.xz = (tmpvar_9.xz - ((tmpvar_9.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_3.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9.xyz - adjCamPos_3));
  tmpvar_7 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = cos(_CamRotate);
  cost_2 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = sin(_CamRotate);
  sint_1 = tmpvar_12;
  highp mat2 tmpvar_13;
  tmpvar_13[0].x = cost_2;
  tmpvar_13[0].y = -(sint_1);
  tmpvar_13[1].x = sint_1;
  tmpvar_13[1].y = cost_2;
  tmpvar_7.xz = (tmpvar_13 * tmpvar_7.xz);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_4 = (tmpvar_14 * _glesTANGENT.xyz);
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(tmpvar_4);
  tmpvar_4 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_6 = (tmpvar_16 * _glesNormal);
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_6);
  tmpvar_6 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx));
  tmpvar_5 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_5);
  tmpvar_5 = tmpvar_19;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord1.xy;
  xlv_TEXCOORD2 = tmpvar_15;
  xlv_TEXCOORD3 = tmpvar_19;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = (tmpvar_9.xyz / tmpvar_9.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform sampler2D _NormalMap;
uniform lowp samplerCube _EnvTex;
uniform highp vec4 _FresnelParams;
uniform mediump float _Reflectivity;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 reflColor_1;
  mediump vec4 baseTexColor_2;
  mediump vec3 normal_3;
  mediump vec4 outColor_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  normal_3 = tmpvar_5;
  mediump mat3 tmpvar_6;
  tmpvar_6[0].x = xlv_TEXCOORD2.x;
  tmpvar_6[0].y = xlv_TEXCOORD2.y;
  tmpvar_6[0].z = xlv_TEXCOORD2.z;
  tmpvar_6[1].x = xlv_TEXCOORD3.x;
  tmpvar_6[1].y = xlv_TEXCOORD3.y;
  tmpvar_6[1].z = xlv_TEXCOORD3.z;
  tmpvar_6[2].x = xlv_TEXCOORD4.x;
  tmpvar_6[2].y = xlv_TEXCOORD4.y;
  tmpvar_6[2].z = xlv_TEXCOORD4.z;
  normal_3 = (tmpvar_6 * normal_3);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_2 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD5 - (2.0 * (
    dot (normal_3, xlv_TEXCOORD5)
   * normal_3)));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureCube (_EnvTex, tmpvar_8);
  reflColor_1 = tmpvar_9;
  mediump float power_10;
  power_10 = _FresnelParams.x;
  mediump float scale_11;
  scale_11 = _FresnelParams.y;
  mediump float bias_12;
  bias_12 = _FresnelParams.z;
  reflColor_1 = (reflColor_1 * (_Reflectivity * (bias_12 + 
    max (0.0, (pow (clamp (
      (1.0 - dot (xlv_TEXCOORD5, xlv_TEXCOORD4))
    , 0.001, 1.0), power_10) * scale_11))
  )));
  outColor_4.xyz = ((baseTexColor_2.xyz * _MainColor.xyz) + reflColor_1.xyz);
  outColor_4.w = (_BloomFactor + reflColor_1.w);
  gl_FragData[0] = outColor_4;
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
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 73016
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