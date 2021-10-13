//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "LineRendering/DoubleSegment" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_CreaseWidth ("Crease Width", Range(0, 100)) = 0.2
_DistancePower ("Distance Power", Range(-3, 3)) = -0.2
_CreaseColor ("Crease Color", Color) = (0,0,0,1)
_VertexOffset ("Vertex Offset", Float) = 0.01
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 55345
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp float _CreaseWidth;
uniform highp float _DistancePower;
uniform highp float _VertexOffset;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (_glesVertex.xyz - _glesTANGENT.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_projection * (unity_MatrixMV * tmpvar_3));
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_projection * (unity_MatrixMV * tmpvar_4));
  highp vec3 tmpvar_7;
  tmpvar_7.z = 0.0;
  tmpvar_7.xy = (((
    (tmpvar_5.xyz / tmpvar_5.w)
  .xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5)) * _ScreenParams.xy);
  highp vec3 tmpvar_8;
  tmpvar_8.z = 0.0;
  tmpvar_8.xy = (((
    (tmpvar_6.xyz / tmpvar_6.w)
  .xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5)) * _ScreenParams.xy);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 - tmpvar_8) * _glesTANGENT.w);
  highp vec2 tmpvar_10;
  tmpvar_10.x = -(tmpvar_9.y);
  tmpvar_10.y = tmpvar_9.x;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 0.0);
  tmpvar_11.xy = (((
    (normalize(tmpvar_10) * _CreaseWidth)
   * _DistancePower) / _ScreenParams.xy) * vec2(2.0, 2.0));
  tmpvar_1 = (tmpvar_5 + (tmpvar_11 * tmpvar_5.w));
  tmpvar_1.z = (tmpvar_1.z + _VertexOffset);
  gl_Position = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _CreaseColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _CreaseColor.xyz;
  tmpvar_1 = (tmpvar_2 * tmpvar_3);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp float _CreaseWidth;
uniform highp float _DistancePower;
uniform highp float _VertexOffset;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (_glesVertex.xyz - _glesTANGENT.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_projection * (unity_MatrixMV * tmpvar_3));
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_projection * (unity_MatrixMV * tmpvar_4));
  highp vec3 tmpvar_7;
  tmpvar_7.z = 0.0;
  tmpvar_7.xy = (((
    (tmpvar_5.xyz / tmpvar_5.w)
  .xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5)) * _ScreenParams.xy);
  highp vec3 tmpvar_8;
  tmpvar_8.z = 0.0;
  tmpvar_8.xy = (((
    (tmpvar_6.xyz / tmpvar_6.w)
  .xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5)) * _ScreenParams.xy);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 - tmpvar_8) * _glesTANGENT.w);
  highp vec2 tmpvar_10;
  tmpvar_10.x = -(tmpvar_9.y);
  tmpvar_10.y = tmpvar_9.x;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 0.0);
  tmpvar_11.xy = (((
    (normalize(tmpvar_10) * _CreaseWidth)
   * _DistancePower) / _ScreenParams.xy) * vec2(2.0, 2.0));
  tmpvar_1 = (tmpvar_5 + (tmpvar_11 * tmpvar_5.w));
  tmpvar_1.z = (tmpvar_1.z + _VertexOffset);
  gl_Position = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _CreaseColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _CreaseColor.xyz;
  tmpvar_1 = (tmpvar_2 * tmpvar_3);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp float _CreaseWidth;
uniform highp float _DistancePower;
uniform highp float _VertexOffset;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (_glesVertex.xyz - _glesTANGENT.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_projection * (unity_MatrixMV * tmpvar_3));
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_projection * (unity_MatrixMV * tmpvar_4));
  highp vec3 tmpvar_7;
  tmpvar_7.z = 0.0;
  tmpvar_7.xy = (((
    (tmpvar_5.xyz / tmpvar_5.w)
  .xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5)) * _ScreenParams.xy);
  highp vec3 tmpvar_8;
  tmpvar_8.z = 0.0;
  tmpvar_8.xy = (((
    (tmpvar_6.xyz / tmpvar_6.w)
  .xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5)) * _ScreenParams.xy);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 - tmpvar_8) * _glesTANGENT.w);
  highp vec2 tmpvar_10;
  tmpvar_10.x = -(tmpvar_9.y);
  tmpvar_10.y = tmpvar_9.x;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 0.0);
  tmpvar_11.xy = (((
    (normalize(tmpvar_10) * _CreaseWidth)
   * _DistancePower) / _ScreenParams.xy) * vec2(2.0, 2.0));
  tmpvar_1 = (tmpvar_5 + (tmpvar_11 * tmpvar_5.w));
  tmpvar_1.z = (tmpvar_1.z + _VertexOffset);
  gl_Position = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _CreaseColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _CreaseColor.xyz;
  tmpvar_1 = (tmpvar_2 * tmpvar_3);
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