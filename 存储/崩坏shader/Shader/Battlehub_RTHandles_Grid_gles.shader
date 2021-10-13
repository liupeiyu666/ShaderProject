//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Battlehub/RTHandles/Grid" {
Properties {
_ZWrite ("ZWrite", Float) = 0
_ZTest ("ZTest", Float) = 0
_Cull ("Cull", Float) = 0
_FadeDistance ("FadeDistance", Float) = 50
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+5" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+5" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 5646
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2.xyz = tmpvar_1.xyz;
  tmpvar_2.w = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FadeDistance;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec3 cam_1;
  highp vec4 col_2;
  col_2.xyz = xlv_COLOR.xyz;
  cam_1.xz = _WorldSpaceCameraPos.xz;
  cam_1.y = xlv_TEXCOORD0.y;
  highp vec3 x_3;
  x_3 = (cam_1 - xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp ((1.0 - (
    sqrt(dot (x_3, x_3))
   / _FadeDistance)), 0.0, 1.0);
  col_2.w = ((xlv_COLOR.w * tmpvar_4) * tmpvar_4);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2.xyz = tmpvar_1.xyz;
  tmpvar_2.w = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FadeDistance;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec3 cam_1;
  highp vec4 col_2;
  col_2.xyz = xlv_COLOR.xyz;
  cam_1.xz = _WorldSpaceCameraPos.xz;
  cam_1.y = xlv_TEXCOORD0.y;
  highp vec3 x_3;
  x_3 = (cam_1 - xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp ((1.0 - (
    sqrt(dot (x_3, x_3))
   / _FadeDistance)), 0.0, 1.0);
  col_2.w = ((xlv_COLOR.w * tmpvar_4) * tmpvar_4);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2.xyz = tmpvar_1.xyz;
  tmpvar_2.w = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FadeDistance;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec3 cam_1;
  highp vec4 col_2;
  col_2.xyz = xlv_COLOR.xyz;
  cam_1.xz = _WorldSpaceCameraPos.xz;
  cam_1.y = xlv_TEXCOORD0.y;
  highp vec3 x_3;
  x_3 = (cam_1 - xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = clamp ((1.0 - (
    sqrt(dot (x_3, x_3))
   / _FadeDistance)), 0.0, 1.0);
  col_2.w = ((xlv_COLOR.w * tmpvar_4) * tmpvar_4);
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