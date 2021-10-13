//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Battlehub/RTHandles/Billboard" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Texture Image", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+20" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+20" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 43438
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 x_1;
  x_1 = (unity_ObjectToWorld * vec4(1.0, 0.0, 0.0, 0.0));
  highp vec4 x_2;
  x_2 = (unity_ObjectToWorld * vec4(0.0, 1.0, 0.0, 0.0));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (unity_MatrixV * (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0))).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.x = (_glesVertex.x * sqrt(dot (x_1, x_1)));
  tmpvar_4.y = (_glesVertex.y * sqrt(dot (x_2, x_2)));
  gl_Position = (glstate_matrix_projection * (tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tmpvar_1 = (_Color * tmpvar_2);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 x_1;
  x_1 = (unity_ObjectToWorld * vec4(1.0, 0.0, 0.0, 0.0));
  highp vec4 x_2;
  x_2 = (unity_ObjectToWorld * vec4(0.0, 1.0, 0.0, 0.0));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (unity_MatrixV * (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0))).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.x = (_glesVertex.x * sqrt(dot (x_1, x_1)));
  tmpvar_4.y = (_glesVertex.y * sqrt(dot (x_2, x_2)));
  gl_Position = (glstate_matrix_projection * (tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tmpvar_1 = (_Color * tmpvar_2);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 x_1;
  x_1 = (unity_ObjectToWorld * vec4(1.0, 0.0, 0.0, 0.0));
  highp vec4 x_2;
  x_2 = (unity_ObjectToWorld * vec4(0.0, 1.0, 0.0, 0.0));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (unity_MatrixV * (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0))).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.x = (_glesVertex.x * sqrt(dot (x_1, x_1)));
  tmpvar_4.y = (_glesVertex.y * sqrt(dot (x_2, x_2)));
  gl_Position = (glstate_matrix_projection * (tmpvar_3 - tmpvar_4));
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tmpvar_1 = (_Color * tmpvar_2);
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