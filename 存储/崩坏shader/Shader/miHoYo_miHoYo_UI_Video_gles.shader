//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Video" {
Properties {
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
[Toggle(_FLIP_X)] _flipX ("flip x", Float) = 0
[Toggle(_FLIP_Y)] _flipY ("flip y", Float) = 0
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 13210
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _flipX;
uniform mediump float _flipY;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  mediump vec4 col_2;
  if ((_flipX > 0.0)) {
    tmpvar_1.x = (1.0 - xlv_TEXCOORD0.x);
  };
  if ((_flipY > 0.0)) {
    tmpvar_1.y = (1.0 - xlv_TEXCOORD0.y);
  };
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_1);
  col_2.xyz = tmpvar_3.xyz;
  col_2.w = _BloomFactor;
  gl_FragData[0] = col_2;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _flipX;
uniform mediump float _flipY;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  mediump vec4 col_2;
  if ((_flipX > 0.0)) {
    tmpvar_1.x = (1.0 - xlv_TEXCOORD0.x);
  };
  if ((_flipY > 0.0)) {
    tmpvar_1.y = (1.0 - xlv_TEXCOORD0.y);
  };
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_1);
  col_2.xyz = tmpvar_3.xyz;
  col_2.w = _BloomFactor;
  gl_FragData[0] = col_2;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _flipX;
uniform mediump float _flipY;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  mediump vec4 col_2;
  if ((_flipX > 0.0)) {
    tmpvar_1.x = (1.0 - xlv_TEXCOORD0.x);
  };
  if ((_flipY > 0.0)) {
    tmpvar_1.y = (1.0 - xlv_TEXCOORD0.y);
  };
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_1);
  col_2.xyz = tmpvar_3.xyz;
  col_2.w = _BloomFactor;
  gl_FragData[0] = col_2;
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