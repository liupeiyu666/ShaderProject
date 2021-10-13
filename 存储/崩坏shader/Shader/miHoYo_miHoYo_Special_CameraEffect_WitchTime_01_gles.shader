//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/CameraEffect/WitchTime_01" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZWrite Off
  Cull Off
  GpuProgramID 26615
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD);
  mediump vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _Color);
  c_1.xyz = (tmpvar_3.xyz * tmpvar_3.w);
  c_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
  gl_FragData[0] = c_1;
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
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD);
  mediump vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _Color);
  c_1.xyz = (tmpvar_3.xyz * tmpvar_3.w);
  c_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
  gl_FragData[0] = c_1;
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
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD);
  mediump vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _Color);
  c_1.xyz = (tmpvar_3.xyz * tmpvar_3.w);
  c_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
  gl_FragData[0] = c_1;
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