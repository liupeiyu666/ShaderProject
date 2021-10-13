//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/miHoYo/DLC/Common/Shared" {
Properties {
}
SubShader {
 Tags { "PerformanceChecks" = "False" "RenderType" = "Opaque" }
 Pass {
  Name "PREDEPTH"
  Tags { "LIGHTMODE" = "PreDepth" "PerformanceChecks" = "False" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 2487
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
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
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float x_2;
  x_2 = ((tmpvar_1 * _Color).w - _AlphaCutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float x_2;
  x_2 = ((tmpvar_1 * _Color).w - _AlphaCutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float x_2;
  x_2 = ((tmpvar_1 * _Color).w - _AlphaCutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
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
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" }
""
}
}
}
}
}