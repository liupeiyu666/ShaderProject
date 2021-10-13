//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_Stencil_Down" {
Properties {
_mainColor ("mainColor", Color) = (0.735849,0,0,0)
_MainTex ("MainTex", 2D) = "white" { }
_Stencil ("Stencil Value", Float) = 0
_mainTiling ("mainTiling", Vector) = (0,0,0,0)
_mainSpeed ("mainSpeed", Vector) = (0,0,0,0)
_SecondTex ("SecondTex", 2D) = "white" { }
_SecondTexColor ("SecondTexColor", Color) = (1,1,1,0)
_SecondTexIntensity ("SecondTexIntensity", Float) = 1
_DistortionTex ("DistortionTex", 2D) = "white" { }
_DistortionIntensity ("DistortionIntensity", Float) = 0
_DistortionTilling ("DistortionTilling", Vector) = (1,1,0,0)
_DistortionSpeed ("DistortionSpeed", Vector) = (0,0,0,0)
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Always
  Cull Front
  GpuProgramID 25265
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _mainColor;
uniform sampler2D _MainTex;
uniform highp vec2 _mainSpeed;
uniform highp vec2 _mainTiling;
uniform sampler2D _SecondTex;
uniform highp vec4 _SecondTex_ST;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform sampler2D _DistortionTex;
uniform highp vec2 _DistortionSpeed;
uniform highp vec2 _DistortionTilling;
uniform highp float _DistortionIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 secondTexColor_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD1.xy * _SecondTex_ST.xy) + _SecondTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SecondTex, tmpvar_3);
  highp vec3 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * _SecondTexColor) * _SecondTexIntensity).xyz;
  secondTexColor_2 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * _DistortionSpeed) + (xlv_TEXCOORD0.xy * _DistortionTilling));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DistortionTex, tmpvar_6);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((_Time.y * _mainSpeed) + (xlv_TEXCOORD0.xy * _mainTiling)) + (tmpvar_7 * (_DistortionIntensity * 0.1)).xy);
  tmpvar_8 = texture2D (_MainTex, P_9);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_mainColor * tmpvar_8).xyz + secondTexColor_2);
  aseOutColor_1 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = aseOutColor_1;
  tmpvar_11.w = 1.0;
  gl_FragData[0] = tmpvar_11;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _mainColor;
uniform sampler2D _MainTex;
uniform highp vec2 _mainSpeed;
uniform highp vec2 _mainTiling;
uniform sampler2D _SecondTex;
uniform highp vec4 _SecondTex_ST;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform sampler2D _DistortionTex;
uniform highp vec2 _DistortionSpeed;
uniform highp vec2 _DistortionTilling;
uniform highp float _DistortionIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 secondTexColor_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD1.xy * _SecondTex_ST.xy) + _SecondTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SecondTex, tmpvar_3);
  highp vec3 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * _SecondTexColor) * _SecondTexIntensity).xyz;
  secondTexColor_2 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * _DistortionSpeed) + (xlv_TEXCOORD0.xy * _DistortionTilling));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DistortionTex, tmpvar_6);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((_Time.y * _mainSpeed) + (xlv_TEXCOORD0.xy * _mainTiling)) + (tmpvar_7 * (_DistortionIntensity * 0.1)).xy);
  tmpvar_8 = texture2D (_MainTex, P_9);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_mainColor * tmpvar_8).xyz + secondTexColor_2);
  aseOutColor_1 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = aseOutColor_1;
  tmpvar_11.w = 1.0;
  gl_FragData[0] = tmpvar_11;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _mainColor;
uniform sampler2D _MainTex;
uniform highp vec2 _mainSpeed;
uniform highp vec2 _mainTiling;
uniform sampler2D _SecondTex;
uniform highp vec4 _SecondTex_ST;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform sampler2D _DistortionTex;
uniform highp vec2 _DistortionSpeed;
uniform highp vec2 _DistortionTilling;
uniform highp float _DistortionIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 secondTexColor_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD1.xy * _SecondTex_ST.xy) + _SecondTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SecondTex, tmpvar_3);
  highp vec3 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * _SecondTexColor) * _SecondTexIntensity).xyz;
  secondTexColor_2 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * _DistortionSpeed) + (xlv_TEXCOORD0.xy * _DistortionTilling));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_DistortionTex, tmpvar_6);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((_Time.y * _mainSpeed) + (xlv_TEXCOORD0.xy * _mainTiling)) + (tmpvar_7 * (_DistortionIntensity * 0.1)).xy);
  tmpvar_8 = texture2D (_MainTex, P_9);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_mainColor * tmpvar_8).xyz + secondTexColor_2);
  aseOutColor_1 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.xyz = aseOutColor_1;
  tmpvar_11.w = 1.0;
  gl_FragData[0] = tmpvar_11;
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
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}