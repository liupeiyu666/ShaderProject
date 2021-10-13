//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/InstancedShader" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_BaseColor ("Base Color", Color) = (1,1,1,1)
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
_BlinSpeed ("BlinSpeed", Float) = 7
_Extent ("Extent", Float) = 0.8
_Frequency ("Frequency", Float) = 1.5
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  GpuProgramID 55594
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Extent;
uniform mediump float _Frequency;
uniform highp vec4 _Color;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 posWorld_1;
  mediump float ttt_2;
  mediump vec3 tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = ((sin(
    (_Time.y * _Frequency)
  ) * _Color.x) * _Extent);
  ttt_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posWorld_1.yw = tmpvar_5.yw;
  posWorld_1.xz = (tmpvar_5.xz + vec2(ttt_2));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  tmpvar_3 = tmpvar_7;
  gl_Position = (unity_MatrixVP * posWorld_1);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (tmpvar_5.xyz / tmpvar_5.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump float _BlinSpeed;
uniform highp vec4 _Color;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float blin_2;
  mediump float f_3;
  mediump vec3 V_4;
  mediump vec4 outColor_5;
  outColor_5.w = _BaseColor.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_4 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = clamp ((1.0 - dot (V_4, 
    normalize(xlv_TEXCOORD1)
  )), 0.0, 1.0);
  highp float tmpvar_8;
  tmpvar_8 = (_RGBias + (pow (tmpvar_7, _RGShininess) * _RGScale));
  f_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (f_3 * _RGColor).xyz;
  mediump float tmpvar_10;
  tmpvar_10 = clamp (f_3, 0.0, 1.0);
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (_BaseColor.xyz, tmpvar_9, vec3((tmpvar_10 * _RGRatio)));
  outColor_5.xyz = (_BaseColor.xyz + tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = (((
    abs(sin((_Time.y * _BlinSpeed)))
   * 0.3) + 0.2) * _Color.y);
  blin_2 = tmpvar_12;
  outColor_5.xyz = (outColor_5.xyz * (blin_2 + 1.0));
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = outColor_5.xyz;
  tmpvar_13.w = _RGBloomFactor;
  tmpvar_1 = tmpvar_13;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Extent;
uniform mediump float _Frequency;
uniform highp vec4 _Color;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 posWorld_1;
  mediump float ttt_2;
  mediump vec3 tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = ((sin(
    (_Time.y * _Frequency)
  ) * _Color.x) * _Extent);
  ttt_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posWorld_1.yw = tmpvar_5.yw;
  posWorld_1.xz = (tmpvar_5.xz + vec2(ttt_2));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  tmpvar_3 = tmpvar_7;
  gl_Position = (unity_MatrixVP * posWorld_1);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (tmpvar_5.xyz / tmpvar_5.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump float _BlinSpeed;
uniform highp vec4 _Color;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float blin_2;
  mediump float f_3;
  mediump vec3 V_4;
  mediump vec4 outColor_5;
  outColor_5.w = _BaseColor.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_4 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = clamp ((1.0 - dot (V_4, 
    normalize(xlv_TEXCOORD1)
  )), 0.0, 1.0);
  highp float tmpvar_8;
  tmpvar_8 = (_RGBias + (pow (tmpvar_7, _RGShininess) * _RGScale));
  f_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (f_3 * _RGColor).xyz;
  mediump float tmpvar_10;
  tmpvar_10 = clamp (f_3, 0.0, 1.0);
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (_BaseColor.xyz, tmpvar_9, vec3((tmpvar_10 * _RGRatio)));
  outColor_5.xyz = (_BaseColor.xyz + tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = (((
    abs(sin((_Time.y * _BlinSpeed)))
   * 0.3) + 0.2) * _Color.y);
  blin_2 = tmpvar_12;
  outColor_5.xyz = (outColor_5.xyz * (blin_2 + 1.0));
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = outColor_5.xyz;
  tmpvar_13.w = _RGBloomFactor;
  tmpvar_1 = tmpvar_13;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Extent;
uniform mediump float _Frequency;
uniform highp vec4 _Color;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 posWorld_1;
  mediump float ttt_2;
  mediump vec3 tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = ((sin(
    (_Time.y * _Frequency)
  ) * _Color.x) * _Extent);
  ttt_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  posWorld_1.yw = tmpvar_5.yw;
  posWorld_1.xz = (tmpvar_5.xz + vec2(ttt_2));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  tmpvar_3 = tmpvar_7;
  gl_Position = (unity_MatrixVP * posWorld_1);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (tmpvar_5.xyz / tmpvar_5.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump float _BlinSpeed;
uniform highp vec4 _Color;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump float blin_2;
  mediump float f_3;
  mediump vec3 V_4;
  mediump vec4 outColor_5;
  outColor_5.w = _BaseColor.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_4 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = clamp ((1.0 - dot (V_4, 
    normalize(xlv_TEXCOORD1)
  )), 0.0, 1.0);
  highp float tmpvar_8;
  tmpvar_8 = (_RGBias + (pow (tmpvar_7, _RGShininess) * _RGScale));
  f_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (f_3 * _RGColor).xyz;
  mediump float tmpvar_10;
  tmpvar_10 = clamp (f_3, 0.0, 1.0);
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (_BaseColor.xyz, tmpvar_9, vec3((tmpvar_10 * _RGRatio)));
  outColor_5.xyz = (_BaseColor.xyz + tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = (((
    abs(sin((_Time.y * _BlinSpeed)))
   * 0.3) + 0.2) * _Color.y);
  blin_2 = tmpvar_12;
  outColor_5.xyz = (outColor_5.xyz * (blin_2 + 1.0));
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = outColor_5.xyz;
  tmpvar_13.w = _RGBloomFactor;
  tmpvar_1 = tmpvar_13;
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
Fallback "Diffuse"
}