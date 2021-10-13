//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_WaterWall" {
Properties {
_MainTex01 ("MainTex01", 2D) = "white" { }
_MainTex01Speed ("MainTex01Speed", Vector) = (0,0,0,0)
_MainTex01Tiling ("MainTex01Tiling", Vector) = (1,1,0,0)
_mainTex01Color ("mainTex01Color", Color) = (0.4056553,0.5742006,0.9044118,0)
_mainTex01DisTex ("mainTex01DisTex", 2D) = "white" { }
_mainTex01Dis ("mainTex01Dis", Float) = 0.13
_mainTex02 ("mainTex02", 2D) = "white" { }
_mainTex02Speed ("mainTex02Speed", Vector) = (0,0,0,0)
_mainTex02Tilling ("mainTex02Tilling", Vector) = (1,1,0,0)
_mainTex02Color ("mainTex02Color", Color) = (0.4056553,0.5742006,0.9044118,0)
_mainTex02Dis ("mainTex02Dis", Float) = 0.13
_mainTex02DisTex ("mainTex02DisTex", 2D) = "white" { }
_BgColor ("BgColor", Color) = (0.9338235,0.9269572,0.9269572,0)
_Opacity ("Opacity", Float) = 1
_mainTex2Intensity ("mainTex2Intensity", Float) = 1
_SpecularTex ("SpecularTex", 2D) = "white" { }
_SpecularIntensity ("SpecularIntensity", Float) = 1
_LightMap ("LightMap", 2D) = "white" { }
_LightMapColor ("LightMapColor", Color) = (1,1,1,0)
_LightMapIntensity ("LightMapIntensity", Float) = 1
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 59923
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _mainTex01Color;
uniform sampler2D _MainTex01;
uniform highp vec2 _MainTex01Speed;
uniform highp vec2 _MainTex01Tiling;
uniform sampler2D _mainTex01DisTex;
uniform highp vec4 _mainTex01DisTex_ST;
uniform highp float _mainTex01Dis;
uniform highp vec4 _mainTex02Color;
uniform sampler2D _mainTex02;
uniform highp vec2 _mainTex02Speed;
uniform highp vec2 _mainTex02Tilling;
uniform sampler2D _mainTex02DisTex;
uniform highp vec4 _mainTex02DisTex_ST;
uniform highp float _mainTex02Dis;
uniform highp float _mainTex2Intensity;
uniform highp float _Opacity;
uniform highp vec4 _BgColor;
uniform sampler2D _SpecularTex;
uniform highp float _SpecularIntensity;
uniform sampler2D _LightMap;
uniform highp vec4 _LightMap_ST;
uniform highp vec4 _LightMapColor;
uniform highp float _LightMapIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode29_3;
  highp vec4 tex2DNode12_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _mainTex01DisTex_ST.xy) + _mainTex01DisTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_mainTex01DisTex, tmpvar_5);
  tex2DNode12_4 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_Time.y * _MainTex01Speed) + (xlv_TEXCOORD0.xy * _MainTex01Tiling)) + (tex2DNode12_4.xy * _mainTex01Dis));
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _mainTex02DisTex_ST.xy) + _mainTex02DisTex_ST.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_mainTex02DisTex, tmpvar_8);
  tex2DNode29_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex01, tmpvar_7);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((_Time.y * _mainTex02Speed) + (xlv_TEXCOORD0.xy * _mainTex02Tilling)) + (tex2DNode29_3.xy * _mainTex02Dis));
  tmpvar_11 = texture2D (_mainTex02, P_12);
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_mainTex01Color * tmpvar_10) + ((_mainTex02Color * tmpvar_11) * _mainTex2Intensity));
  highp vec4 tmpvar_14;
  tmpvar_14 = (_BgColor + tmpvar_13);
  highp vec2 tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD0.xy * _LightMap_ST.xy) + _LightMap_ST.zw);
  highp float tmpvar_16;
  tmpvar_16 = ((1.0 - clamp (tmpvar_13, vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 0.0))) * _Opacity).x;
  aseOutAlpha_2 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SpecularTex, tmpvar_7);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_LightMap, tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_14 + (
    (tmpvar_14 * tmpvar_17)
   * _SpecularIntensity)) + ((tmpvar_18 * _LightMapColor) * _LightMapIntensity)).xyz;
  aseOutColor_1 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = aseOutColor_1;
  tmpvar_21.w = tmpvar_20;
  gl_FragData[0] = tmpvar_21;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _mainTex01Color;
