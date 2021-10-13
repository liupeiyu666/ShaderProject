//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Billboard/Light Beam" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_MainTex_Alpha ("Particle Texture Alpha", 2D) = "white" { }
_DustTex ("Second Texture", 2D) = "black" { }
_DustTex_Alpha ("Second Texture Alpha", 2D) = "white" { }
_DustIntensity ("Dust Intensity", Float) = 1
_DustSpeed ("Dust Speed", Float) = 0
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 41027
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _DustTex;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_DustTex, xlv_TEXCOORD1);
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).x;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).y;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform sampler2D _DustTex;
uniform sampler2D _DustTex_Alpha;
uniform mediump float _DustIntensity;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.w = tmpvar_3.w;
  color_1.xyz = (tmpvar_3.xyz * _EmissionScaler);
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_DustTex, xlv_TEXCOORD1).xyz;
  tmpvar_4.w = texture2D (_DustTex_Alpha, xlv_TEXCOORD1).z;
  color_1 = (color_1 + ((tmpvar_4 * _DustIntensity) * dot (color_1.xyz, vec3(0.22, 0.707, 0.071))));
  gl_FragData[0] = color_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
}
}
 Pass {
  Name "CONSTANT_MAX"
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 96132
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
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
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).x;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).y;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DustTex_ST;
uniform highp float _DustSpeed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 newZ_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  newZ_2.xz = -((unity_WorldToObject * tmpvar_3).xyz).xz;
  newZ_2.y = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(newZ_2);
  newZ_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((_glesVertex.x * -(tmpvar_4.z)) + (_glesVertex.z * tmpvar_4.x));
  tmpvar_5.y = _glesVertex.y;
  tmpvar_5.z = ((_glesVertex.x * tmpvar_4.x) + (_glesVertex.z * tmpvar_4.z));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _DustTex_ST.xy) + _DustTex_ST.zw);
  tmpvar_1.y = (tmpvar_1.y + fract((_Time.x * _DustSpeed)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MainTex_Alpha;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  tmpvar_2.w = texture2D (_MainTex_Alpha, xlv_TEXCOORD0).z;
  lowp float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
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
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ShaderEditorBase"
}