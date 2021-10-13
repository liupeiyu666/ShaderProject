//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Smoke" {
Properties {
_DistortionTexture ("DistortionTexture", 2D) = "white" { }
_NoiseTexture ("NoiseTexture", 2D) = "white" { }
_SmokeShape ("SmokeShape", 2D) = "white" { }
_AlphaMultiplier ("AlphaMultiplier", Float) = 1
_LightColor ("LightColor", Color) = (0.097,0.097,0.097,0)
_RimColor ("RimColor", Color) = (0,0,0,0)
_DarkColor ("DarkColor", Color) = (0.038,0.038,0.038,0)
_SwirlItensity ("SwirlItensity", Float) = 0.05
_SmokeBrightness ("SmokeBrightness", Float) = 1
_FireNoise ("FireNoise", 2D) = "white" { }
_FireColor ("FireColor", Color) = (1,0.8985802,0.08088237,0)
[Toggle(_USEFIRE_ON)] _UseFire ("UseFire", Float) = 1
_DayColor ("DayColor", Color) = (1,1,1,1)
_texcoord ("", 2D) = "white" { }
__dirty ("", Float) = 1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 51298
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
uniform highp vec4 _texcoord_ST;
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShape;
uniform sampler2D _DistortionTexture;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform highp vec4 _FireColor;
uniform sampler2D _FireNoise;
uniform highp vec4 _FireNoise_ST;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTexture;
uniform highp vec4 _NoiseTexture_ST;
uniform highp float _AlphaMultiplier;
uniform mediump float _UseFire;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp vec4 staticSwitch92_7;
  highp vec4 tex2DNode27_8;
  highp vec4 tex2DNode2_9;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.x = xlv_TEXCOORD0.x;
  tmpvar_10.y = (1.0 - xlv_TEXCOORD0.y);
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0 * vec2(1.0, 2.0));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DistortionTexture, tmpvar_11);
  tex2DNode2_9 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.x = ((tex2DNode2_9.x * 2.0) - 1.0);
  tmpvar_13.y = ((2.0 * tex2DNode2_9.y) - 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _SwirlItensity);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_10 + tmpvar_14);
  highp vec4 tmpvar_16;
  tmpvar_16.zw = vec2(0.0, 0.0);
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (1.0 - tmpvar_15.y);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SmokeShape, tmpvar_16.xy);
  tex2DNode27_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (((
    mix (_DarkColor, _LightColor, tex2DNode27_8.xxxx)
   + 
    (_RimColor * tex2DNode27_8.y)
  ) * _SmokeBrightness) * tmpvar_4.y);
  highp vec2 tmpvar_19;
  tmpvar_19 = ((xlv_TEXCOORD0 * _FireNoise_ST.xy) + _FireNoise_ST.zw);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_FireNoise, tmpvar_19);
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_20.x * 
    (7.8 * tex2DNode27_8.z)
  ) - (-0.6 + 
    (tmpvar_4.x * 4.6)
  )), 0.0, 1.0);
  if ((_UseFire > 0.0)) {
    staticSwitch92_7 = ((_FireColor * tmpvar_21) + tmpvar_18);
  } else {
    staticSwitch92_7 = tmpvar_18;
  };
  tmpvar_5 = (staticSwitch92_7 * _DayColor).xyz;
  highp vec2 tmpvar_22;
  tmpvar_22 = ((xlv_TEXCOORD0 * _NoiseTexture_ST.xy) + _NoiseTexture_ST.zw);
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (1.0 - tmpvar_22.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 + tmpvar_14);
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (1.0 - tmpvar_24.y);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_NoiseTexture, tmpvar_25.xy);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DayColor.w * (
    (tex2DNode27_8.w * (tmpvar_26.x - (-0.5 + (tmpvar_4.w * 1.4))))
   * _AlphaMultiplier)), 0.0, 1.0);
  tmpvar_6 = tmpvar_27;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_28.w = tmpvar_6;
  c_1.w = tmpvar_28.w;
  c_1.xyz = tmpvar_5;
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
uniform highp vec4 _texcoord_ST;
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShape;
uniform sampler2D _DistortionTexture;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform highp vec4 _FireColor;
uniform sampler2D _FireNoise;
uniform highp vec4 _FireNoise_ST;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTexture;
uniform highp vec4 _NoiseTexture_ST;
uniform highp float _AlphaMultiplier;
uniform mediump float _UseFire;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp vec4 staticSwitch92_7;
  highp vec4 tex2DNode27_8;
  highp vec4 tex2DNode2_9;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.x = xlv_TEXCOORD0.x;
  tmpvar_10.y = (1.0 - xlv_TEXCOORD0.y);
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0 * vec2(1.0, 2.0));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DistortionTexture, tmpvar_11);
  tex2DNode2_9 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.x = ((tex2DNode2_9.x * 2.0) - 1.0);
  tmpvar_13.y = ((2.0 * tex2DNode2_9.y) - 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _SwirlItensity);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_10 + tmpvar_14);
  highp vec4 tmpvar_16;
  tmpvar_16.zw = vec2(0.0, 0.0);
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (1.0 - tmpvar_15.y);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SmokeShape, tmpvar_16.xy);
  tex2DNode27_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (((
    mix (_DarkColor, _LightColor, tex2DNode27_8.xxxx)
   + 
    (_RimColor * tex2DNode27_8.y)
  ) * _SmokeBrightness) * tmpvar_4.y);
  highp vec2 tmpvar_19;
  tmpvar_19 = ((xlv_TEXCOORD0 * _FireNoise_ST.xy) + _FireNoise_ST.zw);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_FireNoise, tmpvar_19);
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_20.x * 
    (7.8 * tex2DNode27_8.z)
  ) - (-0.6 + 
    (tmpvar_4.x * 4.6)
  )), 0.0, 1.0);
  if ((_UseFire > 0.0)) {
    staticSwitch92_7 = ((_FireColor * tmpvar_21) + tmpvar_18);
  } else {
    staticSwitch92_7 = tmpvar_18;
  };
  tmpvar_5 = (staticSwitch92_7 * _DayColor).xyz;
  highp vec2 tmpvar_22;
  tmpvar_22 = ((xlv_TEXCOORD0 * _NoiseTexture_ST.xy) + _NoiseTexture_ST.zw);
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (1.0 - tmpvar_22.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 + tmpvar_14);
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (1.0 - tmpvar_24.y);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_NoiseTexture, tmpvar_25.xy);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DayColor.w * (
    (tex2DNode27_8.w * (tmpvar_26.x - (-0.5 + (tmpvar_4.w * 1.4))))
   * _AlphaMultiplier)), 0.0, 1.0);
  tmpvar_6 = tmpvar_27;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_28.w = tmpvar_6;
  c_1.w = tmpvar_28.w;
  c_1.xyz = tmpvar_5;
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
uniform highp vec4 _texcoord_ST;
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShape;
uniform sampler2D _DistortionTexture;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform highp vec4 _FireColor;
uniform sampler2D _FireNoise;
uniform highp vec4 _FireNoise_ST;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTexture;
uniform highp vec4 _NoiseTexture_ST;
uniform highp float _AlphaMultiplier;
uniform mediump float _UseFire;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp vec4 staticSwitch92_7;
  highp vec4 tex2DNode27_8;
  highp vec4 tex2DNode2_9;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.x = xlv_TEXCOORD0.x;
  tmpvar_10.y = (1.0 - xlv_TEXCOORD0.y);
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0 * vec2(1.0, 2.0));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DistortionTexture, tmpvar_11);
  tex2DNode2_9 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.x = ((tex2DNode2_9.x * 2.0) - 1.0);
  tmpvar_13.y = ((2.0 * tex2DNode2_9.y) - 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _SwirlItensity);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_10 + tmpvar_14);
  highp vec4 tmpvar_16;
  tmpvar_16.zw = vec2(0.0, 0.0);
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (1.0 - tmpvar_15.y);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SmokeShape, tmpvar_16.xy);
  tex2DNode27_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (((
    mix (_DarkColor, _LightColor, tex2DNode27_8.xxxx)
   + 
    (_RimColor * tex2DNode27_8.y)
  ) * _SmokeBrightness) * tmpvar_4.y);
  highp vec2 tmpvar_19;
  tmpvar_19 = ((xlv_TEXCOORD0 * _FireNoise_ST.xy) + _FireNoise_ST.zw);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_FireNoise, tmpvar_19);
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_20.x * 
    (7.8 * tex2DNode27_8.z)
  ) - (-0.6 + 
    (tmpvar_4.x * 4.6)
  )), 0.0, 1.0);
  if ((_UseFire > 0.0)) {
    staticSwitch92_7 = ((_FireColor * tmpvar_21) + tmpvar_18);
  } else {
    staticSwitch92_7 = tmpvar_18;
  };
  tmpvar_5 = (staticSwitch92_7 * _DayColor).xyz;
  highp vec2 tmpvar_22;
  tmpvar_22 = ((xlv_TEXCOORD0 * _NoiseTexture_ST.xy) + _NoiseTexture_ST.zw);
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (1.0 - tmpvar_22.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 + tmpvar_14);
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (1.0 - tmpvar_24.y);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_NoiseTexture, tmpvar_25.xy);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DayColor.w * (
    (tex2DNode27_8.w * (tmpvar_26.x - (-0.5 + (tmpvar_4.w * 1.4))))
   * _AlphaMultiplier)), 0.0, 1.0);
  tmpvar_6 = tmpvar_27;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_28.w = tmpvar_6;
  c_1.w = tmpvar_28.w;
  c_1.xyz = tmpvar_5;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShape;