uniform sampler2D _MainTex01;
uniform highp vec2 _MainTex01Speed;
uniform highp vec2 _MainTex01Tiling;
uniform sampler2D _mainTex01DisTex;
uniform highp vec4 _mainTex01DisTex_ST;
uniform highp float _mainTex01Dis;
uniform highp vec4 _mainTex02Color;
uniform sampler2D _mainTex02;
uniform highp vec2 _mainTex02Speed;
uniform highp vec2 _mainTex02Tilling;
uniform sampler2D _mainTex02DisTex;
uniform highp vec4 _mainTex02DisTex_ST;
uniform highp float _mainTex02Dis;
uniform highp float _mainTex2Intensity;
uniform highp float _Opacity;
uniform highp vec4 _BgColor;
uniform sampler2D _SpecularTex;
uniform highp float _SpecularIntensity;
uniform sampler2D _LightMap;
uniform highp vec4 _LightMap_ST;
uniform highp vec4 _LightMapColor;
uniform highp float _LightMapIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode29_3;
  highp vec4 tex2DNode12_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _mainTex01DisTex_ST.xy) + _mainTex01DisTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_mainTex01DisTex, tmpvar_5);
  tex2DNode12_4 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_Time.y * _MainTex01Speed) + (xlv_TEXCOORD0.xy * _MainTex01Tiling)) + (tex2DNode12_4.xy * _mainTex01Dis));
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _mainTex02DisTex_ST.xy) + _mainTex02DisTex_ST.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_mainTex02DisTex, tmpvar_8);
  tex2DNode29_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex01, tmpvar_7);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((_Time.y * _mainTex02Speed) + (xlv_TEXCOORD0.xy * _mainTex02Tilling)) + (tex2DNode29_3.xy * _mainTex02Dis));
  tmpvar_11 = texture2D (_mainTex02, P_12);
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_mainTex01Color * tmpvar_10) + ((_mainTex02Color * tmpvar_11) * _mainTex2Intensity));
  highp vec4 tmpvar_14;
  tmpvar_14 = (_BgColor + tmpvar_13);
  highp vec2 tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD0.xy * _LightMap_ST.xy) + _LightMap_ST.zw);
  highp float tmpvar_16;
  tmpvar_16 = ((1.0 - clamp (tmpvar_13, vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 0.0))) * _Opacity).x;
  aseOutAlpha_2 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SpecularTex, tmpvar_7);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_LightMap, tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_14 + (
    (tmpvar_14 * tmpvar_17)
   * _SpecularIntensity)) + ((tmpvar_18 * _LightMapColor) * _LightMapIntensity)).xyz;
  aseOutColor_1 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = aseOutColor_1;
  tmpvar_21.w = tmpvar_20;
  gl_FragData[0] = tmpvar_21;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _mainTex01Color;
uniform sampler2D _MainTex01;
uniform highp vec2 _MainTex01Speed;
uniform highp vec2 _MainTex01Tiling;
uniform sampler2D _mainTex01DisTex;
uniform highp vec4 _mainTex01DisTex_ST;
uniform highp float _mainTex01Dis;
uniform highp vec4 _mainTex02Color;
uniform sampler2D _mainTex02;
uniform highp vec2 _mainTex02Speed;
uniform highp vec2 _mainTex02Tilling;
uniform sampler2D _mainTex02DisTex;
uniform highp vec4 _mainTex02DisTex_ST;
uniform highp float _mainTex02Dis;
uniform highp float _mainTex2Intensity;
uniform highp float _Opacity;
uniform highp vec4 _BgColor;
uniform sampler2D _SpecularTex;
uniform highp float _SpecularIntensity;
uniform sampler2D _LightMap;
uniform highp vec4 _LightMap_ST;
uniform highp vec4 _LightMapColor;
uniform highp float _LightMapIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode29_3;
  highp vec4 tex2DNode12_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _mainTex01DisTex_ST.xy) + _mainTex01DisTex_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_mainTex01DisTex, tmpvar_5);
  tex2DNode12_4 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_Time.y * _MainTex01Speed) + (xlv_TEXCOORD0.xy * _MainTex01Tiling)) + (tex2DNode12_4.xy * _mainTex01Dis));
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _mainTex02DisTex_ST.xy) + _mainTex02DisTex_ST.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_mainTex02DisTex, tmpvar_8);
  tex2DNode29_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex01, tmpvar_7);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (((_Time.y * _mainTex02Speed) + (xlv_TEXCOORD0.xy * _mainTex02Tilling)) + (tex2DNode29_3.xy * _mainTex02Dis));
  tmpvar_11 = texture2D (_mainTex02, P_12);
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_mainTex01Color * tmpvar_10) + ((_mainTex02Color * tmpvar_11) * _mainTex2Intensity));
  highp vec4 tmpvar_14;
  tmpvar_14 = (_BgColor + tmpvar_13);
  highp vec2 tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD0.xy * _LightMap_ST.xy) + _LightMap_ST.zw);
  highp float tmpvar_16;
  tmpvar_16 = ((1.0 - clamp (tmpvar_13, vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 0.0))) * _Opacity).x;
  aseOutAlpha_2 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SpecularTex, tmpvar_7);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_LightMap, tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_14 + (
    (tmpvar_14 * tmpvar_17)
   * _SpecularIntensity)) + ((tmpvar_18 * _LightMapColor) * _LightMapIntensity)).xyz;
  aseOutColor_1 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = aseOutColor_1;
  tmpvar_21.w = tmpvar_20;
  gl_FragData[0] = tmpvar_21;
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
CustomEditor "ASEMaterialInspector"
}