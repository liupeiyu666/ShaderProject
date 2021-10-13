//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/UVMove_Multiply_New" {
Properties {
[Header(Main Texture)] _MainTex ("Main Tex", 2D) = "white" { }
_USpeed ("Main Tex U Speed", Float) = 1
_VSpeed ("Main Tex V Speed", Float) = 1
[Toggle(_RANDOMU_ON)] _RandomU ("Random U Offset", Float) = 0
[Toggle(_RANDOMV_ON)] _RandomV ("Random V Offset", Float) = 0
[Header(Noise Turbulence 01)] [Toggle(_USENOISETEX01_ON)] _UseNoiseTex01 ("Use Noise Tex 01", Float) = 0
_NoiseTex01 ("Noise Tex 01", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _Noise01ChannelMapping ("Channel Mapping", Float) = 0
_Noise01USpeed ("U Speed", Float) = 1
_Noise01VSpeed ("V Speed", Float) = 1
[Toggle] _Noise01RandomU ("Random U Offset", Float) = 0
[Toggle] _Noise01RandomV ("Random V Offset", Float) = 0
[Header(Noise Turbulence 02)] [Toggle(_USENOISETEX02_ON)] _UseNoiseTex02 ("Use Noise Tex 02", Float) = 0
_NoiseTex02 ("Noise Tex 02", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _Noise02ChannelMapping ("Channel Mapping", Float) = 0
_Noise02USpeed ("U Speed", Float) = 1
_Noise02VSpeed ("V Speed", Float) = 1
[Toggle] _Noise02RandomU ("Random U Offset", Float) = 0
[Toggle] _Noise02RandomV ("Random V Offset", Float) = 0
[Header(Noise Options)] _NoiseOffset ("Noise Offset", Float) = 0
_NoiseBrightness ("Noise Brightness", Float) = 1
[Header(Mask)] [Toggle(_USEMASKTEX_ON)] _UseMaskTex ("Use Mask Tex", Float) = 0
_MaskTex ("Mask Tex", 2D) = "white" { }
[Enum(R, 0, G, 1, B, 2, A, 3)] _MaskChannelMapping ("Channel Mapping", Float) = 0
[Header(Bloom)] _BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Header(Render Options)] [Enum(Off, 4, On, 0)] _AlwaysOnTop ("Always On Top", Float) = 4
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 62908
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  highp vec2 UV_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = (_USpeed * _Time.y);
  tmpvar_5.y = (_VSpeed * _Time.y);
  UV_4 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_5);
  NoiseTubulence_3 = _NoiseOffset;
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_4 = (UV_4 + NoiseTubulence_3);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, UV_4);
  MainTexSampler_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_7.w;
  color_1.xyz = (tmpvar_7.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_7.www);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  highp vec2 UV_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = (_USpeed * _Time.y);
  tmpvar_5.y = (_VSpeed * _Time.y);
  UV_4 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_5);
  NoiseTubulence_3 = _NoiseOffset;
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_4 = (UV_4 + NoiseTubulence_3);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, UV_4);
  MainTexSampler_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_7.w;
  color_1.xyz = (tmpvar_7.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_7.www);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  highp vec2 UV_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = (_USpeed * _Time.y);
  tmpvar_5.y = (_VSpeed * _Time.y);
  UV_4 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_5);
  NoiseTubulence_3 = _NoiseOffset;
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_4 = (UV_4 + NoiseTubulence_3);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, UV_4);
  MainTexSampler_2 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_7.w;
  color_1.xyz = (tmpvar_7.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_7.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  highp vec2 UV_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_4.x = tmpvar_5.x;
  UV_4.y = (tmpvar_5.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (_USpeed * _Time.y);
  tmpvar_6.y = (_VSpeed * _Time.y);
  UV_4 = (UV_4 + tmpvar_6);
  NoiseTubulence_3 = _NoiseOffset;
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_4 = (UV_4 + NoiseTubulence_3);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, UV_4);
  MainTexSampler_2 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_8.w;
  color_1.xyz = (tmpvar_8.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_8.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  highp vec2 UV_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_4.x = tmpvar_5.x;
  UV_4.y = (tmpvar_5.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (_USpeed * _Time.y);
  tmpvar_6.y = (_VSpeed * _Time.y);
  UV_4 = (UV_4 + tmpvar_6);
  NoiseTubulence_3 = _NoiseOffset;
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_4 = (UV_4 + NoiseTubulence_3);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, UV_4);
  MainTexSampler_2 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_8.w;
  color_1.xyz = (tmpvar_8.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_8.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  highp vec2 UV_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_4.x = tmpvar_5.x;
  UV_4.y = (tmpvar_5.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (_USpeed * _Time.y);
  tmpvar_6.y = (_VSpeed * _Time.y);
  UV_4 = (UV_4 + tmpvar_6);
  NoiseTubulence_3 = _NoiseOffset;
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_4 = (UV_4 + NoiseTubulence_3);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, UV_4);
  MainTexSampler_2 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_8.w;
  color_1.xyz = (tmpvar_8.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_8.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  highp vec2 UV_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_4.y = tmpvar_5.y;
  UV_4.x = (tmpvar_5.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (_USpeed * _Time.y);
  tmpvar_6.y = (_VSpeed * _Time.y);
  UV_4 = (UV_4 + tmpvar_6);
  NoiseTubulence_3 = _NoiseOffset;
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_4 = (UV_4 + NoiseTubulence_3);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, UV_4);
  MainTexSampler_2 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_8.w;
  color_1.xyz = (tmpvar_8.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_8.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  highp vec2 UV_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_4.y = tmpvar_5.y;
  UV_4.x = (tmpvar_5.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (_USpeed * _Time.y);
  tmpvar_6.y = (_VSpeed * _Time.y);
  UV_4 = (UV_4 + tmpvar_6);
  NoiseTubulence_3 = _NoiseOffset;
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_4 = (UV_4 + NoiseTubulence_3);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, UV_4);
  MainTexSampler_2 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_8.w;
  color_1.xyz = (tmpvar_8.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_8.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  highp vec2 UV_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_4.y = tmpvar_5.y;
  UV_4.x = (tmpvar_5.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (_USpeed * _Time.y);
  tmpvar_6.y = (_VSpeed * _Time.y);
  UV_4 = (UV_4 + tmpvar_6);
  NoiseTubulence_3 = _NoiseOffset;
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_4 = (UV_4 + NoiseTubulence_3);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, UV_4);
  MainTexSampler_2 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_8.w;
  color_1.xyz = (tmpvar_8.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_8.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  highp vec2 UV_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_4.x = (tmpvar_5.x + xlv_TEXCOORD0.z);
  UV_4.y = (tmpvar_5.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (_USpeed * _Time.y);
  tmpvar_6.y = (_VSpeed * _Time.y);
  UV_4 = (UV_4 + tmpvar_6);
  NoiseTubulence_3 = _NoiseOffset;
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_4 = (UV_4 + NoiseTubulence_3);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, UV_4);
  MainTexSampler_2 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_8.w;
  color_1.xyz = (tmpvar_8.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_8.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  highp vec2 UV_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_4.x = (tmpvar_5.x + xlv_TEXCOORD0.z);
  UV_4.y = (tmpvar_5.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (_USpeed * _Time.y);
  tmpvar_6.y = (_VSpeed * _Time.y);
  UV_4 = (UV_4 + tmpvar_6);
  NoiseTubulence_3 = _NoiseOffset;
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_4 = (UV_4 + NoiseTubulence_3);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, UV_4);
  MainTexSampler_2 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_8.w;
  color_1.xyz = (tmpvar_8.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_8.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  highp vec2 UV_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_4.x = (tmpvar_5.x + xlv_TEXCOORD0.z);
  UV_4.y = (tmpvar_5.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (_USpeed * _Time.y);
  tmpvar_6.y = (_VSpeed * _Time.y);
  UV_4 = (UV_4 + tmpvar_6);
  NoiseTubulence_3 = _NoiseOffset;
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_4 = (UV_4 + NoiseTubulence_3);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, UV_4);
  MainTexSampler_2 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_8.w;
  color_1.xyz = (tmpvar_8.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_8.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USEMASKTEX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  highp vec2 UV_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_USpeed * _Time.y);
  tmpvar_7.y = (_VSpeed * _Time.y);
  UV_6 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_7);
  NoiseTubulence_5 = _NoiseOffset;
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_6 = (UV_6 + NoiseTubulence_5);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, UV_6);
  MainTexSampler_4 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskTex, tmpvar_10);
  MaskSampler_2 = tmpvar_11;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_9.w * MaskChannel_1);
  color_3.xyz = (tmpvar_9.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USEMASKTEX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  highp vec2 UV_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_USpeed * _Time.y);
  tmpvar_7.y = (_VSpeed * _Time.y);
  UV_6 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_7);
  NoiseTubulence_5 = _NoiseOffset;
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_6 = (UV_6 + NoiseTubulence_5);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, UV_6);
  MainTexSampler_4 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskTex, tmpvar_10);
  MaskSampler_2 = tmpvar_11;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_9.w * MaskChannel_1);
  color_3.xyz = (tmpvar_9.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USEMASKTEX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  highp vec2 UV_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_USpeed * _Time.y);
  tmpvar_7.y = (_VSpeed * _Time.y);
  UV_6 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_7);
  NoiseTubulence_5 = _NoiseOffset;
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_6 = (UV_6 + NoiseTubulence_5);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, UV_6);
  MainTexSampler_4 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskTex, tmpvar_10);
  MaskSampler_2 = tmpvar_11;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_9.w * MaskChannel_1);
  color_3.xyz = (tmpvar_9.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  highp vec2 UV_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_6.x = tmpvar_7.x;
  UV_6.y = (tmpvar_7.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_6 = (UV_6 + tmpvar_8);
  NoiseTubulence_5 = _NoiseOffset;
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_6 = (UV_6 + NoiseTubulence_5);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, UV_6);
  MainTexSampler_4 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MaskTex, tmpvar_11);
  MaskSampler_2 = tmpvar_12;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_10.w * MaskChannel_1);
  color_3.xyz = (tmpvar_10.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  highp vec2 UV_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_6.x = tmpvar_7.x;
  UV_6.y = (tmpvar_7.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_6 = (UV_6 + tmpvar_8);
  NoiseTubulence_5 = _NoiseOffset;
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_6 = (UV_6 + NoiseTubulence_5);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, UV_6);
  MainTexSampler_4 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MaskTex, tmpvar_11);
  MaskSampler_2 = tmpvar_12;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_10.w * MaskChannel_1);
  color_3.xyz = (tmpvar_10.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  highp vec2 UV_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_6.x = tmpvar_7.x;
  UV_6.y = (tmpvar_7.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_6 = (UV_6 + tmpvar_8);
  NoiseTubulence_5 = _NoiseOffset;
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_6 = (UV_6 + NoiseTubulence_5);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, UV_6);
  MainTexSampler_4 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MaskTex, tmpvar_11);
  MaskSampler_2 = tmpvar_12;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_10.w * MaskChannel_1);
  color_3.xyz = (tmpvar_10.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  highp vec2 UV_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_6.y = tmpvar_7.y;
  UV_6.x = (tmpvar_7.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_6 = (UV_6 + tmpvar_8);
  NoiseTubulence_5 = _NoiseOffset;
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_6 = (UV_6 + NoiseTubulence_5);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, UV_6);
  MainTexSampler_4 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MaskTex, tmpvar_11);
  MaskSampler_2 = tmpvar_12;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_10.w * MaskChannel_1);
  color_3.xyz = (tmpvar_10.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  highp vec2 UV_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_6.y = tmpvar_7.y;
  UV_6.x = (tmpvar_7.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_6 = (UV_6 + tmpvar_8);
  NoiseTubulence_5 = _NoiseOffset;
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_6 = (UV_6 + NoiseTubulence_5);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, UV_6);
  MainTexSampler_4 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MaskTex, tmpvar_11);
  MaskSampler_2 = tmpvar_12;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_10.w * MaskChannel_1);
  color_3.xyz = (tmpvar_10.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  highp vec2 UV_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_6.y = tmpvar_7.y;
  UV_6.x = (tmpvar_7.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_6 = (UV_6 + tmpvar_8);
  NoiseTubulence_5 = _NoiseOffset;
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_6 = (UV_6 + NoiseTubulence_5);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, UV_6);
  MainTexSampler_4 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MaskTex, tmpvar_11);
  MaskSampler_2 = tmpvar_12;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_10.w * MaskChannel_1);
  color_3.xyz = (tmpvar_10.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  highp vec2 UV_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_6.x = (tmpvar_7.x + xlv_TEXCOORD0.z);
  UV_6.y = (tmpvar_7.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_6 = (UV_6 + tmpvar_8);
  NoiseTubulence_5 = _NoiseOffset;
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_6 = (UV_6 + NoiseTubulence_5);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, UV_6);
  MainTexSampler_4 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MaskTex, tmpvar_11);
  MaskSampler_2 = tmpvar_12;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_10.w * MaskChannel_1);
  color_3.xyz = (tmpvar_10.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  highp vec2 UV_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_6.x = (tmpvar_7.x + xlv_TEXCOORD0.z);
  UV_6.y = (tmpvar_7.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_6 = (UV_6 + tmpvar_8);
  NoiseTubulence_5 = _NoiseOffset;
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_6 = (UV_6 + NoiseTubulence_5);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, UV_6);
  MainTexSampler_4 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MaskTex, tmpvar_11);
  MaskSampler_2 = tmpvar_12;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_10.w * MaskChannel_1);
  color_3.xyz = (tmpvar_10.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  highp vec2 UV_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_6.x = (tmpvar_7.x + xlv_TEXCOORD0.z);
  UV_6.y = (tmpvar_7.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_6 = (UV_6 + tmpvar_8);
  NoiseTubulence_5 = _NoiseOffset;
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_6 = (UV_6 + NoiseTubulence_5);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, UV_6);
  MainTexSampler_4 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MaskTex, tmpvar_11);
  MaskSampler_2 = tmpvar_12;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_10.w * MaskChannel_1);
  color_3.xyz = (tmpvar_10.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  highp vec2 Noise02_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_7 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_8);
  mediump vec2 tmpvar_9;
  tmpvar_9.x = _Noise02RandomU;
  tmpvar_9.y = _Noise02RandomV;
  Noise02_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_9 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Noise02USpeed * _Time.y);
  tmpvar_10.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_6 = (Noise02_UV_6 + tmpvar_10);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_NoiseTex02, Noise02_UV_6);
  Noise02Sampler_5 = tmpvar_11;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise02Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_13.w;
  color_1.xyz = (tmpvar_13.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_13.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  highp vec2 Noise02_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_7 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_8);
  mediump vec2 tmpvar_9;
  tmpvar_9.x = _Noise02RandomU;
  tmpvar_9.y = _Noise02RandomV;
  Noise02_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_9 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Noise02USpeed * _Time.y);
  tmpvar_10.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_6 = (Noise02_UV_6 + tmpvar_10);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_NoiseTex02, Noise02_UV_6);
  Noise02Sampler_5 = tmpvar_11;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise02Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_13.w;
  color_1.xyz = (tmpvar_13.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_13.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  highp vec2 Noise02_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_7 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_8);
  mediump vec2 tmpvar_9;
  tmpvar_9.x = _Noise02RandomU;
  tmpvar_9.y = _Noise02RandomV;
  Noise02_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_9 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Noise02USpeed * _Time.y);
  tmpvar_10.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_6 = (Noise02_UV_6 + tmpvar_10);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_NoiseTex02, Noise02_UV_6);
  Noise02Sampler_5 = tmpvar_11;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise02Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_13.w;
  color_1.xyz = (tmpvar_13.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_13.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  highp vec2 Noise02_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.x = tmpvar_8.x;
  UV_7.y = (tmpvar_8.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise02RandomU;
  tmpvar_10.y = _Noise02RandomV;
  Noise02_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise02USpeed * _Time.y);
  tmpvar_11.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_6 = (Noise02_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex02, Noise02_UV_6);
  Noise02Sampler_5 = tmpvar_12;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise02Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  highp vec2 Noise02_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.x = tmpvar_8.x;
  UV_7.y = (tmpvar_8.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise02RandomU;
  tmpvar_10.y = _Noise02RandomV;
  Noise02_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise02USpeed * _Time.y);
  tmpvar_11.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_6 = (Noise02_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex02, Noise02_UV_6);
  Noise02Sampler_5 = tmpvar_12;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise02Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  highp vec2 Noise02_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.x = tmpvar_8.x;
  UV_7.y = (tmpvar_8.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise02RandomU;
  tmpvar_10.y = _Noise02RandomV;
  Noise02_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise02USpeed * _Time.y);
  tmpvar_11.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_6 = (Noise02_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex02, Noise02_UV_6);
  Noise02Sampler_5 = tmpvar_12;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise02Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  highp vec2 Noise02_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.y = tmpvar_8.y;
  UV_7.x = (tmpvar_8.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise02RandomU;
  tmpvar_10.y = _Noise02RandomV;
  Noise02_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise02USpeed * _Time.y);
  tmpvar_11.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_6 = (Noise02_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex02, Noise02_UV_6);
  Noise02Sampler_5 = tmpvar_12;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise02Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  highp vec2 Noise02_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.y = tmpvar_8.y;
  UV_7.x = (tmpvar_8.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise02RandomU;
  tmpvar_10.y = _Noise02RandomV;
  Noise02_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise02USpeed * _Time.y);
  tmpvar_11.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_6 = (Noise02_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex02, Noise02_UV_6);
  Noise02Sampler_5 = tmpvar_12;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise02Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  highp vec2 Noise02_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.y = tmpvar_8.y;
  UV_7.x = (tmpvar_8.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise02RandomU;
  tmpvar_10.y = _Noise02RandomV;
  Noise02_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise02USpeed * _Time.y);
  tmpvar_11.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_6 = (Noise02_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex02, Noise02_UV_6);
  Noise02Sampler_5 = tmpvar_12;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise02Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  highp vec2 Noise02_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.x = (tmpvar_8.x + xlv_TEXCOORD0.z);
  UV_7.y = (tmpvar_8.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise02RandomU;
  tmpvar_10.y = _Noise02RandomV;
  Noise02_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise02USpeed * _Time.y);
  tmpvar_11.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_6 = (Noise02_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex02, Noise02_UV_6);
  Noise02Sampler_5 = tmpvar_12;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise02Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  highp vec2 Noise02_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.x = (tmpvar_8.x + xlv_TEXCOORD0.z);
  UV_7.y = (tmpvar_8.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise02RandomU;
  tmpvar_10.y = _Noise02RandomV;
  Noise02_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise02USpeed * _Time.y);
  tmpvar_11.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_6 = (Noise02_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex02, Noise02_UV_6);
  Noise02Sampler_5 = tmpvar_12;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise02Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  highp vec2 Noise02_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.x = (tmpvar_8.x + xlv_TEXCOORD0.z);
  UV_7.y = (tmpvar_8.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise02RandomU;
  tmpvar_10.y = _Noise02RandomV;
  Noise02_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise02USpeed * _Time.y);
  tmpvar_11.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_6 = (Noise02_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex02, Noise02_UV_6);
  Noise02Sampler_5 = tmpvar_12;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise02Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_USpeed * _Time.y);
  tmpvar_10.y = (_VSpeed * _Time.y);
  UV_9 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_10);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _Noise02RandomU;
  tmpvar_11.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_11 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_Noise02USpeed * _Time.y);
  tmpvar_12.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_12);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_7 = tmpvar_13;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise02Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_16);
  MaskSampler_2 = tmpvar_17;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_15.w * MaskChannel_1);
  color_3.xyz = (tmpvar_15.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_USpeed * _Time.y);
  tmpvar_10.y = (_VSpeed * _Time.y);
  UV_9 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_10);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _Noise02RandomU;
  tmpvar_11.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_11 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_Noise02USpeed * _Time.y);
  tmpvar_12.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_12);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_7 = tmpvar_13;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise02Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_16);
  MaskSampler_2 = tmpvar_17;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_15.w * MaskChannel_1);
  color_3.xyz = (tmpvar_15.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_USpeed * _Time.y);
  tmpvar_10.y = (_VSpeed * _Time.y);
  UV_9 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_10);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _Noise02RandomU;
  tmpvar_11.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_11 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_Noise02USpeed * _Time.y);
  tmpvar_12.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_12);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_7 = tmpvar_13;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise02Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_16);
  MaskSampler_2 = tmpvar_17;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_15.w * MaskChannel_1);
  color_3.xyz = (tmpvar_15.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.x = tmpvar_10.x;
  UV_9.y = (tmpvar_10.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise02RandomU;
  tmpvar_12.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise02USpeed * _Time.y);
  tmpvar_13.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_7 = tmpvar_14;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise02Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.x = tmpvar_10.x;
  UV_9.y = (tmpvar_10.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise02RandomU;
  tmpvar_12.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise02USpeed * _Time.y);
  tmpvar_13.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_7 = tmpvar_14;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise02Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.x = tmpvar_10.x;
  UV_9.y = (tmpvar_10.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise02RandomU;
  tmpvar_12.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise02USpeed * _Time.y);
  tmpvar_13.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_7 = tmpvar_14;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise02Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.y = tmpvar_10.y;
  UV_9.x = (tmpvar_10.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise02RandomU;
  tmpvar_12.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise02USpeed * _Time.y);
  tmpvar_13.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_7 = tmpvar_14;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise02Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.y = tmpvar_10.y;
  UV_9.x = (tmpvar_10.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise02RandomU;
  tmpvar_12.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise02USpeed * _Time.y);
  tmpvar_13.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_7 = tmpvar_14;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise02Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.y = tmpvar_10.y;
  UV_9.x = (tmpvar_10.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise02RandomU;
  tmpvar_12.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise02USpeed * _Time.y);
  tmpvar_13.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_7 = tmpvar_14;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise02Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.x = (tmpvar_10.x + xlv_TEXCOORD0.z);
  UV_9.y = (tmpvar_10.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise02RandomU;
  tmpvar_12.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise02USpeed * _Time.y);
  tmpvar_13.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_7 = tmpvar_14;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise02Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.x = (tmpvar_10.x + xlv_TEXCOORD0.z);
  UV_9.y = (tmpvar_10.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise02RandomU;
  tmpvar_12.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise02USpeed * _Time.y);
  tmpvar_13.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_7 = tmpvar_14;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise02Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.x = (tmpvar_10.x + xlv_TEXCOORD0.z);
  UV_9.y = (tmpvar_10.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise02RandomU;
  tmpvar_12.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise02USpeed * _Time.y);
  tmpvar_13.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_7 = tmpvar_14;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise02Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise01Channel_4;
  mediump vec4 Noise01Sampler_5;
  highp vec2 Noise01_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_7 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_8);
  mediump vec2 tmpvar_9;
  tmpvar_9.x = _Noise01RandomU;
  tmpvar_9.y = _Noise01RandomV;
  Noise01_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_9 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Noise01USpeed * _Time.y);
  tmpvar_10.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_6 = (Noise01_UV_6 + tmpvar_10);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_NoiseTex01, Noise01_UV_6);
  Noise01Sampler_5 = tmpvar_11;
  Noise01Channel_4 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_4 = Noise01Sampler_5.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_4 = Noise01Sampler_5.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_4 = Noise01Sampler_5.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_4 = Noise01Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_13.w;
  color_1.xyz = (tmpvar_13.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_13.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise01Channel_4;
  mediump vec4 Noise01Sampler_5;
  highp vec2 Noise01_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_7 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_8);
  mediump vec2 tmpvar_9;
  tmpvar_9.x = _Noise01RandomU;
  tmpvar_9.y = _Noise01RandomV;
  Noise01_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_9 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Noise01USpeed * _Time.y);
  tmpvar_10.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_6 = (Noise01_UV_6 + tmpvar_10);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_NoiseTex01, Noise01_UV_6);
  Noise01Sampler_5 = tmpvar_11;
  Noise01Channel_4 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_4 = Noise01Sampler_5.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_4 = Noise01Sampler_5.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_4 = Noise01Sampler_5.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_4 = Noise01Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_13.w;
  color_1.xyz = (tmpvar_13.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_13.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise01Channel_4;
  mediump vec4 Noise01Sampler_5;
  highp vec2 Noise01_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_USpeed * _Time.y);
  tmpvar_8.y = (_VSpeed * _Time.y);
  UV_7 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_8);
  mediump vec2 tmpvar_9;
  tmpvar_9.x = _Noise01RandomU;
  tmpvar_9.y = _Noise01RandomV;
  Noise01_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_9 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Noise01USpeed * _Time.y);
  tmpvar_10.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_6 = (Noise01_UV_6 + tmpvar_10);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_NoiseTex01, Noise01_UV_6);
  Noise01Sampler_5 = tmpvar_11;
  Noise01Channel_4 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_4 = Noise01Sampler_5.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_4 = Noise01Sampler_5.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_4 = Noise01Sampler_5.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_4 = Noise01Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_13.w;
  color_1.xyz = (tmpvar_13.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_13.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise01Channel_4;
  mediump vec4 Noise01Sampler_5;
  highp vec2 Noise01_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.x = tmpvar_8.x;
  UV_7.y = (tmpvar_8.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise01RandomU;
  tmpvar_10.y = _Noise01RandomV;
  Noise01_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise01USpeed * _Time.y);
  tmpvar_11.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_6 = (Noise01_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex01, Noise01_UV_6);
  Noise01Sampler_5 = tmpvar_12;
  Noise01Channel_4 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_4 = Noise01Sampler_5.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_4 = Noise01Sampler_5.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_4 = Noise01Sampler_5.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_4 = Noise01Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise01Channel_4;
  mediump vec4 Noise01Sampler_5;
  highp vec2 Noise01_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.x = tmpvar_8.x;
  UV_7.y = (tmpvar_8.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise01RandomU;
  tmpvar_10.y = _Noise01RandomV;
  Noise01_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise01USpeed * _Time.y);
  tmpvar_11.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_6 = (Noise01_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex01, Noise01_UV_6);
  Noise01Sampler_5 = tmpvar_12;
  Noise01Channel_4 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_4 = Noise01Sampler_5.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_4 = Noise01Sampler_5.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_4 = Noise01Sampler_5.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_4 = Noise01Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise01Channel_4;
  mediump vec4 Noise01Sampler_5;
  highp vec2 Noise01_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.x = tmpvar_8.x;
  UV_7.y = (tmpvar_8.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise01RandomU;
  tmpvar_10.y = _Noise01RandomV;
  Noise01_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise01USpeed * _Time.y);
  tmpvar_11.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_6 = (Noise01_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex01, Noise01_UV_6);
  Noise01Sampler_5 = tmpvar_12;
  Noise01Channel_4 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_4 = Noise01Sampler_5.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_4 = Noise01Sampler_5.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_4 = Noise01Sampler_5.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_4 = Noise01Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise01Channel_4;
  mediump vec4 Noise01Sampler_5;
  highp vec2 Noise01_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.y = tmpvar_8.y;
  UV_7.x = (tmpvar_8.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise01RandomU;
  tmpvar_10.y = _Noise01RandomV;
  Noise01_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise01USpeed * _Time.y);
  tmpvar_11.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_6 = (Noise01_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex01, Noise01_UV_6);
  Noise01Sampler_5 = tmpvar_12;
  Noise01Channel_4 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_4 = Noise01Sampler_5.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_4 = Noise01Sampler_5.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_4 = Noise01Sampler_5.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_4 = Noise01Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise01Channel_4;
  mediump vec4 Noise01Sampler_5;
  highp vec2 Noise01_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.y = tmpvar_8.y;
  UV_7.x = (tmpvar_8.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise01RandomU;
  tmpvar_10.y = _Noise01RandomV;
  Noise01_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise01USpeed * _Time.y);
  tmpvar_11.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_6 = (Noise01_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex01, Noise01_UV_6);
  Noise01Sampler_5 = tmpvar_12;
  Noise01Channel_4 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_4 = Noise01Sampler_5.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_4 = Noise01Sampler_5.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_4 = Noise01Sampler_5.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_4 = Noise01Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise01Channel_4;
  mediump vec4 Noise01Sampler_5;
  highp vec2 Noise01_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.y = tmpvar_8.y;
  UV_7.x = (tmpvar_8.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise01RandomU;
  tmpvar_10.y = _Noise01RandomV;
  Noise01_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise01USpeed * _Time.y);
  tmpvar_11.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_6 = (Noise01_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex01, Noise01_UV_6);
  Noise01Sampler_5 = tmpvar_12;
  Noise01Channel_4 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_4 = Noise01Sampler_5.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_4 = Noise01Sampler_5.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_4 = Noise01Sampler_5.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_4 = Noise01Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise01Channel_4;
  mediump vec4 Noise01Sampler_5;
  highp vec2 Noise01_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.x = (tmpvar_8.x + xlv_TEXCOORD0.z);
  UV_7.y = (tmpvar_8.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise01RandomU;
  tmpvar_10.y = _Noise01RandomV;
  Noise01_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise01USpeed * _Time.y);
  tmpvar_11.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_6 = (Noise01_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex01, Noise01_UV_6);
  Noise01Sampler_5 = tmpvar_12;
  Noise01Channel_4 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_4 = Noise01Sampler_5.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_4 = Noise01Sampler_5.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_4 = Noise01Sampler_5.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_4 = Noise01Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise01Channel_4;
  mediump vec4 Noise01Sampler_5;
  highp vec2 Noise01_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.x = (tmpvar_8.x + xlv_TEXCOORD0.z);
  UV_7.y = (tmpvar_8.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise01RandomU;
  tmpvar_10.y = _Noise01RandomV;
  Noise01_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise01USpeed * _Time.y);
  tmpvar_11.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_6 = (Noise01_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex01, Noise01_UV_6);
  Noise01Sampler_5 = tmpvar_12;
  Noise01Channel_4 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_4 = Noise01Sampler_5.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_4 = Noise01Sampler_5.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_4 = Noise01Sampler_5.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_4 = Noise01Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise01Channel_4;
  mediump vec4 Noise01Sampler_5;
  highp vec2 Noise01_UV_6;
  highp vec2 UV_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_7.x = (tmpvar_8.x + xlv_TEXCOORD0.z);
  UV_7.y = (tmpvar_8.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_USpeed * _Time.y);
  tmpvar_9.y = (_VSpeed * _Time.y);
  UV_7 = (UV_7 + tmpvar_9);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = _Noise01RandomU;
  tmpvar_10.y = _Noise01RandomV;
  Noise01_UV_6 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_10 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_Noise01USpeed * _Time.y);
  tmpvar_11.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_6 = (Noise01_UV_6 + tmpvar_11);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_NoiseTex01, Noise01_UV_6);
  Noise01Sampler_5 = tmpvar_12;
  Noise01Channel_4 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_4 = Noise01Sampler_5.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_4 = Noise01Sampler_5.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_4 = Noise01Sampler_5.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_4 = Noise01Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_4 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_7 = (UV_7 + NoiseTubulence_3);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, UV_7);
  MainTexSampler_2 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_14.w;
  color_1.xyz = (tmpvar_14.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_14.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise01_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_USpeed * _Time.y);
  tmpvar_10.y = (_VSpeed * _Time.y);
  UV_9 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_10);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _Noise01RandomU;
  tmpvar_11.y = _Noise01RandomV;
  Noise01_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_11 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_Noise01USpeed * _Time.y);
  tmpvar_12.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_8 = (Noise01_UV_8 + tmpvar_12);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NoiseTex01, Noise01_UV_8);
  Noise01Sampler_7 = tmpvar_13;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_16);
  MaskSampler_2 = tmpvar_17;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_15.w * MaskChannel_1);
  color_3.xyz = (tmpvar_15.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise01_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_USpeed * _Time.y);
  tmpvar_10.y = (_VSpeed * _Time.y);
  UV_9 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_10);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _Noise01RandomU;
  tmpvar_11.y = _Noise01RandomV;
  Noise01_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_11 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_Noise01USpeed * _Time.y);
  tmpvar_12.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_8 = (Noise01_UV_8 + tmpvar_12);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NoiseTex01, Noise01_UV_8);
  Noise01Sampler_7 = tmpvar_13;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_16);
  MaskSampler_2 = tmpvar_17;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_15.w * MaskChannel_1);
  color_3.xyz = (tmpvar_15.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise01_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_USpeed * _Time.y);
  tmpvar_10.y = (_VSpeed * _Time.y);
  UV_9 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_10);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = _Noise01RandomU;
  tmpvar_11.y = _Noise01RandomV;
  Noise01_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_11 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_Noise01USpeed * _Time.y);
  tmpvar_12.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_8 = (Noise01_UV_8 + tmpvar_12);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NoiseTex01, Noise01_UV_8);
  Noise01Sampler_7 = tmpvar_13;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MaskTex, tmpvar_16);
  MaskSampler_2 = tmpvar_17;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_15.w * MaskChannel_1);
  color_3.xyz = (tmpvar_15.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise01_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.x = tmpvar_10.x;
  UV_9.y = (tmpvar_10.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise01RandomU;
  tmpvar_12.y = _Noise01RandomV;
  Noise01_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise01USpeed * _Time.y);
  tmpvar_13.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_8 = (Noise01_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex01, Noise01_UV_8);
  Noise01Sampler_7 = tmpvar_14;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise01_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.x = tmpvar_10.x;
  UV_9.y = (tmpvar_10.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise01RandomU;
  tmpvar_12.y = _Noise01RandomV;
  Noise01_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise01USpeed * _Time.y);
  tmpvar_13.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_8 = (Noise01_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex01, Noise01_UV_8);
  Noise01Sampler_7 = tmpvar_14;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise01_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.x = tmpvar_10.x;
  UV_9.y = (tmpvar_10.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise01RandomU;
  tmpvar_12.y = _Noise01RandomV;
  Noise01_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise01USpeed * _Time.y);
  tmpvar_13.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_8 = (Noise01_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex01, Noise01_UV_8);
  Noise01Sampler_7 = tmpvar_14;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise01_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.y = tmpvar_10.y;
  UV_9.x = (tmpvar_10.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise01RandomU;
  tmpvar_12.y = _Noise01RandomV;
  Noise01_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise01USpeed * _Time.y);
  tmpvar_13.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_8 = (Noise01_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex01, Noise01_UV_8);
  Noise01Sampler_7 = tmpvar_14;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise01_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.y = tmpvar_10.y;
  UV_9.x = (tmpvar_10.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise01RandomU;
  tmpvar_12.y = _Noise01RandomV;
  Noise01_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise01USpeed * _Time.y);
  tmpvar_13.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_8 = (Noise01_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex01, Noise01_UV_8);
  Noise01Sampler_7 = tmpvar_14;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise01_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.y = tmpvar_10.y;
  UV_9.x = (tmpvar_10.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise01RandomU;
  tmpvar_12.y = _Noise01RandomV;
  Noise01_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise01USpeed * _Time.y);
  tmpvar_13.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_8 = (Noise01_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex01, Noise01_UV_8);
  Noise01Sampler_7 = tmpvar_14;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise01_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.x = (tmpvar_10.x + xlv_TEXCOORD0.z);
  UV_9.y = (tmpvar_10.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise01RandomU;
  tmpvar_12.y = _Noise01RandomV;
  Noise01_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise01USpeed * _Time.y);
  tmpvar_13.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_8 = (Noise01_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex01, Noise01_UV_8);
  Noise01Sampler_7 = tmpvar_14;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise01_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.x = (tmpvar_10.x + xlv_TEXCOORD0.z);
  UV_9.y = (tmpvar_10.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise01RandomU;
  tmpvar_12.y = _Noise01RandomV;
  Noise01_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise01USpeed * _Time.y);
  tmpvar_13.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_8 = (Noise01_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex01, Noise01_UV_8);
  Noise01Sampler_7 = tmpvar_14;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise01_UV_8;
  highp vec2 UV_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_9.x = (tmpvar_10.x + xlv_TEXCOORD0.z);
  UV_9.y = (tmpvar_10.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_9 = (UV_9 + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise01RandomU;
  tmpvar_12.y = _Noise01RandomV;
  Noise01_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.xy));
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_Noise01USpeed * _Time.y);
  tmpvar_13.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_8 = (Noise01_UV_8 + tmpvar_13);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTex01, Noise01_UV_8);
  Noise01Sampler_7 = tmpvar_14;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_6 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_9 = (UV_9 + NoiseTubulence_5);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, UV_9);
  MainTexSampler_4 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MaskTex, tmpvar_17);
  MaskSampler_2 = tmpvar_18;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_16.w * MaskChannel_1);
  color_3.xyz = (tmpvar_16.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 Noise01_UV_9;
  highp vec2 UV_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_10 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise01RandomU;
  tmpvar_12.y = _Noise01RandomV;
  Noise01_UV_9 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_13;
  tmpvar_13.x = _Noise02RandomU;
  tmpvar_13.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_13 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_Noise01USpeed * _Time.y);
  tmpvar_14.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_9 = (Noise01_UV_9 + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (_Noise02USpeed * _Time.y);
  tmpvar_15.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_15);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_NoiseTex01, Noise01_UV_9);
  Noise01Sampler_7 = tmpvar_16;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_5 = tmpvar_17;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_6 * Noise02Channel_4);
  NoiseTubulence_3 = (NoiseTubulence_3 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_10 = (UV_10 + NoiseTubulence_3);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, UV_10);
  MainTexSampler_2 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_19.w;
  color_1.xyz = (tmpvar_19.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_19.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 Noise01_UV_9;
  highp vec2 UV_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_10 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise01RandomU;
  tmpvar_12.y = _Noise01RandomV;
  Noise01_UV_9 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_13;
  tmpvar_13.x = _Noise02RandomU;
  tmpvar_13.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_13 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_Noise01USpeed * _Time.y);
  tmpvar_14.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_9 = (Noise01_UV_9 + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (_Noise02USpeed * _Time.y);
  tmpvar_15.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_15);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_NoiseTex01, Noise01_UV_9);
  Noise01Sampler_7 = tmpvar_16;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_5 = tmpvar_17;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_6 * Noise02Channel_4);
  NoiseTubulence_3 = (NoiseTubulence_3 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_10 = (UV_10 + NoiseTubulence_3);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, UV_10);
  MainTexSampler_2 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_19.w;
  color_1.xyz = (tmpvar_19.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_19.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 Noise01_UV_9;
  highp vec2 UV_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = (_USpeed * _Time.y);
  tmpvar_11.y = (_VSpeed * _Time.y);
  UV_10 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = _Noise01RandomU;
  tmpvar_12.y = _Noise01RandomV;
  Noise01_UV_9 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_12 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_13;
  tmpvar_13.x = _Noise02RandomU;
  tmpvar_13.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_13 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_Noise01USpeed * _Time.y);
  tmpvar_14.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_9 = (Noise01_UV_9 + tmpvar_14);
  highp vec2 tmpvar_15;
  tmpvar_15.x = (_Noise02USpeed * _Time.y);
  tmpvar_15.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_15);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_NoiseTex01, Noise01_UV_9);
  Noise01Sampler_7 = tmpvar_16;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_5 = tmpvar_17;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_6 * Noise02Channel_4);
  NoiseTubulence_3 = (NoiseTubulence_3 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_10 = (UV_10 + NoiseTubulence_3);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, UV_10);
  MainTexSampler_2 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_19.w;
  color_1.xyz = (tmpvar_19.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_19.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 Noise01_UV_9;
  highp vec2 UV_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_10.x = tmpvar_11.x;
  UV_10.y = (tmpvar_11.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_USpeed * _Time.y);
  tmpvar_12.y = (_VSpeed * _Time.y);
  UV_10 = (UV_10 + tmpvar_12);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = _Noise01RandomU;
  tmpvar_13.y = _Noise01RandomV;
  Noise01_UV_9 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_13 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _Noise02RandomU;
  tmpvar_14.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_14 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_15;
  tmpvar_15.x = (_Noise01USpeed * _Time.y);
  tmpvar_15.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_9 = (Noise01_UV_9 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (_Noise02USpeed * _Time.y);
  tmpvar_16.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_16);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, Noise01_UV_9);
  Noise01Sampler_7 = tmpvar_17;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_5 = tmpvar_18;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_6 * Noise02Channel_4);
  NoiseTubulence_3 = (NoiseTubulence_3 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_10 = (UV_10 + NoiseTubulence_3);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, UV_10);
  MainTexSampler_2 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_20.w;
  color_1.xyz = (tmpvar_20.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_20.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 Noise01_UV_9;
  highp vec2 UV_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_10.x = tmpvar_11.x;
  UV_10.y = (tmpvar_11.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_USpeed * _Time.y);
  tmpvar_12.y = (_VSpeed * _Time.y);
  UV_10 = (UV_10 + tmpvar_12);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = _Noise01RandomU;
  tmpvar_13.y = _Noise01RandomV;
  Noise01_UV_9 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_13 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _Noise02RandomU;
  tmpvar_14.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_14 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_15;
  tmpvar_15.x = (_Noise01USpeed * _Time.y);
  tmpvar_15.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_9 = (Noise01_UV_9 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (_Noise02USpeed * _Time.y);
  tmpvar_16.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_16);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, Noise01_UV_9);
  Noise01Sampler_7 = tmpvar_17;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_5 = tmpvar_18;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_6 * Noise02Channel_4);
  NoiseTubulence_3 = (NoiseTubulence_3 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_10 = (UV_10 + NoiseTubulence_3);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, UV_10);
  MainTexSampler_2 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_20.w;
  color_1.xyz = (tmpvar_20.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_20.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 Noise01_UV_9;
  highp vec2 UV_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_10.x = tmpvar_11.x;
  UV_10.y = (tmpvar_11.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_USpeed * _Time.y);
  tmpvar_12.y = (_VSpeed * _Time.y);
  UV_10 = (UV_10 + tmpvar_12);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = _Noise01RandomU;
  tmpvar_13.y = _Noise01RandomV;
  Noise01_UV_9 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_13 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _Noise02RandomU;
  tmpvar_14.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_14 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_15;
  tmpvar_15.x = (_Noise01USpeed * _Time.y);
  tmpvar_15.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_9 = (Noise01_UV_9 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (_Noise02USpeed * _Time.y);
  tmpvar_16.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_16);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, Noise01_UV_9);
  Noise01Sampler_7 = tmpvar_17;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_5 = tmpvar_18;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_6 * Noise02Channel_4);
  NoiseTubulence_3 = (NoiseTubulence_3 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_10 = (UV_10 + NoiseTubulence_3);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, UV_10);
  MainTexSampler_2 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_20.w;
  color_1.xyz = (tmpvar_20.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_20.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 Noise01_UV_9;
  highp vec2 UV_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_10.y = tmpvar_11.y;
  UV_10.x = (tmpvar_11.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_USpeed * _Time.y);
  tmpvar_12.y = (_VSpeed * _Time.y);
  UV_10 = (UV_10 + tmpvar_12);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = _Noise01RandomU;
  tmpvar_13.y = _Noise01RandomV;
  Noise01_UV_9 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_13 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _Noise02RandomU;
  tmpvar_14.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_14 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_15;
  tmpvar_15.x = (_Noise01USpeed * _Time.y);
  tmpvar_15.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_9 = (Noise01_UV_9 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (_Noise02USpeed * _Time.y);
  tmpvar_16.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_16);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, Noise01_UV_9);
  Noise01Sampler_7 = tmpvar_17;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_5 = tmpvar_18;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_6 * Noise02Channel_4);
  NoiseTubulence_3 = (NoiseTubulence_3 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_10 = (UV_10 + NoiseTubulence_3);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, UV_10);
  MainTexSampler_2 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_20.w;
  color_1.xyz = (tmpvar_20.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_20.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 Noise01_UV_9;
  highp vec2 UV_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_10.y = tmpvar_11.y;
  UV_10.x = (tmpvar_11.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_USpeed * _Time.y);
  tmpvar_12.y = (_VSpeed * _Time.y);
  UV_10 = (UV_10 + tmpvar_12);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = _Noise01RandomU;
  tmpvar_13.y = _Noise01RandomV;
  Noise01_UV_9 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_13 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _Noise02RandomU;
  tmpvar_14.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_14 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_15;
  tmpvar_15.x = (_Noise01USpeed * _Time.y);
  tmpvar_15.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_9 = (Noise01_UV_9 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (_Noise02USpeed * _Time.y);
  tmpvar_16.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_16);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, Noise01_UV_9);
  Noise01Sampler_7 = tmpvar_17;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_5 = tmpvar_18;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_6 * Noise02Channel_4);
  NoiseTubulence_3 = (NoiseTubulence_3 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_10 = (UV_10 + NoiseTubulence_3);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, UV_10);
  MainTexSampler_2 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_20.w;
  color_1.xyz = (tmpvar_20.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_20.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 Noise01_UV_9;
  highp vec2 UV_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_10.y = tmpvar_11.y;
  UV_10.x = (tmpvar_11.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_USpeed * _Time.y);
  tmpvar_12.y = (_VSpeed * _Time.y);
  UV_10 = (UV_10 + tmpvar_12);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = _Noise01RandomU;
  tmpvar_13.y = _Noise01RandomV;
  Noise01_UV_9 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_13 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _Noise02RandomU;
  tmpvar_14.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_14 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_15;
  tmpvar_15.x = (_Noise01USpeed * _Time.y);
  tmpvar_15.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_9 = (Noise01_UV_9 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (_Noise02USpeed * _Time.y);
  tmpvar_16.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_16);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, Noise01_UV_9);
  Noise01Sampler_7 = tmpvar_17;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_5 = tmpvar_18;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_6 * Noise02Channel_4);
  NoiseTubulence_3 = (NoiseTubulence_3 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_10 = (UV_10 + NoiseTubulence_3);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, UV_10);
  MainTexSampler_2 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_20.w;
  color_1.xyz = (tmpvar_20.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_20.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 Noise01_UV_9;
  highp vec2 UV_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_10.x = (tmpvar_11.x + xlv_TEXCOORD0.z);
  UV_10.y = (tmpvar_11.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_USpeed * _Time.y);
  tmpvar_12.y = (_VSpeed * _Time.y);
  UV_10 = (UV_10 + tmpvar_12);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = _Noise01RandomU;
  tmpvar_13.y = _Noise01RandomV;
  Noise01_UV_9 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_13 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _Noise02RandomU;
  tmpvar_14.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_14 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_15;
  tmpvar_15.x = (_Noise01USpeed * _Time.y);
  tmpvar_15.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_9 = (Noise01_UV_9 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (_Noise02USpeed * _Time.y);
  tmpvar_16.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_16);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, Noise01_UV_9);
  Noise01Sampler_7 = tmpvar_17;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_5 = tmpvar_18;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_6 * Noise02Channel_4);
  NoiseTubulence_3 = (NoiseTubulence_3 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_10 = (UV_10 + NoiseTubulence_3);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, UV_10);
  MainTexSampler_2 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_20.w;
  color_1.xyz = (tmpvar_20.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_20.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 Noise01_UV_9;
  highp vec2 UV_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_10.x = (tmpvar_11.x + xlv_TEXCOORD0.z);
  UV_10.y = (tmpvar_11.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_USpeed * _Time.y);
  tmpvar_12.y = (_VSpeed * _Time.y);
  UV_10 = (UV_10 + tmpvar_12);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = _Noise01RandomU;
  tmpvar_13.y = _Noise01RandomV;
  Noise01_UV_9 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_13 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _Noise02RandomU;
  tmpvar_14.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_14 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_15;
  tmpvar_15.x = (_Noise01USpeed * _Time.y);
  tmpvar_15.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_9 = (Noise01_UV_9 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (_Noise02USpeed * _Time.y);
  tmpvar_16.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_16);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, Noise01_UV_9);
  Noise01Sampler_7 = tmpvar_17;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_5 = tmpvar_18;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_6 * Noise02Channel_4);
  NoiseTubulence_3 = (NoiseTubulence_3 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_10 = (UV_10 + NoiseTubulence_3);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, UV_10);
  MainTexSampler_2 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_20.w;
  color_1.xyz = (tmpvar_20.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_20.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 MainTexSampler_2;
  mediump float NoiseTubulence_3;
  mediump float Noise02Channel_4;
  mediump vec4 Noise02Sampler_5;
  mediump float Noise01Channel_6;
  mediump vec4 Noise01Sampler_7;
  highp vec2 Noise02_UV_8;
  highp vec2 Noise01_UV_9;
  highp vec2 UV_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_10.x = (tmpvar_11.x + xlv_TEXCOORD0.z);
  UV_10.y = (tmpvar_11.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (_USpeed * _Time.y);
  tmpvar_12.y = (_VSpeed * _Time.y);
  UV_10 = (UV_10 + tmpvar_12);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = _Noise01RandomU;
  tmpvar_13.y = _Noise01RandomV;
  Noise01_UV_9 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_13 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _Noise02RandomU;
  tmpvar_14.y = _Noise02RandomV;
  Noise02_UV_8 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_14 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_15;
  tmpvar_15.x = (_Noise01USpeed * _Time.y);
  tmpvar_15.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_9 = (Noise01_UV_9 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (_Noise02USpeed * _Time.y);
  tmpvar_16.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_8 = (Noise02_UV_8 + tmpvar_16);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, Noise01_UV_9);
  Noise01Sampler_7 = tmpvar_17;
  Noise01Channel_6 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_6 = Noise01Sampler_7.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_6 = Noise01Sampler_7.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_6 = Noise01Sampler_7.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_6 = Noise01Sampler_7.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex02, Noise02_UV_8);
  Noise02Sampler_5 = tmpvar_18;
  Noise02Channel_4 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_4 = Noise02Sampler_5.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_4 = Noise02Sampler_5.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_4 = Noise02Sampler_5.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_4 = Noise02Sampler_5.w;
        };
      };
    };
  };
  NoiseTubulence_3 = (Noise01Channel_6 * Noise02Channel_4);
  NoiseTubulence_3 = (NoiseTubulence_3 + _NoiseOffset);
  NoiseTubulence_3 = (NoiseTubulence_3 * _NoiseBrightness);
  UV_10 = (UV_10 + NoiseTubulence_3);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, UV_10);
  MainTexSampler_2 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (MainTexSampler_2 * xlv_COLOR);
  color_1.w = tmpvar_20.w;
  color_1.xyz = (tmpvar_20.xyz * _EmissionScaler);
  color_1.xyz = mix (vec3(1.0, 1.0, 1.0), color_1.xyz, tmpvar_20.www);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  mediump float Noise01Channel_8;
  mediump vec4 Noise01Sampler_9;
  highp vec2 Noise02_UV_10;
  highp vec2 Noise01_UV_11;
  highp vec2 UV_12;
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_USpeed * _Time.y);
  tmpvar_13.y = (_VSpeed * _Time.y);
  UV_12 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_13);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _Noise01RandomU;
  tmpvar_14.y = _Noise01RandomV;
  Noise01_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_14 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = _Noise02RandomU;
  tmpvar_15.y = _Noise02RandomV;
  Noise02_UV_10 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_15 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_16;
  tmpvar_16.x = (_Noise01USpeed * _Time.y);
  tmpvar_16.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_11 = (Noise01_UV_11 + tmpvar_16);
  highp vec2 tmpvar_17;
  tmpvar_17.x = (_Noise02USpeed * _Time.y);
  tmpvar_17.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_10 = (Noise02_UV_10 + tmpvar_17);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex01, Noise01_UV_11);
  Noise01Sampler_9 = tmpvar_18;
  Noise01Channel_8 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_8 = Noise01Sampler_9.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_8 = Noise01Sampler_9.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_8 = Noise01Sampler_9.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_8 = Noise01Sampler_9.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_NoiseTex02, Noise02_UV_10);
  Noise02Sampler_7 = tmpvar_19;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_8 * Noise02Channel_6);
  NoiseTubulence_5 = (NoiseTubulence_5 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_12 = (UV_12 + NoiseTubulence_5);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, UV_12);
  MainTexSampler_4 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MaskTex, tmpvar_22);
  MaskSampler_2 = tmpvar_23;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_21.w * MaskChannel_1);
  color_3.xyz = (tmpvar_21.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  mediump float Noise01Channel_8;
  mediump vec4 Noise01Sampler_9;
  highp vec2 Noise02_UV_10;
  highp vec2 Noise01_UV_11;
  highp vec2 UV_12;
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_USpeed * _Time.y);
  tmpvar_13.y = (_VSpeed * _Time.y);
  UV_12 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_13);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _Noise01RandomU;
  tmpvar_14.y = _Noise01RandomV;
  Noise01_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_14 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = _Noise02RandomU;
  tmpvar_15.y = _Noise02RandomV;
  Noise02_UV_10 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_15 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_16;
  tmpvar_16.x = (_Noise01USpeed * _Time.y);
  tmpvar_16.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_11 = (Noise01_UV_11 + tmpvar_16);
  highp vec2 tmpvar_17;
  tmpvar_17.x = (_Noise02USpeed * _Time.y);
  tmpvar_17.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_10 = (Noise02_UV_10 + tmpvar_17);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex01, Noise01_UV_11);
  Noise01Sampler_9 = tmpvar_18;
  Noise01Channel_8 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_8 = Noise01Sampler_9.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_8 = Noise01Sampler_9.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_8 = Noise01Sampler_9.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_8 = Noise01Sampler_9.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_NoiseTex02, Noise02_UV_10);
  Noise02Sampler_7 = tmpvar_19;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_8 * Noise02Channel_6);
  NoiseTubulence_5 = (NoiseTubulence_5 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_12 = (UV_12 + NoiseTubulence_5);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, UV_12);
  MainTexSampler_4 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MaskTex, tmpvar_22);
  MaskSampler_2 = tmpvar_23;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_21.w * MaskChannel_1);
  color_3.xyz = (tmpvar_21.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  mediump float Noise01Channel_8;
  mediump vec4 Noise01Sampler_9;
  highp vec2 Noise02_UV_10;
  highp vec2 Noise01_UV_11;
  highp vec2 UV_12;
  highp vec2 tmpvar_13;
  tmpvar_13.x = (_USpeed * _Time.y);
  tmpvar_13.y = (_VSpeed * _Time.y);
  UV_12 = (((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + tmpvar_13);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = _Noise01RandomU;
  tmpvar_14.y = _Noise01RandomV;
  Noise01_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_14 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_15;
  tmpvar_15.x = _Noise02RandomU;
  tmpvar_15.y = _Noise02RandomV;
  Noise02_UV_10 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_15 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_16;
  tmpvar_16.x = (_Noise01USpeed * _Time.y);
  tmpvar_16.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_11 = (Noise01_UV_11 + tmpvar_16);
  highp vec2 tmpvar_17;
  tmpvar_17.x = (_Noise02USpeed * _Time.y);
  tmpvar_17.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_10 = (Noise02_UV_10 + tmpvar_17);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NoiseTex01, Noise01_UV_11);
  Noise01Sampler_9 = tmpvar_18;
  Noise01Channel_8 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_8 = Noise01Sampler_9.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_8 = Noise01Sampler_9.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_8 = Noise01Sampler_9.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_8 = Noise01Sampler_9.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_NoiseTex02, Noise02_UV_10);
  Noise02Sampler_7 = tmpvar_19;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_8 * Noise02Channel_6);
  NoiseTubulence_5 = (NoiseTubulence_5 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_12 = (UV_12 + NoiseTubulence_5);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, UV_12);
  MainTexSampler_4 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MaskTex, tmpvar_22);
  MaskSampler_2 = tmpvar_23;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_21.w * MaskChannel_1);
  color_3.xyz = (tmpvar_21.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  mediump float Noise01Channel_8;
  mediump vec4 Noise01Sampler_9;
  highp vec2 Noise02_UV_10;
  highp vec2 Noise01_UV_11;
  highp vec2 UV_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_12.x = tmpvar_13.x;
  UV_12.y = (tmpvar_13.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_USpeed * _Time.y);
  tmpvar_14.y = (_VSpeed * _Time.y);
  UV_12 = (UV_12 + tmpvar_14);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = _Noise01RandomU;
  tmpvar_15.y = _Noise01RandomV;
  Noise01_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_15 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = _Noise02RandomU;
  tmpvar_16.y = _Noise02RandomV;
  Noise02_UV_10 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_16 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_17;
  tmpvar_17.x = (_Noise01USpeed * _Time.y);
  tmpvar_17.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_11 = (Noise01_UV_11 + tmpvar_17);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (_Noise02USpeed * _Time.y);
  tmpvar_18.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_10 = (Noise02_UV_10 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_NoiseTex01, Noise01_UV_11);
  Noise01Sampler_9 = tmpvar_19;
  Noise01Channel_8 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_8 = Noise01Sampler_9.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_8 = Noise01Sampler_9.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_8 = Noise01Sampler_9.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_8 = Noise01Sampler_9.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NoiseTex02, Noise02_UV_10);
  Noise02Sampler_7 = tmpvar_20;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_8 * Noise02Channel_6);
  NoiseTubulence_5 = (NoiseTubulence_5 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_12 = (UV_12 + NoiseTubulence_5);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, UV_12);
  MainTexSampler_4 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MaskTex, tmpvar_23);
  MaskSampler_2 = tmpvar_24;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_22.w * MaskChannel_1);
  color_3.xyz = (tmpvar_22.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  mediump float Noise01Channel_8;
  mediump vec4 Noise01Sampler_9;
  highp vec2 Noise02_UV_10;
  highp vec2 Noise01_UV_11;
  highp vec2 UV_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_12.x = tmpvar_13.x;
  UV_12.y = (tmpvar_13.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_USpeed * _Time.y);
  tmpvar_14.y = (_VSpeed * _Time.y);
  UV_12 = (UV_12 + tmpvar_14);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = _Noise01RandomU;
  tmpvar_15.y = _Noise01RandomV;
  Noise01_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_15 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = _Noise02RandomU;
  tmpvar_16.y = _Noise02RandomV;
  Noise02_UV_10 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_16 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_17;
  tmpvar_17.x = (_Noise01USpeed * _Time.y);
  tmpvar_17.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_11 = (Noise01_UV_11 + tmpvar_17);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (_Noise02USpeed * _Time.y);
  tmpvar_18.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_10 = (Noise02_UV_10 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_NoiseTex01, Noise01_UV_11);
  Noise01Sampler_9 = tmpvar_19;
  Noise01Channel_8 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_8 = Noise01Sampler_9.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_8 = Noise01Sampler_9.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_8 = Noise01Sampler_9.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_8 = Noise01Sampler_9.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NoiseTex02, Noise02_UV_10);
  Noise02Sampler_7 = tmpvar_20;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_8 * Noise02Channel_6);
  NoiseTubulence_5 = (NoiseTubulence_5 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_12 = (UV_12 + NoiseTubulence_5);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, UV_12);
  MainTexSampler_4 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MaskTex, tmpvar_23);
  MaskSampler_2 = tmpvar_24;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_22.w * MaskChannel_1);
  color_3.xyz = (tmpvar_22.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  mediump float Noise01Channel_8;
  mediump vec4 Noise01Sampler_9;
  highp vec2 Noise02_UV_10;
  highp vec2 Noise01_UV_11;
  highp vec2 UV_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_12.x = tmpvar_13.x;
  UV_12.y = (tmpvar_13.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_USpeed * _Time.y);
  tmpvar_14.y = (_VSpeed * _Time.y);
  UV_12 = (UV_12 + tmpvar_14);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = _Noise01RandomU;
  tmpvar_15.y = _Noise01RandomV;
  Noise01_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_15 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = _Noise02RandomU;
  tmpvar_16.y = _Noise02RandomV;
  Noise02_UV_10 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_16 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_17;
  tmpvar_17.x = (_Noise01USpeed * _Time.y);
  tmpvar_17.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_11 = (Noise01_UV_11 + tmpvar_17);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (_Noise02USpeed * _Time.y);
  tmpvar_18.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_10 = (Noise02_UV_10 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_NoiseTex01, Noise01_UV_11);
  Noise01Sampler_9 = tmpvar_19;
  Noise01Channel_8 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_8 = Noise01Sampler_9.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_8 = Noise01Sampler_9.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_8 = Noise01Sampler_9.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_8 = Noise01Sampler_9.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NoiseTex02, Noise02_UV_10);
  Noise02Sampler_7 = tmpvar_20;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_8 * Noise02Channel_6);
  NoiseTubulence_5 = (NoiseTubulence_5 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_12 = (UV_12 + NoiseTubulence_5);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, UV_12);
  MainTexSampler_4 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MaskTex, tmpvar_23);
  MaskSampler_2 = tmpvar_24;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_22.w * MaskChannel_1);
  color_3.xyz = (tmpvar_22.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  mediump float Noise01Channel_8;
  mediump vec4 Noise01Sampler_9;
  highp vec2 Noise02_UV_10;
  highp vec2 Noise01_UV_11;
  highp vec2 UV_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_12.y = tmpvar_13.y;
  UV_12.x = (tmpvar_13.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_USpeed * _Time.y);
  tmpvar_14.y = (_VSpeed * _Time.y);
  UV_12 = (UV_12 + tmpvar_14);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = _Noise01RandomU;
  tmpvar_15.y = _Noise01RandomV;
  Noise01_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_15 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = _Noise02RandomU;
  tmpvar_16.y = _Noise02RandomV;
  Noise02_UV_10 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_16 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_17;
  tmpvar_17.x = (_Noise01USpeed * _Time.y);
  tmpvar_17.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_11 = (Noise01_UV_11 + tmpvar_17);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (_Noise02USpeed * _Time.y);
  tmpvar_18.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_10 = (Noise02_UV_10 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_NoiseTex01, Noise01_UV_11);
  Noise01Sampler_9 = tmpvar_19;
  Noise01Channel_8 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_8 = Noise01Sampler_9.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_8 = Noise01Sampler_9.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_8 = Noise01Sampler_9.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_8 = Noise01Sampler_9.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NoiseTex02, Noise02_UV_10);
  Noise02Sampler_7 = tmpvar_20;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_8 * Noise02Channel_6);
  NoiseTubulence_5 = (NoiseTubulence_5 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_12 = (UV_12 + NoiseTubulence_5);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, UV_12);
  MainTexSampler_4 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MaskTex, tmpvar_23);
  MaskSampler_2 = tmpvar_24;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_22.w * MaskChannel_1);
  color_3.xyz = (tmpvar_22.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  mediump float Noise01Channel_8;
  mediump vec4 Noise01Sampler_9;
  highp vec2 Noise02_UV_10;
  highp vec2 Noise01_UV_11;
  highp vec2 UV_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_12.y = tmpvar_13.y;
  UV_12.x = (tmpvar_13.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_USpeed * _Time.y);
  tmpvar_14.y = (_VSpeed * _Time.y);
  UV_12 = (UV_12 + tmpvar_14);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = _Noise01RandomU;
  tmpvar_15.y = _Noise01RandomV;
  Noise01_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_15 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = _Noise02RandomU;
  tmpvar_16.y = _Noise02RandomV;
  Noise02_UV_10 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_16 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_17;
  tmpvar_17.x = (_Noise01USpeed * _Time.y);
  tmpvar_17.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_11 = (Noise01_UV_11 + tmpvar_17);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (_Noise02USpeed * _Time.y);
  tmpvar_18.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_10 = (Noise02_UV_10 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_NoiseTex01, Noise01_UV_11);
  Noise01Sampler_9 = tmpvar_19;
  Noise01Channel_8 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_8 = Noise01Sampler_9.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_8 = Noise01Sampler_9.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_8 = Noise01Sampler_9.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_8 = Noise01Sampler_9.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NoiseTex02, Noise02_UV_10);
  Noise02Sampler_7 = tmpvar_20;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_8 * Noise02Channel_6);
  NoiseTubulence_5 = (NoiseTubulence_5 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_12 = (UV_12 + NoiseTubulence_5);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, UV_12);
  MainTexSampler_4 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MaskTex, tmpvar_23);
  MaskSampler_2 = tmpvar_24;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_22.w * MaskChannel_1);
  color_3.xyz = (tmpvar_22.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  mediump float Noise01Channel_8;
  mediump vec4 Noise01Sampler_9;
  highp vec2 Noise02_UV_10;
  highp vec2 Noise01_UV_11;
  highp vec2 UV_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_12.y = tmpvar_13.y;
  UV_12.x = (tmpvar_13.x + xlv_TEXCOORD0.z);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_USpeed * _Time.y);
  tmpvar_14.y = (_VSpeed * _Time.y);
  UV_12 = (UV_12 + tmpvar_14);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = _Noise01RandomU;
  tmpvar_15.y = _Noise01RandomV;
  Noise01_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_15 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = _Noise02RandomU;
  tmpvar_16.y = _Noise02RandomV;
  Noise02_UV_10 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_16 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_17;
  tmpvar_17.x = (_Noise01USpeed * _Time.y);
  tmpvar_17.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_11 = (Noise01_UV_11 + tmpvar_17);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (_Noise02USpeed * _Time.y);
  tmpvar_18.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_10 = (Noise02_UV_10 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_NoiseTex01, Noise01_UV_11);
  Noise01Sampler_9 = tmpvar_19;
  Noise01Channel_8 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_8 = Noise01Sampler_9.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_8 = Noise01Sampler_9.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_8 = Noise01Sampler_9.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_8 = Noise01Sampler_9.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NoiseTex02, Noise02_UV_10);
  Noise02Sampler_7 = tmpvar_20;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_8 * Noise02Channel_6);
  NoiseTubulence_5 = (NoiseTubulence_5 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_12 = (UV_12 + NoiseTubulence_5);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, UV_12);
  MainTexSampler_4 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MaskTex, tmpvar_23);
  MaskSampler_2 = tmpvar_24;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_22.w * MaskChannel_1);
  color_3.xyz = (tmpvar_22.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  mediump float Noise01Channel_8;
  mediump vec4 Noise01Sampler_9;
  highp vec2 Noise02_UV_10;
  highp vec2 Noise01_UV_11;
  highp vec2 UV_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_12.x = (tmpvar_13.x + xlv_TEXCOORD0.z);
  UV_12.y = (tmpvar_13.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_USpeed * _Time.y);
  tmpvar_14.y = (_VSpeed * _Time.y);
  UV_12 = (UV_12 + tmpvar_14);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = _Noise01RandomU;
  tmpvar_15.y = _Noise01RandomV;
  Noise01_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_15 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = _Noise02RandomU;
  tmpvar_16.y = _Noise02RandomV;
  Noise02_UV_10 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_16 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_17;
  tmpvar_17.x = (_Noise01USpeed * _Time.y);
  tmpvar_17.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_11 = (Noise01_UV_11 + tmpvar_17);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (_Noise02USpeed * _Time.y);
  tmpvar_18.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_10 = (Noise02_UV_10 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_NoiseTex01, Noise01_UV_11);
  Noise01Sampler_9 = tmpvar_19;
  Noise01Channel_8 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_8 = Noise01Sampler_9.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_8 = Noise01Sampler_9.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_8 = Noise01Sampler_9.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_8 = Noise01Sampler_9.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NoiseTex02, Noise02_UV_10);
  Noise02Sampler_7 = tmpvar_20;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_8 * Noise02Channel_6);
  NoiseTubulence_5 = (NoiseTubulence_5 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_12 = (UV_12 + NoiseTubulence_5);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, UV_12);
  MainTexSampler_4 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MaskTex, tmpvar_23);
  MaskSampler_2 = tmpvar_24;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_22.w * MaskChannel_1);
  color_3.xyz = (tmpvar_22.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  mediump float Noise01Channel_8;
  mediump vec4 Noise01Sampler_9;
  highp vec2 Noise02_UV_10;
  highp vec2 Noise01_UV_11;
  highp vec2 UV_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_12.x = (tmpvar_13.x + xlv_TEXCOORD0.z);
  UV_12.y = (tmpvar_13.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_USpeed * _Time.y);
  tmpvar_14.y = (_VSpeed * _Time.y);
  UV_12 = (UV_12 + tmpvar_14);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = _Noise01RandomU;
  tmpvar_15.y = _Noise01RandomV;
  Noise01_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_15 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = _Noise02RandomU;
  tmpvar_16.y = _Noise02RandomV;
  Noise02_UV_10 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_16 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_17;
  tmpvar_17.x = (_Noise01USpeed * _Time.y);
  tmpvar_17.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_11 = (Noise01_UV_11 + tmpvar_17);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (_Noise02USpeed * _Time.y);
  tmpvar_18.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_10 = (Noise02_UV_10 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_NoiseTex01, Noise01_UV_11);
  Noise01Sampler_9 = tmpvar_19;
  Noise01Channel_8 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_8 = Noise01Sampler_9.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_8 = Noise01Sampler_9.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_8 = Noise01Sampler_9.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_8 = Noise01Sampler_9.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NoiseTex02, Noise02_UV_10);
  Noise02Sampler_7 = tmpvar_20;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_8 * Noise02Channel_6);
  NoiseTubulence_5 = (NoiseTubulence_5 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_12 = (UV_12 + NoiseTubulence_5);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, UV_12);
  MainTexSampler_4 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MaskTex, tmpvar_23);
  MaskSampler_2 = tmpvar_24;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_22.w * MaskChannel_1);
  color_3.xyz = (tmpvar_22.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
  gl_FragData[0] = color_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _Noise01RandomU;
uniform mediump float _Noise01RandomV;
uniform mediump float _Noise02RandomU;
uniform mediump float _Noise02RandomV;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _Noise01ChannelMapping;
uniform highp float _Noise01USpeed;
uniform highp float _Noise01VSpeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02ChannelMapping;
uniform highp float _Noise02USpeed;
uniform highp float _Noise02VSpeed;
uniform highp float _NoiseOffset;
uniform highp float _NoiseBrightness;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _MaskChannelMapping;
uniform highp float _EmissionScaler;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float MaskChannel_1;
  mediump vec4 MaskSampler_2;
  mediump vec4 color_3;
  mediump vec4 MainTexSampler_4;
  mediump float NoiseTubulence_5;
  mediump float Noise02Channel_6;
  mediump vec4 Noise02Sampler_7;
  mediump float Noise01Channel_8;
  mediump vec4 Noise01Sampler_9;
  highp vec2 Noise02_UV_10;
  highp vec2 Noise01_UV_11;
  highp vec2 UV_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_12.x = (tmpvar_13.x + xlv_TEXCOORD0.z);
  UV_12.y = (tmpvar_13.y + xlv_TEXCOORD0.w);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (_USpeed * _Time.y);
  tmpvar_14.y = (_VSpeed * _Time.y);
  UV_12 = (UV_12 + tmpvar_14);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = _Noise01RandomU;
  tmpvar_15.y = _Noise01RandomV;
  Noise01_UV_11 = (((xlv_TEXCOORD0.xy * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw) + (tmpvar_15 * xlv_TEXCOORD1.xy));
  mediump vec2 tmpvar_16;
  tmpvar_16.x = _Noise02RandomU;
  tmpvar_16.y = _Noise02RandomV;
  Noise02_UV_10 = (((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw) + (tmpvar_16 * xlv_TEXCOORD1.zw));
  highp vec2 tmpvar_17;
  tmpvar_17.x = (_Noise01USpeed * _Time.y);
  tmpvar_17.y = (_Noise01VSpeed * _Time.y);
  Noise01_UV_11 = (Noise01_UV_11 + tmpvar_17);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (_Noise02USpeed * _Time.y);
  tmpvar_18.y = (_Noise02VSpeed * _Time.y);
  Noise02_UV_10 = (Noise02_UV_10 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_NoiseTex01, Noise01_UV_11);
  Noise01Sampler_9 = tmpvar_19;
  Noise01Channel_8 = 0.0;
  if ((_Noise01ChannelMapping == 0.0)) {
    Noise01Channel_8 = Noise01Sampler_9.x;
  } else {
    if ((_Noise01ChannelMapping == 1.0)) {
      Noise01Channel_8 = Noise01Sampler_9.y;
    } else {
      if ((_Noise01ChannelMapping == 2.0)) {
        Noise01Channel_8 = Noise01Sampler_9.z;
      } else {
        if ((_Noise01ChannelMapping == 3.0)) {
          Noise01Channel_8 = Noise01Sampler_9.w;
        };
      };
    };
  };
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NoiseTex02, Noise02_UV_10);
  Noise02Sampler_7 = tmpvar_20;
  Noise02Channel_6 = 0.0;
  if ((_Noise02ChannelMapping == 0.0)) {
    Noise02Channel_6 = Noise02Sampler_7.x;
  } else {
    if ((_Noise02ChannelMapping == 1.0)) {
      Noise02Channel_6 = Noise02Sampler_7.y;
    } else {
      if ((_Noise02ChannelMapping == 2.0)) {
        Noise02Channel_6 = Noise02Sampler_7.z;
      } else {
        if ((_Noise02ChannelMapping == 3.0)) {
          Noise02Channel_6 = Noise02Sampler_7.w;
        };
      };
    };
  };
  NoiseTubulence_5 = (Noise01Channel_8 * Noise02Channel_6);
  NoiseTubulence_5 = (NoiseTubulence_5 + _NoiseOffset);
  NoiseTubulence_5 = (NoiseTubulence_5 * _NoiseBrightness);
  UV_12 = (UV_12 + NoiseTubulence_5);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, UV_12);
  MainTexSampler_4 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (MainTexSampler_4 * xlv_COLOR);
  color_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MaskTex, tmpvar_23);
  MaskSampler_2 = tmpvar_24;
  MaskChannel_1 = 0.0;
  if ((_MaskChannelMapping == 0.0)) {
    MaskChannel_1 = MaskSampler_2.x;
  } else {
    if ((_MaskChannelMapping == 1.0)) {
      MaskChannel_1 = MaskSampler_2.y;
    } else {
      if ((_MaskChannelMapping == 2.0)) {
        MaskChannel_1 = MaskSampler_2.z;
      } else {
        if ((_MaskChannelMapping == 3.0)) {
          MaskChannel_1 = MaskSampler_2.w;
        };
      };
    };
  };
  color_3.w = (tmpvar_22.w * MaskChannel_1);
  color_3.xyz = (tmpvar_22.xyz * _EmissionScaler);
  color_3.xyz = mix (vec3(1.0, 1.0, 1.0), color_3.xyz, color_3.www);
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
SubProgram "gles hw_tier00 " {
Keywords { "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USEMASKTEX_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USEMASKTEX_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USEMASKTEX_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USENOISETEX01_ON" "_USENOISETEX02_ON" "_USEMASKTEX_ON" "_RANDOMU_ON" "_RANDOMV_ON" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}