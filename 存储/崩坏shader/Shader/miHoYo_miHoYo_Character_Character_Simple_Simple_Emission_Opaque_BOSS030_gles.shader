//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Simple/Simple_Emission_Opaque_BOSS030" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_EmissionColor ("Emmisive Color", Color) = (0.5,0.5,0.5,1)
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Outline ("Outline Width", Float) = 0.02
[Toggle] _OutlineUseTangent ("Use Tangent For Outline", Float) = 0
_SpecMulti ("Specular Multiply", Float) = 1
_Shininess ("Shininess", Range(0.1, 100)) = 2
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_Ramp ("Toon Ramp (RGB)", 2D) = "white" { }
_SpecRamp ("Specular Ramp (RGB)", 2D) = "black" { }
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_Emission ("Emission", Range(1, 100)) = 1
_EmissionBloomFactor ("Emission Bloom Factor", Float) = 1
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
[Toggle(RIM_GLOW)] _RimGlow ("Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DTTex ("Distortion Tex", 2D) = "gray" { }
_DTIntensity ("Distortion Intensity", Range(1, 9)) = 5
_DTPlaySpeed ("Distortion Play Speed", Float) = 0
_DTNormalDisplacment ("Distortion Normal Displacment", Float) = 0
_DTUVScaleInX ("Distortion UV Scale in X", Float) = 1
_DTUVScaleInY ("Distortion UV Scale in Y", Float) = 1
_DTFresnel ("Distortion Fresnel Params", Vector) = (1,1,0,0)
[Toggle(TRANSPARENT)] _Transparent ("Transparent", Float) = 0
_MainAlpha ("Main Alpha Range(0, 1)", Range(0, 1)) = 1
_AdditiveLightIntensity ("Addtive Light Intensity", Range(0, 5)) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Simple" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 26659
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_glesNormal * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = ((dot (tmpvar_11, tmpvar_9.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_3 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_2;
  };
  s_2 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = tmpvar_15;
  highp vec2 posInViewPort_17;
  posInViewPort_17 = (tmpvar_7.xy / tmpvar_7.w);
  highp float tmpvar_18;
  tmpvar_18 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_17, posInViewPort_17)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_1 = tmpvar_18;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_19.xyw;
  tmpvar_6.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_6.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_6.z = 1.0;
  };
  tmpvar_4.w = (alpha_1 * _Opaqueness);
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = xlv_COLOR0.w;
  highp vec4 scrpos_12;
  scrpos_12 = xlv_TEXCOORD6;
  mediump float a_13;
  a_13 = xlv_TEXCOORD6.z;
  if ((a_13 < 0.95)) {
    scrpos_12.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_13 = (a_13 * 17.0);
    highp float tmpvar_14;
    tmpvar_14 = (scrpos_12.y / 4.0);
    highp float tmpvar_15;
    tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
    highp float tmpvar_16;
    if ((tmpvar_14 >= 0.0)) {
      tmpvar_16 = tmpvar_15;
    } else {
      tmpvar_16 = -(tmpvar_15);
    };
    highp float tmpvar_17;
    tmpvar_17 = (scrpos_12.x / 4.0);
    highp float tmpvar_18;
    tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
    highp float tmpvar_19;
    if ((tmpvar_17 >= 0.0)) {
      tmpvar_19 = tmpvar_18;
    } else {
      tmpvar_19 = -(tmpvar_18);
    };
    highp float x_20;
    x_20 = ((a_13 - _DITHERMATRIX[
      int(tmpvar_16)
    ][
      int(tmpvar_19)
    ]) - 0.01);
    if ((x_20 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = _BloomFactor;
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_glesNormal * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = ((dot (tmpvar_11, tmpvar_9.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_3 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_2;
  };
  s_2 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = tmpvar_15;
  highp vec2 posInViewPort_17;
  posInViewPort_17 = (tmpvar_7.xy / tmpvar_7.w);
  highp float tmpvar_18;
  tmpvar_18 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_17, posInViewPort_17)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_1 = tmpvar_18;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_19.xyw;
  tmpvar_6.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_6.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_6.z = 1.0;
  };
  tmpvar_4.w = (alpha_1 * _Opaqueness);
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = xlv_COLOR0.w;
  highp vec4 scrpos_12;
  scrpos_12 = xlv_TEXCOORD6;
  mediump float a_13;
  a_13 = xlv_TEXCOORD6.z;
  if ((a_13 < 0.95)) {
    scrpos_12.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_13 = (a_13 * 17.0);
    highp float tmpvar_14;
    tmpvar_14 = (scrpos_12.y / 4.0);
    highp float tmpvar_15;
    tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
    highp float tmpvar_16;
    if ((tmpvar_14 >= 0.0)) {
      tmpvar_16 = tmpvar_15;
    } else {
      tmpvar_16 = -(tmpvar_15);
    };
    highp float tmpvar_17;
    tmpvar_17 = (scrpos_12.x / 4.0);
    highp float tmpvar_18;
    tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
    highp float tmpvar_19;
    if ((tmpvar_17 >= 0.0)) {
      tmpvar_19 = tmpvar_18;
    } else {
      tmpvar_19 = -(tmpvar_18);
    };
    highp float x_20;
    x_20 = ((a_13 - _DITHERMATRIX[
      int(tmpvar_16)
    ][
      int(tmpvar_19)
    ]) - 0.01);
    if ((x_20 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = _BloomFactor;
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_glesNormal * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = ((dot (tmpvar_11, tmpvar_9.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_3 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_2;
  };
  s_2 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = tmpvar_15;
  highp vec2 posInViewPort_17;
  posInViewPort_17 = (tmpvar_7.xy / tmpvar_7.w);
  highp float tmpvar_18;
  tmpvar_18 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_17, posInViewPort_17)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_1 = tmpvar_18;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_19.xyw;
  tmpvar_6.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_6.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_6.z = 1.0;
  };
  tmpvar_4.w = (alpha_1 * _Opaqueness);
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = xlv_COLOR0.w;
  highp vec4 scrpos_12;
  scrpos_12 = xlv_TEXCOORD6;
  mediump float a_13;
  a_13 = xlv_TEXCOORD6.z;
  if ((a_13 < 0.95)) {
    scrpos_12.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_13 = (a_13 * 17.0);
    highp float tmpvar_14;
    tmpvar_14 = (scrpos_12.y / 4.0);
    highp float tmpvar_15;
    tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
    highp float tmpvar_16;
    if ((tmpvar_14 >= 0.0)) {
      tmpvar_16 = tmpvar_15;
    } else {
      tmpvar_16 = -(tmpvar_15);
    };
    highp float tmpvar_17;
    tmpvar_17 = (scrpos_12.x / 4.0);
    highp float tmpvar_18;
    tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
    highp float tmpvar_19;
    if ((tmpvar_17 >= 0.0)) {
      tmpvar_19 = tmpvar_18;
    } else {
      tmpvar_19 = -(tmpvar_18);
    };
    highp float x_20;
    x_20 = ((a_13 - _DITHERMATRIX[
      int(tmpvar_16)
    ][
      int(tmpvar_19)
    ]) - 0.01);
    if ((x_20 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = _BloomFactor;
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
uniform mediump float _AdditiveLightIntensity;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(normalize((_glesNormal * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = ((dot (tmpvar_12, tmpvar_10.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = d_3;
  tmpvar_14.y = d_3;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_16;
  tmpvar_16 = pow (max (dot (tmpvar_12, 
    normalize((tmpvar_10.xyz + normalize((_WorldSpaceCameraPos - tmpvar_15.xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_16;
  mediump float tmpvar_17;
  if ((d_3 < 0.5)) {
    tmpvar_17 = 0.025;
  } else {
    tmpvar_17 = s_2;
  };
  s_2 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17;
  tmpvar_18.y = tmpvar_17;
  highp vec2 posInViewPort_19;
  posInViewPort_19 = (tmpvar_8.xy / tmpvar_8.w);
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_19, posInViewPort_19)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_1 = tmpvar_20;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_21.xyw;
  tmpvar_6.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_6.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_6.z = 1.0;
  };
  tmpvar_4.w = (alpha_1 * _Opaqueness);
  mediump vec3 tmpvar_24;
  highp vec3 lightColor0_25;
  lightColor0_25 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_26;
  lightColor1_26 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_27;
  lightColor2_27 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_28;
  lightColor3_28 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_29;
  lightAttenSq_29 = unity_4LightAtten0;
  highp vec3 col_30;
  highp vec4 ndotl_31;
  highp vec4 lengthSq_32;
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_32 = (tmpvar_33 * tmpvar_33);
  lengthSq_32 = (lengthSq_32 + (tmpvar_34 * tmpvar_34));
  lengthSq_32 = (lengthSq_32 + (tmpvar_35 * tmpvar_35));
  highp vec4 tmpvar_36;
  tmpvar_36 = max (lengthSq_32, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_32 = tmpvar_36;
  ndotl_31 = (tmpvar_33 * tmpvar_12.x);
  ndotl_31 = (ndotl_31 + (tmpvar_34 * tmpvar_12.y));
  ndotl_31 = (ndotl_31 + (tmpvar_35 * tmpvar_12.z));
  highp vec4 tmpvar_37;
  tmpvar_37 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_31 * inversesqrt(tmpvar_36)));
  ndotl_31 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = (tmpvar_37 * (1.0/((1.0 + 
    (tmpvar_36 * lightAttenSq_29)
  ))));
  col_30 = (lightColor0_25 * tmpvar_38.x);
  col_30 = (col_30 + (lightColor1_26 * tmpvar_38.y));
  col_30 = (col_30 + (lightColor2_27 * tmpvar_38.z));
  col_30 = (col_30 + (lightColor3_28 * tmpvar_38.w));
  tmpvar_24 = col_30;
  tmpvar_7.xyz = (tmpvar_24 * _AdditiveLightIntensity);
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = xlv_COLOR0.w;
  outColor_5.xyz = (outColor_5.xyz + (outColor_5.xyz * xlv_TEXCOORD7.xyz));
  highp vec4 scrpos_12;
  scrpos_12 = xlv_TEXCOORD6;
  mediump float a_13;
  a_13 = xlv_TEXCOORD6.z;
  if ((a_13 < 0.95)) {
    scrpos_12.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_13 = (a_13 * 17.0);
    highp float tmpvar_14;
    tmpvar_14 = (scrpos_12.y / 4.0);
    highp float tmpvar_15;
    tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
    highp float tmpvar_16;
    if ((tmpvar_14 >= 0.0)) {
      tmpvar_16 = tmpvar_15;
    } else {
      tmpvar_16 = -(tmpvar_15);
    };
    highp float tmpvar_17;
    tmpvar_17 = (scrpos_12.x / 4.0);
    highp float tmpvar_18;
    tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
    highp float tmpvar_19;
    if ((tmpvar_17 >= 0.0)) {
      tmpvar_19 = tmpvar_18;
    } else {
      tmpvar_19 = -(tmpvar_18);
    };
    highp float x_20;
    x_20 = ((a_13 - _DITHERMATRIX[
      int(tmpvar_16)
    ][
      int(tmpvar_19)
    ]) - 0.01);
    if ((x_20 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = _BloomFactor;
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
uniform mediump float _AdditiveLightIntensity;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(normalize((_glesNormal * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = ((dot (tmpvar_12, tmpvar_10.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = d_3;
  tmpvar_14.y = d_3;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_16;
  tmpvar_16 = pow (max (dot (tmpvar_12, 
    normalize((tmpvar_10.xyz + normalize((_WorldSpaceCameraPos - tmpvar_15.xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_16;
  mediump float tmpvar_17;
  if ((d_3 < 0.5)) {
    tmpvar_17 = 0.025;
  } else {
    tmpvar_17 = s_2;
  };
  s_2 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17;
  tmpvar_18.y = tmpvar_17;
  highp vec2 posInViewPort_19;
  posInViewPort_19 = (tmpvar_8.xy / tmpvar_8.w);
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_19, posInViewPort_19)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_1 = tmpvar_20;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_21.xyw;
  tmpvar_6.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_6.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_6.z = 1.0;
  };
  tmpvar_4.w = (alpha_1 * _Opaqueness);
  mediump vec3 tmpvar_24;
  highp vec3 lightColor0_25;
  lightColor0_25 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_26;
  lightColor1_26 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_27;
  lightColor2_27 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_28;
  lightColor3_28 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_29;
  lightAttenSq_29 = unity_4LightAtten0;
  highp vec3 col_30;
  highp vec4 ndotl_31;
  highp vec4 lengthSq_32;
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_32 = (tmpvar_33 * tmpvar_33);
  lengthSq_32 = (lengthSq_32 + (tmpvar_34 * tmpvar_34));
  lengthSq_32 = (lengthSq_32 + (tmpvar_35 * tmpvar_35));
  highp vec4 tmpvar_36;
  tmpvar_36 = max (lengthSq_32, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_32 = tmpvar_36;
  ndotl_31 = (tmpvar_33 * tmpvar_12.x);
  ndotl_31 = (ndotl_31 + (tmpvar_34 * tmpvar_12.y));
  ndotl_31 = (ndotl_31 + (tmpvar_35 * tmpvar_12.z));
  highp vec4 tmpvar_37;
  tmpvar_37 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_31 * inversesqrt(tmpvar_36)));
  ndotl_31 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = (tmpvar_37 * (1.0/((1.0 + 
    (tmpvar_36 * lightAttenSq_29)
  ))));
  col_30 = (lightColor0_25 * tmpvar_38.x);
  col_30 = (col_30 + (lightColor1_26 * tmpvar_38.y));
  col_30 = (col_30 + (lightColor2_27 * tmpvar_38.z));
  col_30 = (col_30 + (lightColor3_28 * tmpvar_38.w));
  tmpvar_24 = col_30;
  tmpvar_7.xyz = (tmpvar_24 * _AdditiveLightIntensity);
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = xlv_COLOR0.w;
  outColor_5.xyz = (outColor_5.xyz + (outColor_5.xyz * xlv_TEXCOORD7.xyz));
  highp vec4 scrpos_12;
  scrpos_12 = xlv_TEXCOORD6;
  mediump float a_13;
  a_13 = xlv_TEXCOORD6.z;
  if ((a_13 < 0.95)) {
    scrpos_12.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_13 = (a_13 * 17.0);
    highp float tmpvar_14;
    tmpvar_14 = (scrpos_12.y / 4.0);
    highp float tmpvar_15;
    tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
    highp float tmpvar_16;
    if ((tmpvar_14 >= 0.0)) {
      tmpvar_16 = tmpvar_15;
    } else {
      tmpvar_16 = -(tmpvar_15);
    };
    highp float tmpvar_17;
    tmpvar_17 = (scrpos_12.x / 4.0);
    highp float tmpvar_18;
    tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
    highp float tmpvar_19;
    if ((tmpvar_17 >= 0.0)) {
      tmpvar_19 = tmpvar_18;
    } else {
      tmpvar_19 = -(tmpvar_18);
    };
    highp float x_20;
    x_20 = ((a_13 - _DITHERMATRIX[
      int(tmpvar_16)
    ][
      int(tmpvar_19)
    ]) - 0.01);
    if ((x_20 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = _BloomFactor;
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
uniform mediump float _AdditiveLightIntensity;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(normalize((_glesNormal * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = ((dot (tmpvar_12, tmpvar_10.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = d_3;
  tmpvar_14.y = d_3;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_16;
  tmpvar_16 = pow (max (dot (tmpvar_12, 
    normalize((tmpvar_10.xyz + normalize((_WorldSpaceCameraPos - tmpvar_15.xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_16;
  mediump float tmpvar_17;
  if ((d_3 < 0.5)) {
    tmpvar_17 = 0.025;
  } else {
    tmpvar_17 = s_2;
  };
  s_2 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17;
  tmpvar_18.y = tmpvar_17;
  highp vec2 posInViewPort_19;
  posInViewPort_19 = (tmpvar_8.xy / tmpvar_8.w);
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_19, posInViewPort_19)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_1 = tmpvar_20;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_21.xyw;
  tmpvar_6.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_6.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_6.z = 1.0;
  };
  tmpvar_4.w = (alpha_1 * _Opaqueness);
  mediump vec3 tmpvar_24;
  highp vec3 lightColor0_25;
  lightColor0_25 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_26;
  lightColor1_26 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_27;
  lightColor2_27 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_28;
  lightColor3_28 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_29;
  lightAttenSq_29 = unity_4LightAtten0;
  highp vec3 col_30;
  highp vec4 ndotl_31;
  highp vec4 lengthSq_32;
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_32 = (tmpvar_33 * tmpvar_33);
  lengthSq_32 = (lengthSq_32 + (tmpvar_34 * tmpvar_34));
  lengthSq_32 = (lengthSq_32 + (tmpvar_35 * tmpvar_35));
  highp vec4 tmpvar_36;
  tmpvar_36 = max (lengthSq_32, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_32 = tmpvar_36;
  ndotl_31 = (tmpvar_33 * tmpvar_12.x);
  ndotl_31 = (ndotl_31 + (tmpvar_34 * tmpvar_12.y));
  ndotl_31 = (ndotl_31 + (tmpvar_35 * tmpvar_12.z));
  highp vec4 tmpvar_37;
  tmpvar_37 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_31 * inversesqrt(tmpvar_36)));
  ndotl_31 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = (tmpvar_37 * (1.0/((1.0 + 
    (tmpvar_36 * lightAttenSq_29)
  ))));
  col_30 = (lightColor0_25 * tmpvar_38.x);
  col_30 = (col_30 + (lightColor1_26 * tmpvar_38.y));
  col_30 = (col_30 + (lightColor2_27 * tmpvar_38.z));
  col_30 = (col_30 + (lightColor3_28 * tmpvar_38.w));
  tmpvar_24 = col_30;
  tmpvar_7.xyz = (tmpvar_24 * _AdditiveLightIntensity);
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = xlv_COLOR0.w;
  outColor_5.xyz = (outColor_5.xyz + (outColor_5.xyz * xlv_TEXCOORD7.xyz));
  highp vec4 scrpos_12;
  scrpos_12 = xlv_TEXCOORD6;
  mediump float a_13;
  a_13 = xlv_TEXCOORD6.z;
  if ((a_13 < 0.95)) {
    scrpos_12.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_13 = (a_13 * 17.0);
    highp float tmpvar_14;
    tmpvar_14 = (scrpos_12.y / 4.0);
    highp float tmpvar_15;
    tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
    highp float tmpvar_16;
    if ((tmpvar_14 >= 0.0)) {
      tmpvar_16 = tmpvar_15;
    } else {
      tmpvar_16 = -(tmpvar_15);
    };
    highp float tmpvar_17;
    tmpvar_17 = (scrpos_12.x / 4.0);
    highp float tmpvar_18;
    tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
    highp float tmpvar_19;
    if ((tmpvar_17 >= 0.0)) {
      tmpvar_19 = tmpvar_18;
    } else {
      tmpvar_19 = -(tmpvar_18);
    };
    highp float x_20;
    x_20 = ((a_13 - _DITHERMATRIX[
      int(tmpvar_16)
    ][
      int(tmpvar_19)
    ]) - 0.01);
    if ((x_20 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = _BloomFactor;
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_glesNormal * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = ((dot (tmpvar_11, tmpvar_9.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp float tmpvar_15;
  tmpvar_15 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + tmpvar_14))
  ), 0.0), _Shininess);
  s_2 = tmpvar_15;
  mediump float tmpvar_16;
  if ((d_3 < 0.5)) {
    tmpvar_16 = 0.025;
  } else {
    tmpvar_16 = s_2;
  };
  s_2 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = tmpvar_16;
  highp vec2 posInViewPort_18;
  posInViewPort_18 = (tmpvar_7.xy / tmpvar_7.w);
  highp float tmpvar_19;
  tmpvar_19 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_18, posInViewPort_18)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_1 = tmpvar_19;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_20.xyw;
  tmpvar_6.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_6.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_6.z = 1.0;
  };
  tmpvar_4.w = (alpha_1 * _Opaqueness);
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = xlv_COLOR0.w;
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_13 = (_RGBias + (tmpvar_14 * _RGScale));
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _RGColor).xyz;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (tmpvar_13, 0.0, 1.0);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (outColor_5.xyz, tmpvar_15, vec3((tmpvar_16 * _RGRatio)));
  tmpvar_12 = tmpvar_17;
  outColor_5.xyz = tmpvar_12;
  highp vec4 scrpos_18;
  scrpos_18 = xlv_TEXCOORD6;
  mediump float a_19;
  a_19 = xlv_TEXCOORD6.z;
  if ((a_19 < 0.95)) {
    scrpos_18.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_19 = (a_19 * 17.0);
    highp float tmpvar_20;
    tmpvar_20 = (scrpos_18.y / 4.0);
    highp float tmpvar_21;
    tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
    highp float tmpvar_22;
    if ((tmpvar_20 >= 0.0)) {
      tmpvar_22 = tmpvar_21;
    } else {
      tmpvar_22 = -(tmpvar_21);
    };
    highp float tmpvar_23;
    tmpvar_23 = (scrpos_18.x / 4.0);
    highp float tmpvar_24;
    tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
    highp float tmpvar_25;
    if ((tmpvar_23 >= 0.0)) {
      tmpvar_25 = tmpvar_24;
    } else {
      tmpvar_25 = -(tmpvar_24);
    };
    highp float x_26;
    x_26 = ((a_19 - _DITHERMATRIX[
      int(tmpvar_22)
    ][
      int(tmpvar_25)
    ]) - 0.01);
    if ((x_26 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = _BloomFactor;
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_glesNormal * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = ((dot (tmpvar_11, tmpvar_9.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp float tmpvar_15;
  tmpvar_15 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + tmpvar_14))
  ), 0.0), _Shininess);
  s_2 = tmpvar_15;
  mediump float tmpvar_16;
  if ((d_3 < 0.5)) {
    tmpvar_16 = 0.025;
  } else {
    tmpvar_16 = s_2;
  };
  s_2 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = tmpvar_16;
  highp vec2 posInViewPort_18;
  posInViewPort_18 = (tmpvar_7.xy / tmpvar_7.w);
  highp float tmpvar_19;
  tmpvar_19 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_18, posInViewPort_18)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_1 = tmpvar_19;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_20.xyw;
  tmpvar_6.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_6.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_6.z = 1.0;
  };
  tmpvar_4.w = (alpha_1 * _Opaqueness);
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = xlv_COLOR0.w;
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_13 = (_RGBias + (tmpvar_14 * _RGScale));
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _RGColor).xyz;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (tmpvar_13, 0.0, 1.0);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (outColor_5.xyz, tmpvar_15, vec3((tmpvar_16 * _RGRatio)));
  tmpvar_12 = tmpvar_17;
  outColor_5.xyz = tmpvar_12;
  highp vec4 scrpos_18;
  scrpos_18 = xlv_TEXCOORD6;
  mediump float a_19;
  a_19 = xlv_TEXCOORD6.z;
  if ((a_19 < 0.95)) {
    scrpos_18.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_19 = (a_19 * 17.0);
    highp float tmpvar_20;
    tmpvar_20 = (scrpos_18.y / 4.0);
    highp float tmpvar_21;
    tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
    highp float tmpvar_22;
    if ((tmpvar_20 >= 0.0)) {
      tmpvar_22 = tmpvar_21;
    } else {
      tmpvar_22 = -(tmpvar_21);
    };
    highp float tmpvar_23;
    tmpvar_23 = (scrpos_18.x / 4.0);
    highp float tmpvar_24;
    tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
    highp float tmpvar_25;
    if ((tmpvar_23 >= 0.0)) {
      tmpvar_25 = tmpvar_24;
    } else {
      tmpvar_25 = -(tmpvar_24);
    };
    highp float x_26;
    x_26 = ((a_19 - _DITHERMATRIX[
      int(tmpvar_22)
    ][
      int(tmpvar_25)
    ]) - 0.01);
    if ((x_26 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = _BloomFactor;
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_glesNormal * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = ((dot (tmpvar_11, tmpvar_9.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp float tmpvar_15;
  tmpvar_15 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + tmpvar_14))
  ), 0.0), _Shininess);
  s_2 = tmpvar_15;
  mediump float tmpvar_16;
  if ((d_3 < 0.5)) {
    tmpvar_16 = 0.025;
  } else {
    tmpvar_16 = s_2;
  };
  s_2 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = tmpvar_16;
  highp vec2 posInViewPort_18;
  posInViewPort_18 = (tmpvar_7.xy / tmpvar_7.w);
  highp float tmpvar_19;
  tmpvar_19 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_18, posInViewPort_18)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_1 = tmpvar_19;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_20.xyw;
  tmpvar_6.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_6.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_6.z = 1.0;
  };
  tmpvar_4.w = (alpha_1 * _Opaqueness);
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = xlv_COLOR0.w;
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_13 = (_RGBias + (tmpvar_14 * _RGScale));
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _RGColor).xyz;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (tmpvar_13, 0.0, 1.0);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (outColor_5.xyz, tmpvar_15, vec3((tmpvar_16 * _RGRatio)));
  tmpvar_12 = tmpvar_17;
  outColor_5.xyz = tmpvar_12;
  highp vec4 scrpos_18;
  scrpos_18 = xlv_TEXCOORD6;
  mediump float a_19;
  a_19 = xlv_TEXCOORD6.z;
  if ((a_19 < 0.95)) {
    scrpos_18.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_19 = (a_19 * 17.0);
    highp float tmpvar_20;
    tmpvar_20 = (scrpos_18.y / 4.0);
    highp float tmpvar_21;
    tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
    highp float tmpvar_22;
    if ((tmpvar_20 >= 0.0)) {
      tmpvar_22 = tmpvar_21;
    } else {
      tmpvar_22 = -(tmpvar_21);
    };
    highp float tmpvar_23;
    tmpvar_23 = (scrpos_18.x / 4.0);
    highp float tmpvar_24;
    tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
    highp float tmpvar_25;
    if ((tmpvar_23 >= 0.0)) {
      tmpvar_25 = tmpvar_24;
    } else {
      tmpvar_25 = -(tmpvar_24);
    };
    highp float x_26;
    x_26 = ((a_19 - _DITHERMATRIX[
      int(tmpvar_22)
    ][
      int(tmpvar_25)
    ]) - 0.01);
    if ((x_26 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = _BloomFactor;
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
uniform mediump float _AdditiveLightIntensity;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(normalize((_glesNormal * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = ((dot (tmpvar_12, tmpvar_10.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = d_3;
  tmpvar_14.y = d_3;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - tmpvar_15.xyz));
  highp float tmpvar_17;
  tmpvar_17 = pow (max (dot (tmpvar_12, 
    normalize((tmpvar_10.xyz + tmpvar_16))
  ), 0.0), _Shininess);
  s_2 = tmpvar_17;
  mediump float tmpvar_18;
  if ((d_3 < 0.5)) {
    tmpvar_18 = 0.025;
  } else {
    tmpvar_18 = s_2;
  };
  s_2 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18;
  tmpvar_19.y = tmpvar_18;
  highp vec2 posInViewPort_20;
  posInViewPort_20 = (tmpvar_8.xy / tmpvar_8.w);
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_20, posInViewPort_20)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_1 = tmpvar_21;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_22.xyw;
  tmpvar_6.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_6.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_6.z = 1.0;
  };
  tmpvar_4.w = (alpha_1 * _Opaqueness);
  mediump vec3 tmpvar_25;
  highp vec3 lightColor0_26;
  lightColor0_26 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_27;
  lightColor1_27 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_28;
  lightColor2_28 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_29;
  lightColor3_29 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_30;
  lightAttenSq_30 = unity_4LightAtten0;
  highp vec3 col_31;
  highp vec4 ndotl_32;
  highp vec4 lengthSq_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_33 = (tmpvar_34 * tmpvar_34);
  lengthSq_33 = (lengthSq_33 + (tmpvar_35 * tmpvar_35));
  lengthSq_33 = (lengthSq_33 + (tmpvar_36 * tmpvar_36));
  highp vec4 tmpvar_37;
  tmpvar_37 = max (lengthSq_33, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_33 = tmpvar_37;
  ndotl_32 = (tmpvar_34 * tmpvar_12.x);
  ndotl_32 = (ndotl_32 + (tmpvar_35 * tmpvar_12.y));
  ndotl_32 = (ndotl_32 + (tmpvar_36 * tmpvar_12.z));
  highp vec4 tmpvar_38;
  tmpvar_38 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_32 * inversesqrt(tmpvar_37)));
  ndotl_32 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (tmpvar_38 * (1.0/((1.0 + 
    (tmpvar_37 * lightAttenSq_30)
  ))));
  col_31 = (lightColor0_26 * tmpvar_39.x);
  col_31 = (col_31 + (lightColor1_27 * tmpvar_39.y));
  col_31 = (col_31 + (lightColor2_28 * tmpvar_39.z));
  col_31 = (col_31 + (lightColor3_29 * tmpvar_39.w));
  tmpvar_25 = col_31;
  tmpvar_7.xyz = (tmpvar_25 * _AdditiveLightIntensity);
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = xlv_COLOR0.w;
  outColor_5.xyz = (outColor_5.xyz + (outColor_5.xyz * xlv_TEXCOORD7.xyz));
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_13 = (_RGBias + (tmpvar_14 * _RGScale));
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _RGColor).xyz;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (tmpvar_13, 0.0, 1.0);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (outColor_5.xyz, tmpvar_15, vec3((tmpvar_16 * _RGRatio)));
  tmpvar_12 = tmpvar_17;
  outColor_5.xyz = tmpvar_12;
  highp vec4 scrpos_18;
  scrpos_18 = xlv_TEXCOORD6;
  mediump float a_19;
  a_19 = xlv_TEXCOORD6.z;
  if ((a_19 < 0.95)) {
    scrpos_18.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_19 = (a_19 * 17.0);
    highp float tmpvar_20;
    tmpvar_20 = (scrpos_18.y / 4.0);
    highp float tmpvar_21;
    tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
    highp float tmpvar_22;
    if ((tmpvar_20 >= 0.0)) {
      tmpvar_22 = tmpvar_21;
    } else {
      tmpvar_22 = -(tmpvar_21);
    };
    highp float tmpvar_23;
    tmpvar_23 = (scrpos_18.x / 4.0);
    highp float tmpvar_24;
    tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
    highp float tmpvar_25;
    if ((tmpvar_23 >= 0.0)) {
      tmpvar_25 = tmpvar_24;
    } else {
      tmpvar_25 = -(tmpvar_24);
    };
    highp float x_26;
    x_26 = ((a_19 - _DITHERMATRIX[
      int(tmpvar_22)
    ][
      int(tmpvar_25)
    ]) - 0.01);
    if ((x_26 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = _BloomFactor;
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
uniform mediump float _AdditiveLightIntensity;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(normalize((_glesNormal * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = ((dot (tmpvar_12, tmpvar_10.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = d_3;
  tmpvar_14.y = d_3;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - tmpvar_15.xyz));
  highp float tmpvar_17;
  tmpvar_17 = pow (max (dot (tmpvar_12, 
    normalize((tmpvar_10.xyz + tmpvar_16))
  ), 0.0), _Shininess);
  s_2 = tmpvar_17;
  mediump float tmpvar_18;
  if ((d_3 < 0.5)) {
    tmpvar_18 = 0.025;
  } else {
    tmpvar_18 = s_2;
  };
  s_2 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18;
  tmpvar_19.y = tmpvar_18;
  highp vec2 posInViewPort_20;
  posInViewPort_20 = (tmpvar_8.xy / tmpvar_8.w);
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_20, posInViewPort_20)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_1 = tmpvar_21;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_22.xyw;
  tmpvar_6.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_6.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_6.z = 1.0;
  };
  tmpvar_4.w = (alpha_1 * _Opaqueness);
  mediump vec3 tmpvar_25;
  highp vec3 lightColor0_26;
  lightColor0_26 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_27;
  lightColor1_27 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_28;
  lightColor2_28 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_29;
  lightColor3_29 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_30;
  lightAttenSq_30 = unity_4LightAtten0;
  highp vec3 col_31;
  highp vec4 ndotl_32;
  highp vec4 lengthSq_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_33 = (tmpvar_34 * tmpvar_34);
  lengthSq_33 = (lengthSq_33 + (tmpvar_35 * tmpvar_35));
  lengthSq_33 = (lengthSq_33 + (tmpvar_36 * tmpvar_36));
  highp vec4 tmpvar_37;
  tmpvar_37 = max (lengthSq_33, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_33 = tmpvar_37;
  ndotl_32 = (tmpvar_34 * tmpvar_12.x);
  ndotl_32 = (ndotl_32 + (tmpvar_35 * tmpvar_12.y));
  ndotl_32 = (ndotl_32 + (tmpvar_36 * tmpvar_12.z));
  highp vec4 tmpvar_38;
  tmpvar_38 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_32 * inversesqrt(tmpvar_37)));
  ndotl_32 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (tmpvar_38 * (1.0/((1.0 + 
    (tmpvar_37 * lightAttenSq_30)
  ))));
  col_31 = (lightColor0_26 * tmpvar_39.x);
  col_31 = (col_31 + (lightColor1_27 * tmpvar_39.y));
  col_31 = (col_31 + (lightColor2_28 * tmpvar_39.z));
  col_31 = (col_31 + (lightColor3_29 * tmpvar_39.w));
  tmpvar_25 = col_31;
  tmpvar_7.xyz = (tmpvar_25 * _AdditiveLightIntensity);
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = xlv_COLOR0.w;
  outColor_5.xyz = (outColor_5.xyz + (outColor_5.xyz * xlv_TEXCOORD7.xyz));
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_13 = (_RGBias + (tmpvar_14 * _RGScale));
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _RGColor).xyz;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (tmpvar_13, 0.0, 1.0);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (outColor_5.xyz, tmpvar_15, vec3((tmpvar_16 * _RGRatio)));
  tmpvar_12 = tmpvar_17;
  outColor_5.xyz = tmpvar_12;
  highp vec4 scrpos_18;
  scrpos_18 = xlv_TEXCOORD6;
  mediump float a_19;
  a_19 = xlv_TEXCOORD6.z;
  if ((a_19 < 0.95)) {
    scrpos_18.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_19 = (a_19 * 17.0);
    highp float tmpvar_20;
    tmpvar_20 = (scrpos_18.y / 4.0);
    highp float tmpvar_21;
    tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
    highp float tmpvar_22;
    if ((tmpvar_20 >= 0.0)) {
      tmpvar_22 = tmpvar_21;
    } else {
      tmpvar_22 = -(tmpvar_21);
    };
    highp float tmpvar_23;
    tmpvar_23 = (scrpos_18.x / 4.0);
    highp float tmpvar_24;
    tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
    highp float tmpvar_25;
    if ((tmpvar_23 >= 0.0)) {
      tmpvar_25 = tmpvar_24;
    } else {
      tmpvar_25 = -(tmpvar_24);
    };
    highp float x_26;
    x_26 = ((a_19 - _DITHERMATRIX[
      int(tmpvar_22)
    ][
      int(tmpvar_25)
    ]) - 0.01);
    if ((x_26 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = _BloomFactor;
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
uniform mediump float _AdditiveLightIntensity;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(normalize((_glesNormal * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = ((dot (tmpvar_12, tmpvar_10.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = d_3;
  tmpvar_14.y = d_3;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - tmpvar_15.xyz));
  highp float tmpvar_17;
  tmpvar_17 = pow (max (dot (tmpvar_12, 
    normalize((tmpvar_10.xyz + tmpvar_16))
  ), 0.0), _Shininess);
  s_2 = tmpvar_17;
  mediump float tmpvar_18;
  if ((d_3 < 0.5)) {
    tmpvar_18 = 0.025;
  } else {
    tmpvar_18 = s_2;
  };
  s_2 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18;
  tmpvar_19.y = tmpvar_18;
  highp vec2 posInViewPort_20;
  posInViewPort_20 = (tmpvar_8.xy / tmpvar_8.w);
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_20, posInViewPort_20)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_1 = tmpvar_21;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_22.xyw;
  tmpvar_6.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_6.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_6.z = 1.0;
  };
  tmpvar_4.w = (alpha_1 * _Opaqueness);
  mediump vec3 tmpvar_25;
  highp vec3 lightColor0_26;
  lightColor0_26 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_27;
  lightColor1_27 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_28;
  lightColor2_28 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_29;
  lightColor3_29 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_30;
  lightAttenSq_30 = unity_4LightAtten0;
  highp vec3 col_31;
  highp vec4 ndotl_32;
  highp vec4 lengthSq_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_33 = (tmpvar_34 * tmpvar_34);
  lengthSq_33 = (lengthSq_33 + (tmpvar_35 * tmpvar_35));
  lengthSq_33 = (lengthSq_33 + (tmpvar_36 * tmpvar_36));
  highp vec4 tmpvar_37;
  tmpvar_37 = max (lengthSq_33, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_33 = tmpvar_37;
  ndotl_32 = (tmpvar_34 * tmpvar_12.x);
  ndotl_32 = (ndotl_32 + (tmpvar_35 * tmpvar_12.y));
  ndotl_32 = (ndotl_32 + (tmpvar_36 * tmpvar_12.z));
  highp vec4 tmpvar_38;
  tmpvar_38 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_32 * inversesqrt(tmpvar_37)));
  ndotl_32 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (tmpvar_38 * (1.0/((1.0 + 
    (tmpvar_37 * lightAttenSq_30)
  ))));
  col_31 = (lightColor0_26 * tmpvar_39.x);
  col_31 = (col_31 + (lightColor1_27 * tmpvar_39.y));
  col_31 = (col_31 + (lightColor2_28 * tmpvar_39.z));
  col_31 = (col_31 + (lightColor3_29 * tmpvar_39.w));
  tmpvar_25 = col_31;
  tmpvar_7.xyz = (tmpvar_25 * _AdditiveLightIntensity);
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = xlv_COLOR0.w;
  outColor_5.xyz = (outColor_5.xyz + (outColor_5.xyz * xlv_TEXCOORD7.xyz));
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_13 = (_RGBias + (tmpvar_14 * _RGScale));
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _RGColor).xyz;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (tmpvar_13, 0.0, 1.0);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (outColor_5.xyz, tmpvar_15, vec3((tmpvar_16 * _RGRatio)));
  tmpvar_12 = tmpvar_17;
  outColor_5.xyz = tmpvar_12;
  highp vec4 scrpos_18;
  scrpos_18 = xlv_TEXCOORD6;
  mediump float a_19;
  a_19 = xlv_TEXCOORD6.z;
  if ((a_19 < 0.95)) {
    scrpos_18.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_19 = (a_19 * 17.0);
    highp float tmpvar_20;
    tmpvar_20 = (scrpos_18.y / 4.0);
    highp float tmpvar_21;
    tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
    highp float tmpvar_22;
    if ((tmpvar_20 >= 0.0)) {
      tmpvar_22 = tmpvar_21;
    } else {
      tmpvar_22 = -(tmpvar_21);
    };
    highp float tmpvar_23;
    tmpvar_23 = (scrpos_18.x / 4.0);
    highp float tmpvar_24;
    tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
    highp float tmpvar_25;
    if ((tmpvar_23 >= 0.0)) {
      tmpvar_25 = tmpvar_24;
    } else {
      tmpvar_25 = -(tmpvar_24);
    };
    highp float x_26;
    x_26 = ((a_19 - _DITHERMATRIX[
      int(tmpvar_22)
    ][
      int(tmpvar_25)
    ]) - 0.01);
    if ((x_26 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = _BloomFactor;
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float alpha_2;
  mediump float s_3;
  mediump float d_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = ((dot (tmpvar_13, tmpvar_11.xyz) * 0.4975) + 0.5);
  d_4 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = d_4;
  tmpvar_15.y = d_4;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_17;
  tmpvar_17 = pow (max (dot (tmpvar_13, 
    normalize((tmpvar_11.xyz + normalize((_WorldSpaceCameraPos - tmpvar_16.xyz))))
  ), 0.0), _Shininess);
  s_3 = tmpvar_17;
  mediump float tmpvar_18;
  if ((d_4 < 0.5)) {
    tmpvar_18 = 0.025;
  } else {
    tmpvar_18 = s_3;
  };
  s_3 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18;
  tmpvar_19.y = tmpvar_18;
  highp vec2 posInViewPort_20;
  posInViewPort_20 = (tmpvar_9.xy / tmpvar_9.w);
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_20, posInViewPort_20)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_2 = tmpvar_21;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_9.zw;
  tmpvar_8.xyw = o_22.xyw;
  tmpvar_8.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_8.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_8.z = 1.0;
  };
  tmpvar_5.w = (alpha_2 * _Opaqueness);
  highp vec2 uv_25;
  uv_25 = tmpvar_1;
  highp vec4 spuvs_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (_glesVertex * 0.5);
  spuvs_26.xy = ((uv_25 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_28;
  tmpvar_28.x = (tmpvar_27.x + (tmpvar_27.z * tmpvar_27.z));
  tmpvar_28.y = ((tmpvar_27.y + (0.5 * tmpvar_27.z)) + ((0.5 * tmpvar_27.x) * tmpvar_27.x));
  spuvs_26.zw = ((tmpvar_28 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_7 = (tmpvar_16.xyz / tmpvar_16.w);
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD3 = spuvs_26;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = xlv_COLOR0.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
  outColor_7 = spColor_20;
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_32 = (a_32 * 17.0);
    highp float tmpvar_33;
    tmpvar_33 = (scrpos_31.y / 4.0);
    highp float tmpvar_34;
    tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
    highp float tmpvar_35;
    if ((tmpvar_33 >= 0.0)) {
      tmpvar_35 = tmpvar_34;
    } else {
      tmpvar_35 = -(tmpvar_34);
    };
    highp float tmpvar_36;
    tmpvar_36 = (scrpos_31.x / 4.0);
    highp float tmpvar_37;
    tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
    highp float tmpvar_38;
    if ((tmpvar_36 >= 0.0)) {
      tmpvar_38 = tmpvar_37;
    } else {
      tmpvar_38 = -(tmpvar_37);
    };
    highp float x_39;
    x_39 = ((a_32 - _DITHERMATRIX[
      int(tmpvar_35)
    ][
      int(tmpvar_38)
    ]) - 0.01);
    if ((x_39 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = _BloomFactor;
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float alpha_2;
  mediump float s_3;
  mediump float d_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = ((dot (tmpvar_13, tmpvar_11.xyz) * 0.4975) + 0.5);
  d_4 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = d_4;
  tmpvar_15.y = d_4;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_17;
  tmpvar_17 = pow (max (dot (tmpvar_13, 
    normalize((tmpvar_11.xyz + normalize((_WorldSpaceCameraPos - tmpvar_16.xyz))))
  ), 0.0), _Shininess);
  s_3 = tmpvar_17;
  mediump float tmpvar_18;
  if ((d_4 < 0.5)) {
    tmpvar_18 = 0.025;
  } else {
    tmpvar_18 = s_3;
  };
  s_3 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18;
  tmpvar_19.y = tmpvar_18;
  highp vec2 posInViewPort_20;
  posInViewPort_20 = (tmpvar_9.xy / tmpvar_9.w);
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_20, posInViewPort_20)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_2 = tmpvar_21;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_9.zw;
  tmpvar_8.xyw = o_22.xyw;
  tmpvar_8.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_8.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_8.z = 1.0;
  };
  tmpvar_5.w = (alpha_2 * _Opaqueness);
  highp vec2 uv_25;
  uv_25 = tmpvar_1;
  highp vec4 spuvs_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (_glesVertex * 0.5);
  spuvs_26.xy = ((uv_25 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_28;
  tmpvar_28.x = (tmpvar_27.x + (tmpvar_27.z * tmpvar_27.z));
  tmpvar_28.y = ((tmpvar_27.y + (0.5 * tmpvar_27.z)) + ((0.5 * tmpvar_27.x) * tmpvar_27.x));
  spuvs_26.zw = ((tmpvar_28 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_7 = (tmpvar_16.xyz / tmpvar_16.w);
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD3 = spuvs_26;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = xlv_COLOR0.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
  outColor_7 = spColor_20;
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_32 = (a_32 * 17.0);
    highp float tmpvar_33;
    tmpvar_33 = (scrpos_31.y / 4.0);
    highp float tmpvar_34;
    tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
    highp float tmpvar_35;
    if ((tmpvar_33 >= 0.0)) {
      tmpvar_35 = tmpvar_34;
    } else {
      tmpvar_35 = -(tmpvar_34);
    };
    highp float tmpvar_36;
    tmpvar_36 = (scrpos_31.x / 4.0);
    highp float tmpvar_37;
    tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
    highp float tmpvar_38;
    if ((tmpvar_36 >= 0.0)) {
      tmpvar_38 = tmpvar_37;
    } else {
      tmpvar_38 = -(tmpvar_37);
    };
    highp float x_39;
    x_39 = ((a_32 - _DITHERMATRIX[
      int(tmpvar_35)
    ][
      int(tmpvar_38)
    ]) - 0.01);
    if ((x_39 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = _BloomFactor;
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float alpha_2;
  mediump float s_3;
  mediump float d_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = ((dot (tmpvar_13, tmpvar_11.xyz) * 0.4975) + 0.5);
  d_4 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = d_4;
  tmpvar_15.y = d_4;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_17;
  tmpvar_17 = pow (max (dot (tmpvar_13, 
    normalize((tmpvar_11.xyz + normalize((_WorldSpaceCameraPos - tmpvar_16.xyz))))
  ), 0.0), _Shininess);
  s_3 = tmpvar_17;
  mediump float tmpvar_18;
  if ((d_4 < 0.5)) {
    tmpvar_18 = 0.025;
  } else {
    tmpvar_18 = s_3;
  };
  s_3 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18;
  tmpvar_19.y = tmpvar_18;
  highp vec2 posInViewPort_20;
  posInViewPort_20 = (tmpvar_9.xy / tmpvar_9.w);
  highp float tmpvar_21;
  tmpvar_21 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_20, posInViewPort_20)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_2 = tmpvar_21;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_9.zw;
  tmpvar_8.xyw = o_22.xyw;
  tmpvar_8.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_8.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_8.z = 1.0;
  };
  tmpvar_5.w = (alpha_2 * _Opaqueness);
  highp vec2 uv_25;
  uv_25 = tmpvar_1;
  highp vec4 spuvs_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (_glesVertex * 0.5);
  spuvs_26.xy = ((uv_25 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_28;
  tmpvar_28.x = (tmpvar_27.x + (tmpvar_27.z * tmpvar_27.z));
  tmpvar_28.y = ((tmpvar_27.y + (0.5 * tmpvar_27.z)) + ((0.5 * tmpvar_27.x) * tmpvar_27.x));
  spuvs_26.zw = ((tmpvar_28 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_7 = (tmpvar_16.xyz / tmpvar_16.w);
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD3 = spuvs_26;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = xlv_COLOR0.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
  outColor_7 = spColor_20;
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_32 = (a_32 * 17.0);
    highp float tmpvar_33;
    tmpvar_33 = (scrpos_31.y / 4.0);
    highp float tmpvar_34;
    tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
    highp float tmpvar_35;
    if ((tmpvar_33 >= 0.0)) {
      tmpvar_35 = tmpvar_34;
    } else {
      tmpvar_35 = -(tmpvar_34);
    };
    highp float tmpvar_36;
    tmpvar_36 = (scrpos_31.x / 4.0);
    highp float tmpvar_37;
    tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
    highp float tmpvar_38;
    if ((tmpvar_36 >= 0.0)) {
      tmpvar_38 = tmpvar_37;
    } else {
      tmpvar_38 = -(tmpvar_37);
    };
    highp float x_39;
    x_39 = ((a_32 - _DITHERMATRIX[
      int(tmpvar_35)
    ][
      int(tmpvar_38)
    ]) - 0.01);
    if ((x_39 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = _BloomFactor;
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 30
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF3
    #define UNITY_PBS_USE_BRDF3 1
#endif
#ifndef UNITY_NO_FULL_STANDARD_SHADER
    #define UNITY_NO_FULL_STANDARD_SHADER 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER1
    #define UNITY_HARDWARE_TIER1 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef VERTEXLIGHT_ON
    #define VERTEXLIGHT_ON 1
#endif
#ifndef SPECIAL_STATE
    #define SPECIAL_STATE 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Color _glesColor
attribute vec4 _glesColor;
#define gl_Normal _glesNormal
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 54
struct v2f {
    highp vec4 position;
    highp vec4 color;
    mediump vec2 uv_MainTex;
    mediump vec2 dd;
    mediump vec2 ss;
    highp vec3 normal;
    highp vec4 spuvs;
    highp vec3 objPos;
    highp vec4 scrpos;
    highp vec4 vertexLightColor;
};
#line 46
struct appdata {
    highp vec4 position;
    highp vec3 normal;
    mediump vec2 uv_MainTex;
    highp vec4 color;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 20
uniform sampler2D _SPTex;
uniform sampler2D _SPTex_Alpha;
uniform highp vec4 _SPTex_ST;
uniform sampler2D _SPNoiseTex;
#line 24
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPEmissionScaler;
#line 28
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform mediump vec4 _SPOutlineColor;
#line 32
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
#line 36
uniform samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
#line 40
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
#line 46
#line 55
#line 65
#line 93
#line 125
#line 154
#line 178
#line 207
#line 238
#line 264
#line 284
#line 368
#line 403
#line 19
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform highp float _Opaqueness;
uniform sampler2D _MainTex;
#line 23
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _Ramp;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
#line 27
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform highp float _Shininess;
uniform mediump float _BloomFactor;
#line 31
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
#line 36
uniform mediump vec4 _ClipPlane;
uniform mediump float _MainAlpha;
#line 40
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
uniform mediump float _AdditiveLightIntensity;
#line 80
#line 136
#line 192
#line 244
#line 330
#line 255
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    #line 259
    highp vec4 toLightY = (lightPosY - pos.y);
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    #line 263
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    lengthSq += (toLightZ * toLightZ);
    #line 267
    lengthSq = max( lengthSq, vec4( 1e-06));
    highp vec4 ndotl = vec4( 0.0);
    #line 271
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    ndotl += (toLightZ * normal.z);
    #line 275
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 279
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    #line 283
    col += (lightColor1 * diff.y);
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 259
mediump vec3 ApplyPointLight( in highp vec3 worldPos, in highp vec3 worldNormal ) {
    return Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldNormal);
}
#line 785
highp vec4 ComputeNonStereoScreenPos( in highp vec4 pos ) {
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    #line 789
    return o;
}
#line 792
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 793
    highp vec4 o = ComputeNonStereoScreenPos( pos);
    #line 797
    return o;
}
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 175
highp vec3 UnityObjectToWorldNormal( in highp vec3 norm ) {
    #line 181
    return normalize((norm * xll_constructMat3_mf4x4( unity_WorldToObject)));
}
#line 17
highp float camera_fade2( in highp vec4 vertex, in highp float fadeOffset, in highp float fadeDistance, in highp vec2 posInViewPort, in highp float startAlpha ) {
    highp vec4 viewPos = (unity_MatrixMV * vertex);
    highp float dist = length(posInViewPort.xy);
    #line 21
    highp float rev_dist = (1.0 - xll_saturate_f(dist));
    highp float factor = ((((-viewPos.z) - _ProjectionParams.y) - fadeOffset) / ((fadeDistance * rev_dist) + 0.1));
    highp float fade = mix( startAlpha, 1.0, xll_saturate_f(factor));
    return fade;
}
#line 46
void spVert( in highp vec4 vertex, in highp vec2 uv, out highp vec4 spuvs ) {
    highp vec4 position = (vertex * 0.5);
    #line 50
    spuvs.xy = ((uv.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
    spuvs.zw = vec2( (position.x + (position.z * position.z)), ((position.y + (0.5 * position.z)) + ((0.5 * position.x) * position.x)));
    spuvs.zw = ((spuvs.zw.xy * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}
#line 80
v2f vert( in appdata in_data ) {
    v2f outData = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    #line 84
    outData.position = UnityObjectToClipPos( in_data.position);
    outData.uv_MainTex = ((in_data.uv_MainTex.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    #line 90
    highp vec3 L = vec3( normalize(_WorldSpaceLightPos0));
    highp vec3 N = normalize(UnityObjectToWorldNormal( in_data.normal));
    mediump float d = ((dot( N, L) * 0.4975) + 0.5);
    #line 94
    outData.dd = vec2( d, d);
    highp vec4 verPos = (unity_ObjectToWorld * in_data.position);
    #line 98
    highp vec3 V = (_WorldSpaceCameraPos - verPos.xyz);
    V = normalize(V);
    highp vec3 H = normalize((L + V));
    mediump float s = pow( max( dot( N, H), 0.0), _Shininess);
    #line 102
    s = (( (d < 0.5) ) ? ( 0.025 ) : ( s ));
    outData.ss = vec2( s, s);
    #line 106
    mediump float alpha = camera_fade2( in_data.position, _FadeOffset, _FadeDistance, (outData.position.xy / outData.position.w), 0.0);
    outData.scrpos = ComputeScreenPos( outData.position);
    outData.scrpos.z = _DitherAlphaRight;
    #line 110
    if ((in_data.color.x > 0.5)){
        outData.scrpos.z = _DitherAlphaLeft;
    }
    if ((in_data.color.x < 0.1)){
        outData.scrpos.z = 1.0;
    }
    #line 115
    outData.color.w = (alpha * _Opaqueness);
    outData.normal = N;
    #line 119
    spVert( in_data.position, in_data.uv_MainTex, outData.spuvs);
    highp vec4 objPos = verPos;
    outData.objPos = (objPos.xyz / objPos.w);
    #line 130
    outData.vertexLightColor.xyz = (ApplyPointLight( vec3( verPos), N) * _AdditiveLightIntensity);
    return outData;
}
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    appdata xlt_in_data;
    xlt_in_data.position = vec4(gl_Vertex);
    xlt_in_data.normal = vec3(gl_Normal);
    xlt_in_data.uv_MainTex = vec2(gl_MultiTexCoord0);
    xlt_in_data.color = vec4(gl_Color);
    xl_retval = vert( xlt_in_data);
    gl_Position = vec4(xl_retval.position);
    xlv_COLOR0 = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec2(xl_retval.uv_MainTex);
    xlv_TEXCOORD1 = vec2(xl_retval.dd);
    xlv_TEXCOORD2 = vec2(xl_retval.ss);
    xlv_TEXCOORD4 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec4(xl_retval.spuvs);
    xlv_TEXCOORD7 = vec3(xl_retval.objPos);
    xlv_TEXCOORD6 = vec4(xl_retval.scrpos);
    xlv_TEXCOORD7 = vec4(xl_retval.vertexLightColor);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(142,20): error: `xlv_TEXCOORD7' redeclared
(164,2): error: value of type vec4 cannot be assigned to variable of type vec3
*/

#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = xlv_COLOR0.w;
  outColor_7.xyz = (outColor_7.xyz + (outColor_7.xyz * xlv_TEXCOORD7.xyz));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7.xyz));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
  outColor_7 = spColor_20;
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_32 = (a_32 * 17.0);
    highp float tmpvar_33;
    tmpvar_33 = (scrpos_31.y / 4.0);
    highp float tmpvar_34;
    tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
    highp float tmpvar_35;
    if ((tmpvar_33 >= 0.0)) {
      tmpvar_35 = tmpvar_34;
    } else {
      tmpvar_35 = -(tmpvar_34);
    };
    highp float tmpvar_36;
    tmpvar_36 = (scrpos_31.x / 4.0);
    highp float tmpvar_37;
    tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
    highp float tmpvar_38;
    if ((tmpvar_36 >= 0.0)) {
      tmpvar_38 = tmpvar_37;
    } else {
      tmpvar_38 = -(tmpvar_37);
    };
    highp float x_39;
    x_39 = ((a_32 - _DITHERMATRIX[
      int(tmpvar_35)
    ][
      int(tmpvar_38)
    ]) - 0.01);
    if ((x_39 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = _BloomFactor;
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 30
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER2
    #define UNITY_HARDWARE_TIER2 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef VERTEXLIGHT_ON
    #define VERTEXLIGHT_ON 1
#endif
#ifndef SPECIAL_STATE
    #define SPECIAL_STATE 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Color _glesColor
attribute vec4 _glesColor;
#define gl_Normal _glesNormal
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 54
struct v2f {
    highp vec4 position;
    highp vec4 color;
    mediump vec2 uv_MainTex;
    mediump vec2 dd;
    mediump vec2 ss;
    highp vec3 normal;
    highp vec4 spuvs;
    highp vec3 objPos;
    highp vec4 scrpos;
    highp vec4 vertexLightColor;
};
#line 46
struct appdata {
    highp vec4 position;
    highp vec3 normal;
    mediump vec2 uv_MainTex;
    highp vec4 color;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 20
uniform sampler2D _SPTex;
uniform sampler2D _SPTex_Alpha;
uniform highp vec4 _SPTex_ST;
uniform sampler2D _SPNoiseTex;
#line 24
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPEmissionScaler;
#line 28
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform mediump vec4 _SPOutlineColor;
#line 32
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
#line 36
uniform samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
#line 40
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
#line 46
#line 55
#line 65
#line 93
#line 125
#line 154
#line 178
#line 207
#line 238
#line 264
#line 284
#line 368
#line 403
#line 19
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform highp float _Opaqueness;
uniform sampler2D _MainTex;
#line 23
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _Ramp;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
#line 27
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform highp float _Shininess;
uniform mediump float _BloomFactor;
#line 31
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
#line 36
uniform mediump vec4 _ClipPlane;
uniform mediump float _MainAlpha;
#line 40
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
uniform mediump float _AdditiveLightIntensity;
#line 80
#line 136
#line 192
#line 244
#line 330
#line 255
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    #line 259
    highp vec4 toLightY = (lightPosY - pos.y);
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    #line 263
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    lengthSq += (toLightZ * toLightZ);
    #line 267
    lengthSq = max( lengthSq, vec4( 1e-06));
    highp vec4 ndotl = vec4( 0.0);
    #line 271
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    ndotl += (toLightZ * normal.z);
    #line 275
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 279
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    #line 283
    col += (lightColor1 * diff.y);
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 259
mediump vec3 ApplyPointLight( in highp vec3 worldPos, in highp vec3 worldNormal ) {
    return Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldNormal);
}
#line 785
highp vec4 ComputeNonStereoScreenPos( in highp vec4 pos ) {
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    #line 789
    return o;
}
#line 792
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 793
    highp vec4 o = ComputeNonStereoScreenPos( pos);
    #line 797
    return o;
}
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 175
highp vec3 UnityObjectToWorldNormal( in highp vec3 norm ) {
    #line 181
    return normalize((norm * xll_constructMat3_mf4x4( unity_WorldToObject)));
}
#line 17
highp float camera_fade2( in highp vec4 vertex, in highp float fadeOffset, in highp float fadeDistance, in highp vec2 posInViewPort, in highp float startAlpha ) {
    highp vec4 viewPos = (unity_MatrixMV * vertex);
    highp float dist = length(posInViewPort.xy);
    #line 21
    highp float rev_dist = (1.0 - xll_saturate_f(dist));
    highp float factor = ((((-viewPos.z) - _ProjectionParams.y) - fadeOffset) / ((fadeDistance * rev_dist) + 0.1));
    highp float fade = mix( startAlpha, 1.0, xll_saturate_f(factor));
    return fade;
}
#line 46
void spVert( in highp vec4 vertex, in highp vec2 uv, out highp vec4 spuvs ) {
    highp vec4 position = (vertex * 0.5);
    #line 50
    spuvs.xy = ((uv.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
    spuvs.zw = vec2( (position.x + (position.z * position.z)), ((position.y + (0.5 * position.z)) + ((0.5 * position.x) * position.x)));
    spuvs.zw = ((spuvs.zw.xy * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}
#line 80
v2f vert( in appdata in_data ) {
    v2f outData = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    #line 84
    outData.position = UnityObjectToClipPos( in_data.position);
    outData.uv_MainTex = ((in_data.uv_MainTex.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    #line 90
    highp vec3 L = vec3( normalize(_WorldSpaceLightPos0));
    highp vec3 N = normalize(UnityObjectToWorldNormal( in_data.normal));
    mediump float d = ((dot( N, L) * 0.4975) + 0.5);
    #line 94
    outData.dd = vec2( d, d);
    highp vec4 verPos = (unity_ObjectToWorld * in_data.position);
    #line 98
    highp vec3 V = (_WorldSpaceCameraPos - verPos.xyz);
    V = normalize(V);
    highp vec3 H = normalize((L + V));
    mediump float s = pow( max( dot( N, H), 0.0), _Shininess);
    #line 102
    s = (( (d < 0.5) ) ? ( 0.025 ) : ( s ));
    outData.ss = vec2( s, s);
    #line 106
    mediump float alpha = camera_fade2( in_data.position, _FadeOffset, _FadeDistance, (outData.position.xy / outData.position.w), 0.0);
    outData.scrpos = ComputeScreenPos( outData.position);
    outData.scrpos.z = _DitherAlphaRight;
    #line 110
    if ((in_data.color.x > 0.5)){
        outData.scrpos.z = _DitherAlphaLeft;
    }
    if ((in_data.color.x < 0.1)){
        outData.scrpos.z = 1.0;
    }
    #line 115
    outData.color.w = (alpha * _Opaqueness);
    outData.normal = N;
    #line 119
    spVert( in_data.position, in_data.uv_MainTex, outData.spuvs);
    highp vec4 objPos = verPos;
    outData.objPos = (objPos.xyz / objPos.w);
    #line 130
    outData.vertexLightColor.xyz = (ApplyPointLight( vec3( verPos), N) * _AdditiveLightIntensity);
    return outData;
}
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    appdata xlt_in_data;
    xlt_in_data.position = vec4(gl_Vertex);
    xlt_in_data.normal = vec3(gl_Normal);
    xlt_in_data.uv_MainTex = vec2(gl_MultiTexCoord0);
    xlt_in_data.color = vec4(gl_Color);
    xl_retval = vert( xlt_in_data);
    gl_Position = vec4(xl_retval.position);
    xlv_COLOR0 = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec2(xl_retval.uv_MainTex);
    xlv_TEXCOORD1 = vec2(xl_retval.dd);
    xlv_TEXCOORD2 = vec2(xl_retval.ss);
    xlv_TEXCOORD4 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec4(xl_retval.spuvs);
    xlv_TEXCOORD7 = vec3(xl_retval.objPos);
    xlv_TEXCOORD6 = vec4(xl_retval.scrpos);
    xlv_TEXCOORD7 = vec4(xl_retval.vertexLightColor);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(142,20): error: `xlv_TEXCOORD7' redeclared
(164,2): error: value of type vec4 cannot be assigned to variable of type vec3
*/

#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = xlv_COLOR0.w;
  outColor_7.xyz = (outColor_7.xyz + (outColor_7.xyz * xlv_TEXCOORD7.xyz));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7.xyz));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
  outColor_7 = spColor_20;
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_32 = (a_32 * 17.0);
    highp float tmpvar_33;
    tmpvar_33 = (scrpos_31.y / 4.0);
    highp float tmpvar_34;
    tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
    highp float tmpvar_35;
    if ((tmpvar_33 >= 0.0)) {
      tmpvar_35 = tmpvar_34;
    } else {
      tmpvar_35 = -(tmpvar_34);
    };
    highp float tmpvar_36;
    tmpvar_36 = (scrpos_31.x / 4.0);
    highp float tmpvar_37;
    tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
    highp float tmpvar_38;
    if ((tmpvar_36 >= 0.0)) {
      tmpvar_38 = tmpvar_37;
    } else {
      tmpvar_38 = -(tmpvar_37);
    };
    highp float x_39;
    x_39 = ((a_32 - _DITHERMATRIX[
      int(tmpvar_35)
    ][
      int(tmpvar_38)
    ]) - 0.01);
    if ((x_39 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = _BloomFactor;
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 30
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER3
    #define UNITY_HARDWARE_TIER3 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef VERTEXLIGHT_ON
    #define VERTEXLIGHT_ON 1
#endif
#ifndef SPECIAL_STATE
    #define SPECIAL_STATE 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Color _glesColor
attribute vec4 _glesColor;
#define gl_Normal _glesNormal
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 54
struct v2f {
    highp vec4 position;
    highp vec4 color;
    mediump vec2 uv_MainTex;
    mediump vec2 dd;
    mediump vec2 ss;
    highp vec3 normal;
    highp vec4 spuvs;
    highp vec3 objPos;
    highp vec4 scrpos;
    highp vec4 vertexLightColor;
};
#line 46
struct appdata {
    highp vec4 position;
    highp vec3 normal;
    mediump vec2 uv_MainTex;
    highp vec4 color;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 20
uniform sampler2D _SPTex;
uniform sampler2D _SPTex_Alpha;
uniform highp vec4 _SPTex_ST;
uniform sampler2D _SPNoiseTex;
#line 24
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPEmissionScaler;
#line 28
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform mediump vec4 _SPOutlineColor;
#line 32
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
#line 36
uniform samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
#line 40
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
#line 46
#line 55
#line 65
#line 93
#line 125
#line 154
#line 178
#line 207
#line 238
#line 264
#line 284
#line 368
#line 403
#line 19
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform highp float _Opaqueness;
uniform sampler2D _MainTex;
#line 23
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _Ramp;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
#line 27
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform highp float _Shininess;
uniform mediump float _BloomFactor;
#line 31
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
#line 36
uniform mediump vec4 _ClipPlane;
uniform mediump float _MainAlpha;
#line 40
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
uniform mediump float _AdditiveLightIntensity;
#line 80
#line 136
#line 192
#line 244
#line 330
#line 255
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    #line 259
    highp vec4 toLightY = (lightPosY - pos.y);
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    #line 263
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    lengthSq += (toLightZ * toLightZ);
    #line 267
    lengthSq = max( lengthSq, vec4( 1e-06));
    highp vec4 ndotl = vec4( 0.0);
    #line 271
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    ndotl += (toLightZ * normal.z);
    #line 275
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 279
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    #line 283
    col += (lightColor1 * diff.y);
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 259
mediump vec3 ApplyPointLight( in highp vec3 worldPos, in highp vec3 worldNormal ) {
    return Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldNormal);
}
#line 785
highp vec4 ComputeNonStereoScreenPos( in highp vec4 pos ) {
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    #line 789
    return o;
}
#line 792
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 793
    highp vec4 o = ComputeNonStereoScreenPos( pos);
    #line 797
    return o;
}
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 175
highp vec3 UnityObjectToWorldNormal( in highp vec3 norm ) {
    #line 181
    return normalize((norm * xll_constructMat3_mf4x4( unity_WorldToObject)));
}
#line 17
highp float camera_fade2( in highp vec4 vertex, in highp float fadeOffset, in highp float fadeDistance, in highp vec2 posInViewPort, in highp float startAlpha ) {
    highp vec4 viewPos = (unity_MatrixMV * vertex);
    highp float dist = length(posInViewPort.xy);
    #line 21
    highp float rev_dist = (1.0 - xll_saturate_f(dist));
    highp float factor = ((((-viewPos.z) - _ProjectionParams.y) - fadeOffset) / ((fadeDistance * rev_dist) + 0.1));
    highp float fade = mix( startAlpha, 1.0, xll_saturate_f(factor));
    return fade;
}
#line 46
void spVert( in highp vec4 vertex, in highp vec2 uv, out highp vec4 spuvs ) {
    highp vec4 position = (vertex * 0.5);
    #line 50
    spuvs.xy = ((uv.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
    spuvs.zw = vec2( (position.x + (position.z * position.z)), ((position.y + (0.5 * position.z)) + ((0.5 * position.x) * position.x)));
    spuvs.zw = ((spuvs.zw.xy * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}
#line 80
v2f vert( in appdata in_data ) {
    v2f outData = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    #line 84
    outData.position = UnityObjectToClipPos( in_data.position);
    outData.uv_MainTex = ((in_data.uv_MainTex.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    #line 90
    highp vec3 L = vec3( normalize(_WorldSpaceLightPos0));
    highp vec3 N = normalize(UnityObjectToWorldNormal( in_data.normal));
    mediump float d = ((dot( N, L) * 0.4975) + 0.5);
    #line 94
    outData.dd = vec2( d, d);
    highp vec4 verPos = (unity_ObjectToWorld * in_data.position);
    #line 98
    highp vec3 V = (_WorldSpaceCameraPos - verPos.xyz);
    V = normalize(V);
    highp vec3 H = normalize((L + V));
    mediump float s = pow( max( dot( N, H), 0.0), _Shininess);
    #line 102
    s = (( (d < 0.5) ) ? ( 0.025 ) : ( s ));
    outData.ss = vec2( s, s);
    #line 106
    mediump float alpha = camera_fade2( in_data.position, _FadeOffset, _FadeDistance, (outData.position.xy / outData.position.w), 0.0);
    outData.scrpos = ComputeScreenPos( outData.position);
    outData.scrpos.z = _DitherAlphaRight;
    #line 110
    if ((in_data.color.x > 0.5)){
        outData.scrpos.z = _DitherAlphaLeft;
    }
    if ((in_data.color.x < 0.1)){
        outData.scrpos.z = 1.0;
    }
    #line 115
    outData.color.w = (alpha * _Opaqueness);
    outData.normal = N;
    #line 119
    spVert( in_data.position, in_data.uv_MainTex, outData.spuvs);
    highp vec4 objPos = verPos;
    outData.objPos = (objPos.xyz / objPos.w);
    #line 130
    outData.vertexLightColor.xyz = (ApplyPointLight( vec3( verPos), N) * _AdditiveLightIntensity);
    return outData;
}
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    appdata xlt_in_data;
    xlt_in_data.position = vec4(gl_Vertex);
    xlt_in_data.normal = vec3(gl_Normal);
    xlt_in_data.uv_MainTex = vec2(gl_MultiTexCoord0);
    xlt_in_data.color = vec4(gl_Color);
    xl_retval = vert( xlt_in_data);
    gl_Position = vec4(xl_retval.position);
    xlv_COLOR0 = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec2(xl_retval.uv_MainTex);
    xlv_TEXCOORD1 = vec2(xl_retval.dd);
    xlv_TEXCOORD2 = vec2(xl_retval.ss);
    xlv_TEXCOORD4 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec4(xl_retval.spuvs);
    xlv_TEXCOORD7 = vec3(xl_retval.objPos);
    xlv_TEXCOORD6 = vec4(xl_retval.scrpos);
    xlv_TEXCOORD7 = vec4(xl_retval.vertexLightColor);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(142,20): error: `xlv_TEXCOORD7' redeclared
(164,2): error: value of type vec4 cannot be assigned to variable of type vec3
*/

#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = xlv_COLOR0.w;
  outColor_7.xyz = (outColor_7.xyz + (outColor_7.xyz * xlv_TEXCOORD7.xyz));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7.xyz));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
  outColor_7 = spColor_20;
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_32 = (a_32 * 17.0);
    highp float tmpvar_33;
    tmpvar_33 = (scrpos_31.y / 4.0);
    highp float tmpvar_34;
    tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
    highp float tmpvar_35;
    if ((tmpvar_33 >= 0.0)) {
      tmpvar_35 = tmpvar_34;
    } else {
      tmpvar_35 = -(tmpvar_34);
    };
    highp float tmpvar_36;
    tmpvar_36 = (scrpos_31.x / 4.0);
    highp float tmpvar_37;
    tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
    highp float tmpvar_38;
    if ((tmpvar_36 >= 0.0)) {
      tmpvar_38 = tmpvar_37;
    } else {
      tmpvar_38 = -(tmpvar_37);
    };
    highp float x_39;
    x_39 = ((a_32 - _DITHERMATRIX[
      int(tmpvar_35)
    ][
      int(tmpvar_38)
    ]) - 0.01);
    if ((x_39 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = _BloomFactor;
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float alpha_2;
  mediump float s_3;
  mediump float d_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = ((dot (tmpvar_13, tmpvar_11.xyz) * 0.4975) + 0.5);
  d_4 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = d_4;
  tmpvar_15.y = d_4;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - tmpvar_16.xyz));
  highp float tmpvar_18;
  tmpvar_18 = pow (max (dot (tmpvar_13, 
    normalize((tmpvar_11.xyz + tmpvar_17))
  ), 0.0), _Shininess);
  s_3 = tmpvar_18;
  mediump float tmpvar_19;
  if ((d_4 < 0.5)) {
    tmpvar_19 = 0.025;
  } else {
    tmpvar_19 = s_3;
  };
  s_3 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19;
  tmpvar_20.y = tmpvar_19;
  highp vec2 posInViewPort_21;
  posInViewPort_21 = (tmpvar_9.xy / tmpvar_9.w);
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_21, posInViewPort_21)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_2 = tmpvar_22;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_9.zw;
  tmpvar_8.xyw = o_23.xyw;
  tmpvar_8.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_8.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_8.z = 1.0;
  };
  tmpvar_5.w = (alpha_2 * _Opaqueness);
  highp vec2 uv_26;
  uv_26 = tmpvar_1;
  highp vec4 spuvs_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (_glesVertex * 0.5);
  spuvs_27.xy = ((uv_26 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_29;
  tmpvar_29.x = (tmpvar_28.x + (tmpvar_28.z * tmpvar_28.z));
  tmpvar_29.y = ((tmpvar_28.y + (0.5 * tmpvar_28.z)) + ((0.5 * tmpvar_28.x) * tmpvar_28.x));
  spuvs_27.zw = ((tmpvar_29 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_7 = (tmpvar_16.xyz / tmpvar_16.w);
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_20;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD3 = spuvs_27;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = xlv_COLOR0.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
  outColor_7.w = spColor_20.w;
  mediump vec3 tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_32 = (_RGBias + (tmpvar_33 * _RGScale));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_32 * _RGColor).xyz;
  mediump float tmpvar_35;
  tmpvar_35 = clamp (tmpvar_32, 0.0, 1.0);
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (spColor_20.xyz, tmpvar_34, vec3((tmpvar_35 * _RGRatio)));
  tmpvar_31 = tmpvar_36;
  outColor_7.xyz = tmpvar_31;
  highp vec4 scrpos_37;
  scrpos_37 = xlv_TEXCOORD6;
  mediump float a_38;
  a_38 = xlv_TEXCOORD6.z;
  if ((a_38 < 0.95)) {
    scrpos_37.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_38 = (a_38 * 17.0);
    highp float tmpvar_39;
    tmpvar_39 = (scrpos_37.y / 4.0);
    highp float tmpvar_40;
    tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
    highp float tmpvar_41;
    if ((tmpvar_39 >= 0.0)) {
      tmpvar_41 = tmpvar_40;
    } else {
      tmpvar_41 = -(tmpvar_40);
    };
    highp float tmpvar_42;
    tmpvar_42 = (scrpos_37.x / 4.0);
    highp float tmpvar_43;
    tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
    highp float tmpvar_44;
    if ((tmpvar_42 >= 0.0)) {
      tmpvar_44 = tmpvar_43;
    } else {
      tmpvar_44 = -(tmpvar_43);
    };
    highp float x_45;
    x_45 = ((a_38 - _DITHERMATRIX[
      int(tmpvar_41)
    ][
      int(tmpvar_44)
    ]) - 0.01);
    if ((x_45 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = _BloomFactor;
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float alpha_2;
  mediump float s_3;
  mediump float d_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = ((dot (tmpvar_13, tmpvar_11.xyz) * 0.4975) + 0.5);
  d_4 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = d_4;
  tmpvar_15.y = d_4;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - tmpvar_16.xyz));
  highp float tmpvar_18;
  tmpvar_18 = pow (max (dot (tmpvar_13, 
    normalize((tmpvar_11.xyz + tmpvar_17))
  ), 0.0), _Shininess);
  s_3 = tmpvar_18;
  mediump float tmpvar_19;
  if ((d_4 < 0.5)) {
    tmpvar_19 = 0.025;
  } else {
    tmpvar_19 = s_3;
  };
  s_3 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19;
  tmpvar_20.y = tmpvar_19;
  highp vec2 posInViewPort_21;
  posInViewPort_21 = (tmpvar_9.xy / tmpvar_9.w);
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_21, posInViewPort_21)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_2 = tmpvar_22;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_9.zw;
  tmpvar_8.xyw = o_23.xyw;
  tmpvar_8.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_8.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_8.z = 1.0;
  };
  tmpvar_5.w = (alpha_2 * _Opaqueness);
  highp vec2 uv_26;
  uv_26 = tmpvar_1;
  highp vec4 spuvs_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (_glesVertex * 0.5);
  spuvs_27.xy = ((uv_26 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_29;
  tmpvar_29.x = (tmpvar_28.x + (tmpvar_28.z * tmpvar_28.z));
  tmpvar_29.y = ((tmpvar_28.y + (0.5 * tmpvar_28.z)) + ((0.5 * tmpvar_28.x) * tmpvar_28.x));
  spuvs_27.zw = ((tmpvar_29 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_7 = (tmpvar_16.xyz / tmpvar_16.w);
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_20;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD3 = spuvs_27;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = xlv_COLOR0.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
  outColor_7.w = spColor_20.w;
  mediump vec3 tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_32 = (_RGBias + (tmpvar_33 * _RGScale));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_32 * _RGColor).xyz;
  mediump float tmpvar_35;
  tmpvar_35 = clamp (tmpvar_32, 0.0, 1.0);
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (spColor_20.xyz, tmpvar_34, vec3((tmpvar_35 * _RGRatio)));
  tmpvar_31 = tmpvar_36;
  outColor_7.xyz = tmpvar_31;
  highp vec4 scrpos_37;
  scrpos_37 = xlv_TEXCOORD6;
  mediump float a_38;
  a_38 = xlv_TEXCOORD6.z;
  if ((a_38 < 0.95)) {
    scrpos_37.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_38 = (a_38 * 17.0);
    highp float tmpvar_39;
    tmpvar_39 = (scrpos_37.y / 4.0);
    highp float tmpvar_40;
    tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
    highp float tmpvar_41;
    if ((tmpvar_39 >= 0.0)) {
      tmpvar_41 = tmpvar_40;
    } else {
      tmpvar_41 = -(tmpvar_40);
    };
    highp float tmpvar_42;
    tmpvar_42 = (scrpos_37.x / 4.0);
    highp float tmpvar_43;
    tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
    highp float tmpvar_44;
    if ((tmpvar_42 >= 0.0)) {
      tmpvar_44 = tmpvar_43;
    } else {
      tmpvar_44 = -(tmpvar_43);
    };
    highp float x_45;
    x_45 = ((a_38 - _DITHERMATRIX[
      int(tmpvar_41)
    ][
      int(tmpvar_44)
    ]) - 0.01);
    if ((x_45 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = _BloomFactor;
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float alpha_2;
  mediump float s_3;
  mediump float d_4;
  highp vec4 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = ((dot (tmpvar_13, tmpvar_11.xyz) * 0.4975) + 0.5);
  d_4 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = d_4;
  tmpvar_15.y = d_4;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - tmpvar_16.xyz));
  highp float tmpvar_18;
  tmpvar_18 = pow (max (dot (tmpvar_13, 
    normalize((tmpvar_11.xyz + tmpvar_17))
  ), 0.0), _Shininess);
  s_3 = tmpvar_18;
  mediump float tmpvar_19;
  if ((d_4 < 0.5)) {
    tmpvar_19 = 0.025;
  } else {
    tmpvar_19 = s_3;
  };
  s_3 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19;
  tmpvar_20.y = tmpvar_19;
  highp vec2 posInViewPort_21;
  posInViewPort_21 = (tmpvar_9.xy / tmpvar_9.w);
  highp float tmpvar_22;
  tmpvar_22 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / (
    (_FadeDistance * (1.0 - clamp (sqrt(
      dot (posInViewPort_21, posInViewPort_21)
    ), 0.0, 1.0)))
   + 0.1)), 0.0, 1.0);
  alpha_2 = tmpvar_22;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_9.zw;
  tmpvar_8.xyw = o_23.xyw;
  tmpvar_8.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_8.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_8.z = 1.0;
  };
  tmpvar_5.w = (alpha_2 * _Opaqueness);
  highp vec2 uv_26;
  uv_26 = tmpvar_1;
  highp vec4 spuvs_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (_glesVertex * 0.5);
  spuvs_27.xy = ((uv_26 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_29;
  tmpvar_29.x = (tmpvar_28.x + (tmpvar_28.z * tmpvar_28.z));
  tmpvar_29.y = ((tmpvar_28.y + (0.5 * tmpvar_28.z)) + ((0.5 * tmpvar_28.x) * tmpvar_28.x));
  spuvs_27.zw = ((tmpvar_29 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_7 = (tmpvar_16.xyz / tmpvar_16.w);
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_20;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD3 = spuvs_27;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = xlv_COLOR0.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
  outColor_7.w = spColor_20.w;
  mediump vec3 tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_32 = (_RGBias + (tmpvar_33 * _RGScale));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_32 * _RGColor).xyz;
  mediump float tmpvar_35;
  tmpvar_35 = clamp (tmpvar_32, 0.0, 1.0);
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (spColor_20.xyz, tmpvar_34, vec3((tmpvar_35 * _RGRatio)));
  tmpvar_31 = tmpvar_36;
  outColor_7.xyz = tmpvar_31;
  highp vec4 scrpos_37;
  scrpos_37 = xlv_TEXCOORD6;
  mediump float a_38;
  a_38 = xlv_TEXCOORD6.z;
  if ((a_38 < 0.95)) {
    scrpos_37.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_38 = (a_38 * 17.0);
    highp float tmpvar_39;
    tmpvar_39 = (scrpos_37.y / 4.0);
    highp float tmpvar_40;
    tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
    highp float tmpvar_41;
    if ((tmpvar_39 >= 0.0)) {
      tmpvar_41 = tmpvar_40;
    } else {
      tmpvar_41 = -(tmpvar_40);
    };
    highp float tmpvar_42;
    tmpvar_42 = (scrpos_37.x / 4.0);
    highp float tmpvar_43;
    tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
    highp float tmpvar_44;
    if ((tmpvar_42 >= 0.0)) {
      tmpvar_44 = tmpvar_43;
    } else {
      tmpvar_44 = -(tmpvar_43);
    };
    highp float x_45;
    x_45 = ((a_38 - _DITHERMATRIX[
      int(tmpvar_41)
    ][
      int(tmpvar_44)
    ]) - 0.01);
    if ((x_45 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = _BloomFactor;
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 30
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF3
    #define UNITY_PBS_USE_BRDF3 1
#endif
#ifndef UNITY_NO_FULL_STANDARD_SHADER
    #define UNITY_NO_FULL_STANDARD_SHADER 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER1
    #define UNITY_HARDWARE_TIER1 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef VERTEXLIGHT_ON
    #define VERTEXLIGHT_ON 1
#endif
#ifndef SPECIAL_STATE
    #define SPECIAL_STATE 1
#endif
#ifndef RIM_GLOW
    #define RIM_GLOW 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Color _glesColor
attribute vec4 _glesColor;
#define gl_Normal _glesNormal
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 54
struct v2f {
    highp vec4 position;
    highp vec4 color;
    mediump vec2 uv_MainTex;
    mediump vec2 dd;
    mediump vec2 ss;
    highp vec3 normal;
    highp vec4 spuvs;
    highp vec3 objPos;
    highp vec3 viewDir;
    highp vec4 scrpos;
    highp vec4 vertexLightColor;
};
#line 46
struct appdata {
    highp vec4 position;
    highp vec3 normal;
    mediump vec2 uv_MainTex;
    highp vec4 color;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 20
uniform sampler2D _SPTex;
uniform sampler2D _SPTex_Alpha;
uniform highp vec4 _SPTex_ST;
uniform sampler2D _SPNoiseTex;
#line 24
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPEmissionScaler;
#line 28
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform mediump vec4 _SPOutlineColor;
#line 32
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
#line 36
uniform samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
#line 40
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
#line 46
#line 55
#line 65
#line 93
#line 125
#line 154
#line 178
#line 207
#line 238
#line 264
#line 284
#line 368
#line 403
#line 9
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
#line 13
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp int _RGBlendType;
#line 17
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
#line 21
uniform highp float _RGMaskIntensity;
uniform mediump vec4 _HRRimColor2;
#line 25
uniform mediump vec4 _HRRimColor3;
uniform mediump vec4 _HRRimColor4;
uniform mediump vec4 _HRRimColor5;
uniform mediump float _HRRimPower;
#line 29
uniform highp int _HRRimIntensity;
uniform highp int _MoreHardRimColor;
#line 45
#line 51
#line 84
#line 105
#line 117
#line 146
#line 181
#line 19
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform highp float _Opaqueness;
uniform sampler2D _MainTex;
#line 23
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _Ramp;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
#line 27
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform highp float _Shininess;
uniform mediump float _BloomFactor;
#line 31
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
#line 36
uniform mediump vec4 _ClipPlane;
uniform mediump float _MainAlpha;
#line 40
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
uniform mediump float _AdditiveLightIntensity;
#line 80
#line 136
#line 192
#line 244
#line 281
#line 330
#line 255
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    #line 259
    highp vec4 toLightY = (lightPosY - pos.y);
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    #line 263
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    lengthSq += (toLightZ * toLightZ);
    #line 267
    lengthSq = max( lengthSq, vec4( 1e-06));
    highp vec4 ndotl = vec4( 0.0);
    #line 271
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    ndotl += (toLightZ * normal.z);
    #line 275
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 279
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    #line 283
    col += (lightColor1 * diff.y);
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 259
mediump vec3 ApplyPointLight( in highp vec3 worldPos, in highp vec3 worldNormal ) {
    return Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldNormal);
}
#line 785
highp vec4 ComputeNonStereoScreenPos( in highp vec4 pos ) {
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    #line 789
    return o;
}
#line 792
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 793
    highp vec4 o = ComputeNonStereoScreenPos( pos);
    #line 797
    return o;
}
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 175
highp vec3 UnityObjectToWorldNormal( in highp vec3 norm ) {
    #line 181
    return normalize((norm * xll_constructMat3_mf4x4( unity_WorldToObject)));
}
#line 17
highp float camera_fade2( in highp vec4 vertex, in highp float fadeOffset, in highp float fadeDistance, in highp vec2 posInViewPort, in highp float startAlpha ) {
    highp vec4 viewPos = (unity_MatrixMV * vertex);
    highp float dist = length(posInViewPort.xy);
    #line 21
    highp float rev_dist = (1.0 - xll_saturate_f(dist));
    highp float factor = ((((-viewPos.z) - _ProjectionParams.y) - fadeOffset) / ((fadeDistance * rev_dist) + 0.1));
    highp float fade = mix( startAlpha, 1.0, xll_saturate_f(factor));
    return fade;
}
#line 46
void spVert( in highp vec4 vertex, in highp vec2 uv, out highp vec4 spuvs ) {
    highp vec4 position = (vertex * 0.5);
    #line 50
    spuvs.xy = ((uv.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
    spuvs.zw = vec2( (position.x + (position.z * position.z)), ((position.y + (0.5 * position.z)) + ((0.5 * position.x) * position.x)));
    spuvs.zw = ((spuvs.zw.xy * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}
#line 80
v2f vert( in appdata in_data ) {
    v2f outData = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    #line 84
    outData.position = UnityObjectToClipPos( in_data.position);
    outData.uv_MainTex = ((in_data.uv_MainTex.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    #line 90
    highp vec3 L = vec3( normalize(_WorldSpaceLightPos0));
    highp vec3 N = normalize(UnityObjectToWorldNormal( in_data.normal));
    mediump float d = ((dot( N, L) * 0.4975) + 0.5);
    #line 94
    outData.dd = vec2( d, d);
    highp vec4 verPos = (unity_ObjectToWorld * in_data.position);
    #line 98
    highp vec3 V = (_WorldSpaceCameraPos - verPos.xyz);
    V = normalize(V);
    highp vec3 H = normalize((L + V));
    mediump float s = pow( max( dot( N, H), 0.0), _Shininess);
    #line 102
    s = (( (d < 0.5) ) ? ( 0.025 ) : ( s ));
    outData.ss = vec2( s, s);
    #line 106
    mediump float alpha = camera_fade2( in_data.position, _FadeOffset, _FadeDistance, (outData.position.xy / outData.position.w), 0.0);
    outData.scrpos = ComputeScreenPos( outData.position);
    outData.scrpos.z = _DitherAlphaRight;
    #line 110
    if ((in_data.color.x > 0.5)){
        outData.scrpos.z = _DitherAlphaLeft;
    }
    if ((in_data.color.x < 0.1)){
        outData.scrpos.z = 1.0;
    }
    #line 115
    outData.color.w = (alpha * _Opaqueness);
    outData.normal = N;
    #line 119
    spVert( in_data.position, in_data.uv_MainTex, outData.spuvs);
    highp vec4 objPos = verPos;
    outData.objPos = (objPos.xyz / objPos.w);
    #line 126
    outData.viewDir = V;
    #line 130
    outData.vertexLightColor.xyz = (ApplyPointLight( vec3( verPos), N) * _AdditiveLightIntensity);
    return outData;
}
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    appdata xlt_in_data;
    xlt_in_data.position = vec4(gl_Vertex);
    xlt_in_data.normal = vec3(gl_Normal);
    xlt_in_data.uv_MainTex = vec2(gl_MultiTexCoord0);
    xlt_in_data.color = vec4(gl_Color);
    xl_retval = vert( xlt_in_data);
    gl_Position = vec4(xl_retval.position);
    xlv_COLOR0 = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec2(xl_retval.uv_MainTex);
    xlv_TEXCOORD1 = vec2(xl_retval.dd);
    xlv_TEXCOORD2 = vec2(xl_retval.ss);
    xlv_TEXCOORD4 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec4(xl_retval.spuvs);
    xlv_TEXCOORD7 = vec3(xl_retval.objPos);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval.scrpos);
    xlv_TEXCOORD7 = vec4(xl_retval.vertexLightColor);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(143,20): error: `xlv_TEXCOORD7' redeclared
(166,2): error: value of type vec4 cannot be assigned to variable of type vec3
*/

#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = xlv_COLOR0.w;
  outColor_7.xyz = (outColor_7.xyz + (outColor_7.xyz * xlv_TEXCOORD7.xyz));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7.xyz));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
  outColor_7.w = spColor_20.w;
  mediump vec3 tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_32 = (_RGBias + (tmpvar_33 * _RGScale));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_32 * _RGColor).xyz;
  mediump float tmpvar_35;
  tmpvar_35 = clamp (tmpvar_32, 0.0, 1.0);
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (spColor_20.xyz, tmpvar_34, vec3((tmpvar_35 * _RGRatio)));
  tmpvar_31 = tmpvar_36;
  outColor_7.xyz = tmpvar_31;
  highp vec4 scrpos_37;
  scrpos_37 = xlv_TEXCOORD6;
  mediump float a_38;
  a_38 = xlv_TEXCOORD6.z;
  if ((a_38 < 0.95)) {
    scrpos_37.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_38 = (a_38 * 17.0);
    highp float tmpvar_39;
    tmpvar_39 = (scrpos_37.y / 4.0);
    highp float tmpvar_40;
    tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
    highp float tmpvar_41;
    if ((tmpvar_39 >= 0.0)) {
      tmpvar_41 = tmpvar_40;
    } else {
      tmpvar_41 = -(tmpvar_40);
    };
    highp float tmpvar_42;
    tmpvar_42 = (scrpos_37.x / 4.0);
    highp float tmpvar_43;
    tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
    highp float tmpvar_44;
    if ((tmpvar_42 >= 0.0)) {
      tmpvar_44 = tmpvar_43;
    } else {
      tmpvar_44 = -(tmpvar_43);
    };
    highp float x_45;
    x_45 = ((a_38 - _DITHERMATRIX[
      int(tmpvar_41)
    ][
      int(tmpvar_44)
    ]) - 0.01);
    if ((x_45 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = _BloomFactor;
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 30
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER2
    #define UNITY_HARDWARE_TIER2 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef VERTEXLIGHT_ON
    #define VERTEXLIGHT_ON 1
#endif
#ifndef SPECIAL_STATE
    #define SPECIAL_STATE 1
#endif
#ifndef RIM_GLOW
    #define RIM_GLOW 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Color _glesColor
attribute vec4 _glesColor;
#define gl_Normal _glesNormal
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 54
struct v2f {
    highp vec4 position;
    highp vec4 color;
    mediump vec2 uv_MainTex;
    mediump vec2 dd;
    mediump vec2 ss;
    highp vec3 normal;
    highp vec4 spuvs;
    highp vec3 objPos;
    highp vec3 viewDir;
    highp vec4 scrpos;
    highp vec4 vertexLightColor;
};
#line 46
struct appdata {
    highp vec4 position;
    highp vec3 normal;
    mediump vec2 uv_MainTex;
    highp vec4 color;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 20
uniform sampler2D _SPTex;
uniform sampler2D _SPTex_Alpha;
uniform highp vec4 _SPTex_ST;
uniform sampler2D _SPNoiseTex;
#line 24
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPEmissionScaler;
#line 28
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform mediump vec4 _SPOutlineColor;
#line 32
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
#line 36
uniform samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
#line 40
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
#line 46
#line 55
#line 65
#line 93
#line 125
#line 154
#line 178
#line 207
#line 238
#line 264
#line 284
#line 368
#line 403
#line 9
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
#line 13
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp int _RGBlendType;
#line 17
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
#line 21
uniform highp float _RGMaskIntensity;
uniform mediump vec4 _HRRimColor2;
#line 25
uniform mediump vec4 _HRRimColor3;
uniform mediump vec4 _HRRimColor4;
uniform mediump vec4 _HRRimColor5;
uniform mediump float _HRRimPower;
#line 29
uniform highp int _HRRimIntensity;
uniform highp int _MoreHardRimColor;
#line 45
#line 51
#line 84
#line 105
#line 117
#line 146
#line 181
#line 19
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform highp float _Opaqueness;
uniform sampler2D _MainTex;
#line 23
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _Ramp;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
#line 27
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform highp float _Shininess;
uniform mediump float _BloomFactor;
#line 31
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
#line 36
uniform mediump vec4 _ClipPlane;
uniform mediump float _MainAlpha;
#line 40
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
uniform mediump float _AdditiveLightIntensity;
#line 80
#line 136
#line 192
#line 244
#line 281
#line 330
#line 255
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    #line 259
    highp vec4 toLightY = (lightPosY - pos.y);
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    #line 263
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    lengthSq += (toLightZ * toLightZ);
    #line 267
    lengthSq = max( lengthSq, vec4( 1e-06));
    highp vec4 ndotl = vec4( 0.0);
    #line 271
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    ndotl += (toLightZ * normal.z);
    #line 275
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 279
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    #line 283
    col += (lightColor1 * diff.y);
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 259
mediump vec3 ApplyPointLight( in highp vec3 worldPos, in highp vec3 worldNormal ) {
    return Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldNormal);
}
#line 785
highp vec4 ComputeNonStereoScreenPos( in highp vec4 pos ) {
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    #line 789
    return o;
}
#line 792
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 793
    highp vec4 o = ComputeNonStereoScreenPos( pos);
    #line 797
    return o;
}
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 175
highp vec3 UnityObjectToWorldNormal( in highp vec3 norm ) {
    #line 181
    return normalize((norm * xll_constructMat3_mf4x4( unity_WorldToObject)));
}
#line 17
highp float camera_fade2( in highp vec4 vertex, in highp float fadeOffset, in highp float fadeDistance, in highp vec2 posInViewPort, in highp float startAlpha ) {
    highp vec4 viewPos = (unity_MatrixMV * vertex);
    highp float dist = length(posInViewPort.xy);
    #line 21
    highp float rev_dist = (1.0 - xll_saturate_f(dist));
    highp float factor = ((((-viewPos.z) - _ProjectionParams.y) - fadeOffset) / ((fadeDistance * rev_dist) + 0.1));
    highp float fade = mix( startAlpha, 1.0, xll_saturate_f(factor));
    return fade;
}
#line 46
void spVert( in highp vec4 vertex, in highp vec2 uv, out highp vec4 spuvs ) {
    highp vec4 position = (vertex * 0.5);
    #line 50
    spuvs.xy = ((uv.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
    spuvs.zw = vec2( (position.x + (position.z * position.z)), ((position.y + (0.5 * position.z)) + ((0.5 * position.x) * position.x)));
    spuvs.zw = ((spuvs.zw.xy * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}
#line 80
v2f vert( in appdata in_data ) {
    v2f outData = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    #line 84
    outData.position = UnityObjectToClipPos( in_data.position);
    outData.uv_MainTex = ((in_data.uv_MainTex.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    #line 90
    highp vec3 L = vec3( normalize(_WorldSpaceLightPos0));
    highp vec3 N = normalize(UnityObjectToWorldNormal( in_data.normal));
    mediump float d = ((dot( N, L) * 0.4975) + 0.5);
    #line 94
    outData.dd = vec2( d, d);
    highp vec4 verPos = (unity_ObjectToWorld * in_data.position);
    #line 98
    highp vec3 V = (_WorldSpaceCameraPos - verPos.xyz);
    V = normalize(V);
    highp vec3 H = normalize((L + V));
    mediump float s = pow( max( dot( N, H), 0.0), _Shininess);
    #line 102
    s = (( (d < 0.5) ) ? ( 0.025 ) : ( s ));
    outData.ss = vec2( s, s);
    #line 106
    mediump float alpha = camera_fade2( in_data.position, _FadeOffset, _FadeDistance, (outData.position.xy / outData.position.w), 0.0);
    outData.scrpos = ComputeScreenPos( outData.position);
    outData.scrpos.z = _DitherAlphaRight;
    #line 110
    if ((in_data.color.x > 0.5)){
        outData.scrpos.z = _DitherAlphaLeft;
    }
    if ((in_data.color.x < 0.1)){
        outData.scrpos.z = 1.0;
    }
    #line 115
    outData.color.w = (alpha * _Opaqueness);
    outData.normal = N;
    #line 119
    spVert( in_data.position, in_data.uv_MainTex, outData.spuvs);
    highp vec4 objPos = verPos;
    outData.objPos = (objPos.xyz / objPos.w);
    #line 126
    outData.viewDir = V;
    #line 130
    outData.vertexLightColor.xyz = (ApplyPointLight( vec3( verPos), N) * _AdditiveLightIntensity);
    return outData;
}
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    appdata xlt_in_data;
    xlt_in_data.position = vec4(gl_Vertex);
    xlt_in_data.normal = vec3(gl_Normal);
    xlt_in_data.uv_MainTex = vec2(gl_MultiTexCoord0);
    xlt_in_data.color = vec4(gl_Color);
    xl_retval = vert( xlt_in_data);
    gl_Position = vec4(xl_retval.position);
    xlv_COLOR0 = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec2(xl_retval.uv_MainTex);
    xlv_TEXCOORD1 = vec2(xl_retval.dd);
    xlv_TEXCOORD2 = vec2(xl_retval.ss);
    xlv_TEXCOORD4 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec4(xl_retval.spuvs);
    xlv_TEXCOORD7 = vec3(xl_retval.objPos);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval.scrpos);
    xlv_TEXCOORD7 = vec4(xl_retval.vertexLightColor);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(143,20): error: `xlv_TEXCOORD7' redeclared
(166,2): error: value of type vec4 cannot be assigned to variable of type vec3
*/

#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = xlv_COLOR0.w;
  outColor_7.xyz = (outColor_7.xyz + (outColor_7.xyz * xlv_TEXCOORD7.xyz));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7.xyz));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
  outColor_7.w = spColor_20.w;
  mediump vec3 tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_32 = (_RGBias + (tmpvar_33 * _RGScale));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_32 * _RGColor).xyz;
  mediump float tmpvar_35;
  tmpvar_35 = clamp (tmpvar_32, 0.0, 1.0);
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (spColor_20.xyz, tmpvar_34, vec3((tmpvar_35 * _RGRatio)));
  tmpvar_31 = tmpvar_36;
  outColor_7.xyz = tmpvar_31;
  highp vec4 scrpos_37;
  scrpos_37 = xlv_TEXCOORD6;
  mediump float a_38;
  a_38 = xlv_TEXCOORD6.z;
  if ((a_38 < 0.95)) {
    scrpos_37.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_38 = (a_38 * 17.0);
    highp float tmpvar_39;
    tmpvar_39 = (scrpos_37.y / 4.0);
    highp float tmpvar_40;
    tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
    highp float tmpvar_41;
    if ((tmpvar_39 >= 0.0)) {
      tmpvar_41 = tmpvar_40;
    } else {
      tmpvar_41 = -(tmpvar_40);
    };
    highp float tmpvar_42;
    tmpvar_42 = (scrpos_37.x / 4.0);
    highp float tmpvar_43;
    tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
    highp float tmpvar_44;
    if ((tmpvar_42 >= 0.0)) {
      tmpvar_44 = tmpvar_43;
    } else {
      tmpvar_44 = -(tmpvar_43);
    };
    highp float x_45;
    x_45 = ((a_38 - _DITHERMATRIX[
      int(tmpvar_41)
    ][
      int(tmpvar_44)
    ]) - 0.01);
    if ((x_45 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = _BloomFactor;
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 30
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_ENABLE_REFLECTION_BUFFERS
    #define UNITY_ENABLE_REFLECTION_BUFFERS 1
#endif
#ifndef UNITY_FRAMEBUFFER_FETCH_AVAILABLE
    #define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#endif
#ifndef UNITY_NO_CUBEMAP_ARRAY
    #define UNITY_NO_CUBEMAP_ARRAY 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_PBS_USE_BRDF2
    #define UNITY_PBS_USE_BRDF2 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#ifndef UNITY_HARDWARE_TIER3
    #define UNITY_HARDWARE_TIER3 1
#endif
#ifndef UNITY_COLORSPACE_GAMMA
    #define UNITY_COLORSPACE_GAMMA 1
#endif
#ifndef UNITY_LIGHTMAP_DLDR_ENCODING
    #define UNITY_LIGHTMAP_DLDR_ENCODING 1
#endif
#ifndef VERTEXLIGHT_ON
    #define VERTEXLIGHT_ON 1
#endif
#ifndef SPECIAL_STATE
    #define SPECIAL_STATE 1
#endif
#ifndef RIM_GLOW
    #define RIM_GLOW 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 201758
#endif
#ifndef SHADER_STAGE_VERTEX
    #define SHADER_STAGE_VERTEX 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Color _glesColor
attribute vec4 _glesColor;
#define gl_Normal _glesNormal
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 447
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 756
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 749
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 54
struct v2f {
    highp vec4 position;
    highp vec4 color;
    mediump vec2 uv_MainTex;
    mediump vec2 dd;
    mediump vec2 ss;
    highp vec3 normal;
    highp vec4 spuvs;
    highp vec3 objPos;
    highp vec3 viewDir;
    highp vec4 scrpos;
    highp vec4 vertexLightColor;
};
#line 46
struct appdata {
    highp vec4 position;
    highp vec3 normal;
    mediump vec2 uv_MainTex;
    highp vec4 color;
};
#line 40
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 46
uniform highp vec3 _WorldSpaceCameraPos;
#line 53
uniform highp vec4 _ProjectionParams;
#line 59
uniform highp vec4 _ScreenParams;
#line 71
uniform highp vec4 _ZBufferParams;
#line 77
uniform highp vec4 unity_OrthoParams;
#line 82
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 88
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_WorldToCamera;
uniform highp mat4 unity_CameraToWorld;
#line 104
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 108
uniform highp vec4 _LightProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
#line 112
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
#line 118
uniform highp vec4 unity_LightPosition[8];
#line 123
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 127
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 131
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 136
uniform lowp vec4 unity_OcclusionMaskSelector;
uniform lowp vec4 unity_ProbesOcclusion;
#line 141
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 148
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 152
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 161
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 202
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 210
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 214
uniform lowp vec4 unity_IndirectSpecColor;
uniform highp mat4 glstate_matrix_projection;
#line 218
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp int unity_StereoEyeIndex;
#line 224
uniform lowp vec4 unity_ShadowColor;
#line 231
uniform lowp vec4 unity_FogColor;
#line 236
uniform highp vec4 unity_FogParams;
#line 244
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_LightmapInd;
#line 258
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 263
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 271
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 275
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 280
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 320
highp mat4 unity_MatrixMVP;
highp mat4 unity_MatrixMV;
highp mat4 unity_MatrixTMV;
highp mat4 unity_MatrixITMV;
#line 9
#line 14
#line 84
#line 93
#line 103
#line 112
#line 124
#line 135
#line 141
#line 147
#line 151
#line 157
#line 163
#line 169
#line 175
#line 186
#line 201
#line 208
#line 223
#line 230
#line 237
#line 255
#line 291
#line 320
#line 326
#line 339
#line 357
#line 373
#line 427
#line 453
#line 464
#line 473
#line 480
#line 485
#line 502
#line 522
#line 537
#line 543
#line 554
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 568
#line 578
#line 593
#line 602
#line 609
#line 618
#line 626
#line 635
#line 654
#line 660
#line 670
#line 680
#line 691
#line 696
#line 702
#line 707
#line 764
#line 770
#line 785
#line 816
#line 830
#line 834
#line 840
#line 849
#line 859
#line 885
#line 891
#line 8
#line 17
#line 29
#line 50
#line 91
#line 102
#line 114
#line 127
#line 133
#line 188
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
#line 202
#line 234
uniform highp mat4 _DITHERMATRIX;
#line 259
#line 20
uniform sampler2D _SPTex;
uniform sampler2D _SPTex_Alpha;
uniform highp vec4 _SPTex_ST;
uniform sampler2D _SPNoiseTex;
#line 24
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPEmissionScaler;
#line 28
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform mediump vec4 _SPOutlineColor;
#line 32
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
#line 36
uniform samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
#line 40
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
#line 46
#line 55
#line 65
#line 93
#line 125
#line 154
#line 178
#line 207
#line 238
#line 264
#line 284
#line 368
#line 403
#line 9
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
#line 13
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp int _RGBlendType;
#line 17
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
#line 21
uniform highp float _RGMaskIntensity;
uniform mediump vec4 _HRRimColor2;
#line 25
uniform mediump vec4 _HRRimColor3;
uniform mediump vec4 _HRRimColor4;
uniform mediump vec4 _HRRimColor5;
uniform mediump float _HRRimPower;
#line 29
uniform highp int _HRRimIntensity;
uniform highp int _MoreHardRimColor;
#line 45
#line 51
#line 84
#line 105
#line 117
#line 146
#line 181
#line 19
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform highp float _Opaqueness;
uniform sampler2D _MainTex;
#line 23
uniform mediump vec4 _MainTex_ST;
uniform sampler2D _Ramp;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
#line 27
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform highp float _Shininess;
uniform mediump float _BloomFactor;
#line 31
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
#line 36
uniform mediump vec4 _ClipPlane;
uniform mediump float _MainAlpha;
#line 40
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
uniform mediump float _AdditiveLightIntensity;
#line 80
#line 136
#line 192
#line 244
#line 281
#line 330
#line 255
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    #line 259
    highp vec4 toLightY = (lightPosY - pos.y);
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    #line 263
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    lengthSq += (toLightZ * toLightZ);
    #line 267
    lengthSq = max( lengthSq, vec4( 1e-06));
    highp vec4 ndotl = vec4( 0.0);
    #line 271
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    ndotl += (toLightZ * normal.z);
    #line 275
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 279
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    #line 283
    col += (lightColor1 * diff.y);
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 259
mediump vec3 ApplyPointLight( in highp vec3 worldPos, in highp vec3 worldNormal ) {
    return Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldNormal);
}
#line 785
highp vec4 ComputeNonStereoScreenPos( in highp vec4 pos ) {
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    #line 789
    return o;
}
#line 792
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 793
    highp vec4 o = ComputeNonStereoScreenPos( pos);
    #line 797
    return o;
}
#line 9
highp vec4 UnityObjectToClipPos( in highp vec3 pos ) {
    return (unity_MatrixVP * (unity_ObjectToWorld * vec4( pos, 1.0)));
}
#line 14
highp vec4 UnityObjectToClipPos( in highp vec4 pos ) {
    return UnityObjectToClipPos( pos.xyz);
}
#line 175
highp vec3 UnityObjectToWorldNormal( in highp vec3 norm ) {
    #line 181
    return normalize((norm * xll_constructMat3_mf4x4( unity_WorldToObject)));
}
#line 17
highp float camera_fade2( in highp vec4 vertex, in highp float fadeOffset, in highp float fadeDistance, in highp vec2 posInViewPort, in highp float startAlpha ) {
    highp vec4 viewPos = (unity_MatrixMV * vertex);
    highp float dist = length(posInViewPort.xy);
    #line 21
    highp float rev_dist = (1.0 - xll_saturate_f(dist));
    highp float factor = ((((-viewPos.z) - _ProjectionParams.y) - fadeOffset) / ((fadeDistance * rev_dist) + 0.1));
    highp float fade = mix( startAlpha, 1.0, xll_saturate_f(factor));
    return fade;
}
#line 46
void spVert( in highp vec4 vertex, in highp vec2 uv, out highp vec4 spuvs ) {
    highp vec4 position = (vertex * 0.5);
    #line 50
    spuvs.xy = ((uv.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
    spuvs.zw = vec2( (position.x + (position.z * position.z)), ((position.y + (0.5 * position.z)) + ((0.5 * position.x) * position.x)));
    spuvs.zw = ((spuvs.zw.xy * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}
#line 80
v2f vert( in appdata in_data ) {
    v2f outData = v2f(vec4(0.0, 0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec2(0.0, 0.0), vec3(0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0), vec4(0.0, 0.0, 0.0, 0.0));
    #line 84
    outData.position = UnityObjectToClipPos( in_data.position);
    outData.uv_MainTex = ((in_data.uv_MainTex.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    #line 90
    highp vec3 L = vec3( normalize(_WorldSpaceLightPos0));
    highp vec3 N = normalize(UnityObjectToWorldNormal( in_data.normal));
    mediump float d = ((dot( N, L) * 0.4975) + 0.5);
    #line 94
    outData.dd = vec2( d, d);
    highp vec4 verPos = (unity_ObjectToWorld * in_data.position);
    #line 98
    highp vec3 V = (_WorldSpaceCameraPos - verPos.xyz);
    V = normalize(V);
    highp vec3 H = normalize((L + V));
    mediump float s = pow( max( dot( N, H), 0.0), _Shininess);
    #line 102
    s = (( (d < 0.5) ) ? ( 0.025 ) : ( s ));
    outData.ss = vec2( s, s);
    #line 106
    mediump float alpha = camera_fade2( in_data.position, _FadeOffset, _FadeDistance, (outData.position.xy / outData.position.w), 0.0);
    outData.scrpos = ComputeScreenPos( outData.position);
    outData.scrpos.z = _DitherAlphaRight;
    #line 110
    if ((in_data.color.x > 0.5)){
        outData.scrpos.z = _DitherAlphaLeft;
    }
    if ((in_data.color.x < 0.1)){
        outData.scrpos.z = 1.0;
    }
    #line 115
    outData.color.w = (alpha * _Opaqueness);
    outData.normal = N;
    #line 119
    spVert( in_data.position, in_data.uv_MainTex, outData.spuvs);
    highp vec4 objPos = verPos;
    outData.objPos = (objPos.xyz / objPos.w);
    #line 126
    outData.viewDir = V;
    #line 130
    outData.vertexLightColor.xyz = (ApplyPointLight( vec3( verPos), N) * _AdditiveLightIntensity);
    return outData;
}
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main() {
unity_MatrixMVP = (unity_MatrixVP * unity_ObjectToWorld);
unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
unity_MatrixTMV = xll_transpose_mf4x4(unity_MatrixMV);
unity_MatrixITMV = xll_transpose_mf4x4((unity_WorldToObject * unity_MatrixInvV));
    v2f xl_retval;
    appdata xlt_in_data;
    xlt_in_data.position = vec4(gl_Vertex);
    xlt_in_data.normal = vec3(gl_Normal);
    xlt_in_data.uv_MainTex = vec2(gl_MultiTexCoord0);
    xlt_in_data.color = vec4(gl_Color);
    xl_retval = vert( xlt_in_data);
    gl_Position = vec4(xl_retval.position);
    xlv_COLOR0 = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec2(xl_retval.uv_MainTex);
    xlv_TEXCOORD1 = vec2(xl_retval.dd);
    xlv_TEXCOORD2 = vec2(xl_retval.ss);
    xlv_TEXCOORD4 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec4(xl_retval.spuvs);
    xlv_TEXCOORD7 = vec3(xl_retval.objPos);
    xlv_TEXCOORD5 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD6 = vec4(xl_retval.scrpos);
    xlv_TEXCOORD7 = vec4(xl_retval.vertexLightColor);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(143,20): error: `xlv_TEXCOORD7' redeclared
(166,2): error: value of type vec4 cannot be assigned to variable of type vec3
*/

#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = xlv_COLOR0.w;
  outColor_7.xyz = (outColor_7.xyz + (outColor_7.xyz * xlv_TEXCOORD7.xyz));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7.xyz));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
  outColor_7.w = spColor_20.w;
  mediump vec3 tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD4))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_32 = (_RGBias + (tmpvar_33 * _RGScale));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_32 * _RGColor).xyz;
  mediump float tmpvar_35;
  tmpvar_35 = clamp (tmpvar_32, 0.0, 1.0);
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (spColor_20.xyz, tmpvar_34, vec3((tmpvar_35 * _RGRatio)));
  tmpvar_31 = tmpvar_36;
  outColor_7.xyz = tmpvar_31;
  highp vec4 scrpos_37;
  scrpos_37 = xlv_TEXCOORD6;
  mediump float a_38;
  a_38 = xlv_TEXCOORD6.z;
  if ((a_38 < 0.95)) {
    scrpos_37.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_38 = (a_38 * 17.0);
    highp float tmpvar_39;
    tmpvar_39 = (scrpos_37.y / 4.0);
    highp float tmpvar_40;
    tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
    highp float tmpvar_41;
    if ((tmpvar_39 >= 0.0)) {
      tmpvar_41 = tmpvar_40;
    } else {
      tmpvar_41 = -(tmpvar_40);
    };
    highp float tmpvar_42;
    tmpvar_42 = (scrpos_37.x / 4.0);
    highp float tmpvar_43;
    tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
    highp float tmpvar_44;
    if ((tmpvar_42 >= 0.0)) {
      tmpvar_44 = tmpvar_43;
    } else {
      tmpvar_44 = -(tmpvar_43);
    };
    highp float x_45;
    x_45 = ((a_38 - _DITHERMATRIX[
      int(tmpvar_41)
    ][
      int(tmpvar_44)
    ]) - 0.01);
    if ((x_45 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = _BloomFactor;
  tmpvar_1 = outColor_7;
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
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
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
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
}
}
 Pass {
  Name "OUTLINE"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 123023
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_8.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_8.z = 1.0;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  highp vec4 scrpos_3;
  scrpos_3 = xlv_TEXCOORD0;
  mediump float a_4;
  a_4 = xlv_TEXCOORD0.z;
  if ((a_4 < 0.95)) {
    scrpos_3.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_8.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_8.z = 1.0;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  highp vec4 scrpos_3;
  scrpos_3 = xlv_TEXCOORD0;
  mediump float a_4;
  a_4 = xlv_TEXCOORD0.z;
  if ((a_4 < 0.95)) {
    scrpos_3.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_8.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_8.z = 1.0;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  highp vec4 scrpos_3;
  scrpos_3 = xlv_TEXCOORD0;
  mediump float a_4;
  a_4 = xlv_TEXCOORD0.z;
  if ((a_4 < 0.95)) {
    scrpos_3.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_8.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_8.z = 1.0;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = outColor_2;
  };
  outColor_2 = outColor_4;
  highp vec4 scrpos_7;
  scrpos_7 = xlv_TEXCOORD0;
  mediump float a_8;
  a_8 = xlv_TEXCOORD0.z;
  if ((a_8 < 0.95)) {
    scrpos_7.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_4;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_8.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_8.z = 1.0;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = outColor_2;
  };
  outColor_2 = outColor_4;
  highp vec4 scrpos_7;
  scrpos_7 = xlv_TEXCOORD0;
  mediump float a_8;
  a_8 = xlv_TEXCOORD0.z;
  if ((a_8 < 0.95)) {
    scrpos_7.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_4;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlphaLeft;
uniform highp float _DitherAlphaRight;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
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
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlphaRight;
  if ((_glesColor.x > 0.5)) {
    tmpvar_8.z = _DitherAlphaLeft;
  };
  if ((_glesColor.x < 0.1)) {
    tmpvar_8.z = 1.0;
  };
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = outColor_2;
  };
  outColor_2 = outColor_4;
  highp vec4 scrpos_7;
  scrpos_7 = xlv_TEXCOORD0;
  mediump float a_8;
  a_8 = xlv_TEXCOORD0.z;
  if ((a_8 < 0.95)) {
    scrpos_7.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_4;
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
CustomEditor "MoleMole.CharacterShaderEditorBase"
}