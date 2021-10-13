//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Liquid_Common" {
Properties {
_LiquidTex ("LiquidTex", 2D) = "white" { }
_Normalmap ("Normalmap", 2D) = "bump" { }
_NormalBrightness ("NormalBrightness", Range(-1, 4)) = 1
_MatcapSize ("MatcapSize", Range(0, 2)) = 1
_Matcap ("Matcap", 2D) = "white" { }
_ColorBrightnessMax ("ColorBrightnessMax", Float) = 1.05
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 2
[MHYToggle] _MatcapAlphaToggle ("MatcapAlphaToggle", Float) = 0
_Color ("Color", Color) = (1,1,1,1)
[MHYToggle] _UspeedToggle ("UspeedToggle", Float) = 0
_Uspeed ("Uspeed", Float) = 0
[Toggle(_MASKTEXTOGGLE_ON)] _MaskTexToggle ("MaskTexToggle", Float) = 0
_TextureMask ("TextureMask", 2D) = "white" { }
[Toggle(_NOISETOGGLE_ON)] _NoiseToggle ("NoiseToggle", Float) = 0
[MHYToggle] _NoiseRandomToggle ("NoiseRandomToggle", Float) = 0
_Noise_Tex ("Noise_Tex", 2D) = "white" { }
_Noise_Uspeed ("Noise_Uspeed", Float) = 0
_Noise_Vspeed ("Noise_Vspeed", Float) = 0
_Noise_Offset ("Noise_Offset", Float) = 0.5
_Noise_Brightness ("Noise_Brightness", Float) = 0.1
[MHYToggle] _ParticlesColorToggle1 ("ParticlesColorToggle1", Float) = 0
[MHYToggle] _ParticlesColorToggle2 ("ParticlesColorToggle2", Float) = 0
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_DayColor ("DayColor", Color) = (1,1,1,1)
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 10268
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_2.xyw = tmpvar_15.xyw;
  tmpvar_2.z = (tmpvar_15.z + (_MHYZBias * tmpvar_15.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = o_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform highp vec4 _DayColor;
uniform mediump float _ParticlesColorToggle2;
uniform mediump float _MatcapAlphaToggle;
uniform sampler2D _LiquidTex;
uniform mediump float _UspeedToggle;
uniform highp float _Uspeed;
uniform highp vec4 _LiquidTex_ST;
uniform sampler2D _Matcap;
uniform sampler2D _Normalmap;
uniform highp vec4 _Normalmap_ST;
uniform highp float _NormalBrightness;
uniform highp float _MatcapSize;
uniform highp float _AlphaBrightness;
uniform highp float _ColorBrightness;
uniform mediump float _ParticlesColorToggle1;
uniform highp vec4 _Color;
uniform highp float _ColorBrightnessMax;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 staticSwitch273_3;
  highp float staticSwitch274_4;
  highp float staticSwitch275_5;
  highp vec4 tex2DNode86_6;
  highp vec3 tex2DNode1_7;
  highp float ifLocalVar119_8;
  highp vec4 tex2DNode151_9;
  highp vec2 staticSwitch265_10;
  highp float tmpvar_11;
  tmpvar_11 = (_Time.y * _Uspeed);
  staticSwitch265_10 = vec2(0.0, 0.0);
  if ((_UspeedToggle == 1.0)) {
    staticSwitch265_10 = (tmpvar_11 + xlv_TEXCOORD1.xy);
  } else {
    staticSwitch265_10 = vec2(0.0, 0.0);
  };
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0.xy * _LiquidTex_ST.xy) + _LiquidTex_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (staticSwitch265_10 + tmpvar_12.x).x;
  tmpvar_13.y = tmpvar_12.y;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LiquidTex, tmpvar_13);
  tex2DNode151_9 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (1.0 - xlv_COLOR.w);
  ifLocalVar119_8 = 0.0;
  if ((tex2DNode151_9.x <= tmpvar_15)) {
    ifLocalVar119_8 = 0.0;
  } else {
    ifLocalVar119_8 = 1.0;
  };
  highp float tmpvar_16;
  tmpvar_16 = (tex2DNode151_9.y * ifLocalVar119_8);
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _Normalmap_ST.xy) + _Normalmap_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + staticSwitch265_10).x;
  tmpvar_18.y = tmpvar_17.y;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_Normalmap, tmpvar_18).xyz * 2.0) - 1.0);
  tex2DNode1_7 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = xlv_TEXCOORD3.xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_22;
  tmpvar_22 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_23;
  tmpvar_23.x = tmpvar_20.x;
  tmpvar_23.y = tmpvar_22.x;
  tmpvar_23.z = tmpvar_21.x;
  highp vec3 tmpvar_24;
  tmpvar_24.x = tmpvar_20.y;
  tmpvar_24.y = tmpvar_22.y;
  tmpvar_24.z = tmpvar_21.y;
  highp vec3 tmpvar_25;
  tmpvar_25.x = tmpvar_20.z;
  tmpvar_25.y = tmpvar_22.z;
  tmpvar_25.z = tmpvar_21.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tex2DNode1_7 * (1.0 + _NormalBrightness));
  highp vec3 tmpvar_27;
  tmpvar_27.x = dot (tmpvar_23, tmpvar_26);
  tmpvar_27.y = dot (tmpvar_24, tmpvar_26);
  tmpvar_27.z = dot (tmpvar_25, tmpvar_26);
  highp mat3 tmpvar_28;
  tmpvar_28[0] = unity_MatrixV[0].xyz;
  tmpvar_28[1] = unity_MatrixV[1].xyz;
  tmpvar_28[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (((
    (tmpvar_28 * tmpvar_27)
  .xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_29 = texture2D (_Matcap, P_30);
  tex2DNode86_6 = tmpvar_29;
  staticSwitch275_5 = 0.0;
  if ((_MatcapAlphaToggle == 1.0)) {
    staticSwitch275_5 = (tex2DNode86_6.w * tmpvar_16);
  } else {
    staticSwitch275_5 = tmpvar_16;
  };
  highp float tmpvar_31;
  tmpvar_31 = (staticSwitch275_5 * _AlphaBrightness);
  staticSwitch274_4 = 0.0;
  if ((_ParticlesColorToggle2 == 1.0)) {
    staticSwitch274_4 = tmpvar_31;
  } else {
    staticSwitch274_4 = (xlv_COLOR.x * tmpvar_31);
  };
  highp float tmpvar_32;
  tmpvar_32 = clamp ((_DayColor.w * staticSwitch274_4), 0.0, 1.0);
  staticSwitch273_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_ParticlesColorToggle1 == 1.0)) {
    staticSwitch273_3 = xlv_COLOR;
  } else {
    staticSwitch273_3 = _Color;
  };
  aseOutAlpha_2 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = (clamp ((_ColorBrightness * 
    (staticSwitch273_3 * tex2DNode86_6)
  ), vec4(0.0, 0.0, 0.0, 0.0), vec4(_ColorBrightnessMax)) * _DayColor).xyz;
  aseOutColor_1 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_34;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = aseOutColor_1;
  tmpvar_35.w = tmpvar_34;
  gl_FragData[0] = tmpvar_35;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_2.xyw = tmpvar_15.xyw;
  tmpvar_2.z = (tmpvar_15.z + (_MHYZBias * tmpvar_15.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = o_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform highp vec4 _DayColor;
uniform mediump float _ParticlesColorToggle2;
uniform mediump float _MatcapAlphaToggle;
uniform sampler2D _LiquidTex;
uniform mediump float _UspeedToggle;
uniform highp float _Uspeed;
uniform highp vec4 _LiquidTex_ST;
uniform sampler2D _Matcap;
uniform sampler2D _Normalmap;
uniform highp vec4 _Normalmap_ST;
uniform highp float _NormalBrightness;
uniform highp float _MatcapSize;
uniform highp float _AlphaBrightness;
uniform highp float _ColorBrightness;
uniform mediump float _ParticlesColorToggle1;
uniform highp vec4 _Color;
uniform highp float _ColorBrightnessMax;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 staticSwitch273_3;
  highp float staticSwitch274_4;
  highp float staticSwitch275_5;
  highp vec4 tex2DNode86_6;
  highp vec3 tex2DNode1_7;
  highp float ifLocalVar119_8;
  highp vec4 tex2DNode151_9;
  highp vec2 staticSwitch265_10;
  highp float tmpvar_11;
  tmpvar_11 = (_Time.y * _Uspeed);
  staticSwitch265_10 = vec2(0.0, 0.0);
  if ((_UspeedToggle == 1.0)) {
    staticSwitch265_10 = (tmpvar_11 + xlv_TEXCOORD1.xy);
  } else {
    staticSwitch265_10 = vec2(0.0, 0.0);
  };
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0.xy * _LiquidTex_ST.xy) + _LiquidTex_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (staticSwitch265_10 + tmpvar_12.x).x;
  tmpvar_13.y = tmpvar_12.y;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LiquidTex, tmpvar_13);
  tex2DNode151_9 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (1.0 - xlv_COLOR.w);
  ifLocalVar119_8 = 0.0;
  if ((tex2DNode151_9.x <= tmpvar_15)) {
    ifLocalVar119_8 = 0.0;
  } else {
    ifLocalVar119_8 = 1.0;
  };
  highp float tmpvar_16;
  tmpvar_16 = (tex2DNode151_9.y * ifLocalVar119_8);
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _Normalmap_ST.xy) + _Normalmap_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + staticSwitch265_10).x;
  tmpvar_18.y = tmpvar_17.y;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_Normalmap, tmpvar_18).xyz * 2.0) - 1.0);
  tex2DNode1_7 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = xlv_TEXCOORD3.xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_22;
  tmpvar_22 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_23;
  tmpvar_23.x = tmpvar_20.x;
  tmpvar_23.y = tmpvar_22.x;
  tmpvar_23.z = tmpvar_21.x;
  highp vec3 tmpvar_24;
  tmpvar_24.x = tmpvar_20.y;
  tmpvar_24.y = tmpvar_22.y;
  tmpvar_24.z = tmpvar_21.y;
  highp vec3 tmpvar_25;
  tmpvar_25.x = tmpvar_20.z;
  tmpvar_25.y = tmpvar_22.z;
  tmpvar_25.z = tmpvar_21.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tex2DNode1_7 * (1.0 + _NormalBrightness));
  highp vec3 tmpvar_27;
  tmpvar_27.x = dot (tmpvar_23, tmpvar_26);
  tmpvar_27.y = dot (tmpvar_24, tmpvar_26);
  tmpvar_27.z = dot (tmpvar_25, tmpvar_26);
  highp mat3 tmpvar_28;
  tmpvar_28[0] = unity_MatrixV[0].xyz;
  tmpvar_28[1] = unity_MatrixV[1].xyz;
  tmpvar_28[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (((
    (tmpvar_28 * tmpvar_27)
  .xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_29 = texture2D (_Matcap, P_30);
  tex2DNode86_6 = tmpvar_29;
  staticSwitch275_5 = 0.0;
  if ((_MatcapAlphaToggle == 1.0)) {
    staticSwitch275_5 = (tex2DNode86_6.w * tmpvar_16);
  } else {
    staticSwitch275_5 = tmpvar_16;
  };
  highp float tmpvar_31;
  tmpvar_31 = (staticSwitch275_5 * _AlphaBrightness);
  staticSwitch274_4 = 0.0;
  if ((_ParticlesColorToggle2 == 1.0)) {
    staticSwitch274_4 = tmpvar_31;
  } else {
    staticSwitch274_4 = (xlv_COLOR.x * tmpvar_31);
  };
  highp float tmpvar_32;
  tmpvar_32 = clamp ((_DayColor.w * staticSwitch274_4), 0.0, 1.0);
  staticSwitch273_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_ParticlesColorToggle1 == 1.0)) {
    staticSwitch273_3 = xlv_COLOR;
  } else {
    staticSwitch273_3 = _Color;
  };
  aseOutAlpha_2 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = (clamp ((_ColorBrightness * 
    (staticSwitch273_3 * tex2DNode86_6)
  ), vec4(0.0, 0.0, 0.0, 0.0), vec4(_ColorBrightnessMax)) * _DayColor).xyz;
  aseOutColor_1 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_34;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = aseOutColor_1;
  tmpvar_35.w = tmpvar_34;
  gl_FragData[0] = tmpvar_35;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_1.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_2.xyw = tmpvar_15.xyw;
  tmpvar_2.z = (tmpvar_15.z + (_MHYZBias * tmpvar_15.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = o_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform highp vec4 _DayColor;
uniform mediump float _ParticlesColorToggle2;
uniform mediump float _MatcapAlphaToggle;
uniform sampler2D _LiquidTex;
uniform mediump float _UspeedToggle;
uniform highp float _Uspeed;
uniform highp vec4 _LiquidTex_ST;
uniform sampler2D _Matcap;
uniform sampler2D _Normalmap;
uniform highp vec4 _Normalmap_ST;
uniform highp float _NormalBrightness;
uniform highp float _MatcapSize;
uniform highp float _AlphaBrightness;
uniform highp float _ColorBrightness;
uniform mediump float _ParticlesColorToggle1;
uniform highp vec4 _Color;
uniform highp float _ColorBrightnessMax;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 staticSwitch273_3;
  highp float staticSwitch274_4;
  highp float staticSwitch275_5;
  highp vec4 tex2DNode86_6;
  highp vec3 tex2DNode1_7;
  highp float ifLocalVar119_8;
  highp vec4 tex2DNode151_9;
  highp vec2 staticSwitch265_10;
  highp float tmpvar_11;
  tmpvar_11 = (_Time.y * _Uspeed);
  staticSwitch265_10 = vec2(0.0, 0.0);
  if ((_UspeedToggle == 1.0)) {
    staticSwitch265_10 = (tmpvar_11 + xlv_TEXCOORD1.xy);
  } else {
    staticSwitch265_10 = vec2(0.0, 0.0);
  };
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0.xy * _LiquidTex_ST.xy) + _LiquidTex_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (staticSwitch265_10 + tmpvar_12.x).x;
  tmpvar_13.y = tmpvar_12.y;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LiquidTex, tmpvar_13);
  tex2DNode151_9 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (1.0 - xlv_COLOR.w);
  ifLocalVar119_8 = 0.0;
  if ((tex2DNode151_9.x <= tmpvar_15)) {
    ifLocalVar119_8 = 0.0;
  } else {
    ifLocalVar119_8 = 1.0;
  };
  highp float tmpvar_16;
  tmpvar_16 = (tex2DNode151_9.y * ifLocalVar119_8);
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _Normalmap_ST.xy) + _Normalmap_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + staticSwitch265_10).x;
  tmpvar_18.y = tmpvar_17.y;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_Normalmap, tmpvar_18).xyz * 2.0) - 1.0);
  tex2DNode1_7 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = xlv_TEXCOORD3.xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_22;
  tmpvar_22 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_23;
  tmpvar_23.x = tmpvar_20.x;
  tmpvar_23.y = tmpvar_22.x;
  tmpvar_23.z = tmpvar_21.x;
  highp vec3 tmpvar_24;
  tmpvar_24.x = tmpvar_20.y;
  tmpvar_24.y = tmpvar_22.y;
  tmpvar_24.z = tmpvar_21.y;
  highp vec3 tmpvar_25;
  tmpvar_25.x = tmpvar_20.z;
  tmpvar_25.y = tmpvar_22.z;
  tmpvar_25.z = tmpvar_21.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tex2DNode1_7 * (1.0 + _NormalBrightness));
  highp vec3 tmpvar_27;
  tmpvar_27.x = dot (tmpvar_23, tmpvar_26);
  tmpvar_27.y = dot (tmpvar_24, tmpvar_26);
  tmpvar_27.z = dot (tmpvar_25, tmpvar_26);
  highp mat3 tmpvar_28;
  tmpvar_28[0] = unity_MatrixV[0].xyz;
  tmpvar_28[1] = unity_MatrixV[1].xyz;
  tmpvar_28[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (((
    (tmpvar_28 * tmpvar_27)
  .xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_29 = texture2D (_Matcap, P_30);
  tex2DNode86_6 = tmpvar_29;
  staticSwitch275_5 = 0.0;
  if ((_MatcapAlphaToggle == 1.0)) {
    staticSwitch275_5 = (tex2DNode86_6.w * tmpvar_16);
  } else {
    staticSwitch275_5 = tmpvar_16;
  };
  highp float tmpvar_31;
  tmpvar_31 = (staticSwitch275_5 * _AlphaBrightness);
  staticSwitch274_4 = 0.0;
  if ((_ParticlesColorToggle2 == 1.0)) {
    staticSwitch274_4 = tmpvar_31;
  } else {
    staticSwitch274_4 = (xlv_COLOR.x * tmpvar_31);
  };
  highp float tmpvar_32;
  tmpvar_32 = clamp ((_DayColor.w * staticSwitch274_4), 0.0, 1.0);
  staticSwitch273_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_ParticlesColorToggle1 == 1.0)) {
    staticSwitch273_3 = xlv_COLOR;
  } else {
    staticSwitch273_3 = _Color;
  };
  aseOutAlpha_2 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = (clamp ((_ColorBrightness * 
    (staticSwitch273_3 * tex2DNode86_6)
  ), vec4(0.0, 0.0, 0.0, 0.0), vec4(_ColorBrightnessMax)) * _DayColor).xyz;
  aseOutColor_1 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_34;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = aseOutColor_1;
  tmpvar_35.w = tmpvar_34;
  gl_FragData[0] = tmpvar_35;
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
CustomEditor "MiHoYoASEMaterialInspector"
}