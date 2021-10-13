//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/Effect_After_Image" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
[Toggle(RIM_GLOW)] _RimGlow ("Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent" "Reflected" = "Reflected" "RenderType" = "Transparent" }
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Transparent" "Reflected" = "Reflected" "RenderType" = "Transparent" }
  GpuProgramID 17662
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
varying mediump vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xyz = _Color.xyz;
  tmpvar_1.w = (_Color.w * _Opaqueness);
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(normalize((_glesNormal * tmpvar_5)));
  tmpvar_2 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4.xyz / tmpvar_4.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
varying mediump vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 rgColor_1;
  mediump vec3 V_2;
  mediump vec4 outColor_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_5;
  mediump float tmpvar_6;
  highp vec3 N_7;
  N_7 = tmpvar_4;
  highp vec3 V_8;
  V_8 = V_2;
  highp float tmpvar_9;
  tmpvar_9 = pow (clamp ((1.001 - 
    dot (V_8, N_7)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_6 = (_RGBias + (tmpvar_9 * _RGScale));
  rgColor_1.xyz = (tmpvar_6 * _RGColor).xyz;
  rgColor_1.w = 1.0;
  mediump float tmpvar_10;
  tmpvar_10 = clamp (tmpvar_6, 0.0, 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (xlv_COLOR0, rgColor_1, vec4((tmpvar_10 * _RGRatio)));
  outColor_3 = tmpvar_11;
  outColor_3.w = clamp (outColor_3.w, 0.0, 1.0);
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
varying mediump vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xyz = _Color.xyz;
  tmpvar_1.w = (_Color.w * _Opaqueness);
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(normalize((_glesNormal * tmpvar_5)));
  tmpvar_2 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4.xyz / tmpvar_4.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
varying mediump vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 rgColor_1;
  mediump vec3 V_2;
  mediump vec4 outColor_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_5;
  mediump float tmpvar_6;
  highp vec3 N_7;
  N_7 = tmpvar_4;
  highp vec3 V_8;
  V_8 = V_2;
  highp float tmpvar_9;
  tmpvar_9 = pow (clamp ((1.001 - 
    dot (V_8, N_7)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_6 = (_RGBias + (tmpvar_9 * _RGScale));
  rgColor_1.xyz = (tmpvar_6 * _RGColor).xyz;
  rgColor_1.w = 1.0;
  mediump float tmpvar_10;
  tmpvar_10 = clamp (tmpvar_6, 0.0, 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (xlv_COLOR0, rgColor_1, vec4((tmpvar_10 * _RGRatio)));
  outColor_3 = tmpvar_11;
  outColor_3.w = clamp (outColor_3.w, 0.0, 1.0);
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
varying mediump vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xyz = _Color.xyz;
  tmpvar_1.w = (_Color.w * _Opaqueness);
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(normalize((_glesNormal * tmpvar_5)));
  tmpvar_2 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4.xyz / tmpvar_4.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
varying mediump vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 rgColor_1;
  mediump vec3 V_2;
  mediump vec4 outColor_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_5;
  mediump float tmpvar_6;
  highp vec3 N_7;
  N_7 = tmpvar_4;
  highp vec3 V_8;
  V_8 = V_2;
  highp float tmpvar_9;
  tmpvar_9 = pow (clamp ((1.001 - 
    dot (V_8, N_7)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_6 = (_RGBias + (tmpvar_9 * _RGScale));
  rgColor_1.xyz = (tmpvar_6 * _RGColor).xyz;
  rgColor_1.w = 1.0;
  mediump float tmpvar_10;
  tmpvar_10 = clamp (tmpvar_6, 0.0, 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (xlv_COLOR0, rgColor_1, vec4((tmpvar_10 * _RGRatio)));
  outColor_3 = tmpvar_11;
  outColor_3.w = clamp (outColor_3.w, 0.0, 1.0);
  gl_FragData[0] = outColor_3;
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
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent" "Reflected" = "Reflected" "RenderType" = "Transparent" }
  GpuProgramID 123438
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
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
}