//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/RainDistortion" {
Properties {
_Strength ("Distortion Strength", Range(0, 1000)) = 50
_Distortion ("Normalmap", 2D) = "bump" { }
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Always
  GpuProgramID 1204
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _CameraTex_TexelSize;
uniform mediump float _Strength;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_Strength * _CameraTex_TexelSize.xy);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Distortion;
uniform sampler2D _CameraTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2.zw = xlv_TEXCOORD1.zw;
  mediump vec2 norm_3;
  lowp vec2 tmpvar_4;
  tmpvar_4 = ((texture2D (_Distortion, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xy;
  norm_3 = tmpvar_4;
  tmpvar_2.xy = (xlv_TEXCOORD1.xy - (xlv_TEXCOORD2 * norm_3));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_CameraTex, tmpvar_2);
  tmpvar_1 = tmpvar_5;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _CameraTex_TexelSize;
uniform mediump float _Strength;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_Strength * _CameraTex_TexelSize.xy);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Distortion;
uniform sampler2D _CameraTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2.zw = xlv_TEXCOORD1.zw;
  mediump vec2 norm_3;
  lowp vec2 tmpvar_4;
  tmpvar_4 = ((texture2D (_Distortion, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xy;
  norm_3 = tmpvar_4;
  tmpvar_2.xy = (xlv_TEXCOORD1.xy - (xlv_TEXCOORD2 * norm_3));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_CameraTex, tmpvar_2);
  tmpvar_1 = tmpvar_5;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _CameraTex_TexelSize;
uniform mediump float _Strength;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (_Strength * _CameraTex_TexelSize.xy);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Distortion;
uniform sampler2D _CameraTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2.zw = xlv_TEXCOORD1.zw;
  mediump vec2 norm_3;
  lowp vec2 tmpvar_4;
  tmpvar_4 = ((texture2D (_Distortion, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xy;
  norm_3 = tmpvar_4;
  tmpvar_2.xy = (xlv_TEXCOORD1.xy - (xlv_TEXCOORD2 * norm_3));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_CameraTex, tmpvar_2);
  tmpvar_1 = tmpvar_5;
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
}