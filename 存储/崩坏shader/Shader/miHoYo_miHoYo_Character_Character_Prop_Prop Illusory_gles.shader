//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop Illusory" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Environment Color", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 0.25
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
_EmissionScaler ("Emission Scaler", Range(1, 10)) = 1
_EmissionFactor ("Emission Factor (lerp factor between original and emission color)", Range(0, 1)) = 0
_EmissionFactorFromTexToggle ("Emission Factor From Tex Toggle", Range(0, 1)) = 0
_EmissionBloomFactor ("Emission Bloom Factor", Float) = 1
_ClipPlane ("Clip Plane (Model Space)", Vector) = (0,0,0,0)
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
[Toggle(SPECIAL_STATE)] _SpecialState ("Special State", Float) = 0
_SPTex ("SP Tex", 2D) = "white" { }
_SPNoiseTex ("SP Noise Tex", 2D) = "white" { }
_SPNoiseScaler ("SP Noise Scaler", Range(0, 10)) = 1
_SPIntensity ("SP Intensity", Range(0, 1)) = 0.5
_SPTransition ("SP Transition", Range(0, 1)) = 0
_SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
_SPOpaqueness ("SP Opaqueness", Range(0, 1)) = 1
_SPOutlineColor ("SP Outline Color", Color) = (1,1,1,1)
_SPTransitionEmissionScaler ("SP Transition Emission Scaler", Range(1, 100)) = 1
_SPTransitionBloomFactor ("SP Transition Bloom Factor", Float) = 1
_SPCubeMap ("SP CubeMap", Cube) = "white" { }
_SPCubeMapColor ("SP CubeMap Color", Color) = (1,1,1,0)
_SPCubeMapOffset ("SP CubeMap Offset", Vector) = (0,0,0,0)
_SPCubeMapIntensity ("SP CubeMap Intensity", Range(0, 1)) = 0
_SPCubeMapNoiseIntensity ("SP CubeMap Noise Intensity", Range(0, 5)) = 0
_SPCubeMapBrightness ("SP CubeMap Brightness", Float) = 1.26
_SPOldColor ("SP Old Color", Color) = (1,1,1,0)
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 42532
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_17.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_20 * 0.5);
    highp vec2 tmpvar_24;
    tmpvar_24.x = tmpvar_23.x;
    tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
    o_22.xy = (tmpvar_24 + tmpvar_23.w);
    o_22.zw = tmpvar_20.zw;
    tmpvar_6.xyw = o_22.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  mediump vec3 baseTexColor_1;
  mediump vec4 outColor_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_4.xyz;
  baseTexColor_1 = tmpvar_3;
  outColor_2.xyz = (mix (baseTexColor_1, (baseTexColor_1 * _EmissionScaler), vec3(mix (_EmissionFactor, tmpvar_4.w, _EmissionFactorFromTexToggle))) * _MainColor.xyz);
  outColor_2.w = clamp (xlv_COLOR1.y, 0.0, 1.0);
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_17.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_20 * 0.5);
    highp vec2 tmpvar_24;
    tmpvar_24.x = tmpvar_23.x;
    tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
    o_22.xy = (tmpvar_24 + tmpvar_23.w);
    o_22.zw = tmpvar_20.zw;
    tmpvar_6.xyw = o_22.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  mediump vec3 baseTexColor_1;
  mediump vec4 outColor_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_4.xyz;
  baseTexColor_1 = tmpvar_3;
  outColor_2.xyz = (mix (baseTexColor_1, (baseTexColor_1 * _EmissionScaler), vec3(mix (_EmissionFactor, tmpvar_4.w, _EmissionFactorFromTexToggle))) * _MainColor.xyz);
  outColor_2.w = clamp (xlv_COLOR1.y, 0.0, 1.0);
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_17.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_20 * 0.5);
    highp vec2 tmpvar_24;
    tmpvar_24.x = tmpvar_23.x;
    tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
    o_22.xy = (tmpvar_24 + tmpvar_23.w);
    o_22.zw = tmpvar_20.zw;
    tmpvar_6.xyw = o_22.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  mediump vec3 baseTexColor_1;
  mediump vec4 outColor_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_4.xyz;
  baseTexColor_1 = tmpvar_3;
  outColor_2.xyz = (mix (baseTexColor_1, (baseTexColor_1 * _EmissionScaler), vec3(mix (_EmissionFactor, tmpvar_4.w, _EmissionFactorFromTexToggle))) * _MainColor.xyz);
  outColor_2.w = clamp (xlv_COLOR1.y, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_17.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  highp vec4 spuvs_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (vertex_17 * 0.5);
  spuvs_22.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_24;
  tmpvar_24.x = (tmpvar_23.x + (tmpvar_23.z * tmpvar_23.z));
  tmpvar_24.y = ((tmpvar_23.y + (0.5 * tmpvar_23.z)) + ((0.5 * tmpvar_23.x) * tmpvar_23.x));
  spuvs_22.zw = ((tmpvar_24 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_20 * 0.5);
    highp vec2 tmpvar_27;
    tmpvar_27.x = tmpvar_26.x;
    tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
    o_25.xy = (tmpvar_27 + tmpvar_26.w);
    o_25.zw = tmpvar_20.zw;
    tmpvar_6.xyw = o_25.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = spuvs_22;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_4 = tmpvar_5.xyz;
  baseTexColor_2 = tmpvar_4;
  outColor_3.xyz = (mix (baseTexColor_2, (baseTexColor_2 * _EmissionScaler), vec3(mix (_EmissionFactor, tmpvar_5.w, _EmissionFactorFromTexToggle))) * _MainColor.xyz);
  outColor_3.w = xlv_COLOR1.y;
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_7;
  mediump vec3 reflection_8;
  mediump vec3 R_9;
  mediump float intensity_10;
  mediump vec4 noiseTex_11;
  mediump vec4 spColor_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_12.xyz = tmpvar_13.xyz;
  spColor_12.w = outColor_3.w;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (((1.99 * noiseTex_11.x) * _SPNoiseScaler) - 1.0);
  intensity_10 = tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 I_17;
  I_17 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_11 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_16 = (I_17 - (2.0 * (
    dot (tmpvar_6, I_17)
   * tmpvar_6)));
  R_9 = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = textureCube (_SPCubeMap, R_9).xyz;
  reflection_8 = tmpvar_18;
  highp vec3 tmpvar_19;
  mediump vec3 x_20;
  x_20 = (spColor_12.xyz * _SPOldColor.xyz);
  tmpvar_19 = mix (x_20, ((reflection_8 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_12.xyz = tmpvar_19;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_10 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_10 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_21;
      tmpvar_21 = mix (spColor_12, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_10) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_12 = tmpvar_21;
    };
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (outColor_3.xyz, spColor_12.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_12.xyz = tmpvar_22;
  outColor_3.xyz = spColor_12.xyz;
  outColor_3.w = clamp (spColor_12.w, 0.0, 1.0);
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_17.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  highp vec4 spuvs_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (vertex_17 * 0.5);
  spuvs_22.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_24;
  tmpvar_24.x = (tmpvar_23.x + (tmpvar_23.z * tmpvar_23.z));
  tmpvar_24.y = ((tmpvar_23.y + (0.5 * tmpvar_23.z)) + ((0.5 * tmpvar_23.x) * tmpvar_23.x));
  spuvs_22.zw = ((tmpvar_24 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_20 * 0.5);
    highp vec2 tmpvar_27;
    tmpvar_27.x = tmpvar_26.x;
    tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
    o_25.xy = (tmpvar_27 + tmpvar_26.w);
    o_25.zw = tmpvar_20.zw;
    tmpvar_6.xyw = o_25.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = spuvs_22;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_4 = tmpvar_5.xyz;
  baseTexColor_2 = tmpvar_4;
  outColor_3.xyz = (mix (baseTexColor_2, (baseTexColor_2 * _EmissionScaler), vec3(mix (_EmissionFactor, tmpvar_5.w, _EmissionFactorFromTexToggle))) * _MainColor.xyz);
  outColor_3.w = xlv_COLOR1.y;
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_7;
  mediump vec3 reflection_8;
  mediump vec3 R_9;
  mediump float intensity_10;
  mediump vec4 noiseTex_11;
  mediump vec4 spColor_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_12.xyz = tmpvar_13.xyz;
  spColor_12.w = outColor_3.w;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (((1.99 * noiseTex_11.x) * _SPNoiseScaler) - 1.0);
  intensity_10 = tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 I_17;
  I_17 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_11 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_16 = (I_17 - (2.0 * (
    dot (tmpvar_6, I_17)
   * tmpvar_6)));
  R_9 = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = textureCube (_SPCubeMap, R_9).xyz;
  reflection_8 = tmpvar_18;
  highp vec3 tmpvar_19;
  mediump vec3 x_20;
  x_20 = (spColor_12.xyz * _SPOldColor.xyz);
  tmpvar_19 = mix (x_20, ((reflection_8 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_12.xyz = tmpvar_19;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_10 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_10 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_21;
      tmpvar_21 = mix (spColor_12, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_10) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_12 = tmpvar_21;
    };
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (outColor_3.xyz, spColor_12.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_12.xyz = tmpvar_22;
  outColor_3.xyz = spColor_12.xyz;
  outColor_3.w = clamp (spColor_12.w, 0.0, 1.0);
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_17.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  highp vec4 spuvs_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (vertex_17 * 0.5);
  spuvs_22.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_24;
  tmpvar_24.x = (tmpvar_23.x + (tmpvar_23.z * tmpvar_23.z));
  tmpvar_24.y = ((tmpvar_23.y + (0.5 * tmpvar_23.z)) + ((0.5 * tmpvar_23.x) * tmpvar_23.x));
  spuvs_22.zw = ((tmpvar_24 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_20 * 0.5);
    highp vec2 tmpvar_27;
    tmpvar_27.x = tmpvar_26.x;
    tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
    o_25.xy = (tmpvar_27 + tmpvar_26.w);
    o_25.zw = tmpvar_20.zw;
    tmpvar_6.xyw = o_25.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = spuvs_22;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_4 = tmpvar_5.xyz;
  baseTexColor_2 = tmpvar_4;
  outColor_3.xyz = (mix (baseTexColor_2, (baseTexColor_2 * _EmissionScaler), vec3(mix (_EmissionFactor, tmpvar_5.w, _EmissionFactorFromTexToggle))) * _MainColor.xyz);
  outColor_3.w = xlv_COLOR1.y;
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_7;
  mediump vec3 reflection_8;
  mediump vec3 R_9;
  mediump float intensity_10;
  mediump vec4 noiseTex_11;
  mediump vec4 spColor_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_12.xyz = tmpvar_13.xyz;
  spColor_12.w = outColor_3.w;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (((1.99 * noiseTex_11.x) * _SPNoiseScaler) - 1.0);
  intensity_10 = tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 I_17;
  I_17 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_11 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_16 = (I_17 - (2.0 * (
    dot (tmpvar_6, I_17)
   * tmpvar_6)));
  R_9 = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = textureCube (_SPCubeMap, R_9).xyz;
  reflection_8 = tmpvar_18;
  highp vec3 tmpvar_19;
  mediump vec3 x_20;
  x_20 = (spColor_12.xyz * _SPOldColor.xyz);
  tmpvar_19 = mix (x_20, ((reflection_8 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_12.xyz = tmpvar_19;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_10 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_10 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_21;
      tmpvar_21 = mix (spColor_12, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_10) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_12 = tmpvar_21;
    };
  };
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (outColor_3.xyz, spColor_12.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_12.xyz = tmpvar_22;
  outColor_3.xyz = spColor_12.xyz;
  outColor_3.w = clamp (spColor_12.w, 0.0, 1.0);
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
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 90889
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
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
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
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
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = (vertex_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (tmpvar_7.x + (tmpvar_7.z * tmpvar_7.z));
  tmpvar_8.y = ((tmpvar_7.y + (0.5 * tmpvar_7.z)) + ((0.5 * tmpvar_7.x) * tmpvar_7.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((tmpvar_8 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  mediump float intensity_3;
  mediump float outBloomFactor_4;
  outBloomFactor_4 = color_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_3 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_3 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_7;
    tmpvar_7 = mix (color_1.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_3) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_4 = tmpvar_7;
  } else {
    if ((intensity_3 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_4 = (outBloomFactor_4 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_4;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = (vertex_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (tmpvar_7.x + (tmpvar_7.z * tmpvar_7.z));
  tmpvar_8.y = ((tmpvar_7.y + (0.5 * tmpvar_7.z)) + ((0.5 * tmpvar_7.x) * tmpvar_7.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((tmpvar_8 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  mediump float intensity_3;
  mediump float outBloomFactor_4;
  outBloomFactor_4 = color_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_3 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_3 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_7;
    tmpvar_7 = mix (color_1.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_3) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_4 = tmpvar_7;
  } else {
    if ((intensity_3 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_4 = (outBloomFactor_4 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_4;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = (vertex_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (tmpvar_7.x + (tmpvar_7.z * tmpvar_7.z));
  tmpvar_8.y = ((tmpvar_7.y + (0.5 * tmpvar_7.z)) + ((0.5 * tmpvar_7.x) * tmpvar_7.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((tmpvar_8 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  mediump float intensity_3;
  mediump float outBloomFactor_4;
  outBloomFactor_4 = color_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_3 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_3 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_7;
    tmpvar_7 = mix (color_1.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_3) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_4 = tmpvar_7;
  } else {
    if ((intensity_3 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_4 = (outBloomFactor_4 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_4;
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
CustomEditor "MoleMole.PropShaderEditorBase"
}