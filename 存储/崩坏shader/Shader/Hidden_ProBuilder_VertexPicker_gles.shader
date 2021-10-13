//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/ProBuilder/VertexPicker" {
Properties {
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "ProBuilderPicker" = "VertexPass" "RenderType" = "Transparent" }
 Pass {
  Name "VERTICES"
  LOD 200
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "ProBuilderPicker" = "VertexPass" "RenderType" = "Transparent" }
  Cull Off
  Offset -1, -1
  GpuProgramID 47191
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 clip_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_4)).xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
  tmpvar_2.w = tmpvar_5.w;
  tmpvar_2.xyz = (tmpvar_3 * 0.95);
  tmpvar_2 = (glstate_matrix_projection * tmpvar_2);
  clip_1.zw = tmpvar_2.zw;
  clip_1.xy = (tmpvar_2.xy / tmpvar_2.w);
  clip_1.xy = ((clip_1.xy * 0.5) + 0.5);
  clip_1.xy = (clip_1.xy * _ScreenParams.xy);
  clip_1.xy = (clip_1.xy + (_glesMultiTexCoord1.xy * 3.5));
  clip_1.z = (tmpvar_2.z - (0.0001 * (1.0 - glstate_matrix_projection[3].w)));
  clip_1.xy = (clip_1.xy / _ScreenParams.xy);
  clip_1.xy = ((clip_1.xy - 0.5) / 0.5);
  clip_1.xy = (clip_1.xy * tmpvar_2.w);
  tmpvar_2 = clip_1;
  gl_Position = clip_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR = _glesColor;
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 clip_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_4)).xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
  tmpvar_2.w = tmpvar_5.w;
  tmpvar_2.xyz = (tmpvar_3 * 0.95);
  tmpvar_2 = (glstate_matrix_projection * tmpvar_2);
  clip_1.zw = tmpvar_2.zw;
  clip_1.xy = (tmpvar_2.xy / tmpvar_2.w);
  clip_1.xy = ((clip_1.xy * 0.5) + 0.5);
  clip_1.xy = (clip_1.xy * _ScreenParams.xy);
  clip_1.xy = (clip_1.xy + (_glesMultiTexCoord1.xy * 3.5));
  clip_1.z = (tmpvar_2.z - (0.0001 * (1.0 - glstate_matrix_projection[3].w)));
  clip_1.xy = (clip_1.xy / _ScreenParams.xy);
  clip_1.xy = ((clip_1.xy - 0.5) / 0.5);
  clip_1.xy = (clip_1.xy * tmpvar_2.w);
  tmpvar_2 = clip_1;
  gl_Position = clip_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR = _glesColor;
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 clip_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_4)).xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
  tmpvar_2.w = tmpvar_5.w;
  tmpvar_2.xyz = (tmpvar_3 * 0.95);
  tmpvar_2 = (glstate_matrix_projection * tmpvar_2);
  clip_1.zw = tmpvar_2.zw;
  clip_1.xy = (tmpvar_2.xy / tmpvar_2.w);
  clip_1.xy = ((clip_1.xy * 0.5) + 0.5);
  clip_1.xy = (clip_1.xy * _ScreenParams.xy);
  clip_1.xy = (clip_1.xy + (_glesMultiTexCoord1.xy * 3.5));
  clip_1.z = (tmpvar_2.z - (0.0001 * (1.0 - glstate_matrix_projection[3].w)));
  clip_1.xy = (clip_1.xy / _ScreenParams.xy);
  clip_1.xy = ((clip_1.xy - 0.5) / 0.5);
  clip_1.xy = (clip_1.xy * tmpvar_2.w);
  tmpvar_2 = clip_1;
  gl_Position = clip_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR = _glesColor;
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