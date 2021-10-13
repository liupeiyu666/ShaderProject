//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Billboard/XY With Perspective Adjust (Alpha Blended)" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_SizeScaleX ("Size Scale X", Float) = 1
_SizeScaleY ("Size Scale Y", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 58890
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp vec4 _MainTex_ST;
uniform highp float _SizeScaleX;
uniform highp float _SizeScaleY;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = ((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0));
  highp float tmpvar_2;
  tmpvar_2 = sqrt(dot (tmpvar_1.xyz, tmpvar_1.xyz));
  highp vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.x = (_glesVertex.x * _SizeScaleX);
  tmpvar_3.y = (_glesVertex.y * _SizeScaleY);
  highp vec3 tmpvar_4;
  tmpvar_4 = ((tmpvar_3.yzx * tmpvar_1.zxy) - (tmpvar_3.zxy * tmpvar_1.yzx));
  highp float tmpvar_5;
  tmpvar_5 = sqrt(dot (tmpvar_3, tmpvar_3));
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_5 / tmpvar_2);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (((
    (-(tmpvar_1.xyz) / tmpvar_2)
   * tmpvar_6) + (
    normalize(((tmpvar_1.yzx * tmpvar_4.zxy) - (tmpvar_1.zxy * tmpvar_4.yzx)))
   * 
    sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
  )) * tmpvar_5);
  gl_Position = (glstate_matrix_projection * (tmpvar_1 + tmpvar_7));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp vec4 _MainTex_ST;
uniform highp float _SizeScaleX;
uniform highp float _SizeScaleY;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = ((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0));
  highp float tmpvar_2;
  tmpvar_2 = sqrt(dot (tmpvar_1.xyz, tmpvar_1.xyz));
  highp vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.x = (_glesVertex.x * _SizeScaleX);
  tmpvar_3.y = (_glesVertex.y * _SizeScaleY);
  highp vec3 tmpvar_4;
  tmpvar_4 = ((tmpvar_3.yzx * tmpvar_1.zxy) - (tmpvar_3.zxy * tmpvar_1.yzx));
  highp float tmpvar_5;
  tmpvar_5 = sqrt(dot (tmpvar_3, tmpvar_3));
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_5 / tmpvar_2);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (((
    (-(tmpvar_1.xyz) / tmpvar_2)
   * tmpvar_6) + (
    normalize(((tmpvar_1.yzx * tmpvar_4.zxy) - (tmpvar_1.zxy * tmpvar_4.yzx)))
   * 
    sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
  )) * tmpvar_5);
  gl_Position = (glstate_matrix_projection * (tmpvar_1 + tmpvar_7));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp vec4 _MainTex_ST;
uniform highp float _SizeScaleX;
uniform highp float _SizeScaleY;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = ((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0));
  highp float tmpvar_2;
  tmpvar_2 = sqrt(dot (tmpvar_1.xyz, tmpvar_1.xyz));
  highp vec3 tmpvar_3;
  tmpvar_3.z = 0.0;
  tmpvar_3.x = (_glesVertex.x * _SizeScaleX);
  tmpvar_3.y = (_glesVertex.y * _SizeScaleY);
  highp vec3 tmpvar_4;
  tmpvar_4 = ((tmpvar_3.yzx * tmpvar_1.zxy) - (tmpvar_3.zxy * tmpvar_1.yzx));
  highp float tmpvar_5;
  tmpvar_5 = sqrt(dot (tmpvar_3, tmpvar_3));
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_5 / tmpvar_2);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (((
    (-(tmpvar_1.xyz) / tmpvar_2)
   * tmpvar_6) + (
    normalize(((tmpvar_1.yzx * tmpvar_4.zxy) - (tmpvar_1.zxy * tmpvar_4.yzx)))
   * 
    sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
  )) * tmpvar_5);
  gl_Position = (glstate_matrix_projection * (tmpvar_1 + tmpvar_7));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  color_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
  Name "CONSTANT_MAX"
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 75242
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
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
Fallback "Diffuse"
}