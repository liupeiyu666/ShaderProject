//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Toon Basic Transparent Emission Outline" {
Properties {
_MainTex ("Main Tex", 2D) = "white" { }
_MainAlpha ("Main Alpha(0-1.0)", Range(0, 1)) = 0.5
_EmissionColor ("Main Emission Color(128 is standard)", Color) = (1,1,1,1)
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_OutlineMax ("Outline Max", Float) = 0.005
_OutlineMin ("Outline Min", Float) = 0.002
_Outline ("Outline width(0.002-0.005)", Float) = 0.005
_OutlineAlpha ("Outline Alpha(0-1.0)", Range(0, 1)) = 0.5
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 63837
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_1 = (tmpvar_3 * _glesNormal);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _MainAlpha;
uniform mediump vec4 _EmissionColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _EmissionColor);
  col_2 = tmpvar_4;
  col_2.w = clamp ((col_2.w * _MainAlpha), 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (2.0 * col_2.xyz);
  tmpvar_5.w = col_2.w;
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_1 = (tmpvar_3 * _glesNormal);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _MainAlpha;
uniform mediump vec4 _EmissionColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _EmissionColor);
  col_2 = tmpvar_4;
  col_2.w = clamp ((col_2.w * _MainAlpha), 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (2.0 * col_2.xyz);
  tmpvar_5.w = col_2.w;
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_1 = (tmpvar_3 * _glesNormal);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _MainAlpha;
uniform mediump vec4 _EmissionColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _EmissionColor);
  col_2 = tmpvar_4;
  col_2.w = clamp ((col_2.w * _MainAlpha), 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (2.0 * col_2.xyz);
  tmpvar_5.w = col_2.w;
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_1 = (tmpvar_3 * _glesNormal);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _MainAlpha;
uniform mediump vec4 _EmissionColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _EmissionColor);
  col_2 = tmpvar_4;
  col_2.w = clamp ((col_2.w * _MainAlpha), 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (2.0 * col_2.xyz);
  tmpvar_5.w = col_2.w;
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_1 = (tmpvar_3 * _glesNormal);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _MainAlpha;
uniform mediump vec4 _EmissionColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _EmissionColor);
  col_2 = tmpvar_4;
  col_2.w = clamp ((col_2.w * _MainAlpha), 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (2.0 * col_2.xyz);
  tmpvar_5.w = col_2.w;
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_1 = (tmpvar_3 * _glesNormal);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _MainAlpha;
uniform mediump vec4 _EmissionColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _EmissionColor);
  col_2 = tmpvar_4;
  col_2.w = clamp ((col_2.w * _MainAlpha), 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (2.0 * col_2.xyz);
  tmpvar_5.w = col_2.w;
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_1 = (tmpvar_3 * _glesNormal);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _MainAlpha;
uniform mediump vec4 _EmissionColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _EmissionColor);
  col_2 = tmpvar_4;
  col_2.w = clamp ((col_2.w * _MainAlpha), 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (2.0 * col_2.xyz);
  tmpvar_5.w = col_2.w;
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_1 = (tmpvar_3 * _glesNormal);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _MainAlpha;
uniform mediump vec4 _EmissionColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _EmissionColor);
  col_2 = tmpvar_4;
  col_2.w = clamp ((col_2.w * _MainAlpha), 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (2.0 * col_2.xyz);
  tmpvar_5.w = col_2.w;
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_1 = (tmpvar_3 * _glesNormal);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _MainAlpha;
uniform mediump vec4 _EmissionColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _EmissionColor);
  col_2 = tmpvar_4;
  col_2.w = clamp ((col_2.w * _MainAlpha), 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (2.0 * col_2.xyz);
  tmpvar_5.w = col_2.w;
  tmpvar_1 = tmpvar_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
}
}
 Pass {
  Name "OUTLINE"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 78142
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _OutlineAlpha;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    (tmpvar_10 * _glesNormal)
  .xy) * _Outline));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_6 = (tmpvar_12 * _glesNormal);
  tmpvar_7.xyz = _OutlineColor.xyz;
  tmpvar_7.w = _OutlineAlpha;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_TEXCOORD4.xyz;
  tmpvar_1.w = clamp (xlv_TEXCOORD4.w, 0.0, 1.0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _OutlineAlpha;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    (tmpvar_10 * _glesNormal)
  .xy) * _Outline));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_6 = (tmpvar_12 * _glesNormal);
  tmpvar_7.xyz = _OutlineColor.xyz;
  tmpvar_7.w = _OutlineAlpha;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_TEXCOORD4.xyz;
  tmpvar_1.w = clamp (xlv_TEXCOORD4.w, 0.0, 1.0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _OutlineAlpha;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    (tmpvar_10 * _glesNormal)
  .xy) * _Outline));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_6 = (tmpvar_12 * _glesNormal);
  tmpvar_7.xyz = _OutlineColor.xyz;
  tmpvar_7.w = _OutlineAlpha;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_TEXCOORD4.xyz;
  tmpvar_1.w = clamp (xlv_TEXCOORD4.w, 0.0, 1.0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _OutlineAlpha;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    (tmpvar_10 * _glesNormal)
  .xy) * _Outline));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_6 = (tmpvar_12 * _glesNormal);
  tmpvar_7.xyz = _OutlineColor.xyz;
  tmpvar_7.w = _OutlineAlpha;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_TEXCOORD4.xyz;
  tmpvar_1.w = clamp (xlv_TEXCOORD4.w, 0.0, 1.0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _OutlineAlpha;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    (tmpvar_10 * _glesNormal)
  .xy) * _Outline));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_6 = (tmpvar_12 * _glesNormal);
  tmpvar_7.xyz = _OutlineColor.xyz;
  tmpvar_7.w = _OutlineAlpha;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_TEXCOORD4.xyz;
  tmpvar_1.w = clamp (xlv_TEXCOORD4.w, 0.0, 1.0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _OutlineAlpha;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    (tmpvar_10 * _glesNormal)
  .xy) * _Outline));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_6 = (tmpvar_12 * _glesNormal);
  tmpvar_7.xyz = _OutlineColor.xyz;
  tmpvar_7.w = _OutlineAlpha;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_TEXCOORD4.xyz;
  tmpvar_1.w = clamp (xlv_TEXCOORD4.w, 0.0, 1.0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _OutlineAlpha;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    (tmpvar_10 * _glesNormal)
  .xy) * _Outline));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_6 = (tmpvar_12 * _glesNormal);
  tmpvar_7.xyz = _OutlineColor.xyz;
  tmpvar_7.w = _OutlineAlpha;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_TEXCOORD4.xyz;
  tmpvar_1.w = clamp (xlv_TEXCOORD4.w, 0.0, 1.0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _OutlineAlpha;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    (tmpvar_10 * _glesNormal)
  .xy) * _Outline));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_6 = (tmpvar_12 * _glesNormal);
  tmpvar_7.xyz = _OutlineColor.xyz;
  tmpvar_7.w = _OutlineAlpha;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_TEXCOORD4.xyz;
  tmpvar_1.w = clamp (xlv_TEXCOORD4.w, 0.0, 1.0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _OutlineAlpha;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    (tmpvar_10 * _glesNormal)
  .xy) * _Outline));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  tmpvar_6 = (tmpvar_12 * _glesNormal);
  tmpvar_7.xyz = _OutlineColor.xyz;
  tmpvar_7.w = _OutlineAlpha;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_TEXCOORD4.xyz;
  tmpvar_1.w = clamp (xlv_TEXCOORD4.w, 0.0, 1.0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
}
}
}
Fallback "Diffuse"
}