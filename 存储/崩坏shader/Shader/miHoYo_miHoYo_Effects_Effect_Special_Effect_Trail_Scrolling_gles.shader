//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect_Trail/Scrolling" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_ScrollU ("Scroll U", Float) = 1
_ScrollV ("Scroll V", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 36768
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _ScrollU;
  tmpvar_2.y = _ScrollV;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_2));
  tmpvar_3 = texture2D (_MainTex, P_4);
  highp vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_3 * _Color) * xlv_COLOR);
  c_1 = tmpvar_5;
  c_1.w = clamp (c_1.w, 0.0, 1.0);
  gl_FragData[0] = c_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _ScrollU;
  tmpvar_2.y = _ScrollV;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_2));
  tmpvar_3 = texture2D (_MainTex, P_4);
  highp vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_3 * _Color) * xlv_COLOR);
  c_1 = tmpvar_5;
  c_1.w = clamp (c_1.w, 0.0, 1.0);
  gl_FragData[0] = c_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _ScrollU;
  tmpvar_2.y = _ScrollV;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_2));
  tmpvar_3 = texture2D (_MainTex, P_4);
  highp vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_3 * _Color) * xlv_COLOR);
  c_1 = tmpvar_5;
  c_1.w = clamp (c_1.w, 0.0, 1.0);
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