uniform sampler2D _DistortionTexture;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform highp vec4 _FireColor;
uniform sampler2D _FireNoise;
uniform highp vec4 _FireNoise_ST;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTexture;
uniform highp vec4 _NoiseTexture_ST;
uniform highp float _AlphaMultiplier;
uniform mediump float _UseFire;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp vec4 staticSwitch92_7;
  highp vec4 tex2DNode27_8;
  highp vec4 tex2DNode2_9;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.x = xlv_TEXCOORD0.x;
  tmpvar_10.y = (1.0 - xlv_TEXCOORD0.y);
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0 * vec2(1.0, 2.0));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DistortionTexture, tmpvar_11);
  tex2DNode2_9 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.x = ((tex2DNode2_9.x * 2.0) - 1.0);
  tmpvar_13.y = ((2.0 * tex2DNode2_9.y) - 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _SwirlItensity);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_10 + tmpvar_14);
  highp vec4 tmpvar_16;
  tmpvar_16.zw = vec2(0.0, 0.0);
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (1.0 - tmpvar_15.y);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SmokeShape, tmpvar_16.xy);
  tex2DNode27_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (((
    mix (_DarkColor, _LightColor, tex2DNode27_8.xxxx)
   + 
    (_RimColor * tex2DNode27_8.y)
  ) * _SmokeBrightness) * tmpvar_4.y);
  highp vec2 tmpvar_19;
  tmpvar_19 = ((xlv_TEXCOORD0 * _FireNoise_ST.xy) + _FireNoise_ST.zw);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_FireNoise, tmpvar_19);
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_20.x * 
    (7.8 * tex2DNode27_8.z)
  ) - (-0.6 + 
    (tmpvar_4.x * 4.6)
  )), 0.0, 1.0);
  if ((_UseFire > 0.0)) {
    staticSwitch92_7 = ((_FireColor * tmpvar_21) + tmpvar_18);
  } else {
    staticSwitch92_7 = tmpvar_18;
  };
  tmpvar_5 = (staticSwitch92_7 * _DayColor).xyz;
  highp vec2 tmpvar_22;
  tmpvar_22 = ((xlv_TEXCOORD0 * _NoiseTexture_ST.xy) + _NoiseTexture_ST.zw);
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (1.0 - tmpvar_22.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 + tmpvar_14);
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (1.0 - tmpvar_24.y);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_NoiseTexture, tmpvar_25.xy);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DayColor.w * (
    (tex2DNode27_8.w * (tmpvar_26.x - (-0.5 + (tmpvar_4.w * 1.4))))
   * _AlphaMultiplier)), 0.0, 1.0);
  tmpvar_6 = tmpvar_27;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_28.w = tmpvar_6;
  c_1.w = tmpvar_28.w;
  c_1.xyz = tmpvar_5;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShape;
