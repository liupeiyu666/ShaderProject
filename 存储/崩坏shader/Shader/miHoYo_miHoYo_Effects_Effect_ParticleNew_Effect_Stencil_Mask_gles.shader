//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_Stencil_Mask" {
Properties {
_MainColor ("MainColor", Color) = (0,0,0,0)
_Opacity ("Opacity", Float) = 1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 18261
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp float _Opacity;
uniform highp vec4 _MainColor;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  aseOutAlpha_2 = _Opacity;
  highp vec3 tmpvar_3;
  tmpvar_3 = _MainColor.xyz;
  aseOutColor_1 = tmpvar_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = aseOutColor_1;
  tmpvar_5.w = tmpvar_4;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp float _Opacity;
uniform highp vec4 _MainColor;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  aseOutAlpha_2 = _Opacity;
  highp vec3 tmpvar_3;
  tmpvar_3 = _MainColor.xyz;
  aseOutColor_1 = tmpvar_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = aseOutColor_1;
  tmpvar_5.w = tmpvar_4;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp float _Opacity;
uniform highp vec4 _MainColor;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  aseOutAlpha_2 = _Opacity;
  highp vec3 tmpvar_3;
  tmpvar_3 = _MainColor.xyz;
  aseOutColor_1 = tmpvar_3;
  mediump float tmpvar_4;
  tmpvar_4 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = aseOutColor_1;
  tmpvar_5.w = tmpvar_4;
  gl_FragData[0] = tmpvar_5;
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
CustomEditor "ASEMaterialInspector"
}