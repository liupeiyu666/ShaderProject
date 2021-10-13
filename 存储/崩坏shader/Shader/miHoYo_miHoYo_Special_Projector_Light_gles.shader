//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Projector/Light" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_ShadowTex ("Cookie", 2D) = "" { }
_FalloffTex ("FallOff", 2D) = "" { }
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" }
  ZWrite Off
  Offset -1, -1
  GpuProgramID 19973
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp mat4 unity_Projector;
uniform highp mat4 unity_ProjectorClip;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (unity_Projector * _glesVertex);
  xlv_TEXCOORD1 = (unity_ProjectorClip * _glesVertex);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform sampler2D _FalloffTex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 texF_1;
  mediump vec4 texS_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2DProj (_ShadowTex, xlv_TEXCOORD0);
  texS_2 = tmpvar_3;
  texS_2.xyz = (texS_2.xyz * _Color.xyz);
  texS_2.w = (1.0 - texS_2.w);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_FalloffTex, xlv_TEXCOORD1);
  texF_1 = tmpvar_4;
  gl_FragData[0] = (texS_2 * texF_1.w);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp mat4 unity_Projector;
uniform highp mat4 unity_ProjectorClip;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (unity_Projector * _glesVertex);
  xlv_TEXCOORD1 = (unity_ProjectorClip * _glesVertex);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform sampler2D _FalloffTex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 texF_1;
  mediump vec4 texS_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2DProj (_ShadowTex, xlv_TEXCOORD0);
  texS_2 = tmpvar_3;
  texS_2.xyz = (texS_2.xyz * _Color.xyz);
  texS_2.w = (1.0 - texS_2.w);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_FalloffTex, xlv_TEXCOORD1);
  texF_1 = tmpvar_4;
  gl_FragData[0] = (texS_2 * texF_1.w);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp mat4 unity_Projector;
uniform highp mat4 unity_ProjectorClip;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (unity_Projector * _glesVertex);
  xlv_TEXCOORD1 = (unity_ProjectorClip * _glesVertex);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _ShadowTex;
uniform sampler2D _FalloffTex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 texF_1;
  mediump vec4 texS_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2DProj (_ShadowTex, xlv_TEXCOORD0);
  texS_2 = tmpvar_3;
  texS_2.xyz = (texS_2.xyz * _Color.xyz);
  texS_2.w = (1.0 - texS_2.w);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_FalloffTex, xlv_TEXCOORD1);
  texF_1 = tmpvar_4;
  gl_FragData[0] = (texS_2 * texF_1.w);
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