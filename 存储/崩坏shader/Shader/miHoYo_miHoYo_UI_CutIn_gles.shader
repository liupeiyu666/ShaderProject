//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/CutIn" {
Properties {
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_MainTest ("MainTest (A)", 2D) = "white" { }
_AlphaTex ("AlphaTex (A)", 2D) = "white" { }
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "AlphaTest" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "AlphaTest" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 29053
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTest_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTest_ST.xy) + _MainTest_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTest;
uniform sampler2D _AlphaTex;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 coltest_1;
  mediump vec4 colAlpha_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  colAlpha_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTest, xlv_TEXCOORD0);
  coltest_1 = tmpvar_5;
  mediump float x_6;
  x_6 = (colAlpha_2.x - 0.2);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_3.w = colAlpha_2.x;
  col_3.xyz = coltest_1.xyz;
  gl_FragData[0] = col_3;
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
uniform highp vec4 _MainTest_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTest_ST.xy) + _MainTest_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTest;
uniform sampler2D _AlphaTex;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 coltest_1;
  mediump vec4 colAlpha_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  colAlpha_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTest, xlv_TEXCOORD0);
  coltest_1 = tmpvar_5;
  mediump float x_6;
  x_6 = (colAlpha_2.x - 0.2);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_3.w = colAlpha_2.x;
  col_3.xyz = coltest_1.xyz;
  gl_FragData[0] = col_3;
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
uniform highp vec4 _MainTest_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTest_ST.xy) + _MainTest_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTest;
uniform sampler2D _AlphaTex;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 coltest_1;
  mediump vec4 colAlpha_2;
  mediump vec4 col_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  colAlpha_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTest, xlv_TEXCOORD0);
  coltest_1 = tmpvar_5;
  mediump float x_6;
  x_6 = (colAlpha_2.x - 0.2);
  if ((x_6 < 0.0)) {
    discard;
  };
  col_3.w = colAlpha_2.x;
  col_3.xyz = coltest_1.xyz;
  gl_FragData[0] = col_3;
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