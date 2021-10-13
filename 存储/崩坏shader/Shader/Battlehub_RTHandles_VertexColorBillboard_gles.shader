//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Battlehub/RTHandles/VertexColorBillboard" {
Properties {
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 14196
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 x_3;
  x_3 = (unity_ObjectToWorld * vec4(1.0, 0.0, 0.0, 0.0));
  highp vec4 x_4;
  x_4 = (unity_ObjectToWorld * vec4(0.0, 1.0, 0.0, 0.0));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = (unity_MatrixV * (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0))).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.x = (_glesVertex.x * sqrt(dot (x_3, x_3)));
  tmpvar_6.y = (_glesVertex.y * sqrt(dot (x_4, x_4)));
  tmpvar_2.xyz = tmpvar_1.xyz;
  tmpvar_2.w = tmpvar_1.w;
  gl_Position = (glstate_matrix_projection * (tmpvar_5 - tmpvar_6));
  xlv_COLOR = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 x_3;
  x_3 = (unity_ObjectToWorld * vec4(1.0, 0.0, 0.0, 0.0));
  highp vec4 x_4;
  x_4 = (unity_ObjectToWorld * vec4(0.0, 1.0, 0.0, 0.0));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = (unity_MatrixV * (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0))).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.x = (_glesVertex.x * sqrt(dot (x_3, x_3)));
  tmpvar_6.y = (_glesVertex.y * sqrt(dot (x_4, x_4)));
  tmpvar_2.xyz = tmpvar_1.xyz;
  tmpvar_2.w = tmpvar_1.w;
  gl_Position = (glstate_matrix_projection * (tmpvar_5 - tmpvar_6));
  xlv_COLOR = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 x_3;
  x_3 = (unity_ObjectToWorld * vec4(1.0, 0.0, 0.0, 0.0));
  highp vec4 x_4;
  x_4 = (unity_ObjectToWorld * vec4(0.0, 1.0, 0.0, 0.0));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = (unity_MatrixV * (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0))).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.x = (_glesVertex.x * sqrt(dot (x_3, x_3)));
  tmpvar_6.y = (_glesVertex.y * sqrt(dot (x_4, x_4)));
  tmpvar_2.xyz = tmpvar_1.xyz;
  tmpvar_2.w = tmpvar_1.w;
  gl_Position = (glstate_matrix_projection * (tmpvar_5 - tmpvar_6));
  xlv_COLOR = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
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