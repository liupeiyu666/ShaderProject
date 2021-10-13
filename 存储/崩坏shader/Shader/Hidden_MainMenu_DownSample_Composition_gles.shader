//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/MainMenu/DownSample_Composition" {
Properties {
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 20987
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
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _FarTex;
uniform sampler2D _NearTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 nearColor_1;
  mediump vec4 farColor_2;
  mediump vec4 color_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FarTex, xlv_TEXCOORD0);
  farColor_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_NearTex, xlv_TEXCOORD0);
  nearColor_1 = tmpvar_5;
  color_3.xyz = mix (farColor_2.xyz, nearColor_1.xyz, nearColor_1.www);
  color_3.w = clamp (nearColor_1.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _FarTex;
uniform sampler2D _NearTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 nearColor_1;
  mediump vec4 farColor_2;
  mediump vec4 color_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FarTex, xlv_TEXCOORD0);
  farColor_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_NearTex, xlv_TEXCOORD0);
  nearColor_1 = tmpvar_5;
  color_3.xyz = mix (farColor_2.xyz, nearColor_1.xyz, nearColor_1.www);
  color_3.w = clamp (nearColor_1.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _FarTex;
uniform sampler2D _NearTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 nearColor_1;
  mediump vec4 farColor_2;
  mediump vec4 color_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FarTex, xlv_TEXCOORD0);
  farColor_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_NearTex, xlv_TEXCOORD0);
  nearColor_1 = tmpvar_5;
  color_3.xyz = mix (farColor_2.xyz, nearColor_1.xyz, nearColor_1.www);
  color_3.w = clamp (nearColor_1.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 74029
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec2 twoTexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  mediump vec2 tmpvar_7;
  tmpvar_7.y = 0.0;
  tmpvar_7.x = twoTexelSize.x;
  tmpvar_3 = (_glesMultiTexCoord0.xy + tmpvar_7);
  tmpvar_4 = (_glesMultiTexCoord0.xy + twoTexelSize);
  mediump vec2 tmpvar_8;
  tmpvar_8.x = 0.0;
  tmpvar_8.y = twoTexelSize.y;
  tmpvar_5 = (_glesMultiTexCoord0.xy + tmpvar_8);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _FarTex;
uniform sampler2D _NearTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 nearColor_1;
  mediump vec4 farColor_2;
  mediump vec4 color_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (((
    (texture2D (_FarTex, xlv_TEXCOORD0) * 0.25)
   + 
    (texture2D (_FarTex, xlv_TEXCOORD1) * 0.25)
  ) + (texture2D (_FarTex, xlv_TEXCOORD2) * 0.25)) + (texture2D (_FarTex, xlv_TEXCOORD3) * 0.25));
  farColor_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = (((
    (texture2D (_NearTex, xlv_TEXCOORD0) * 0.25)
   + 
    (texture2D (_NearTex, xlv_TEXCOORD1) * 0.25)
  ) + (texture2D (_NearTex, xlv_TEXCOORD2) * 0.25)) + (texture2D (_NearTex, xlv_TEXCOORD3) * 0.25));
  nearColor_1 = tmpvar_5;
  color_3.xyz = mix (farColor_2.xyz, nearColor_1.xyz, nearColor_1.www);
  color_3.w = nearColor_1.w;
  gl_FragData[0] = color_3;
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
uniform mediump vec2 twoTexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  mediump vec2 tmpvar_7;
  tmpvar_7.y = 0.0;
  tmpvar_7.x = twoTexelSize.x;
  tmpvar_3 = (_glesMultiTexCoord0.xy + tmpvar_7);
  tmpvar_4 = (_glesMultiTexCoord0.xy + twoTexelSize);
  mediump vec2 tmpvar_8;
  tmpvar_8.x = 0.0;
  tmpvar_8.y = twoTexelSize.y;
  tmpvar_5 = (_glesMultiTexCoord0.xy + tmpvar_8);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _FarTex;
uniform sampler2D _NearTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 nearColor_1;
  mediump vec4 farColor_2;
  mediump vec4 color_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (((
    (texture2D (_FarTex, xlv_TEXCOORD0) * 0.25)
   + 
    (texture2D (_FarTex, xlv_TEXCOORD1) * 0.25)
  ) + (texture2D (_FarTex, xlv_TEXCOORD2) * 0.25)) + (texture2D (_FarTex, xlv_TEXCOORD3) * 0.25));
  farColor_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = (((
    (texture2D (_NearTex, xlv_TEXCOORD0) * 0.25)
   + 
    (texture2D (_NearTex, xlv_TEXCOORD1) * 0.25)
  ) + (texture2D (_NearTex, xlv_TEXCOORD2) * 0.25)) + (texture2D (_NearTex, xlv_TEXCOORD3) * 0.25));
  nearColor_1 = tmpvar_5;
  color_3.xyz = mix (farColor_2.xyz, nearColor_1.xyz, nearColor_1.www);
  color_3.w = nearColor_1.w;
  gl_FragData[0] = color_3;
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
uniform mediump vec2 twoTexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  mediump vec2 tmpvar_7;
  tmpvar_7.y = 0.0;
  tmpvar_7.x = twoTexelSize.x;
  tmpvar_3 = (_glesMultiTexCoord0.xy + tmpvar_7);
  tmpvar_4 = (_glesMultiTexCoord0.xy + twoTexelSize);
  mediump vec2 tmpvar_8;
  tmpvar_8.x = 0.0;
  tmpvar_8.y = twoTexelSize.y;
  tmpvar_5 = (_glesMultiTexCoord0.xy + tmpvar_8);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _FarTex;
uniform sampler2D _NearTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 nearColor_1;
  mediump vec4 farColor_2;
  mediump vec4 color_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (((
    (texture2D (_FarTex, xlv_TEXCOORD0) * 0.25)
   + 
    (texture2D (_FarTex, xlv_TEXCOORD1) * 0.25)
  ) + (texture2D (_FarTex, xlv_TEXCOORD2) * 0.25)) + (texture2D (_FarTex, xlv_TEXCOORD3) * 0.25));
  farColor_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = (((
    (texture2D (_NearTex, xlv_TEXCOORD0) * 0.25)
   + 
    (texture2D (_NearTex, xlv_TEXCOORD1) * 0.25)
  ) + (texture2D (_NearTex, xlv_TEXCOORD2) * 0.25)) + (texture2D (_NearTex, xlv_TEXCOORD3) * 0.25));
  nearColor_1 = tmpvar_5;
  color_3.xyz = mix (farColor_2.xyz, nearColor_1.xyz, nearColor_1.www);
  color_3.w = nearColor_1.w;
  gl_FragData[0] = color_3;
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