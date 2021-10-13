//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Stencil_Up" {
Properties {
_MainColor ("MainColor", Color) = (0,0,0,0)
_MaskTexture ("MaskTexture", 2D) = "white" { }
_Intensity ("Intensity", Float) = 0
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 48777
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MaskTexture;
uniform highp vec4 _MaskTexture_ST;
uniform highp vec4 _MainColor;
uniform highp float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_MaskTexture, tmpvar_3).x;
  aseOutAlpha_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_MainColor * _Intensity).xyz;
  aseOutColor_1 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7.xyz = aseOutColor_1;
  tmpvar_7.w = tmpvar_6;
  gl_FragData[0] = tmpvar_7;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MaskTexture;
uniform highp vec4 _MaskTexture_ST;
uniform highp vec4 _MainColor;
uniform highp float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_MaskTexture, tmpvar_3).x;
  aseOutAlpha_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_MainColor * _Intensity).xyz;
  aseOutColor_1 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7.xyz = aseOutColor_1;
  tmpvar_7.w = tmpvar_6;
  gl_FragData[0] = tmpvar_7;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MaskTexture;
uniform highp vec4 _MaskTexture_ST;
uniform highp vec4 _MainColor;
uniform highp float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD0.xy * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_MaskTexture, tmpvar_3).x;
  aseOutAlpha_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_MainColor * _Intensity).xyz;
  aseOutColor_1 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7.xyz = aseOutColor_1;
  tmpvar_7.w = tmpvar_6;
  gl_FragData[0] = tmpvar_7;
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