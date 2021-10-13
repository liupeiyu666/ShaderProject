//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Avatar/Avatar_Star_Clamp" {
Properties {
_Colortop ("Color Top", Color) = (0.02,0.04,0.09,1)
_Colorbottom ("Color Bottom", Color) = (0.27,0.16,0.37,1)
_BottomPos ("Gradient Offset", Range(-2, 2)) = 0
_BottonWidth ("Gradient Width", Range(0, 2)) = 1
_RimColor ("Rim Color", Color) = (0.42,0.46,1,1)
_RimPow ("Rim Width", Float) = 1
_RimPow2 ("Rim Transparent", Float) = 1
_RimSterngth ("Rim Strength", Float) = 1
_TwinkleTex ("Twinkle Tex (RGBA)", 2D) = "black" { }
_StarColor ("Star Color", Color) = (1,1,1,1)
_StarCenter ("Star Center", Vector) = (0,0,0,0)
_StarEmission ("Star Emission", Range(1, 100)) = 1
_SpeedX ("Speed X of Star Move", Range(-0.1, 0)) = -0.03
_SpeedY ("Speed Y of Star Move", Range(-0.1, 0)) = -0.03
_DispearDistance ("Dispear Distance", Range(0, 1)) = 0.7
_Color ("Main Color", Color) = (1,1,1,1)
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_Scale ("Scale Compared to Maya", Float) = 0.01
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_OutlineWidth ("Outline Width", Float) = 0.02
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
[Toggle(SIDERIM)] _SideRim ("SideRim", Float) = 0
_RimLightDir ("Rim Light Dir", Vector) = (1,1,1,1)
}
SubShader {
 Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 49374
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
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
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
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
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
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
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
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
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
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
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
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
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
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
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
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
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
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
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
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
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
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
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
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
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
}
}
 Pass {
  Name "BASE"
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 120821
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _StarCenter;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _StarCenter.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_13.xyz / tmpvar_13.w);
  tmpvar_14.w = (tmpvar_13.y / tmpvar_13.w);
  tmpvar_2 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_2 = (tmpvar_2 / tmpvar_2.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = o_5;
  xlv_TEXCOORD1 = o_10;
  xlv_NORMAL = normalize(normalize((_glesNormal * tmpvar_15)));
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform mediump float _StarEmission;
uniform highp vec4 _Colortop;
uniform highp vec4 _Colorbottom;
uniform highp vec4 _RimColor;
uniform highp float _RimPow;
uniform highp float _RimPow2;
uniform highp float _RimSterngth;
uniform highp float _BottomPos;
uniform highp float _BottonWidth;
uniform highp float _SpeedX;
uniform highp float _SpeedY;
uniform mediump vec4 _StarColor;
uniform sampler2D _TwinkleTex;
uniform highp vec4 _TwinkleTex_ST;
uniform highp float _DispearDistance;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 Star_1;
  mediump vec4 result_2;
  highp float rimalpha_3;
  highp float rimrgb_4;
  highp float rim_5;
  mediump vec3 V_6;
  mediump vec3 N_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_NORMAL);
  N_7 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  V_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - dot (N_7, V_6));
  rim_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = min (_RimSterngth, 1.0);
  rimrgb_4 = (pow (rim_5, _RimPow) * tmpvar_11);
  rimalpha_3 = (pow (rim_5, _RimPow2) * tmpvar_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = mix (_Colorbottom, _Colortop, vec4(clamp ((
    (xlv_TEXCOORD2.w - (xlv_TEXCOORD3.y - _BottomPos))
   / _BottonWidth), 0.0, 1.0)));
  result_2 = tmpvar_12;
  if ((rimrgb_4 > 0.5)) {
    result_2 = _RimColor;
  };
  highp vec4 ScreenPosN_13;
  mediump vec4 ScreenPos_14;
  highp vec4 o_15;
  o_15.xzw = xlv_TEXCOORD1.xzw;
  o_15.y = (xlv_TEXCOORD1.w * 0.5);
  o_15.y = (((xlv_TEXCOORD1.y - o_15.y) * _ProjectionParams.x) + o_15.y);
  ScreenPos_14 = o_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (ScreenPos_14 / ScreenPos_14.w);
  ScreenPosN_13 = tmpvar_16;
  highp vec4 ScreenPosN_17;
  mediump vec4 ScreenPos_18;
  highp vec4 o_19;
  o_19.xzw = xlv_TEXCOORD0.xzw;
  o_19.y = (xlv_TEXCOORD0.w * 0.5);
  o_19.y = (((xlv_TEXCOORD0.y - o_19.y) * _ProjectionParams.x) + o_19.y);
  ScreenPos_18 = o_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (ScreenPos_18 / ScreenPos_18.w);
  ScreenPosN_17 = tmpvar_20;
  highp float tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_WorldSpaceCameraPos.xz - xlv_TEXCOORD3.xz);
  tmpvar_21 = sqrt(dot (tmpvar_22, tmpvar_22));
  highp float tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (ScreenPosN_17.xy - ScreenPosN_13.xy);
  tmpvar_23 = sqrt(dot (tmpvar_24, tmpvar_24));
  highp vec2 tmpvar_25;
  tmpvar_25.x = ((_Time.y * _SpeedX) + ((
    (ScreenPosN_17.xy - ScreenPosN_13.xy)
  .x * tmpvar_21) * 0.1));
  tmpvar_25.y = ((_Time.y * _SpeedY) + ((
    (ScreenPosN_17.xy - ScreenPosN_13.xy)
  .y * tmpvar_21) * 0.1));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (tmpvar_25 * _TwinkleTex_ST.xy);
  tmpvar_26 = texture2D (_TwinkleTex, P_27);
  Star_1 = tmpvar_26;
  Star_1.w = (Star_1.w * _StarEmission);
  Star_1.xyz = (Star_1.xyz * _StarColor.xyz);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((_DispearDistance - tmpvar_23) / -(tmpvar_23)), 0.0, 1.0);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (result_2, Star_1, vec4(((tmpvar_28 * 
    (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
  ) * Star_1.w)));
  result_2.xyz = tmpvar_29.xyz;
  highp float tmpvar_30;
  tmpvar_30 = clamp (rimalpha_3, 0.0, 1.0);
  result_2.w = tmpvar_30;
  gl_FragData[0] = result_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _StarCenter;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _StarCenter.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_13.xyz / tmpvar_13.w);
  tmpvar_14.w = (tmpvar_13.y / tmpvar_13.w);
  tmpvar_2 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_2 = (tmpvar_2 / tmpvar_2.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = o_5;
  xlv_TEXCOORD1 = o_10;
  xlv_NORMAL = normalize(normalize((_glesNormal * tmpvar_15)));
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform mediump float _StarEmission;
uniform highp vec4 _Colortop;
uniform highp vec4 _Colorbottom;
uniform highp vec4 _RimColor;
uniform highp float _RimPow;
uniform highp float _RimPow2;
uniform highp float _RimSterngth;
uniform highp float _BottomPos;
uniform highp float _BottonWidth;
uniform highp float _SpeedX;
uniform highp float _SpeedY;
uniform mediump vec4 _StarColor;
uniform sampler2D _TwinkleTex;
uniform highp vec4 _TwinkleTex_ST;
uniform highp float _DispearDistance;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 Star_1;
  mediump vec4 result_2;
  highp float rimalpha_3;
  highp float rimrgb_4;
  highp float rim_5;
  mediump vec3 V_6;
  mediump vec3 N_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_NORMAL);
  N_7 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  V_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - dot (N_7, V_6));
  rim_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = min (_RimSterngth, 1.0);
  rimrgb_4 = (pow (rim_5, _RimPow) * tmpvar_11);
  rimalpha_3 = (pow (rim_5, _RimPow2) * tmpvar_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = mix (_Colorbottom, _Colortop, vec4(clamp ((
    (xlv_TEXCOORD2.w - (xlv_TEXCOORD3.y - _BottomPos))
   / _BottonWidth), 0.0, 1.0)));
  result_2 = tmpvar_12;
  if ((rimrgb_4 > 0.5)) {
    result_2 = _RimColor;
  };
  highp vec4 ScreenPosN_13;
  mediump vec4 ScreenPos_14;
  highp vec4 o_15;
  o_15.xzw = xlv_TEXCOORD1.xzw;
  o_15.y = (xlv_TEXCOORD1.w * 0.5);
  o_15.y = (((xlv_TEXCOORD1.y - o_15.y) * _ProjectionParams.x) + o_15.y);
  ScreenPos_14 = o_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (ScreenPos_14 / ScreenPos_14.w);
  ScreenPosN_13 = tmpvar_16;
  highp vec4 ScreenPosN_17;
  mediump vec4 ScreenPos_18;
  highp vec4 o_19;
  o_19.xzw = xlv_TEXCOORD0.xzw;
  o_19.y = (xlv_TEXCOORD0.w * 0.5);
  o_19.y = (((xlv_TEXCOORD0.y - o_19.y) * _ProjectionParams.x) + o_19.y);
  ScreenPos_18 = o_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (ScreenPos_18 / ScreenPos_18.w);
  ScreenPosN_17 = tmpvar_20;
  highp float tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_WorldSpaceCameraPos.xz - xlv_TEXCOORD3.xz);
  tmpvar_21 = sqrt(dot (tmpvar_22, tmpvar_22));
  highp float tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (ScreenPosN_17.xy - ScreenPosN_13.xy);
  tmpvar_23 = sqrt(dot (tmpvar_24, tmpvar_24));
  highp vec2 tmpvar_25;
  tmpvar_25.x = ((_Time.y * _SpeedX) + ((
    (ScreenPosN_17.xy - ScreenPosN_13.xy)
  .x * tmpvar_21) * 0.1));
  tmpvar_25.y = ((_Time.y * _SpeedY) + ((
    (ScreenPosN_17.xy - ScreenPosN_13.xy)
  .y * tmpvar_21) * 0.1));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (tmpvar_25 * _TwinkleTex_ST.xy);
  tmpvar_26 = texture2D (_TwinkleTex, P_27);
  Star_1 = tmpvar_26;
  Star_1.w = (Star_1.w * _StarEmission);
  Star_1.xyz = (Star_1.xyz * _StarColor.xyz);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((_DispearDistance - tmpvar_23) / -(tmpvar_23)), 0.0, 1.0);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (result_2, Star_1, vec4(((tmpvar_28 * 
    (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
  ) * Star_1.w)));
  result_2.xyz = tmpvar_29.xyz;
  highp float tmpvar_30;
  tmpvar_30 = clamp (rimalpha_3, 0.0, 1.0);
  result_2.w = tmpvar_30;
  gl_FragData[0] = result_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _StarCenter;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _StarCenter.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_13.xyz / tmpvar_13.w);
  tmpvar_14.w = (tmpvar_13.y / tmpvar_13.w);
  tmpvar_2 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_2 = (tmpvar_2 / tmpvar_2.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = o_5;
  xlv_TEXCOORD1 = o_10;
  xlv_NORMAL = normalize(normalize((_glesNormal * tmpvar_15)));
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform mediump float _StarEmission;
uniform highp vec4 _Colortop;
uniform highp vec4 _Colorbottom;
uniform highp vec4 _RimColor;
uniform highp float _RimPow;
uniform highp float _RimPow2;
uniform highp float _RimSterngth;
uniform highp float _BottomPos;
uniform highp float _BottonWidth;
uniform highp float _SpeedX;
uniform highp float _SpeedY;
uniform mediump vec4 _StarColor;
uniform sampler2D _TwinkleTex;
uniform highp vec4 _TwinkleTex_ST;
uniform highp float _DispearDistance;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 Star_1;
  mediump vec4 result_2;
  highp float rimalpha_3;
  highp float rimrgb_4;
  highp float rim_5;
  mediump vec3 V_6;
  mediump vec3 N_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_NORMAL);
  N_7 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz));
  V_6 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - dot (N_7, V_6));
  rim_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = min (_RimSterngth, 1.0);
  rimrgb_4 = (pow (rim_5, _RimPow) * tmpvar_11);
  rimalpha_3 = (pow (rim_5, _RimPow2) * tmpvar_11);
  highp vec4 tmpvar_12;
  tmpvar_12 = mix (_Colorbottom, _Colortop, vec4(clamp ((
    (xlv_TEXCOORD2.w - (xlv_TEXCOORD3.y - _BottomPos))
   / _BottonWidth), 0.0, 1.0)));
  result_2 = tmpvar_12;
  if ((rimrgb_4 > 0.5)) {
    result_2 = _RimColor;
  };
  highp vec4 ScreenPosN_13;
  mediump vec4 ScreenPos_14;
  highp vec4 o_15;
  o_15.xzw = xlv_TEXCOORD1.xzw;
  o_15.y = (xlv_TEXCOORD1.w * 0.5);
  o_15.y = (((xlv_TEXCOORD1.y - o_15.y) * _ProjectionParams.x) + o_15.y);
  ScreenPos_14 = o_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (ScreenPos_14 / ScreenPos_14.w);
  ScreenPosN_13 = tmpvar_16;
  highp vec4 ScreenPosN_17;
  mediump vec4 ScreenPos_18;
  highp vec4 o_19;
  o_19.xzw = xlv_TEXCOORD0.xzw;
  o_19.y = (xlv_TEXCOORD0.w * 0.5);
  o_19.y = (((xlv_TEXCOORD0.y - o_19.y) * _ProjectionParams.x) + o_19.y);
  ScreenPos_18 = o_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (ScreenPos_18 / ScreenPos_18.w);
  ScreenPosN_17 = tmpvar_20;
  highp float tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_WorldSpaceCameraPos.xz - xlv_TEXCOORD3.xz);
  tmpvar_21 = sqrt(dot (tmpvar_22, tmpvar_22));
  highp float tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (ScreenPosN_17.xy - ScreenPosN_13.xy);
  tmpvar_23 = sqrt(dot (tmpvar_24, tmpvar_24));
  highp vec2 tmpvar_25;
  tmpvar_25.x = ((_Time.y * _SpeedX) + ((
    (ScreenPosN_17.xy - ScreenPosN_13.xy)
  .x * tmpvar_21) * 0.1));
  tmpvar_25.y = ((_Time.y * _SpeedY) + ((
    (ScreenPosN_17.xy - ScreenPosN_13.xy)
  .y * tmpvar_21) * 0.1));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (tmpvar_25 * _TwinkleTex_ST.xy);
  tmpvar_26 = texture2D (_TwinkleTex, P_27);
  Star_1 = tmpvar_26;
  Star_1.w = (Star_1.w * _StarEmission);
  Star_1.xyz = (Star_1.xyz * _StarColor.xyz);
  highp float tmpvar_28;
  tmpvar_28 = clamp (((_DispearDistance - tmpvar_23) / -(tmpvar_23)), 0.0, 1.0);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (result_2, Star_1, vec4(((tmpvar_28 * 
    (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
  ) * Star_1.w)));
  result_2.xyz = tmpvar_29.xyz;
  highp float tmpvar_30;
  tmpvar_30 = clamp (rimalpha_3, 0.0, 1.0);
  result_2.w = tmpvar_30;
  gl_FragData[0] = result_2;
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
  Name "COMPLEX"
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 136188
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_12;
    highp vec4 tmpvar_13;
    tmpvar_13 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_14;
    tmpvar_14.x = tmpvar_13.x;
    tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
    o_12.xy = (tmpvar_14 + tmpvar_13.w);
    o_12.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_12.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_12;
    highp vec4 tmpvar_13;
    tmpvar_13 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_14;
    tmpvar_14.x = tmpvar_13.x;
    tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
    o_12.xy = (tmpvar_14 + tmpvar_13.w);
    o_12.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_12.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_12;
    highp vec4 tmpvar_13;
    tmpvar_13 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_14;
    tmpvar_14.x = tmpvar_13.x;
    tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
    o_12.xy = (tmpvar_14 + tmpvar_13.w);
    o_12.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_12.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec2 spnoiseuv_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (_glesVertex * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (tmpvar_13.z * tmpvar_13.z));
  tmpvar_14.y = ((tmpvar_13.y + (0.5 * tmpvar_13.z)) + ((0.5 * tmpvar_13.x) * tmpvar_13.x));
  spnoiseuv_12 = ((tmpvar_14 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_15.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = spnoiseuv_12;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec2 spnoiseuv_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (_glesVertex * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (tmpvar_13.z * tmpvar_13.z));
  tmpvar_14.y = ((tmpvar_13.y + (0.5 * tmpvar_13.z)) + ((0.5 * tmpvar_13.x) * tmpvar_13.x));
  spnoiseuv_12 = ((tmpvar_14 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_15.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = spnoiseuv_12;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec2 spnoiseuv_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (_glesVertex * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (tmpvar_13.z * tmpvar_13.z));
  tmpvar_14.y = ((tmpvar_13.y + (0.5 * tmpvar_13.z)) + ((0.5 * tmpvar_13.x) * tmpvar_13.x));
  spnoiseuv_12 = ((tmpvar_14 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_15.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = spnoiseuv_12;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
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
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
}
}
 Pass {
  Name "CONSTANT_REPLACE"
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 220157
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
uniform mediump float _EmissionBloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_color_1;
  mediump vec4 o_2;
  o_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_color_1 = tmpvar_3;
  o_2.w = mix (_BloomFactor, _EmissionBloomFactor, tex_color_1.w);
  gl_FragData[0] = o_2;
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
uniform mediump float _EmissionBloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_color_1;
  mediump vec4 o_2;
  o_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_color_1 = tmpvar_3;
  o_2.w = mix (_BloomFactor, _EmissionBloomFactor, tex_color_1.w);
  gl_FragData[0] = o_2;
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
uniform mediump float _EmissionBloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tex_color_1;
  mediump vec4 o_2;
  o_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_color_1 = tmpvar_3;
  o_2.w = mix (_BloomFactor, _EmissionBloomFactor, tex_color_1.w);
  gl_FragData[0] = o_2;
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