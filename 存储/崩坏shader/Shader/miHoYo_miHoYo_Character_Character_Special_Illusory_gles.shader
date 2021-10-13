//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Special/Illusory" {
Properties {
_Color ("Main Color", Color) = (1,1,1,0.5)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_ColorScaler ("Color Scaler", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 0.5
_RimShininess ("Rim Shininess", Range(0.1, 100)) = 10
_RimThreshold ("Rim Threshold", Range(0, 1)) = 0.5
_RimIntensity ("Rim Intensity", Range(0, 10)) = 0.5
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 32123
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _Opaqueness;
uniform mediump float _ColorScaler;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = ((_Color.xyz * _ColorScaler) * _EnvColor.xyz);
  color_1.w = clamp (_Opaqueness, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _Opaqueness;
uniform mediump float _ColorScaler;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = ((_Color.xyz * _ColorScaler) * _EnvColor.xyz);
  color_1.w = clamp (_Opaqueness, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _Opaqueness;
uniform mediump float _ColorScaler;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = ((_Color.xyz * _ColorScaler) * _EnvColor.xyz);
  color_1.w = clamp (_Opaqueness, 0.0, 1.0);
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
 Pass {
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 120339
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (unity_MatrixMV * _glesVertex).xyz;
  tmpvar_2 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_MatrixMV[0].xyz;
  tmpvar_4[1] = unity_MatrixMV[1].xyz;
  tmpvar_4[2] = unity_MatrixMV[2].xyz;
  tmpvar_1 = (tmpvar_4 * _glesTANGENT.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _Opaqueness;
uniform mediump float _ColorScaler;
uniform mediump float _RimShininess;
uniform mediump float _RimThreshold;
uniform mediump float _RimIntensity;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump float rim_1;
  mediump vec4 color_2;
  mediump float tmpvar_3;
  tmpvar_3 = pow ((1.0 - max (0.0, 
    dot (normalize(xlv_TEXCOORD0), -(normalize(xlv_TEXCOORD1)))
  )), _RimShininess);
  rim_1 = tmpvar_3;
  if ((tmpvar_3 >= _RimThreshold)) {
    rim_1 = _RimIntensity;
  } else {
    rim_1 = 0.0;
  };
  color_2.xyz = (((
    (1.0 + rim_1)
   * _Color.xyz) * _ColorScaler) * _EnvColor.xyz);
  color_2.w = clamp (_Opaqueness, 0.0, 1.0);
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (unity_MatrixMV * _glesVertex).xyz;
  tmpvar_2 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_MatrixMV[0].xyz;
  tmpvar_4[1] = unity_MatrixMV[1].xyz;
  tmpvar_4[2] = unity_MatrixMV[2].xyz;
  tmpvar_1 = (tmpvar_4 * _glesTANGENT.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _Opaqueness;
uniform mediump float _ColorScaler;
uniform mediump float _RimShininess;
uniform mediump float _RimThreshold;
uniform mediump float _RimIntensity;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump float rim_1;
  mediump vec4 color_2;
  mediump float tmpvar_3;
  tmpvar_3 = pow ((1.0 - max (0.0, 
    dot (normalize(xlv_TEXCOORD0), -(normalize(xlv_TEXCOORD1)))
  )), _RimShininess);
  rim_1 = tmpvar_3;
  if ((tmpvar_3 >= _RimThreshold)) {
    rim_1 = _RimIntensity;
  } else {
    rim_1 = 0.0;
  };
  color_2.xyz = (((
    (1.0 + rim_1)
   * _Color.xyz) * _ColorScaler) * _EnvColor.xyz);
  color_2.w = clamp (_Opaqueness, 0.0, 1.0);
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (unity_MatrixMV * _glesVertex).xyz;
  tmpvar_2 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_MatrixMV[0].xyz;
  tmpvar_4[1] = unity_MatrixMV[1].xyz;
  tmpvar_4[2] = unity_MatrixMV[2].xyz;
  tmpvar_1 = (tmpvar_4 * _glesTANGENT.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _Opaqueness;
uniform mediump float _ColorScaler;
uniform mediump float _RimShininess;
uniform mediump float _RimThreshold;
uniform mediump float _RimIntensity;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump float rim_1;
  mediump vec4 color_2;
  mediump float tmpvar_3;
  tmpvar_3 = pow ((1.0 - max (0.0, 
    dot (normalize(xlv_TEXCOORD0), -(normalize(xlv_TEXCOORD1)))
  )), _RimShininess);
  rim_1 = tmpvar_3;
  if ((tmpvar_3 >= _RimThreshold)) {
    rim_1 = _RimIntensity;
  } else {
    rim_1 = 0.0;
  };
  color_2.xyz = (((
    (1.0 + rim_1)
   * _Color.xyz) * _ColorScaler) * _EnvColor.xyz);
  color_2.w = clamp (_Opaqueness, 0.0, 1.0);
  gl_FragData[0] = color_2;
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
  Name "CONSTANT_REPLACE_NOCUTOFF"
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 155624
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
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