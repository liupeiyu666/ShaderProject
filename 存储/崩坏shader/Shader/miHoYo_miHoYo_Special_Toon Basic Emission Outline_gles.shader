//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Toon Basic Emission Outline" {
Properties {
_EmissionColor ("Main Emission Color(128 is standard)", Color) = (1,1,1,1)
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Outline ("Outline width(0.002 - 0.05)", Float) = 0.005
_MainTex ("Base (RGB)", 2D) = "white" { }
}
SubShader {
 LOD 200
 Pass {
  Name "BASE"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 24338
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _EmissionColor;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = ((2.0 * col_1.xyz) * _EmissionColor.xyz);
  tmpvar_3.w = col_1.w;
  gl_FragData[0] = tmpvar_3;
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
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _EmissionColor;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = ((2.0 * col_1.xyz) * _EmissionColor.xyz);
  tmpvar_3.w = col_1.w;
  gl_FragData[0] = tmpvar_3;
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
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _EmissionColor;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = ((2.0 * col_1.xyz) * _EmissionColor.xyz);
  tmpvar_3.w = col_1.w;
  gl_FragData[0] = tmpvar_3;
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
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 71924
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Outline;
uniform mediump vec4 _OutlineColor;
varying mediump vec4 xlv_COLOR;
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
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5.zw = tmpvar_7.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = tmpvar_2.xyz;
  tmpvar_9[1] = tmpvar_3.xyz;
  tmpvar_9[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_projection[0].xy;
  tmpvar_10[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_7.xy + ((tmpvar_10 * 
    (tmpvar_9 * _glesNormal)
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  tmpvar_6.w = _OutlineColor.w;
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  tmpvar_1.w = clamp (xlv_COLOR.w, 0.0, 1.0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Outline;
uniform mediump vec4 _OutlineColor;
varying mediump vec4 xlv_COLOR;
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
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5.zw = tmpvar_7.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = tmpvar_2.xyz;
  tmpvar_9[1] = tmpvar_3.xyz;
  tmpvar_9[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_projection[0].xy;
  tmpvar_10[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_7.xy + ((tmpvar_10 * 
    (tmpvar_9 * _glesNormal)
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  tmpvar_6.w = _OutlineColor.w;
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  tmpvar_1.w = clamp (xlv_COLOR.w, 0.0, 1.0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Outline;
uniform mediump vec4 _OutlineColor;
varying mediump vec4 xlv_COLOR;
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
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5.zw = tmpvar_7.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = tmpvar_2.xyz;
  tmpvar_9[1] = tmpvar_3.xyz;
  tmpvar_9[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_projection[0].xy;
  tmpvar_10[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_7.xy + ((tmpvar_10 * 
    (tmpvar_9 * _glesNormal)
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  tmpvar_6.w = _OutlineColor.w;
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  tmpvar_1.w = clamp (xlv_COLOR.w, 0.0, 1.0);
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
Fallback "Diffuse"
}