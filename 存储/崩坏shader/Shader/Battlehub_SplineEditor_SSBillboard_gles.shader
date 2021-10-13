//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Battlehub/SplineEditor/SSBillboard" {
Properties {
_Color ("Color", Color) = (0,0,0,1)
_Scale ("Scale", Float) = 1
_ZWrite ("ZWrite", Float) = 0
_ZTest ("ZTest", Float) = 0
_Cull ("Cull", Float) = 0
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  ZTest Off
  ZWrite Off
  Cull Off
  Offset -1, -1
  GpuProgramID 17263
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp float _Scale;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_1)).xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (_glesMultiTexCoord0.xy * vec2(mix ((
    (((tmpvar_2.z * 7.0) * _Scale) / _ScreenParams.y)
   * 
    (1.0/(unity_CameraProjection[1].y))
  ), (
    ((unity_OrthoParams.y * 7.0) * _Scale)
   / _ScreenParams.y), unity_OrthoParams.w)));
  gl_Position = (glstate_matrix_projection * (tmpvar_2 - tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp float _Scale;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_1)).xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (_glesMultiTexCoord0.xy * vec2(mix ((
    (((tmpvar_2.z * 7.0) * _Scale) / _ScreenParams.y)
   * 
    (1.0/(unity_CameraProjection[1].y))
  ), (
    ((unity_OrthoParams.y * 7.0) * _Scale)
   / _ScreenParams.y), unity_OrthoParams.w)));
  gl_Position = (glstate_matrix_projection * (tmpvar_2 - tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp float _Scale;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_1)).xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (_glesMultiTexCoord0.xy * vec2(mix ((
    (((tmpvar_2.z * 7.0) * _Scale) / _ScreenParams.y)
   * 
    (1.0/(unity_CameraProjection[1].y))
  ), (
    ((unity_OrthoParams.y * 7.0) * _Scale)
   / _ScreenParams.y), unity_OrthoParams.w)));
  gl_Position = (glstate_matrix_projection * (tmpvar_2 - tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  gl_FragData[0] = tmpvar_1;
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