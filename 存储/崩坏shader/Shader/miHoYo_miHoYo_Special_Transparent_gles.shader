//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Transparent" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_Emission ("Emmisive Color", Color) = (0,0,0,0)
_MainTex ("Base (RGB) Trans. (Alpha)", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "Transparent" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "Vertex" "QUEUE" = "Transparent" }
  ZWrite Off
  GpuProgramID 15331
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  xlv_COLOR0 = clamp (color_1, 0.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  xlv_COLOR0 = clamp (color_1, 0.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  xlv_COLOR0 = clamp (color_1, 0.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  xlv_COLOR0 = clamp (color_1, 0.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  xlv_COLOR0 = clamp (color_1, 0.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
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
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  xlv_COLOR0 = clamp (color_1, 0.0, 1.0);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _LumiFactor;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2.xyz = (tex_1 * xlv_COLOR0).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tex_1.w * _Color.w);
  col_2.xyz = mix (col_2.xyz, vec3(dot (col_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_2.w = clamp (col_2.w, 0.0, 1.0);
  gl_FragData[0] = col_2;
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