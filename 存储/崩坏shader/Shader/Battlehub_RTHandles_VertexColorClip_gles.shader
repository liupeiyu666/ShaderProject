//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Battlehub/RTHandles/VertexColorClip" {
Properties {
_ZWrite ("ZWrite", Float) = 0
_ZTest ("ZTest", Float) = 0
_Cull ("Cull", Float) = 0
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry+5" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry+5" "RenderType" = "Opaque" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 28192
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp mat4 tmpvar_2;
  tmpvar_2[0].x = m_1[0].x;
  tmpvar_2[0].y = m_1[1].x;
  tmpvar_2[0].z = m_1[2].x;
  tmpvar_2[0].w = m_1[3].x;
  tmpvar_2[1].x = m_1[0].y;
  tmpvar_2[1].y = m_1[1].y;
  tmpvar_2[1].z = m_1[2].y;
  tmpvar_2[1].w = m_1[3].y;
  tmpvar_2[2].x = m_1[0].z;
  tmpvar_2[2].y = m_1[1].z;
  tmpvar_2[2].z = m_1[2].z;
  tmpvar_2[2].w = m_1[3].z;
  tmpvar_2[3].x = m_1[0].w;
  tmpvar_2[3].y = m_1[1].w;
  tmpvar_2[3].z = m_1[2].w;
  tmpvar_2[3].w = m_1[3].w;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesVertex;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_3.xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = tmpvar_3.xyz;
  tmpvar_5.xyz = tmpvar_4.xyz;
  tmpvar_5.w = tmpvar_4.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = normalize((tmpvar_2 * tmpvar_7)).xyz;
  xlv_COLOR = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  if ((xlv_TEXCOORD0.z < 0.0)) {
    discard;
  };
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp mat4 tmpvar_2;
  tmpvar_2[0].x = m_1[0].x;
  tmpvar_2[0].y = m_1[1].x;
  tmpvar_2[0].z = m_1[2].x;
  tmpvar_2[0].w = m_1[3].x;
  tmpvar_2[1].x = m_1[0].y;
  tmpvar_2[1].y = m_1[1].y;
  tmpvar_2[1].z = m_1[2].y;
  tmpvar_2[1].w = m_1[3].y;
  tmpvar_2[2].x = m_1[0].z;
  tmpvar_2[2].y = m_1[1].z;
  tmpvar_2[2].z = m_1[2].z;
  tmpvar_2[2].w = m_1[3].z;
  tmpvar_2[3].x = m_1[0].w;
  tmpvar_2[3].y = m_1[1].w;
  tmpvar_2[3].z = m_1[2].w;
  tmpvar_2[3].w = m_1[3].w;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesVertex;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_3.xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = tmpvar_3.xyz;
  tmpvar_5.xyz = tmpvar_4.xyz;
  tmpvar_5.w = tmpvar_4.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = normalize((tmpvar_2 * tmpvar_7)).xyz;
  xlv_COLOR = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  if ((xlv_TEXCOORD0.z < 0.0)) {
    discard;
  };
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp mat4 tmpvar_2;
  tmpvar_2[0].x = m_1[0].x;
  tmpvar_2[0].y = m_1[1].x;
  tmpvar_2[0].z = m_1[2].x;
  tmpvar_2[0].w = m_1[3].x;
  tmpvar_2[1].x = m_1[0].y;
  tmpvar_2[1].y = m_1[1].y;
  tmpvar_2[1].z = m_1[2].y;
  tmpvar_2[1].w = m_1[3].y;
  tmpvar_2[2].x = m_1[0].z;
  tmpvar_2[2].y = m_1[1].z;
  tmpvar_2[2].z = m_1[2].z;
  tmpvar_2[2].w = m_1[3].z;
  tmpvar_2[3].x = m_1[0].w;
  tmpvar_2[3].y = m_1[1].w;
  tmpvar_2[3].z = m_1[2].w;
  tmpvar_2[3].w = m_1[3].w;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesVertex;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_3.xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = tmpvar_3.xyz;
  tmpvar_5.xyz = tmpvar_4.xyz;
  tmpvar_5.w = tmpvar_4.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = normalize((tmpvar_2 * tmpvar_7)).xyz;
  xlv_COLOR = tmpvar_5;
}


#endif
#ifdef FRAGMENT
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  if ((xlv_TEXCOORD0.z < 0.0)) {
    discard;
  };
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