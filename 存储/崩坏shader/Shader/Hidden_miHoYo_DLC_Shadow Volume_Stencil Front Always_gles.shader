//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/miHoYo/DLC/Shadow Volume/Stencil Front Always" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  GpuProgramID 12181
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _ShadowVolumeSource;
uniform highp float _ShadowVolumeExtrudeBias;
uniform highp float _ShadowVolumeExtrudeAmount;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_ShadowVolumeSource.xyz - (tmpvar_1 * _ShadowVolumeSource.w)));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (tmpvar_1 - (tmpvar_3 * (_ShadowVolumeExtrudeBias + 
    (_ShadowVolumeExtrudeAmount * float((dot (
      normalize((_glesNormal * tmpvar_2))
    , tmpvar_3) < 0.0)))
  )));
  gl_Position = (unity_MatrixVP * tmpvar_4);
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _ShadowVolumeSource;
uniform highp float _ShadowVolumeExtrudeBias;
uniform highp float _ShadowVolumeExtrudeAmount;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_ShadowVolumeSource.xyz - (tmpvar_1 * _ShadowVolumeSource.w)));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (tmpvar_1 - (tmpvar_3 * (_ShadowVolumeExtrudeBias + 
    (_ShadowVolumeExtrudeAmount * float((dot (
      normalize((_glesNormal * tmpvar_2))
    , tmpvar_3) < 0.0)))
  )));
  gl_Position = (unity_MatrixVP * tmpvar_4);
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _ShadowVolumeSource;
uniform highp float _ShadowVolumeExtrudeBias;
uniform highp float _ShadowVolumeExtrudeAmount;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_ShadowVolumeSource.xyz - (tmpvar_1 * _ShadowVolumeSource.w)));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (tmpvar_1 - (tmpvar_3 * (_ShadowVolumeExtrudeBias + 
    (_ShadowVolumeExtrudeAmount * float((dot (
      normalize((_glesNormal * tmpvar_2))
    , tmpvar_3) < 0.0)))
  )));
  gl_Position = (unity_MatrixVP * tmpvar_4);
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(1.0, 1.0, 1.0, 1.0);
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