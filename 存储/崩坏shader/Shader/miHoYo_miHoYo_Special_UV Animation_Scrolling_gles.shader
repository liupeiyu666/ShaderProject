//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/UV Animation/Scrolling" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_ScrollU ("Scroll U", Float) = 1
_ScrollV ("Scroll V", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 3357
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = _ScrollU;
  tmpvar_6.y = _ScrollV;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_6));
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 * _Color) * tmpvar_2);
  c_5 = tmpvar_9;
  tmpvar_3 = c_5.xyz;
  tmpvar_4 = c_5.w;
  lowp vec4 c_10;
  lowp vec4 c_11;
  c_11.xyz = vec3(0.0, 0.0, 0.0);
  c_11.w = tmpvar_4;
  c_10.w = c_11.w;
  c_10.xyz = c_11.xyz;
  c_1.w = c_10.w;
  c_1.xyz = tmpvar_3;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = _ScrollU;
  tmpvar_6.y = _ScrollV;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_6));
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 * _Color) * tmpvar_2);
  c_5 = tmpvar_9;
  tmpvar_3 = c_5.xyz;
  tmpvar_4 = c_5.w;
  lowp vec4 c_10;
  lowp vec4 c_11;
  c_11.xyz = vec3(0.0, 0.0, 0.0);
  c_11.w = tmpvar_4;
  c_10.w = c_11.w;
  c_10.xyz = c_11.xyz;
  c_1.w = c_10.w;
  c_1.xyz = tmpvar_3;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = _ScrollU;
  tmpvar_6.y = _ScrollV;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_6));
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 * _Color) * tmpvar_2);
  c_5 = tmpvar_9;
  tmpvar_3 = c_5.xyz;
  tmpvar_4 = c_5.w;
  lowp vec4 c_10;
  lowp vec4 c_11;
  c_11.xyz = vec3(0.0, 0.0, 0.0);
  c_11.w = tmpvar_4;
  c_10.w = c_11.w;
  c_10.xyz = c_11.xyz;
  c_1.w = c_10.w;
  c_1.xyz = tmpvar_3;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  mediump vec3 normal_4;
  normal_4 = tmpvar_3;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = normal_4;
  mediump vec3 res_6;
  mediump vec3 x_7;
  x_7.x = dot (unity_SHAr, tmpvar_5);
  x_7.y = dot (unity_SHAg, tmpvar_5);
  x_7.z = dot (unity_SHAb, tmpvar_5);
  mediump vec3 x1_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = (normal_4.xyzz * normal_4.yzzx);
  x1_8.x = dot (unity_SHBr, tmpvar_9);
  x1_8.y = dot (unity_SHBg, tmpvar_9);
  x1_8.z = dot (unity_SHBb, tmpvar_9);
  res_6 = (x_7 + (x1_8 + (unity_SHC.xyz * 
    ((normal_4.x * normal_4.x) - (normal_4.y * normal_4.y))
  )));
  mediump vec3 tmpvar_10;
  tmpvar_10 = max (((1.055 * 
    pow (max (res_6, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_6 = tmpvar_10;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_10);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = _ScrollU;
  tmpvar_6.y = _ScrollV;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_6));
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 * _Color) * tmpvar_2);
  c_5 = tmpvar_9;
  tmpvar_3 = c_5.xyz;
  tmpvar_4 = c_5.w;
  lowp vec4 c_10;
  lowp vec4 c_11;
  c_11.xyz = vec3(0.0, 0.0, 0.0);
  c_11.w = tmpvar_4;
  c_10.w = c_11.w;
  c_10.xyz = c_11.xyz;
  c_1.w = c_10.w;
  c_1.xyz = tmpvar_3;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  mediump vec3 normal_4;
  normal_4 = tmpvar_3;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = normal_4;
  mediump vec3 res_6;
  mediump vec3 x_7;
  x_7.x = dot (unity_SHAr, tmpvar_5);
  x_7.y = dot (unity_SHAg, tmpvar_5);
  x_7.z = dot (unity_SHAb, tmpvar_5);
  mediump vec3 x1_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = (normal_4.xyzz * normal_4.yzzx);
  x1_8.x = dot (unity_SHBr, tmpvar_9);
  x1_8.y = dot (unity_SHBg, tmpvar_9);
  x1_8.z = dot (unity_SHBb, tmpvar_9);
  res_6 = (x_7 + (x1_8 + (unity_SHC.xyz * 
    ((normal_4.x * normal_4.x) - (normal_4.y * normal_4.y))
  )));
  mediump vec3 tmpvar_10;
  tmpvar_10 = max (((1.055 * 
    pow (max (res_6, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_6 = tmpvar_10;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_10);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = _ScrollU;
  tmpvar_6.y = _ScrollV;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_6));
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 * _Color) * tmpvar_2);
  c_5 = tmpvar_9;
  tmpvar_3 = c_5.xyz;
  tmpvar_4 = c_5.w;
  lowp vec4 c_10;
  lowp vec4 c_11;
  c_11.xyz = vec3(0.0, 0.0, 0.0);
  c_11.w = tmpvar_4;
  c_10.w = c_11.w;
  c_10.xyz = c_11.xyz;
  c_1.w = c_10.w;
  c_1.xyz = tmpvar_3;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_glesNormal * tmpvar_2));
  mediump vec3 normal_4;
  normal_4 = tmpvar_3;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = normal_4;
  mediump vec3 res_6;
  mediump vec3 x_7;
  x_7.x = dot (unity_SHAr, tmpvar_5);
  x_7.y = dot (unity_SHAg, tmpvar_5);
  x_7.z = dot (unity_SHAb, tmpvar_5);
  mediump vec3 x1_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = (normal_4.xyzz * normal_4.yzzx);
  x1_8.x = dot (unity_SHBr, tmpvar_9);
  x1_8.y = dot (unity_SHBg, tmpvar_9);
  x1_8.z = dot (unity_SHBb, tmpvar_9);
  res_6 = (x_7 + (x1_8 + (unity_SHC.xyz * 
    ((normal_4.x * normal_4.x) - (normal_4.y * normal_4.y))
  )));
  mediump vec3 tmpvar_10;
  tmpvar_10 = max (((1.055 * 
    pow (max (res_6, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_6 = tmpvar_10;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_10);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = _ScrollU;
  tmpvar_6.y = _ScrollV;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_6));
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 * _Color) * tmpvar_2);
  c_5 = tmpvar_9;
  tmpvar_3 = c_5.xyz;
  tmpvar_4 = c_5.w;
  lowp vec4 c_10;
  lowp vec4 c_11;
  c_11.xyz = vec3(0.0, 0.0, 0.0);
  c_11.w = tmpvar_4;
  c_10.w = c_11.w;
  c_10.xyz = c_11.xyz;
  c_1.w = c_10.w;
  c_1.xyz = tmpvar_3;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  highp vec3 lightColor0_6;
  lightColor0_6 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_7;
  lightColor1_7 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_8;
  lightColor2_8 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_9;
  lightColor3_9 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_10;
  lightAttenSq_10 = unity_4LightAtten0;
  highp vec3 col_11;
  highp vec4 ndotl_12;
  highp vec4 lengthSq_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - tmpvar_3.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - tmpvar_3.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - tmpvar_3.z);
  lengthSq_13 = (tmpvar_14 * tmpvar_14);
  lengthSq_13 = (lengthSq_13 + (tmpvar_15 * tmpvar_15));
  lengthSq_13 = (lengthSq_13 + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_17;
  tmpvar_17 = max (lengthSq_13, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_13 = tmpvar_17;
  ndotl_12 = (tmpvar_14 * tmpvar_5.x);
  ndotl_12 = (ndotl_12 + (tmpvar_15 * tmpvar_5.y));
  ndotl_12 = (ndotl_12 + (tmpvar_16 * tmpvar_5.z));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_12 * inversesqrt(tmpvar_17)));
  ndotl_12 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * (1.0/((1.0 + 
    (tmpvar_17 * lightAttenSq_10)
  ))));
  col_11 = (lightColor0_6 * tmpvar_19.x);
  col_11 = (col_11 + (lightColor1_7 * tmpvar_19.y));
  col_11 = (col_11 + (lightColor2_8 * tmpvar_19.z));
  col_11 = (col_11 + (lightColor3_9 * tmpvar_19.w));
  tmpvar_1 = col_11;
  mediump vec3 normal_20;
  normal_20 = tmpvar_5;
  mediump vec3 ambient_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = normal_20;
  mediump vec3 res_23;
  mediump vec3 x_24;
  x_24.x = dot (unity_SHAr, tmpvar_22);
  x_24.y = dot (unity_SHAg, tmpvar_22);
  x_24.z = dot (unity_SHAb, tmpvar_22);
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_20.xyzz * normal_20.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
    ((normal_20.x * normal_20.x) - (normal_20.y * normal_20.y))
  )));
  mediump vec3 tmpvar_27;
  tmpvar_27 = max (((1.055 * 
    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_23 = tmpvar_27;
  ambient_21 = (tmpvar_1 + max (vec3(0.0, 0.0, 0.0), tmpvar_27));
  tmpvar_1 = ambient_21;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ambient_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = _ScrollU;
  tmpvar_6.y = _ScrollV;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_6));
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 * _Color) * tmpvar_2);
  c_5 = tmpvar_9;
  tmpvar_3 = c_5.xyz;
  tmpvar_4 = c_5.w;
  lowp vec4 c_10;
  lowp vec4 c_11;
  c_11.xyz = vec3(0.0, 0.0, 0.0);
  c_11.w = tmpvar_4;
  c_10.w = c_11.w;
  c_10.xyz = c_11.xyz;
  c_1.w = c_10.w;
  c_1.xyz = tmpvar_3;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  highp vec3 lightColor0_6;
  lightColor0_6 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_7;
  lightColor1_7 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_8;
  lightColor2_8 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_9;
  lightColor3_9 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_10;
  lightAttenSq_10 = unity_4LightAtten0;
  highp vec3 col_11;
  highp vec4 ndotl_12;
  highp vec4 lengthSq_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - tmpvar_3.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - tmpvar_3.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - tmpvar_3.z);
  lengthSq_13 = (tmpvar_14 * tmpvar_14);
  lengthSq_13 = (lengthSq_13 + (tmpvar_15 * tmpvar_15));
  lengthSq_13 = (lengthSq_13 + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_17;
  tmpvar_17 = max (lengthSq_13, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_13 = tmpvar_17;
  ndotl_12 = (tmpvar_14 * tmpvar_5.x);
  ndotl_12 = (ndotl_12 + (tmpvar_15 * tmpvar_5.y));
  ndotl_12 = (ndotl_12 + (tmpvar_16 * tmpvar_5.z));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_12 * inversesqrt(tmpvar_17)));
  ndotl_12 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * (1.0/((1.0 + 
    (tmpvar_17 * lightAttenSq_10)
  ))));
  col_11 = (lightColor0_6 * tmpvar_19.x);
  col_11 = (col_11 + (lightColor1_7 * tmpvar_19.y));
  col_11 = (col_11 + (lightColor2_8 * tmpvar_19.z));
  col_11 = (col_11 + (lightColor3_9 * tmpvar_19.w));
  tmpvar_1 = col_11;
  mediump vec3 normal_20;
  normal_20 = tmpvar_5;
  mediump vec3 ambient_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = normal_20;
  mediump vec3 res_23;
  mediump vec3 x_24;
  x_24.x = dot (unity_SHAr, tmpvar_22);
  x_24.y = dot (unity_SHAg, tmpvar_22);
  x_24.z = dot (unity_SHAb, tmpvar_22);
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_20.xyzz * normal_20.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
    ((normal_20.x * normal_20.x) - (normal_20.y * normal_20.y))
  )));
  mediump vec3 tmpvar_27;
  tmpvar_27 = max (((1.055 * 
    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_23 = tmpvar_27;
  ambient_21 = (tmpvar_1 + max (vec3(0.0, 0.0, 0.0), tmpvar_27));
  tmpvar_1 = ambient_21;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ambient_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = _ScrollU;
  tmpvar_6.y = _ScrollV;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_6));
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 * _Color) * tmpvar_2);
  c_5 = tmpvar_9;
  tmpvar_3 = c_5.xyz;
  tmpvar_4 = c_5.w;
  lowp vec4 c_10;
  lowp vec4 c_11;
  c_11.xyz = vec3(0.0, 0.0, 0.0);
  c_11.w = tmpvar_4;
  c_10.w = c_11.w;
  c_10.xyz = c_11.xyz;
  c_1.w = c_10.w;
  c_1.xyz = tmpvar_3;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  highp vec3 lightColor0_6;
  lightColor0_6 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_7;
  lightColor1_7 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_8;
  lightColor2_8 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_9;
  lightColor3_9 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_10;
  lightAttenSq_10 = unity_4LightAtten0;
  highp vec3 col_11;
  highp vec4 ndotl_12;
  highp vec4 lengthSq_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - tmpvar_3.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - tmpvar_3.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - tmpvar_3.z);
  lengthSq_13 = (tmpvar_14 * tmpvar_14);
  lengthSq_13 = (lengthSq_13 + (tmpvar_15 * tmpvar_15));
  lengthSq_13 = (lengthSq_13 + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_17;
  tmpvar_17 = max (lengthSq_13, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_13 = tmpvar_17;
  ndotl_12 = (tmpvar_14 * tmpvar_5.x);
  ndotl_12 = (ndotl_12 + (tmpvar_15 * tmpvar_5.y));
  ndotl_12 = (ndotl_12 + (tmpvar_16 * tmpvar_5.z));
  highp vec4 tmpvar_18;
  tmpvar_18 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_12 * inversesqrt(tmpvar_17)));
  ndotl_12 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * (1.0/((1.0 + 
    (tmpvar_17 * lightAttenSq_10)
  ))));
  col_11 = (lightColor0_6 * tmpvar_19.x);
  col_11 = (col_11 + (lightColor1_7 * tmpvar_19.y));
  col_11 = (col_11 + (lightColor2_8 * tmpvar_19.z));
  col_11 = (col_11 + (lightColor3_9 * tmpvar_19.w));
  tmpvar_1 = col_11;
  mediump vec3 normal_20;
  normal_20 = tmpvar_5;
  mediump vec3 ambient_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = normal_20;
  mediump vec3 res_23;
  mediump vec3 x_24;
  x_24.x = dot (unity_SHAr, tmpvar_22);
  x_24.y = dot (unity_SHAg, tmpvar_22);
  x_24.z = dot (unity_SHAb, tmpvar_22);
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_20.xyzz * normal_20.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
    ((normal_20.x * normal_20.x) - (normal_20.y * normal_20.y))
  )));
  mediump vec3 tmpvar_27;
  tmpvar_27 = max (((1.055 * 
    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_23 = tmpvar_27;
  ambient_21 = (tmpvar_1 + max (vec3(0.0, 0.0, 0.0), tmpvar_27));
  tmpvar_1 = ambient_21;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ambient_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 c_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = _ScrollU;
  tmpvar_6.y = _ScrollV;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_6));
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 * _Color) * tmpvar_2);
  c_5 = tmpvar_9;
  tmpvar_3 = c_5.xyz;
  tmpvar_4 = c_5.w;
  lowp vec4 c_10;
  lowp vec4 c_11;
  c_11.xyz = vec3(0.0, 0.0, 0.0);
  c_11.w = tmpvar_4;
  c_10.w = c_11.w;
  c_10.xyz = c_11.xyz;
  c_1.w = c_10.w;
  c_1.xyz = tmpvar_3;
  gl_FragData[0] = c_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
}
}
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 81732
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _ScrollU;
  tmpvar_4.y = _ScrollV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_4));
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_5 * _Color) * tmpvar_1);
  c_3 = tmpvar_7;
  tmpvar_2 = c_3.w;
  lowp vec4 c_8;
  lowp vec4 c_9;
  c_9.xyz = vec3(0.0, 0.0, 0.0);
  c_9.w = tmpvar_2;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
}
}
 Pass {
  Name "META"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "META" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 183949
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 vertex_2;
  vertex_2 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_2.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_3;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_2.z = tmpvar_3;
  };
  if (unity_MetaVertexControl.y) {
    vertex_2.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_4;
    if ((vertex_2.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_2.z = tmpvar_4;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = vertex_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  mediump vec4 c_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = _ScrollU;
  tmpvar_6.y = _ScrollV;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_6));
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 * _Color) * tmpvar_3);
  c_5 = tmpvar_9;
  tmpvar_4 = c_5.xyz;
  tmpvar_2 = tmpvar_4;
  mediump vec4 res_10;
  res_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    res_10.w = 1.0;
    highp vec3 tmpvar_11;
    tmpvar_11 = clamp (pow (vec3(0.0, 0.0, 0.0), vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_10.xyz = tmpvar_11;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_12;
    if (bool(unity_UseLinearSpace)) {
      emission_12 = tmpvar_2;
    } else {
      emission_12 = (tmpvar_2 * ((tmpvar_2 * 
        ((tmpvar_2 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 1.0;
    tmpvar_13.xyz = emission_12;
    res_10 = tmpvar_13;
  };
  tmpvar_1 = res_10;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 vertex_2;
  vertex_2 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_2.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_3;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_2.z = tmpvar_3;
  };
  if (unity_MetaVertexControl.y) {
    vertex_2.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_4;
    if ((vertex_2.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_2.z = tmpvar_4;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = vertex_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  mediump vec4 c_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = _ScrollU;
  tmpvar_6.y = _ScrollV;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_6));
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 * _Color) * tmpvar_3);
  c_5 = tmpvar_9;
  tmpvar_4 = c_5.xyz;
  tmpvar_2 = tmpvar_4;
  mediump vec4 res_10;
  res_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    res_10.w = 1.0;
    highp vec3 tmpvar_11;
    tmpvar_11 = clamp (pow (vec3(0.0, 0.0, 0.0), vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_10.xyz = tmpvar_11;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_12;
    if (bool(unity_UseLinearSpace)) {
      emission_12 = tmpvar_2;
    } else {
      emission_12 = (tmpvar_2 * ((tmpvar_2 * 
        ((tmpvar_2 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 1.0;
    tmpvar_13.xyz = emission_12;
    res_10 = tmpvar_13;
  };
  tmpvar_1 = res_10;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 vertex_2;
  vertex_2 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_2.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_3;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_2.z = tmpvar_3;
  };
  if (unity_MetaVertexControl.y) {
    vertex_2.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_4;
    if ((vertex_2.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_2.z = tmpvar_4;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = vertex_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform highp float _ScrollU;
uniform highp float _ScrollV;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  mediump vec4 c_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = _ScrollU;
  tmpvar_6.y = _ScrollV;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + (_Time.xy * tmpvar_6));
  tmpvar_7 = texture2D (_MainTex, P_8);
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_7 * _Color) * tmpvar_3);
  c_5 = tmpvar_9;
  tmpvar_4 = c_5.xyz;
  tmpvar_2 = tmpvar_4;
  mediump vec4 res_10;
  res_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    res_10.w = 1.0;
    highp vec3 tmpvar_11;
    tmpvar_11 = clamp (pow (vec3(0.0, 0.0, 0.0), vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_10.xyz = tmpvar_11;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_12;
    if (bool(unity_UseLinearSpace)) {
      emission_12 = tmpvar_2;
    } else {
      emission_12 = (tmpvar_2 * ((tmpvar_2 * 
        ((tmpvar_2 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 1.0;
    tmpvar_13.xyz = emission_12;
    res_10 = tmpvar_13;
  };
  tmpvar_1 = res_10;
  gl_FragData[0] = tmpvar_1;
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