uniform sampler2D _DistortionTexture;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform highp vec4 _FireColor;
uniform sampler2D _FireNoise;
uniform highp vec4 _FireNoise_ST;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTexture;
uniform highp vec4 _NoiseTexture_ST;
uniform highp float _AlphaMultiplier;
uniform mediump float _UseFire;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp vec4 staticSwitch92_7;
  highp vec4 tex2DNode27_8;
  highp vec4 tex2DNode2_9;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.x = xlv_TEXCOORD0.x;
  tmpvar_10.y = (1.0 - xlv_TEXCOORD0.y);
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0 * vec2(1.0, 2.0));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DistortionTexture, tmpvar_11);
  tex2DNode2_9 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.x = ((tex2DNode2_9.x * 2.0) - 1.0);
  tmpvar_13.y = ((2.0 * tex2DNode2_9.y) - 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _SwirlItensity);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_10 + tmpvar_14);
  highp vec4 tmpvar_16;
  tmpvar_16.zw = vec2(0.0, 0.0);
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (1.0 - tmpvar_15.y);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SmokeShape, tmpvar_16.xy);
  tex2DNode27_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (((
    mix (_DarkColor, _LightColor, tex2DNode27_8.xxxx)
   + 
    (_RimColor * tex2DNode27_8.y)
  ) * _SmokeBrightness) * tmpvar_4.y);
  highp vec2 tmpvar_19;
  tmpvar_19 = ((xlv_TEXCOORD0 * _FireNoise_ST.xy) + _FireNoise_ST.zw);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_FireNoise, tmpvar_19);
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_20.x * 
    (7.8 * tex2DNode27_8.z)
  ) - (-0.6 + 
    (tmpvar_4.x * 4.6)
  )), 0.0, 1.0);
  if ((_UseFire > 0.0)) {
    staticSwitch92_7 = ((_FireColor * tmpvar_21) + tmpvar_18);
  } else {
    staticSwitch92_7 = tmpvar_18;
  };
  tmpvar_5 = (staticSwitch92_7 * _DayColor).xyz;
  highp vec2 tmpvar_22;
  tmpvar_22 = ((xlv_TEXCOORD0 * _NoiseTexture_ST.xy) + _NoiseTexture_ST.zw);
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (1.0 - tmpvar_22.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 + tmpvar_14);
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (1.0 - tmpvar_24.y);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_NoiseTexture, tmpvar_25.xy);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DayColor.w * (
    (tex2DNode27_8.w * (tmpvar_26.x - (-0.5 + (tmpvar_4.w * 1.4))))
   * _AlphaMultiplier)), 0.0, 1.0);
  tmpvar_6 = tmpvar_27;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_28.w = tmpvar_6;
  c_1.w = tmpvar_28.w;
  c_1.xyz = tmpvar_5;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShape;
