//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/SandPostProcess" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_SandMaskTex ("Mask", 2D) = "black" { }
_DissipateSpeed ("Dissipate Speed", Range(0, 0.1)) = 0.01
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 38471
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SandMaskTex;
uniform mediump float _DissipateSpeed;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float mask_1;
  mediump float origin_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).x;
  origin_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_SandMaskTex, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_4;
  origin_2 = (origin_2 - (_DissipateSpeed * mask_1));
  mediump float tmpvar_5;
  tmpvar_5 = clamp (origin_2, 0.0, 1.0);
  origin_2 = tmpvar_5;
  gl_FragData[0] = vec4(tmpvar_5);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SandMaskTex;
uniform mediump float _DissipateSpeed;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float mask_1;
  mediump float origin_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).x;
  origin_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_SandMaskTex, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_4;
  origin_2 = (origin_2 - (_DissipateSpeed * mask_1));
  mediump float tmpvar_5;
  tmpvar_5 = clamp (origin_2, 0.0, 1.0);
  origin_2 = tmpvar_5;
  gl_FragData[0] = vec4(tmpvar_5);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _SandMaskTex;
uniform mediump float _DissipateSpeed;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float mask_1;
  mediump float origin_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).x;
  origin_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_SandMaskTex, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_4;
  origin_2 = (origin_2 - (_DissipateSpeed * mask_1));
  mediump float tmpvar_5;
  tmpvar_5 = clamp (origin_2, 0.0, 1.0);
  origin_2 = tmpvar_5;
  gl_FragData[0] = vec4(tmpvar_5);
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