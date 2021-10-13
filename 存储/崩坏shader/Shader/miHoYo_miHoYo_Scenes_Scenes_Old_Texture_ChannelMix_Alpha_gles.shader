//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Texture_ChannelMix_Alpha" {
Properties {
_MainTex ("Particle Texture", 2D) = "white" { }
_TintColor0 ("Tint Color0", Color) = (0.5,0.5,0.5,0.5)
_TintColor1 ("Tint Color1", Color) = (0.5,0.5,0.5,0.5)
_TintColor2 ("Tint Color2", Color) = (0.5,0.5,0.5,0.5)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emmision Scaler", Range(0, 10)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 15812
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_1 + _nextFrameOffset);
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = (_BloomFactor * tmpvar_8.x);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_1 + _nextFrameOffset);
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = (_BloomFactor * tmpvar_8.x);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_1 + _nextFrameOffset);
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = (_BloomFactor * tmpvar_8.x);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_1 + _nextFrameOffset);
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = (_BloomFactor * tmpvar_8.x);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  color_1.w = clamp (color_1.w, 0.0, 1.0);
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_1 + _nextFrameOffset);
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = (_BloomFactor * tmpvar_8.x);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  color_1.w = clamp (color_1.w, 0.0, 1.0);
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_1 + _nextFrameOffset);
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = (_BloomFactor * tmpvar_8.x);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  color_1.w = clamp (color_1.w, 0.0, 1.0);
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
Fallback "Diffuse"
}