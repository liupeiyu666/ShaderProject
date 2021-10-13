//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Billboard/Perpendicular Light (Additive Smooth)" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_SizeScaleX ("Size Scale X", Float) = 1
_SizeScaleY ("Size Scale Y", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = -1
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = -1
_DistanceAttenuationOffset ("Distance Attenuation Offset", Float) = 30
_DistanceAttenuationFactor ("Distance Attenuation Quadratic Factor", Range(0, 0.1)) = 0.015
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 26931
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp vec4 _MainTex_ST;
uniform highp float _SizeScaleX;
uniform highp float _SizeScaleY;
uniform highp float _DistanceAttenuationOffset;
uniform highp float _DistanceAttenuationFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_MatrixV[0].xyz;
  tmpvar_2[1] = unity_MatrixV[1].xyz;
  tmpvar_2[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * vec3(0.0, 1.0, 0.0)));
  highp vec4 tmpvar_4;
  tmpvar_4 = ((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = (((
    normalize(((tmpvar_3.yzx * vec3(1.0, 0.0, 0.0)) - (tmpvar_3.zxy * vec3(0.0, 1.0, 0.0))))
   * _glesVertex.x) * _SizeScaleX) + ((tmpvar_3 * _glesVertex.y) * _SizeScaleY));
  tmpvar_1.w = _glesColor.w;
  highp float tmpvar_6;
  tmpvar_6 = max (((
    -(tmpvar_4.z)
   - _ProjectionParams.y) - _DistanceAttenuationOffset), 0.0);
  tmpvar_1.xyz = (_glesColor.xyz / (1.0 + (
    (tmpvar_6 * tmpvar_6)
   * _DistanceAttenuationFactor)));
  gl_Position = (glstate_matrix_projection * (tmpvar_4 + tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = tmpvar_1;
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
  color_1.xyz = (tmpvar_3.xyz * (tmpvar_3.w * _EmissionScaler));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp vec4 _MainTex_ST;
uniform highp float _SizeScaleX;
uniform highp float _SizeScaleY;
uniform highp float _DistanceAttenuationOffset;
uniform highp float _DistanceAttenuationFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_MatrixV[0].xyz;
  tmpvar_2[1] = unity_MatrixV[1].xyz;
  tmpvar_2[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * vec3(0.0, 1.0, 0.0)));
  highp vec4 tmpvar_4;
  tmpvar_4 = ((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = (((
    normalize(((tmpvar_3.yzx * vec3(1.0, 0.0, 0.0)) - (tmpvar_3.zxy * vec3(0.0, 1.0, 0.0))))
   * _glesVertex.x) * _SizeScaleX) + ((tmpvar_3 * _glesVertex.y) * _SizeScaleY));
  tmpvar_1.w = _glesColor.w;
  highp float tmpvar_6;
  tmpvar_6 = max (((
    -(tmpvar_4.z)
   - _ProjectionParams.y) - _DistanceAttenuationOffset), 0.0);
  tmpvar_1.xyz = (_glesColor.xyz / (1.0 + (
    (tmpvar_6 * tmpvar_6)
   * _DistanceAttenuationFactor)));
  gl_Position = (glstate_matrix_projection * (tmpvar_4 + tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = tmpvar_1;
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
  color_1.xyz = (tmpvar_3.xyz * (tmpvar_3.w * _EmissionScaler));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp vec4 _MainTex_ST;
uniform highp float _SizeScaleX;
uniform highp float _SizeScaleY;
uniform highp float _DistanceAttenuationOffset;
uniform highp float _DistanceAttenuationFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_MatrixV[0].xyz;
  tmpvar_2[1] = unity_MatrixV[1].xyz;
  tmpvar_2[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((tmpvar_2 * vec3(0.0, 1.0, 0.0)));
  highp vec4 tmpvar_4;
  tmpvar_4 = ((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = (((
    normalize(((tmpvar_3.yzx * vec3(1.0, 0.0, 0.0)) - (tmpvar_3.zxy * vec3(0.0, 1.0, 0.0))))
   * _glesVertex.x) * _SizeScaleX) + ((tmpvar_3 * _glesVertex.y) * _SizeScaleY));
  tmpvar_1.w = _glesColor.w;
  highp float tmpvar_6;
  tmpvar_6 = max (((
    -(tmpvar_4.z)
   - _ProjectionParams.y) - _DistanceAttenuationOffset), 0.0);
  tmpvar_1.xyz = (_glesColor.xyz / (1.0 + (
    (tmpvar_6 * tmpvar_6)
   * _DistanceAttenuationFactor)));
  gl_Position = (glstate_matrix_projection * (tmpvar_4 + tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = tmpvar_1;
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
  color_1.xyz = (tmpvar_3.xyz * (tmpvar_3.w * _EmissionScaler));
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
  GpuProgramID 115608
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