uniform sampler2D _DistortionTexture;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform highp vec4 _FireColor;
uniform sampler2D _FireNoise;
uniform highp vec4 _FireNoise_ST;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTexture;
uniform highp vec4 _NoiseTexture_ST;
uniform highp float _AlphaMultiplier;
uniform mediump float _UseFire;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp vec4 staticSwitch92_7;
  highp vec4 tex2DNode27_8;
  highp vec4 tex2DNode2_9;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.x = xlv_TEXCOORD0.x;
  tmpvar_10.y = (1.0 - xlv_TEXCOORD0.y);
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0 * vec2(1.0, 2.0));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DistortionTexture, tmpvar_11);
  tex2DNode2_9 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.zw = vec2(0.0, 0.0);
  tmpvar_13.x = ((tex2DNode2_9.x * 2.0) - 1.0);
  tmpvar_13.y = ((2.0 * tex2DNode2_9.y) - 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _SwirlItensity);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_10 + tmpvar_14);
  highp vec4 tmpvar_16;
  tmpvar_16.zw = vec2(0.0, 0.0);
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (1.0 - tmpvar_15.y);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SmokeShape, tmpvar_16.xy);
  tex2DNode27_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (((
    mix (_DarkColor, _LightColor, tex2DNode27_8.xxxx)
   + 
    (_RimColor * tex2DNode27_8.y)
  ) * _SmokeBrightness) * tmpvar_4.y);
  highp vec2 tmpvar_19;
  tmpvar_19 = ((xlv_TEXCOORD0 * _FireNoise_ST.xy) + _FireNoise_ST.zw);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_FireNoise, tmpvar_19);
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_20.x * 
    (7.8 * tex2DNode27_8.z)
  ) - (-0.6 + 
    (tmpvar_4.x * 4.6)
  )), 0.0, 1.0);
  if ((_UseFire > 0.0)) {
    staticSwitch92_7 = ((_FireColor * tmpvar_21) + tmpvar_18);
  } else {
    staticSwitch92_7 = tmpvar_18;
  };
  tmpvar_5 = (staticSwitch92_7 * _DayColor).xyz;
  highp vec2 tmpvar_22;
  tmpvar_22 = ((xlv_TEXCOORD0 * _NoiseTexture_ST.xy) + _NoiseTexture_ST.zw);
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (1.0 - tmpvar_22.y);
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 + tmpvar_14);
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (1.0 - tmpvar_24.y);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_NoiseTexture, tmpvar_25.xy);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((_DayColor.w * (
    (tex2DNode27_8.w * (tmpvar_26.x - (-0.5 + (tmpvar_4.w * 1.4))))
   * _AlphaMultiplier)), 0.0, 1.0);
  tmpvar_6 = tmpvar_27;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_28.w = tmpvar_6;
  c_1.w = tmpvar_28.w;
  c_1.xyz = tmpvar_5;
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
}
CustomEditor "MiHoYoMaterialInspector"
}