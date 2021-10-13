//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Texture_ChannelMix" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_TintColor0 ("Tint Color0", Color) = (0.5,0.5,0.5,0.5)
_TintColor1 ("Tint Color1", Color) = (0.5,0.5,0.5,0.5)
_TintColor2 ("Tint Color2", Color) = (0.5,0.5,0.5,0.5)
_EmissionScaler ("Emission Scaler", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 17860
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_3;
  color_1.xyz = (_TintColor0.xyz * srcColor_2.x);
  color_1.xyz = mix (color_1.xyz, _TintColor1.xyz, vec3((srcColor_2.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((srcColor_2.z * _TintColor2.w)));
  color_1.xyz = (color_1.xyz * _EmissionScaler);
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
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_3;
  color_1.xyz = (_TintColor0.xyz * srcColor_2.x);
  color_1.xyz = mix (color_1.xyz, _TintColor1.xyz, vec3((srcColor_2.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((srcColor_2.z * _TintColor2.w)));
  color_1.xyz = (color_1.xyz * _EmissionScaler);
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
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_3;
  color_1.xyz = (_TintColor0.xyz * srcColor_2.x);
  color_1.xyz = mix (color_1.xyz, _TintColor1.xyz, vec3((srcColor_2.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((srcColor_2.z * _TintColor2.w)));
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = _BloomFactor;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_3;
  color_1.xyz = (_TintColor0.xyz * srcColor_2.x);
  color_1.xyz = mix (color_1.xyz, _TintColor1.xyz, vec3((srcColor_2.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((srcColor_2.z * _TintColor2.w)));
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = _BloomFactor;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_3;
  color_1.xyz = (_TintColor0.xyz * srcColor_2.x);
  color_1.xyz = mix (color_1.xyz, _TintColor1.xyz, vec3((srcColor_2.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((srcColor_2.z * _TintColor2.w)));
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = _BloomFactor;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_3;
  color_1.xyz = (_TintColor0.xyz * srcColor_2.x);
  color_1.xyz = mix (color_1.xyz, _TintColor1.xyz, vec3((srcColor_2.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((srcColor_2.z * _TintColor2.w)));
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = _BloomFactor;
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
}
}
}
}