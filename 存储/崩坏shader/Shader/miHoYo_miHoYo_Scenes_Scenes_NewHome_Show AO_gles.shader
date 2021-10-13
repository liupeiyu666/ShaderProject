//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewHome/Show AO" {
Properties {
_Color ("Color (RGB) Intensity (A)", Color) = (0.2,0.2,0.2,1)
_MainTex ("Texture", 2D) = "white" { }
_Offset ("Polygon Offset", Float) = -2
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent+2" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent+2" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 25965
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 col_1;
  mediump float ao_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  ao_2 = tmpvar_3;
  col_1.xyz = _Color.xyz;
  col_1.w = ((1.0 - ao_2) * _Color.w);
  col_1.xyz = (_Color.xyz * col_1.w);
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 col_1;
  mediump float ao_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  ao_2 = tmpvar_3;
  col_1.xyz = _Color.xyz;
  col_1.w = ((1.0 - ao_2) * _Color.w);
  col_1.xyz = (_Color.xyz * col_1.w);
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 col_1;
  mediump float ao_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  ao_2 = tmpvar_3;
  col_1.xyz = _Color.xyz;
  col_1.w = ((1.0 - ao_2) * _Color.w);
  col_1.xyz = (_Color.xyz * col_1.w);
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 col_1;
  mediump float ao_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  ao_2 = tmpvar_3;
  col_1.xyz = _Color.xyz;
  col_1.w = ((1.0 - ao_2) * _Color.w);
  col_1.xyz = (_Color.xyz * col_1.w);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 col_1;
  mediump float ao_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  ao_2 = tmpvar_3;
  col_1.xyz = _Color.xyz;
  col_1.w = ((1.0 - ao_2) * _Color.w);
  col_1.xyz = (_Color.xyz * col_1.w);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 col_1;
  mediump float ao_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  ao_2 = tmpvar_3;
  col_1.xyz = _Color.xyz;
  col_1.w = ((1.0 - ao_2) * _Color.w);
  col_1.xyz = (_Color.xyz * col_1.w);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
""
}
}
}
}
}