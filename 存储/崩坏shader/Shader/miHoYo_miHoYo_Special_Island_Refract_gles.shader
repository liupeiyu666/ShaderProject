//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Island/Refract" {
Properties {
_CausticColor ("Caustic Color", Color) = (1,0,0,1)
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_Speed ("Speed", Range(0.001, 2)) = 0.5
_Frequency ("Frequency", Range(1, 200)) = 20
_Delta ("Delta", Range(0, 0.1)) = 0.01
_PhaseOffset ("PhaseOffset", Range(0, 6)) = 0
_CausticScale ("CausticScale", Range(0, 10)) = 3
_MainIntensity ("MainIntensity", Range(0, 1)) = 1
_CausticIntensity ("CausticIntensity", Range(0, 5)) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_CausticTex ("CausticMap (RGB)", 2D) = "black" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 33834
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord1.xy;
  xlv_COLOR1 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _CausticTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _MainIntensity;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  highp vec2 p_6;
  mediump vec4 outColor_7;
  p_6 = xlv_TEXCOORD0;
  highp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _Speed);
  tmpvar_8 = (cos((
    ((p_6.x + tmpvar_9) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_5 = tmpvar_8;
  highp float tmpvar_10;
  tmpvar_10 = (cos((
    ((p_6.y + tmpvar_9) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_4 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = dx_5;
  tmpvar_11.y = dy_4;
  p_6 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * _MainIntensity);
  tex_C_Color_3 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_14;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + p_6) * _CausticScale);
  tmpvar_15 = texture2D (_CausticTex, P_16);
  colorBlendLightMap_1 = (colorBlendLightMap_1 + ((tmpvar_15.y * _CausticColor.xyz) * (_CausticIntensity * xlv_COLOR1.w)));
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord1.xy;
  xlv_COLOR1 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _CausticTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _MainIntensity;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  highp vec2 p_6;
  mediump vec4 outColor_7;
  p_6 = xlv_TEXCOORD0;
  highp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _Speed);
  tmpvar_8 = (cos((
    ((p_6.x + tmpvar_9) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_5 = tmpvar_8;
  highp float tmpvar_10;
  tmpvar_10 = (cos((
    ((p_6.y + tmpvar_9) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_4 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = dx_5;
  tmpvar_11.y = dy_4;
  p_6 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * _MainIntensity);
  tex_C_Color_3 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_14;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + p_6) * _CausticScale);
  tmpvar_15 = texture2D (_CausticTex, P_16);
  colorBlendLightMap_1 = (colorBlendLightMap_1 + ((tmpvar_15.y * _CausticColor.xyz) * (_CausticIntensity * xlv_COLOR1.w)));
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord1.xy;
  xlv_COLOR1 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _CausticTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta;
uniform highp float _PhaseOffset;
uniform highp float _CausticScale;
uniform highp float _MainIntensity;
uniform highp float _CausticIntensity;
uniform highp vec4 _CausticColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  highp vec2 p_6;
  mediump vec4 outColor_7;
  p_6 = xlv_TEXCOORD0;
  highp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _Speed);
  tmpvar_8 = (cos((
    ((p_6.x + tmpvar_9) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dx_5 = tmpvar_8;
  highp float tmpvar_10;
  tmpvar_10 = (cos((
    ((p_6.y + tmpvar_9) * _Frequency)
   + _PhaseOffset)) * _Delta);
  dy_4 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = dx_5;
  tmpvar_11.y = dy_4;
  p_6 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * _MainIntensity);
  tex_C_Color_3 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_14;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + p_6) * _CausticScale);
  tmpvar_15 = texture2D (_CausticTex, P_16);
  colorBlendLightMap_1 = (colorBlendLightMap_1 + ((tmpvar_15.y * _CausticColor.xyz) * (_CausticIntensity * xlv_COLOR1.w)));
  outColor_7.xyz = colorBlendLightMap_1;
  outColor_7.w = _BloomFactor;
  gl_FragData[0] = outColor_7;
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