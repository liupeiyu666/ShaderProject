//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_Stencil_Down_Alpha" {
Properties {
_mainColor ("mainColor", Color) = (0.735849,0,0,0)
_mainColorIntensity ("mainColorIntensity", Float) = 1
_MainTex ("MainTex", 2D) = "white" { }
_mainTiling ("mainTiling", Vector) = (0,0,0,0)
_mainSpeed ("mainSpeed", Vector) = (0,0,0,0)
_Opacity ("Opacity", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Always
  Cull Front
  GpuProgramID 40367
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
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _mainColorIntensity;
uniform highp vec2 _mainSpeed;
uniform highp vec2 _mainTiling;
uniform highp float _Opacity;
uniform highp vec4 _mainColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode3_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_Time.y * _mainSpeed) + (xlv_TEXCOORD0.xy * _mainTiling));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  tex2DNode3_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (tex2DNode3_3.x * _Opacity);
  aseOutAlpha_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_mainColor * tex2DNode3_3) * _mainColorIntensity).xyz;
  aseOutColor_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = aseOutColor_1;
  tmpvar_9.w = tmpvar_8;
  gl_FragData[0] = tmpvar_9;
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
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _mainColorIntensity;
uniform highp vec2 _mainSpeed;
uniform highp vec2 _mainTiling;
uniform highp float _Opacity;
uniform highp vec4 _mainColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode3_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_Time.y * _mainSpeed) + (xlv_TEXCOORD0.xy * _mainTiling));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  tex2DNode3_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (tex2DNode3_3.x * _Opacity);
  aseOutAlpha_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_mainColor * tex2DNode3_3) * _mainColorIntensity).xyz;
  aseOutColor_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = aseOutColor_1;
  tmpvar_9.w = tmpvar_8;
  gl_FragData[0] = tmpvar_9;
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
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp float _mainColorIntensity;
uniform highp vec2 _mainSpeed;
uniform highp vec2 _mainTiling;
uniform highp float _Opacity;
uniform highp vec4 _mainColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode3_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_Time.y * _mainSpeed) + (xlv_TEXCOORD0.xy * _mainTiling));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  tex2DNode3_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (tex2DNode3_3.x * _Opacity);
  aseOutAlpha_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_mainColor * tex2DNode3_3) * _mainColorIntensity).xyz;
  aseOutColor_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = aseOutColor_1;
  tmpvar_9.w = tmpvar_8;
  gl_FragData[0] = tmpvar_9;
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