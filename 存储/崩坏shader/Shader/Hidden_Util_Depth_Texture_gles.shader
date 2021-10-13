//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Util/Depth_Texture" {
Properties {
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Off
  ZWrite Off
  GpuProgramID 45561
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _CameraDepthTexture;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 ret_1;
  ret_1.yzw = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  ret_1.x = tmpvar_2.x;
  gl_FragData[0] = ret_1;
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _CameraDepthTexture;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 ret_1;
  ret_1.yzw = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  ret_1.x = tmpvar_2.x;
  gl_FragData[0] = ret_1;
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _CameraDepthTexture;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 ret_1;
  ret_1.yzw = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  ret_1.x = tmpvar_2.x;
  gl_FragData[0] = ret_1;
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