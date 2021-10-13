//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/Scene_Grass" {
Properties {
[MHYHeaderBox(Surface)] _AlphaClip ("Alpha Clip", Range(0, 1)) = 0.5
_MainTex ("Base (RGB)", 2D) = "white" { }
_TipsColor ("Main Color", Color) = (0.1,0.9,0.1,1)
_RootColor ("Root Color", Color) = (0.1,0.7,0.1,1)
_ColorShift ("Color Shift", Range(0, 1)) = 0.5
_EnableOutline ("Enable Outline", Float) = 1
_OutlineColor ("Outline Color", Color) = (1,1,1,1)
_OutlinePower ("Outline Power", Range(0, 1)) = 0.5
[MHYHeaderBox(Swaying)] _Amplitude ("Amplitude", Range(0, 1)) = 1
_Frequency ("Frequency", Range(20, 50)) = 25
_SwayMax ("Sway Max", Range(0, 0.1)) = 0.005
[MHYHeaderBox(Interaction)] _IntrRadius ("Intr Radius", Range(0, 5)) = 1
_IntrSensitivity ("Intr Sensitivity", Range(0, 10)) = 1
_IntrMaxWidth ("Intr Max Width", Range(0, 2)) = 0.1
[MHYHeaderBox(Noise Map)] _EnableNoiseMap ("Enable NoiseMap", Float) = 1
_NoiseMap ("Noise Map", 2D) = "gray" { }
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "QUEUE" = "AlphaTest-1" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest-1" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 27729
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp int _EnableNoiseMap;
uniform sampler2D _NoiseMap;
uniform highp vec4 _NoiseMap_ST;
uniform mediump float _ColorShift;
uniform mediump float _SwayMax;
uniform mediump float _Amplitude;
uniform mediump float _Frequency;
uniform mediump float _IntrRadius;
uniform mediump float _IntrMaxWidth;
uniform mediump float _IntrSensitivity;
uniform highp vec3 _Positions[4];
uniform highp float _PositionArray;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_2.yw = _glesVertex.yw;
  tmpvar_3 = _glesColor;
  highp vec2 noise_4;
  highp float amplitude_6;
  highp float frequency_7;
  highp vec3 worldPos_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  worldPos_8 = tmpvar_10;
  frequency_7 = _Frequency;
  mediump float tmpvar_11;
  tmpvar_11 = (_glesColor.x * _Amplitude);
  amplitude_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = (_glesColor.y * 6.28319);
  tmpvar_2.x = (_glesVertex.x + ((
    sin(((_Time.x * frequency_7) + ((tmpvar_10.x * 0.31831) + tmpvar_12)))
   * amplitude_6) * _SwayMax));
  tmpvar_2.z = (_glesVertex.z + ((
    sin(((_Time.x * frequency_7) + ((tmpvar_10.z * 0.31831) + tmpvar_12)))
   * amplitude_6) * _SwayMax));
  for (highp int i_5 = 0; float(i_5) < _PositionArray; i_5++) {
    highp vec3 tmpvar_13;
    tmpvar_13 = (_Positions[i_5] - worldPos_8);
    mediump vec2 tmpvar_14;
    tmpvar_14 = vec2(-(_IntrMaxWidth));
    tmpvar_2.xz = (tmpvar_2.xz + ((tmpvar_2.y * _IntrSensitivity) * clamp (
      (((worldPos_8 - _Positions[i_5]) * (1.0 - clamp (
        (vec3(sqrt(dot (tmpvar_13, tmpvar_13))) / _IntrRadius)
      , 0.0, 1.0))).xz * tmpvar_3.x)
    , tmpvar_14, vec2(_IntrMaxWidth))));
  };
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_2.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  if (bool(_EnableNoiseMap)) {
    highp vec4 tmpvar_17;
    tmpvar_17.zw = vec2(0.0, 0.0);
    tmpvar_17.xy = (((tmpvar_10.xz + tmpvar_2.xz) * _NoiseMap_ST.xy) + _NoiseMap_ST.zw);
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2DLod (_NoiseMap, tmpvar_17.xy, 0.0);
    noise_4 = tmpvar_18.xy;
  };
  tmpvar_9.x = (_glesColor.x * noise_4.x);
  tmpvar_9.y = ((_glesColor.x * noise_4.y) * (_ColorShift * 2.4));
  xlv_TEXCOORD0 = tmpvar_1;
  gl_Position = tmpvar_15;
  xlv_COLOR0 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump float _AlphaClip;
uniform sampler2D _MainTex;
uniform mediump vec4 _TipsColor;
uniform mediump vec4 _RootColor;
uniform highp int _EnableOutline;
uniform mediump vec4 _OutlineColor;
uniform mediump float _OutlinePower;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 finalColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float x_4;
  x_4 = (tmpvar_3.w - _AlphaClip);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  tmpvar_5 = mix (_RootColor, _TipsColor, xlv_COLOR0.yyyy);
  finalColor_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = clamp ((finalColor_2 * (1.0 + 
    ((xlv_COLOR0.x - 0.5) * 0.5)
  )), 0.0, 1.0);
  finalColor_2 = tmpvar_6;
  if ((_EnableOutline > 0)) {
    highp vec4 tmpvar_7;
    tmpvar_7.w = 0.0;
    tmpvar_7.xyz = tmpvar_6.xyz;
    mediump float tmpvar_8;
    tmpvar_8 = pow (tmpvar_3.w, _OutlinePower);
    finalColor_2.xyz = mix (_OutlineColor, tmpvar_7, vec4(tmpvar_8)).xyz;
  };
  finalColor_2.w = tmpvar_3.w;
  tmpvar_1 = finalColor_2;
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp int _EnableNoiseMap;
uniform sampler2D _NoiseMap;
uniform highp vec4 _NoiseMap_ST;
uniform mediump float _ColorShift;
uniform mediump float _SwayMax;
uniform mediump float _Amplitude;
uniform mediump float _Frequency;
uniform mediump float _IntrRadius;
uniform mediump float _IntrMaxWidth;
uniform mediump float _IntrSensitivity;
uniform highp vec3 _Positions[4];
uniform highp float _PositionArray;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_2.yw = _glesVertex.yw;
  tmpvar_3 = _glesColor;
  highp vec2 noise_4;
  highp float amplitude_6;
  highp float frequency_7;
  highp vec3 worldPos_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  worldPos_8 = tmpvar_10;
  frequency_7 = _Frequency;
  mediump float tmpvar_11;
  tmpvar_11 = (_glesColor.x * _Amplitude);
  amplitude_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = (_glesColor.y * 6.28319);
  tmpvar_2.x = (_glesVertex.x + ((
    sin(((_Time.x * frequency_7) + ((tmpvar_10.x * 0.31831) + tmpvar_12)))
   * amplitude_6) * _SwayMax));
  tmpvar_2.z = (_glesVertex.z + ((
    sin(((_Time.x * frequency_7) + ((tmpvar_10.z * 0.31831) + tmpvar_12)))
   * amplitude_6) * _SwayMax));
  for (highp int i_5 = 0; float(i_5) < _PositionArray; i_5++) {
    highp vec3 tmpvar_13;
    tmpvar_13 = (_Positions[i_5] - worldPos_8);
    mediump vec2 tmpvar_14;
    tmpvar_14 = vec2(-(_IntrMaxWidth));
    tmpvar_2.xz = (tmpvar_2.xz + ((tmpvar_2.y * _IntrSensitivity) * clamp (
      (((worldPos_8 - _Positions[i_5]) * (1.0 - clamp (
        (vec3(sqrt(dot (tmpvar_13, tmpvar_13))) / _IntrRadius)
      , 0.0, 1.0))).xz * tmpvar_3.x)
    , tmpvar_14, vec2(_IntrMaxWidth))));
  };
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_2.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  if (bool(_EnableNoiseMap)) {
    highp vec4 tmpvar_17;
    tmpvar_17.zw = vec2(0.0, 0.0);
    tmpvar_17.xy = (((tmpvar_10.xz + tmpvar_2.xz) * _NoiseMap_ST.xy) + _NoiseMap_ST.zw);
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2DLod (_NoiseMap, tmpvar_17.xy, 0.0);
    noise_4 = tmpvar_18.xy;
  };
  tmpvar_9.x = (_glesColor.x * noise_4.x);
  tmpvar_9.y = ((_glesColor.x * noise_4.y) * (_ColorShift * 2.4));
  xlv_TEXCOORD0 = tmpvar_1;
  gl_Position = tmpvar_15;
  xlv_COLOR0 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump float _AlphaClip;
uniform sampler2D _MainTex;
uniform mediump vec4 _TipsColor;
uniform mediump vec4 _RootColor;
uniform highp int _EnableOutline;
uniform mediump vec4 _OutlineColor;
uniform mediump float _OutlinePower;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 finalColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float x_4;
  x_4 = (tmpvar_3.w - _AlphaClip);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  tmpvar_5 = mix (_RootColor, _TipsColor, xlv_COLOR0.yyyy);
  finalColor_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = clamp ((finalColor_2 * (1.0 + 
    ((xlv_COLOR0.x - 0.5) * 0.5)
  )), 0.0, 1.0);
  finalColor_2 = tmpvar_6;
  if ((_EnableOutline > 0)) {
    highp vec4 tmpvar_7;
    tmpvar_7.w = 0.0;
    tmpvar_7.xyz = tmpvar_6.xyz;
    mediump float tmpvar_8;
    tmpvar_8 = pow (tmpvar_3.w, _OutlinePower);
    finalColor_2.xyz = mix (_OutlineColor, tmpvar_7, vec4(tmpvar_8)).xyz;
  };
  finalColor_2.w = tmpvar_3.w;
  tmpvar_1 = finalColor_2;
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp int _EnableNoiseMap;
uniform sampler2D _NoiseMap;
uniform highp vec4 _NoiseMap_ST;
uniform mediump float _ColorShift;
uniform mediump float _SwayMax;
uniform mediump float _Amplitude;
uniform mediump float _Frequency;
uniform mediump float _IntrRadius;
uniform mediump float _IntrMaxWidth;
uniform mediump float _IntrSensitivity;
uniform highp vec3 _Positions[4];
uniform highp float _PositionArray;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_2.yw = _glesVertex.yw;
  tmpvar_3 = _glesColor;
  highp vec2 noise_4;
  highp float amplitude_6;
  highp float frequency_7;
  highp vec3 worldPos_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  worldPos_8 = tmpvar_10;
  frequency_7 = _Frequency;
  mediump float tmpvar_11;
  tmpvar_11 = (_glesColor.x * _Amplitude);
  amplitude_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = (_glesColor.y * 6.28319);
  tmpvar_2.x = (_glesVertex.x + ((
    sin(((_Time.x * frequency_7) + ((tmpvar_10.x * 0.31831) + tmpvar_12)))
   * amplitude_6) * _SwayMax));
  tmpvar_2.z = (_glesVertex.z + ((
    sin(((_Time.x * frequency_7) + ((tmpvar_10.z * 0.31831) + tmpvar_12)))
   * amplitude_6) * _SwayMax));
  for (highp int i_5 = 0; float(i_5) < _PositionArray; i_5++) {
    highp vec3 tmpvar_13;
    tmpvar_13 = (_Positions[i_5] - worldPos_8);
    mediump vec2 tmpvar_14;
    tmpvar_14 = vec2(-(_IntrMaxWidth));
    tmpvar_2.xz = (tmpvar_2.xz + ((tmpvar_2.y * _IntrSensitivity) * clamp (
      (((worldPos_8 - _Positions[i_5]) * (1.0 - clamp (
        (vec3(sqrt(dot (tmpvar_13, tmpvar_13))) / _IntrRadius)
      , 0.0, 1.0))).xz * tmpvar_3.x)
    , tmpvar_14, vec2(_IntrMaxWidth))));
  };
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_2.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  if (bool(_EnableNoiseMap)) {
    highp vec4 tmpvar_17;
    tmpvar_17.zw = vec2(0.0, 0.0);
    tmpvar_17.xy = (((tmpvar_10.xz + tmpvar_2.xz) * _NoiseMap_ST.xy) + _NoiseMap_ST.zw);
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2DLod (_NoiseMap, tmpvar_17.xy, 0.0);
    noise_4 = tmpvar_18.xy;
  };
  tmpvar_9.x = (_glesColor.x * noise_4.x);
  tmpvar_9.y = ((_glesColor.x * noise_4.y) * (_ColorShift * 2.4));
  xlv_TEXCOORD0 = tmpvar_1;
  gl_Position = tmpvar_15;
  xlv_COLOR0 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump float _AlphaClip;
uniform sampler2D _MainTex;
uniform mediump vec4 _TipsColor;
uniform mediump vec4 _RootColor;
uniform highp int _EnableOutline;
uniform mediump vec4 _OutlineColor;
uniform mediump float _OutlinePower;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 finalColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float x_4;
  x_4 = (tmpvar_3.w - _AlphaClip);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  tmpvar_5 = mix (_RootColor, _TipsColor, xlv_COLOR0.yyyy);
  finalColor_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = clamp ((finalColor_2 * (1.0 + 
    ((xlv_COLOR0.x - 0.5) * 0.5)
  )), 0.0, 1.0);
  finalColor_2 = tmpvar_6;
  if ((_EnableOutline > 0)) {
    highp vec4 tmpvar_7;
    tmpvar_7.w = 0.0;
    tmpvar_7.xyz = tmpvar_6.xyz;
    mediump float tmpvar_8;
    tmpvar_8 = pow (tmpvar_3.w, _OutlinePower);
    finalColor_2.xyz = mix (_OutlineColor, tmpvar_7, vec4(tmpvar_8)).xyz;
  };
  finalColor_2.w = tmpvar_3.w;
  tmpvar_1 = finalColor_2;
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