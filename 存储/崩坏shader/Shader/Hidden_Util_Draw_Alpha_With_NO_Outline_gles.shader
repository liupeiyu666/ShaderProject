//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Util/Draw_Alpha_With_NO_Outline" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_AlphaClip ("Alpha Clip", Float) = 0.01
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "OutlineType" = "Simple" }
 Pass {
  LOD 200
  Tags { "OutlineType" = "Simple" }
  GpuProgramID 27339
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_4;
  tmpvar_4 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_4 * _Opaqueness) * _Color.w);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_4;
  tmpvar_4 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_4 * _Opaqueness) * _Color.w);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_4;
  tmpvar_4 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_4 * _Opaqueness) * _Color.w);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
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
SubShader {
 LOD 200
 Tags { "OutlineType" = "Complex" }
 Pass {
  LOD 200
  Tags { "OutlineType" = "Complex" }
  GpuProgramID 113675
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_4;
  tmpvar_4 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_4 * _Opaqueness) * _Color.w);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_4;
  tmpvar_4 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_4 * _Opaqueness) * _Color.w);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float tmpvar_2;
  tmpvar_1.zw = vec2(0.0, 0.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_4;
  tmpvar_4 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_4 * _Opaqueness) * _Color.w);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
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