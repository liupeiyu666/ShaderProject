//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect_Trail/ScrollingMulti" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_ScrollU1 ("Scroll U1", Float) = 1
_ScrollV1 ("Scroll V1", Float) = 1
_ScrollU2 ("Scroll U2", Float) = 1
_ScrollV2 ("Scroll V2", Float) = 1
_Boost ("Boost", Float) = 1
_MainTex ("Base (RGB) Trans (A) 1", 2D) = "white" { }
_MainTex2 ("Base (RGB) Trans (A) 2", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 50015
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
uniform sampler2D _MainTex2;
uniform mediump vec4 _Color;
uniform highp float _ScrollU1;
uniform highp float _ScrollV1;
uniform highp float _ScrollU2;
uniform highp float _ScrollV2;
uniform highp float _Boost;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec4 c_1;
  mediump vec4 c2_2;
  mediump vec4 c1_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU1;
  tmpvar_4.y = _ScrollV1;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  c1_3 = tmpvar_5;
  highp vec2 tmpvar_7;
  tmpvar_7.x = _ScrollU2;
  tmpvar_7.y = _ScrollV2;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_7));
  tmpvar_8 = texture2D (_MainTex2, P_9);
  c2_2 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10 = ((c1_3 * c2_2) * ((_Color * xlv_COLOR) * _Boost));
  c_1 = tmpvar_10;
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
uniform sampler2D _MainTex2;
uniform mediump vec4 _Color;
uniform highp float _ScrollU1;
uniform highp float _ScrollV1;
uniform highp float _ScrollU2;
uniform highp float _ScrollV2;
uniform highp float _Boost;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec4 c_1;
  mediump vec4 c2_2;
  mediump vec4 c1_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU1;
  tmpvar_4.y = _ScrollV1;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  c1_3 = tmpvar_5;
  highp vec2 tmpvar_7;
  tmpvar_7.x = _ScrollU2;
  tmpvar_7.y = _ScrollV2;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_7));
  tmpvar_8 = texture2D (_MainTex2, P_9);
  c2_2 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10 = ((c1_3 * c2_2) * ((_Color * xlv_COLOR) * _Boost));
  c_1 = tmpvar_10;
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
uniform sampler2D _MainTex2;
uniform mediump vec4 _Color;
uniform highp float _ScrollU1;
uniform highp float _ScrollV1;
uniform highp float _ScrollU2;
uniform highp float _ScrollV2;
uniform highp float _Boost;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec4 c_1;
  mediump vec4 c2_2;
  mediump vec4 c1_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU1;
  tmpvar_4.y = _ScrollV1;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  c1_3 = tmpvar_5;
  highp vec2 tmpvar_7;
  tmpvar_7.x = _ScrollU2;
  tmpvar_7.y = _ScrollV2;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_7));
  tmpvar_8 = texture2D (_MainTex2, P_9);
  c2_2 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10 = ((c1_3 * c2_2) * ((_Color * xlv_COLOR) * _Boost));
  c_1 = tmpvar_10;
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