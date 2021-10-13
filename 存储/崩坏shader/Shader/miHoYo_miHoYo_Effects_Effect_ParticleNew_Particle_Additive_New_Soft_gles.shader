//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Particle_Additive_New_Soft" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_DepthCt ("DepthCt", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DistortionTex ("Distortion Tex", 2D) = "gray" { }
_DistortionIntensity ("Distortion Intensity", Range(0, 10)) = 5
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 25229
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = o_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_5;
  z_5 = tmpvar_4.x;
  highp float tmpvar_6;
  tmpvar_6 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD2 / xlv_TEXCOORD2.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  color_1.w = (color_1.w * tmpvar_6);
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
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = o_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_5;
  z_5 = tmpvar_4.x;
  highp float tmpvar_6;
  tmpvar_6 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD2 / xlv_TEXCOORD2.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  color_1.w = (color_1.w * tmpvar_6);
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
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = o_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_5;
  z_5 = tmpvar_4.x;
  highp float tmpvar_6;
  tmpvar_6 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD2 / xlv_TEXCOORD2.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  color_1.w = (color_1.w * tmpvar_6);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = o_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_5;
  z_5 = tmpvar_4.x;
  highp float tmpvar_6;
  tmpvar_6 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD2 / xlv_TEXCOORD2.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  color_1.w = (color_1.w * tmpvar_6);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = o_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_5;
  z_5 = tmpvar_4.x;
  highp float tmpvar_6;
  tmpvar_6 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD2 / xlv_TEXCOORD2.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  color_1.w = (color_1.w * tmpvar_6);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = o_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_5;
  z_5 = tmpvar_4.x;
  highp float tmpvar_6;
  tmpvar_6 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD2 / xlv_TEXCOORD2.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  color_1.w = (color_1.w * tmpvar_6);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = o_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_5;
  z_5 = tmpvar_4.x;
  highp float tmpvar_6;
  tmpvar_6 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD2 / xlv_TEXCOORD2.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  color_1.w = (color_1.w * tmpvar_6);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = o_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_5;
  z_5 = tmpvar_4.x;
  highp float tmpvar_6;
  tmpvar_6 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD2 / xlv_TEXCOORD2.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  color_1.w = (color_1.w * tmpvar_6);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = o_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_5;
  z_5 = tmpvar_4.x;
  highp float tmpvar_6;
  tmpvar_6 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD2 / xlv_TEXCOORD2.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  color_1.w = (color_1.w * tmpvar_6);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = o_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_5;
  z_5 = tmpvar_4.x;
  highp float tmpvar_6;
  tmpvar_6 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD2 / xlv_TEXCOORD2.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  color_1.w = (color_1.w * tmpvar_6);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = o_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_5;
  z_5 = tmpvar_4.x;
  highp float tmpvar_6;
  tmpvar_6 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD2 / xlv_TEXCOORD2.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  color_1.w = (color_1.w * tmpvar_6);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD2 = o_3;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_5;
  z_5 = tmpvar_4.x;
  highp float tmpvar_6;
  tmpvar_6 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD2 / xlv_TEXCOORD2.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  color_1.w = (color_1.w * tmpvar_6);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
SubProgram "gles hw_tier00 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}