//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Projector/Alpha Blend" {
Properties {
_MainColor ("Main Color", Color) = (0.05,0.24,0.35,1)
_Opaqueness ("Opaqueness", Range(0, 1)) = 0.75
_Cookie ("Cookie", 2D) = "white" { }
_FalloffTex ("FallOff", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" }
  ZWrite Off
  Offset -1, -1
  GpuProgramID 30284
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
uniform sampler2D _Cookie;
uniform sampler2D _FalloffTex;
uniform mediump float _Opaqueness;
uniform mediump vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 res_1;
  mediump vec4 texF_2;
  mediump vec4 texS_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_Cookie, xlv_TEXCOORD0);
  texS_3 = tmpvar_4;
  texS_3.w = (1.0 - texS_3.w);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_FalloffTex, xlv_TEXCOORD1);
  texF_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (vec4(1.0, 1.0, 1.0, 0.0), texS_3, texF_2.wwww);
  res_1.xyz = tmpvar_6.xyz;
  res_1.w = ((1.0 - tmpvar_6.x) * _Opaqueness);
  mediump float x_7;
  x_7 = (res_1.w - 0.01);
  if ((x_7 < 0.0)) {
    discard;
  };
  res_1.xyz = _MainColor.xyz;
  res_1.w = clamp (res_1.w, 0.0, 1.0);
  gl_FragData[0] = res_1;
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
uniform sampler2D _Cookie;
uniform sampler2D _FalloffTex;
uniform mediump float _Opaqueness;
uniform mediump vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 res_1;
  mediump vec4 texF_2;
  mediump vec4 texS_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_Cookie, xlv_TEXCOORD0);
  texS_3 = tmpvar_4;
  texS_3.w = (1.0 - texS_3.w);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_FalloffTex, xlv_TEXCOORD1);
  texF_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (vec4(1.0, 1.0, 1.0, 0.0), texS_3, texF_2.wwww);
  res_1.xyz = tmpvar_6.xyz;
  res_1.w = ((1.0 - tmpvar_6.x) * _Opaqueness);
  mediump float x_7;
  x_7 = (res_1.w - 0.01);
  if ((x_7 < 0.0)) {
    discard;
  };
  res_1.xyz = _MainColor.xyz;
  res_1.w = clamp (res_1.w, 0.0, 1.0);
  gl_FragData[0] = res_1;
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
uniform sampler2D _Cookie;
uniform sampler2D _FalloffTex;
uniform mediump float _Opaqueness;
uniform mediump vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 res_1;
  mediump vec4 texF_2;
  mediump vec4 texS_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_Cookie, xlv_TEXCOORD0);
  texS_3 = tmpvar_4;
  texS_3.w = (1.0 - texS_3.w);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_FalloffTex, xlv_TEXCOORD1);
  texF_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (vec4(1.0, 1.0, 1.0, 0.0), texS_3, texF_2.wwww);
  res_1.xyz = tmpvar_6.xyz;
  res_1.w = ((1.0 - tmpvar_6.x) * _Opaqueness);
  mediump float x_7;
  x_7 = (res_1.w - 0.01);
  if ((x_7 < 0.0)) {
    discard;
  };
  res_1.xyz = _MainColor.xyz;
  res_1.w = clamp (res_1.w, 0.0, 1.0);
  gl_FragData[0] = res_1;
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