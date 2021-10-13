//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/StarCompositionEx" {
Properties {
_MainTex0 ("Level0", 2D) = "" { }
_MainTex1 ("Level1", 2D) = "" { }
_MainTex2 ("Level2", 2D) = "" { }
_MainTex3 ("Level3", 2D) = "" { }
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 54322
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex0;
uniform sampler2D _MainTex1;
uniform sampler2D _MainTex2;
uniform sampler2D _MainTex3;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color2_1;
  mediump vec4 color1_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = max (texture2D (_MainTex0, xlv_TEXCOORD0), texture2D (_MainTex1, xlv_TEXCOORD0));
  color1_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = max (texture2D (_MainTex2, xlv_TEXCOORD0), texture2D (_MainTex3, xlv_TEXCOORD0));
  color2_1 = tmpvar_4;
  gl_FragData[0] = max (color1_2, color2_1);
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex0;
uniform sampler2D _MainTex1;
uniform sampler2D _MainTex2;
uniform sampler2D _MainTex3;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color2_1;
  mediump vec4 color1_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = max (texture2D (_MainTex0, xlv_TEXCOORD0), texture2D (_MainTex1, xlv_TEXCOORD0));
  color1_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = max (texture2D (_MainTex2, xlv_TEXCOORD0), texture2D (_MainTex3, xlv_TEXCOORD0));
  color2_1 = tmpvar_4;
  gl_FragData[0] = max (color1_2, color2_1);
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex0;
uniform sampler2D _MainTex1;
uniform sampler2D _MainTex2;
uniform sampler2D _MainTex3;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color2_1;
  mediump vec4 color1_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = max (texture2D (_MainTex0, xlv_TEXCOORD0), texture2D (_MainTex1, xlv_TEXCOORD0));
  color1_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = max (texture2D (_MainTex2, xlv_TEXCOORD0), texture2D (_MainTex3, xlv_TEXCOORD0));
  color2_1 = tmpvar_4;
  gl_FragData[0] = max (color1_2, color2_1);
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
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 125642
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex0;
uniform sampler2D _MainTex1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = max (texture2D (_MainTex0, xlv_TEXCOORD0), texture2D (_MainTex1, xlv_TEXCOORD0));
  tmpvar_1 = tmpvar_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex0;
uniform sampler2D _MainTex1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = max (texture2D (_MainTex0, xlv_TEXCOORD0), texture2D (_MainTex1, xlv_TEXCOORD0));
  tmpvar_1 = tmpvar_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex0;
uniform sampler2D _MainTex1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = max (texture2D (_MainTex0, xlv_TEXCOORD0), texture2D (_MainTex1, xlv_TEXCOORD0));
  tmpvar_1 = tmpvar_2;
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