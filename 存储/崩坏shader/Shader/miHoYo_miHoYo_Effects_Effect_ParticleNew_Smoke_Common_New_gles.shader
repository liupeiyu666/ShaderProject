//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Smoke_Common_New" {
Properties {
_LightColor ("LightColor", Color) = (0.097,0.097,0.097,0)
_DarkColor ("DarkColor", Color) = (0.038,0.038,0.038,0)
_RimColor ("RimColor", Color) = (0.5441177,0.5441177,0.5441177,0)
_SmokeBrightness ("SmokeBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
_SmokeShapeTex ("SmokeShapeTex", 2D) = "white" { }
_DistortionTex ("DistortionTex", 2D) = "white" { }
_SwirlItensity ("SwirlItensity", Float) = 0.05
_NoiseTex ("NoiseTex", 2D) = "white" { }
_DissolveDistortionNoiseTex ("DissolveDistortionNoiseTex", 2D) = "black" { }
_DissolveDistortionNoise_USpeed ("DissolveDistortionNoise_USpeed", Float) = 0
_DissolveDistortionNoise_VSpeed ("DissolveDistortionNoise_VSpeed", Float) = 0
_DistortionNoiseBrightness ("DistortionNoiseBrightness", Float) = 0
[Toggle(_FIRETOGGLE_ON)] _FireToggle ("FireToggle", Float) = 0
_FireColor ("FireColor", Color) = (1,0.8985802,0.08088237,0)
[MHYToggle] _CustomeFireColorToggle ("CustomeFireColorToggle", Float) = 0
_FireNoiseTex ("FireNoiseTex", 2D) = "white" { }
_DayColor ("DayColor", Color) = (1,1,1,1)
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "MAIN"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 17099
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShapeTex;
uniform highp vec4 _SmokeShapeTex_ST;
uniform sampler2D _DistortionTex;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _DissolveDistortionNoiseTex;
uniform highp float _DissolveDistortionNoise_USpeed;
uniform highp vec4 _DissolveDistortionNoiseTex_ST;
uniform highp float _DissolveDistortionNoise_VSpeed;
uniform highp float _DistortionNoiseBrightness;
uniform highp float _AlphaBrightness;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 aseOutColor_2;
  highp vec4 tex2DNode27_3;
  highp vec4 tex2DNode2_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _SmokeShapeTex_ST.xy) + _SmokeShapeTex_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (1.0 - tmpvar_5.y);
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DistortionTex, tmpvar_7);
  tex2DNode2_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tex2DNode2_4.x * 2.0) - 1.0);
  tmpvar_9.y = ((2.0 * tex2DNode2_4.y) - 1.0);
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _SwirlItensity);
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_6 + tmpvar_10);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (1.0 - tmpvar_11.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_SmokeShapeTex, tmpvar_12);
  tex2DNode27_3 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (1.0 - tmpvar_14.y);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15 + tmpvar_10);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (1.0 - tmpvar_16.y);
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy) + _DissolveDistortionNoiseTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = ((_Time.y * _DissolveDistortionNoise_USpeed) + tmpvar_18.x);
  tmpvar_19.y = (tmpvar_18.y + (_Time.y * _DissolveDistortionNoise_VSpeed));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_DissolveDistortionNoiseTex, tmpvar_19);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_17 + (tmpvar_20.x * _DistortionNoiseBrightness));
  tmpvar_21 = texture2D (_NoiseTex, P_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = (((
    (mix (_DarkColor, _LightColor, tex2DNode27_3.xxxx) + (_RimColor * tex2DNode27_3.z))
   * _SmokeBrightness) * xlv_COLOR.y) * _DayColor).xyz;
  aseOutColor_2 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DayColor.w * (
    (xlv_COLOR.z * (tex2DNode27_3.w * (tmpvar_21.x - (-0.5 + 
      (xlv_COLOR.w * 1.4)
    ))))
   * _AlphaBrightness)), 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = aseOutColor_2;
  tmpvar_25.w = aseOutAlpha_1;
  gl_FragData[0] = tmpvar_25;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShapeTex;
uniform highp vec4 _SmokeShapeTex_ST;
uniform sampler2D _DistortionTex;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _DissolveDistortionNoiseTex;
uniform highp float _DissolveDistortionNoise_USpeed;
uniform highp vec4 _DissolveDistortionNoiseTex_ST;
uniform highp float _DissolveDistortionNoise_VSpeed;
uniform highp float _DistortionNoiseBrightness;
uniform highp float _AlphaBrightness;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 aseOutColor_2;
  highp vec4 tex2DNode27_3;
  highp vec4 tex2DNode2_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _SmokeShapeTex_ST.xy) + _SmokeShapeTex_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (1.0 - tmpvar_5.y);
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DistortionTex, tmpvar_7);
  tex2DNode2_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tex2DNode2_4.x * 2.0) - 1.0);
  tmpvar_9.y = ((2.0 * tex2DNode2_4.y) - 1.0);
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _SwirlItensity);
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_6 + tmpvar_10);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (1.0 - tmpvar_11.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_SmokeShapeTex, tmpvar_12);
  tex2DNode27_3 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (1.0 - tmpvar_14.y);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15 + tmpvar_10);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (1.0 - tmpvar_16.y);
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy) + _DissolveDistortionNoiseTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = ((_Time.y * _DissolveDistortionNoise_USpeed) + tmpvar_18.x);
  tmpvar_19.y = (tmpvar_18.y + (_Time.y * _DissolveDistortionNoise_VSpeed));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_DissolveDistortionNoiseTex, tmpvar_19);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_17 + (tmpvar_20.x * _DistortionNoiseBrightness));
  tmpvar_21 = texture2D (_NoiseTex, P_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = (((
    (mix (_DarkColor, _LightColor, tex2DNode27_3.xxxx) + (_RimColor * tex2DNode27_3.z))
   * _SmokeBrightness) * xlv_COLOR.y) * _DayColor).xyz;
  aseOutColor_2 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DayColor.w * (
    (xlv_COLOR.z * (tex2DNode27_3.w * (tmpvar_21.x - (-0.5 + 
      (xlv_COLOR.w * 1.4)
    ))))
   * _AlphaBrightness)), 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = aseOutColor_2;
  tmpvar_25.w = aseOutAlpha_1;
  gl_FragData[0] = tmpvar_25;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShapeTex;
uniform highp vec4 _SmokeShapeTex_ST;
uniform sampler2D _DistortionTex;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _DissolveDistortionNoiseTex;
uniform highp float _DissolveDistortionNoise_USpeed;
uniform highp vec4 _DissolveDistortionNoiseTex_ST;
uniform highp float _DissolveDistortionNoise_VSpeed;
uniform highp float _DistortionNoiseBrightness;
uniform highp float _AlphaBrightness;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 aseOutColor_2;
  highp vec4 tex2DNode27_3;
  highp vec4 tex2DNode2_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _SmokeShapeTex_ST.xy) + _SmokeShapeTex_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (1.0 - tmpvar_5.y);
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DistortionTex, tmpvar_7);
  tex2DNode2_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tex2DNode2_4.x * 2.0) - 1.0);
  tmpvar_9.y = ((2.0 * tex2DNode2_4.y) - 1.0);
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _SwirlItensity);
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_6 + tmpvar_10);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (1.0 - tmpvar_11.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_SmokeShapeTex, tmpvar_12);
  tex2DNode27_3 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (1.0 - tmpvar_14.y);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15 + tmpvar_10);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (1.0 - tmpvar_16.y);
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy) + _DissolveDistortionNoiseTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = ((_Time.y * _DissolveDistortionNoise_USpeed) + tmpvar_18.x);
  tmpvar_19.y = (tmpvar_18.y + (_Time.y * _DissolveDistortionNoise_VSpeed));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_DissolveDistortionNoiseTex, tmpvar_19);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_17 + (tmpvar_20.x * _DistortionNoiseBrightness));
  tmpvar_21 = texture2D (_NoiseTex, P_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = (((
    (mix (_DarkColor, _LightColor, tex2DNode27_3.xxxx) + (_RimColor * tex2DNode27_3.z))
   * _SmokeBrightness) * xlv_COLOR.y) * _DayColor).xyz;
  aseOutColor_2 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DayColor.w * (
    (xlv_COLOR.z * (tex2DNode27_3.w * (tmpvar_21.x - (-0.5 + 
      (xlv_COLOR.w * 1.4)
    ))))
   * _AlphaBrightness)), 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = aseOutColor_2;
  tmpvar_25.w = aseOutAlpha_1;
  gl_FragData[0] = tmpvar_25;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_FIRETOGGLE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShapeTex;
uniform highp vec4 _SmokeShapeTex_ST;
uniform sampler2D _DistortionTex;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform mediump float _CustomeFireColorToggle;
uniform highp vec4 _FireColor;
uniform sampler2D _FireNoiseTex;
uniform highp vec4 _FireNoiseTex_ST;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _DissolveDistortionNoiseTex;
uniform highp float _DissolveDistortionNoise_USpeed;
uniform highp vec4 _DissolveDistortionNoiseTex_ST;
uniform highp float _DissolveDistortionNoise_VSpeed;
uniform highp float _DistortionNoiseBrightness;
uniform highp float _AlphaBrightness;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 aseOutColor_2;
  highp vec4 staticSwitch105_3;
  highp vec4 uv103_4;
  highp vec4 tex2DNode27_5;
  highp vec4 tex2DNode2_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _SmokeShapeTex_ST.xy) + _SmokeShapeTex_ST.zw);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (1.0 - tmpvar_7.y);
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_DistortionTex, tmpvar_9);
  tex2DNode2_6 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((tex2DNode2_6.x * 2.0) - 1.0);
  tmpvar_11.y = ((2.0 * tex2DNode2_6.y) - 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * _SwirlItensity);
  highp vec2 tmpvar_13;
  tmpvar_13 = (tmpvar_8 + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (1.0 - tmpvar_13.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_SmokeShapeTex, tmpvar_14);
  tex2DNode27_5 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (((
    mix (_DarkColor, _LightColor, tex2DNode27_5.xxxx)
   + 
    (_RimColor * tex2DNode27_5.z)
  ) * _SmokeBrightness) * xlv_COLOR.y);
  uv103_4.zw = xlv_TEXCOORD1.zw;
  uv103_4.xy = xlv_TEXCOORD1.xy;
  staticSwitch105_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_CustomeFireColorToggle == 1.0)) {
    staticSwitch105_3 = uv103_4;
  } else {
    staticSwitch105_3 = _FireColor;
  };
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _FireNoiseTex_ST.xy) + _FireNoiseTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FireNoiseTex, tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (1.0 - tmpvar_19.y);
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_20 + tmpvar_12);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (1.0 - tmpvar_21.y);
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy) + _DissolveDistortionNoiseTex_ST.zw);
  highp vec2 tmpvar_24;
  tmpvar_24.x = ((_Time.y * _DissolveDistortionNoise_USpeed) + tmpvar_23.x);
  tmpvar_24.y = (tmpvar_23.y + (_Time.y * _DissolveDistortionNoise_VSpeed));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_DissolveDistortionNoiseTex, tmpvar_24);
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (tmpvar_22 + (tmpvar_25.x * _DistortionNoiseBrightness));
  tmpvar_26 = texture2D (_NoiseTex, P_27);
  highp vec3 tmpvar_28;
  tmpvar_28 = (((staticSwitch105_3 * 
    clamp (((tmpvar_18.x * (7.0 * tex2DNode27_5.y)) - (-0.6 + (xlv_COLOR.x * 4.6))), 0.0, 1.0)
  ) + tmpvar_16) * _DayColor).xyz;
  aseOutColor_2 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp ((_DayColor.w * (
    (xlv_COLOR.z * (tex2DNode27_5.w * (tmpvar_26.x - (-0.5 + 
      (xlv_COLOR.w * 1.4)
    ))))
   * _AlphaBrightness)), 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = aseOutColor_2;
  tmpvar_30.w = aseOutAlpha_1;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_FIRETOGGLE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShapeTex;
uniform highp vec4 _SmokeShapeTex_ST;
uniform sampler2D _DistortionTex;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform mediump float _CustomeFireColorToggle;
uniform highp vec4 _FireColor;
uniform sampler2D _FireNoiseTex;
uniform highp vec4 _FireNoiseTex_ST;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _DissolveDistortionNoiseTex;
uniform highp float _DissolveDistortionNoise_USpeed;
uniform highp vec4 _DissolveDistortionNoiseTex_ST;
uniform highp float _DissolveDistortionNoise_VSpeed;
uniform highp float _DistortionNoiseBrightness;
uniform highp float _AlphaBrightness;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 aseOutColor_2;
  highp vec4 staticSwitch105_3;
  highp vec4 uv103_4;
  highp vec4 tex2DNode27_5;
  highp vec4 tex2DNode2_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _SmokeShapeTex_ST.xy) + _SmokeShapeTex_ST.zw);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (1.0 - tmpvar_7.y);
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_DistortionTex, tmpvar_9);
  tex2DNode2_6 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((tex2DNode2_6.x * 2.0) - 1.0);
  tmpvar_11.y = ((2.0 * tex2DNode2_6.y) - 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * _SwirlItensity);
  highp vec2 tmpvar_13;
  tmpvar_13 = (tmpvar_8 + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (1.0 - tmpvar_13.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_SmokeShapeTex, tmpvar_14);
  tex2DNode27_5 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (((
    mix (_DarkColor, _LightColor, tex2DNode27_5.xxxx)
   + 
    (_RimColor * tex2DNode27_5.z)
  ) * _SmokeBrightness) * xlv_COLOR.y);
  uv103_4.zw = xlv_TEXCOORD1.zw;
  uv103_4.xy = xlv_TEXCOORD1.xy;
  staticSwitch105_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_CustomeFireColorToggle == 1.0)) {
    staticSwitch105_3 = uv103_4;
  } else {
    staticSwitch105_3 = _FireColor;
  };
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _FireNoiseTex_ST.xy) + _FireNoiseTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FireNoiseTex, tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (1.0 - tmpvar_19.y);
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_20 + tmpvar_12);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (1.0 - tmpvar_21.y);
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy) + _DissolveDistortionNoiseTex_ST.zw);
  highp vec2 tmpvar_24;
  tmpvar_24.x = ((_Time.y * _DissolveDistortionNoise_USpeed) + tmpvar_23.x);
  tmpvar_24.y = (tmpvar_23.y + (_Time.y * _DissolveDistortionNoise_VSpeed));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_DissolveDistortionNoiseTex, tmpvar_24);
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (tmpvar_22 + (tmpvar_25.x * _DistortionNoiseBrightness));
  tmpvar_26 = texture2D (_NoiseTex, P_27);
  highp vec3 tmpvar_28;
  tmpvar_28 = (((staticSwitch105_3 * 
    clamp (((tmpvar_18.x * (7.0 * tex2DNode27_5.y)) - (-0.6 + (xlv_COLOR.x * 4.6))), 0.0, 1.0)
  ) + tmpvar_16) * _DayColor).xyz;
  aseOutColor_2 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp ((_DayColor.w * (
    (xlv_COLOR.z * (tex2DNode27_5.w * (tmpvar_26.x - (-0.5 + 
      (xlv_COLOR.w * 1.4)
    ))))
   * _AlphaBrightness)), 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = aseOutColor_2;
  tmpvar_30.w = aseOutAlpha_1;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_FIRETOGGLE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShapeTex;
uniform highp vec4 _SmokeShapeTex_ST;
uniform sampler2D _DistortionTex;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform mediump float _CustomeFireColorToggle;
uniform highp vec4 _FireColor;
uniform sampler2D _FireNoiseTex;
uniform highp vec4 _FireNoiseTex_ST;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _DissolveDistortionNoiseTex;
uniform highp float _DissolveDistortionNoise_USpeed;
uniform highp vec4 _DissolveDistortionNoiseTex_ST;
uniform highp float _DissolveDistortionNoise_VSpeed;
uniform highp float _DistortionNoiseBrightness;
uniform highp float _AlphaBrightness;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 aseOutColor_2;
  highp vec4 staticSwitch105_3;
  highp vec4 uv103_4;
  highp vec4 tex2DNode27_5;
  highp vec4 tex2DNode2_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _SmokeShapeTex_ST.xy) + _SmokeShapeTex_ST.zw);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (1.0 - tmpvar_7.y);
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_DistortionTex, tmpvar_9);
  tex2DNode2_6 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((tex2DNode2_6.x * 2.0) - 1.0);
  tmpvar_11.y = ((2.0 * tex2DNode2_6.y) - 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * _SwirlItensity);
  highp vec2 tmpvar_13;
  tmpvar_13 = (tmpvar_8 + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (1.0 - tmpvar_13.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_SmokeShapeTex, tmpvar_14);
  tex2DNode27_5 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (((
    mix (_DarkColor, _LightColor, tex2DNode27_5.xxxx)
   + 
    (_RimColor * tex2DNode27_5.z)
  ) * _SmokeBrightness) * xlv_COLOR.y);
  uv103_4.zw = xlv_TEXCOORD1.zw;
  uv103_4.xy = xlv_TEXCOORD1.xy;
  staticSwitch105_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_CustomeFireColorToggle == 1.0)) {
    staticSwitch105_3 = uv103_4;
  } else {
    staticSwitch105_3 = _FireColor;
  };
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _FireNoiseTex_ST.xy) + _FireNoiseTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FireNoiseTex, tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (1.0 - tmpvar_19.y);
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_20 + tmpvar_12);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (1.0 - tmpvar_21.y);
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy) + _DissolveDistortionNoiseTex_ST.zw);
  highp vec2 tmpvar_24;
  tmpvar_24.x = ((_Time.y * _DissolveDistortionNoise_USpeed) + tmpvar_23.x);
  tmpvar_24.y = (tmpvar_23.y + (_Time.y * _DissolveDistortionNoise_VSpeed));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_DissolveDistortionNoiseTex, tmpvar_24);
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (tmpvar_22 + (tmpvar_25.x * _DistortionNoiseBrightness));
  tmpvar_26 = texture2D (_NoiseTex, P_27);
  highp vec3 tmpvar_28;
  tmpvar_28 = (((staticSwitch105_3 * 
    clamp (((tmpvar_18.x * (7.0 * tex2DNode27_5.y)) - (-0.6 + (xlv_COLOR.x * 4.6))), 0.0, 1.0)
  ) + tmpvar_16) * _DayColor).xyz;
  aseOutColor_2 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp ((_DayColor.w * (
    (xlv_COLOR.z * (tex2DNode27_5.w * (tmpvar_26.x - (-0.5 + 
      (xlv_COLOR.w * 1.4)
    ))))
   * _AlphaBrightness)), 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = aseOutColor_2;
  tmpvar_30.w = aseOutAlpha_1;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShapeTex;
uniform highp vec4 _SmokeShapeTex_ST;
uniform sampler2D _DistortionTex;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _DissolveDistortionNoiseTex;
uniform highp float _DissolveDistortionNoise_USpeed;
uniform highp vec4 _DissolveDistortionNoiseTex_ST;
uniform highp float _DissolveDistortionNoise_VSpeed;
uniform highp float _DistortionNoiseBrightness;
uniform highp float _AlphaBrightness;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 aseOutColor_2;
  highp vec4 tex2DNode27_3;
  highp vec4 tex2DNode2_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _SmokeShapeTex_ST.xy) + _SmokeShapeTex_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (1.0 - tmpvar_5.y);
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DistortionTex, tmpvar_7);
  tex2DNode2_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tex2DNode2_4.x * 2.0) - 1.0);
  tmpvar_9.y = ((2.0 * tex2DNode2_4.y) - 1.0);
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _SwirlItensity);
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_6 + tmpvar_10);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (1.0 - tmpvar_11.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_SmokeShapeTex, tmpvar_12);
  tex2DNode27_3 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (1.0 - tmpvar_14.y);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15 + tmpvar_10);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (1.0 - tmpvar_16.y);
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy) + _DissolveDistortionNoiseTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = ((_Time.y * _DissolveDistortionNoise_USpeed) + tmpvar_18.x);
  tmpvar_19.y = (tmpvar_18.y + (_Time.y * _DissolveDistortionNoise_VSpeed));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_DissolveDistortionNoiseTex, tmpvar_19);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_17 + (tmpvar_20.x * _DistortionNoiseBrightness));
  tmpvar_21 = texture2D (_NoiseTex, P_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = (((
    (mix (_DarkColor, _LightColor, tex2DNode27_3.xxxx) + (_RimColor * tex2DNode27_3.z))
   * _SmokeBrightness) * xlv_COLOR.y) * _DayColor).xyz;
  aseOutColor_2 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DayColor.w * (
    (xlv_COLOR.z * (tex2DNode27_3.w * (tmpvar_21.x - (-0.5 + 
      (xlv_COLOR.w * 1.4)
    ))))
   * _AlphaBrightness)), 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_24;
  aseOutColor_2 = mix (aseOutColor_2, vec3(dot (aseOutColor_2, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = aseOutColor_2;
  tmpvar_25.w = aseOutAlpha_1;
  gl_FragData[0] = tmpvar_25;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShapeTex;
uniform highp vec4 _SmokeShapeTex_ST;
uniform sampler2D _DistortionTex;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _DissolveDistortionNoiseTex;
uniform highp float _DissolveDistortionNoise_USpeed;
uniform highp vec4 _DissolveDistortionNoiseTex_ST;
uniform highp float _DissolveDistortionNoise_VSpeed;
uniform highp float _DistortionNoiseBrightness;
uniform highp float _AlphaBrightness;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 aseOutColor_2;
  highp vec4 tex2DNode27_3;
  highp vec4 tex2DNode2_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _SmokeShapeTex_ST.xy) + _SmokeShapeTex_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (1.0 - tmpvar_5.y);
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DistortionTex, tmpvar_7);
  tex2DNode2_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tex2DNode2_4.x * 2.0) - 1.0);
  tmpvar_9.y = ((2.0 * tex2DNode2_4.y) - 1.0);
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _SwirlItensity);
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_6 + tmpvar_10);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (1.0 - tmpvar_11.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_SmokeShapeTex, tmpvar_12);
  tex2DNode27_3 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (1.0 - tmpvar_14.y);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15 + tmpvar_10);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (1.0 - tmpvar_16.y);
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy) + _DissolveDistortionNoiseTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = ((_Time.y * _DissolveDistortionNoise_USpeed) + tmpvar_18.x);
  tmpvar_19.y = (tmpvar_18.y + (_Time.y * _DissolveDistortionNoise_VSpeed));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_DissolveDistortionNoiseTex, tmpvar_19);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_17 + (tmpvar_20.x * _DistortionNoiseBrightness));
  tmpvar_21 = texture2D (_NoiseTex, P_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = (((
    (mix (_DarkColor, _LightColor, tex2DNode27_3.xxxx) + (_RimColor * tex2DNode27_3.z))
   * _SmokeBrightness) * xlv_COLOR.y) * _DayColor).xyz;
  aseOutColor_2 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DayColor.w * (
    (xlv_COLOR.z * (tex2DNode27_3.w * (tmpvar_21.x - (-0.5 + 
      (xlv_COLOR.w * 1.4)
    ))))
   * _AlphaBrightness)), 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_24;
  aseOutColor_2 = mix (aseOutColor_2, vec3(dot (aseOutColor_2, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = aseOutColor_2;
  tmpvar_25.w = aseOutAlpha_1;
  gl_FragData[0] = tmpvar_25;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShapeTex;
uniform highp vec4 _SmokeShapeTex_ST;
uniform sampler2D _DistortionTex;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _DissolveDistortionNoiseTex;
uniform highp float _DissolveDistortionNoise_USpeed;
uniform highp vec4 _DissolveDistortionNoiseTex_ST;
uniform highp float _DissolveDistortionNoise_VSpeed;
uniform highp float _DistortionNoiseBrightness;
uniform highp float _AlphaBrightness;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 aseOutColor_2;
  highp vec4 tex2DNode27_3;
  highp vec4 tex2DNode2_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _SmokeShapeTex_ST.xy) + _SmokeShapeTex_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (1.0 - tmpvar_5.y);
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_DistortionTex, tmpvar_7);
  tex2DNode2_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((tex2DNode2_4.x * 2.0) - 1.0);
  tmpvar_9.y = ((2.0 * tex2DNode2_4.y) - 1.0);
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _SwirlItensity);
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_6 + tmpvar_10);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (1.0 - tmpvar_11.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_SmokeShapeTex, tmpvar_12);
  tex2DNode27_3 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (1.0 - tmpvar_14.y);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15 + tmpvar_10);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (1.0 - tmpvar_16.y);
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy) + _DissolveDistortionNoiseTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = ((_Time.y * _DissolveDistortionNoise_USpeed) + tmpvar_18.x);
  tmpvar_19.y = (tmpvar_18.y + (_Time.y * _DissolveDistortionNoise_VSpeed));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_DissolveDistortionNoiseTex, tmpvar_19);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_17 + (tmpvar_20.x * _DistortionNoiseBrightness));
  tmpvar_21 = texture2D (_NoiseTex, P_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = (((
    (mix (_DarkColor, _LightColor, tex2DNode27_3.xxxx) + (_RimColor * tex2DNode27_3.z))
   * _SmokeBrightness) * xlv_COLOR.y) * _DayColor).xyz;
  aseOutColor_2 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp ((_DayColor.w * (
    (xlv_COLOR.z * (tex2DNode27_3.w * (tmpvar_21.x - (-0.5 + 
      (xlv_COLOR.w * 1.4)
    ))))
   * _AlphaBrightness)), 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_24;
  aseOutColor_2 = mix (aseOutColor_2, vec3(dot (aseOutColor_2, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = aseOutColor_2;
  tmpvar_25.w = aseOutAlpha_1;
  gl_FragData[0] = tmpvar_25;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_FIRETOGGLE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShapeTex;
uniform highp vec4 _SmokeShapeTex_ST;
uniform sampler2D _DistortionTex;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform mediump float _CustomeFireColorToggle;
uniform highp vec4 _FireColor;
uniform sampler2D _FireNoiseTex;
uniform highp vec4 _FireNoiseTex_ST;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _DissolveDistortionNoiseTex;
uniform highp float _DissolveDistortionNoise_USpeed;
uniform highp vec4 _DissolveDistortionNoiseTex_ST;
uniform highp float _DissolveDistortionNoise_VSpeed;
uniform highp float _DistortionNoiseBrightness;
uniform highp float _AlphaBrightness;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 aseOutColor_2;
  highp vec4 staticSwitch105_3;
  highp vec4 uv103_4;
  highp vec4 tex2DNode27_5;
  highp vec4 tex2DNode2_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _SmokeShapeTex_ST.xy) + _SmokeShapeTex_ST.zw);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (1.0 - tmpvar_7.y);
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_DistortionTex, tmpvar_9);
  tex2DNode2_6 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((tex2DNode2_6.x * 2.0) - 1.0);
  tmpvar_11.y = ((2.0 * tex2DNode2_6.y) - 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * _SwirlItensity);
  highp vec2 tmpvar_13;
  tmpvar_13 = (tmpvar_8 + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (1.0 - tmpvar_13.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_SmokeShapeTex, tmpvar_14);
  tex2DNode27_5 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (((
    mix (_DarkColor, _LightColor, tex2DNode27_5.xxxx)
   + 
    (_RimColor * tex2DNode27_5.z)
  ) * _SmokeBrightness) * xlv_COLOR.y);
  uv103_4.zw = xlv_TEXCOORD1.zw;
  uv103_4.xy = xlv_TEXCOORD1.xy;
  staticSwitch105_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_CustomeFireColorToggle == 1.0)) {
    staticSwitch105_3 = uv103_4;
  } else {
    staticSwitch105_3 = _FireColor;
  };
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _FireNoiseTex_ST.xy) + _FireNoiseTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FireNoiseTex, tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (1.0 - tmpvar_19.y);
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_20 + tmpvar_12);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (1.0 - tmpvar_21.y);
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy) + _DissolveDistortionNoiseTex_ST.zw);
  highp vec2 tmpvar_24;
  tmpvar_24.x = ((_Time.y * _DissolveDistortionNoise_USpeed) + tmpvar_23.x);
  tmpvar_24.y = (tmpvar_23.y + (_Time.y * _DissolveDistortionNoise_VSpeed));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_DissolveDistortionNoiseTex, tmpvar_24);
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (tmpvar_22 + (tmpvar_25.x * _DistortionNoiseBrightness));
  tmpvar_26 = texture2D (_NoiseTex, P_27);
  highp vec3 tmpvar_28;
  tmpvar_28 = (((staticSwitch105_3 * 
    clamp (((tmpvar_18.x * (7.0 * tex2DNode27_5.y)) - (-0.6 + (xlv_COLOR.x * 4.6))), 0.0, 1.0)
  ) + tmpvar_16) * _DayColor).xyz;
  aseOutColor_2 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp ((_DayColor.w * (
    (xlv_COLOR.z * (tex2DNode27_5.w * (tmpvar_26.x - (-0.5 + 
      (xlv_COLOR.w * 1.4)
    ))))
   * _AlphaBrightness)), 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_29;
  aseOutColor_2 = mix (aseOutColor_2, vec3(dot (aseOutColor_2, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = aseOutColor_2;
  tmpvar_30.w = aseOutAlpha_1;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_FIRETOGGLE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShapeTex;
uniform highp vec4 _SmokeShapeTex_ST;
uniform sampler2D _DistortionTex;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform mediump float _CustomeFireColorToggle;
uniform highp vec4 _FireColor;
uniform sampler2D _FireNoiseTex;
uniform highp vec4 _FireNoiseTex_ST;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _DissolveDistortionNoiseTex;
uniform highp float _DissolveDistortionNoise_USpeed;
uniform highp vec4 _DissolveDistortionNoiseTex_ST;
uniform highp float _DissolveDistortionNoise_VSpeed;
uniform highp float _DistortionNoiseBrightness;
uniform highp float _AlphaBrightness;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 aseOutColor_2;
  highp vec4 staticSwitch105_3;
  highp vec4 uv103_4;
  highp vec4 tex2DNode27_5;
  highp vec4 tex2DNode2_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _SmokeShapeTex_ST.xy) + _SmokeShapeTex_ST.zw);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (1.0 - tmpvar_7.y);
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_DistortionTex, tmpvar_9);
  tex2DNode2_6 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((tex2DNode2_6.x * 2.0) - 1.0);
  tmpvar_11.y = ((2.0 * tex2DNode2_6.y) - 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * _SwirlItensity);
  highp vec2 tmpvar_13;
  tmpvar_13 = (tmpvar_8 + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (1.0 - tmpvar_13.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_SmokeShapeTex, tmpvar_14);
  tex2DNode27_5 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (((
    mix (_DarkColor, _LightColor, tex2DNode27_5.xxxx)
   + 
    (_RimColor * tex2DNode27_5.z)
  ) * _SmokeBrightness) * xlv_COLOR.y);
  uv103_4.zw = xlv_TEXCOORD1.zw;
  uv103_4.xy = xlv_TEXCOORD1.xy;
  staticSwitch105_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_CustomeFireColorToggle == 1.0)) {
    staticSwitch105_3 = uv103_4;
  } else {
    staticSwitch105_3 = _FireColor;
  };
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _FireNoiseTex_ST.xy) + _FireNoiseTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FireNoiseTex, tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (1.0 - tmpvar_19.y);
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_20 + tmpvar_12);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (1.0 - tmpvar_21.y);
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy) + _DissolveDistortionNoiseTex_ST.zw);
  highp vec2 tmpvar_24;
  tmpvar_24.x = ((_Time.y * _DissolveDistortionNoise_USpeed) + tmpvar_23.x);
  tmpvar_24.y = (tmpvar_23.y + (_Time.y * _DissolveDistortionNoise_VSpeed));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_DissolveDistortionNoiseTex, tmpvar_24);
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (tmpvar_22 + (tmpvar_25.x * _DistortionNoiseBrightness));
  tmpvar_26 = texture2D (_NoiseTex, P_27);
  highp vec3 tmpvar_28;
  tmpvar_28 = (((staticSwitch105_3 * 
    clamp (((tmpvar_18.x * (7.0 * tex2DNode27_5.y)) - (-0.6 + (xlv_COLOR.x * 4.6))), 0.0, 1.0)
  ) + tmpvar_16) * _DayColor).xyz;
  aseOutColor_2 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp ((_DayColor.w * (
    (xlv_COLOR.z * (tex2DNode27_5.w * (tmpvar_26.x - (-0.5 + 
      (xlv_COLOR.w * 1.4)
    ))))
   * _AlphaBrightness)), 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_29;
  aseOutColor_2 = mix (aseOutColor_2, vec3(dot (aseOutColor_2, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = aseOutColor_2;
  tmpvar_30.w = aseOutAlpha_1;
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_FIRETOGGLE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform sampler2D _SmokeShapeTex;
uniform highp vec4 _SmokeShapeTex_ST;
uniform sampler2D _DistortionTex;
uniform highp float _SwirlItensity;
uniform highp vec4 _RimColor;
uniform highp float _SmokeBrightness;
uniform mediump float _CustomeFireColorToggle;
uniform highp vec4 _FireColor;
uniform sampler2D _FireNoiseTex;
uniform highp vec4 _FireNoiseTex_ST;
uniform highp vec4 _DayColor;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _DissolveDistortionNoiseTex;
uniform highp float _DissolveDistortionNoise_USpeed;
uniform highp vec4 _DissolveDistortionNoiseTex_ST;
uniform highp float _DissolveDistortionNoise_VSpeed;
uniform highp float _DistortionNoiseBrightness;
uniform highp float _AlphaBrightness;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 aseOutColor_2;
  highp vec4 staticSwitch105_3;
  highp vec4 uv103_4;
  highp vec4 tex2DNode27_5;
  highp vec4 tex2DNode2_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _SmokeShapeTex_ST.xy) + _SmokeShapeTex_ST.zw);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (1.0 - tmpvar_7.y);
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_DistortionTex, tmpvar_9);
  tex2DNode2_6 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((tex2DNode2_6.x * 2.0) - 1.0);
  tmpvar_11.y = ((2.0 * tex2DNode2_6.y) - 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * _SwirlItensity);
  highp vec2 tmpvar_13;
  tmpvar_13 = (tmpvar_8 + tmpvar_12);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (1.0 - tmpvar_13.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_SmokeShapeTex, tmpvar_14);
  tex2DNode27_5 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (((
    mix (_DarkColor, _LightColor, tex2DNode27_5.xxxx)
   + 
    (_RimColor * tex2DNode27_5.z)
  ) * _SmokeBrightness) * xlv_COLOR.y);
  uv103_4.zw = xlv_TEXCOORD1.zw;
  uv103_4.xy = xlv_TEXCOORD1.xy;
  staticSwitch105_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_CustomeFireColorToggle == 1.0)) {
    staticSwitch105_3 = uv103_4;
  } else {
    staticSwitch105_3 = _FireColor;
  };
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _FireNoiseTex_ST.xy) + _FireNoiseTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_FireNoiseTex, tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (1.0 - tmpvar_19.y);
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_20 + tmpvar_12);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (1.0 - tmpvar_21.y);
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy) + _DissolveDistortionNoiseTex_ST.zw);
  highp vec2 tmpvar_24;
  tmpvar_24.x = ((_Time.y * _DissolveDistortionNoise_USpeed) + tmpvar_23.x);
  tmpvar_24.y = (tmpvar_23.y + (_Time.y * _DissolveDistortionNoise_VSpeed));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_DissolveDistortionNoiseTex, tmpvar_24);
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (tmpvar_22 + (tmpvar_25.x * _DistortionNoiseBrightness));
  tmpvar_26 = texture2D (_NoiseTex, P_27);
  highp vec3 tmpvar_28;
  tmpvar_28 = (((staticSwitch105_3 * 
    clamp (((tmpvar_18.x * (7.0 * tex2DNode27_5.y)) - (-0.6 + (xlv_COLOR.x * 4.6))), 0.0, 1.0)
  ) + tmpvar_16) * _DayColor).xyz;
  aseOutColor_2 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp ((_DayColor.w * (
    (xlv_COLOR.z * (tex2DNode27_5.w * (tmpvar_26.x - (-0.5 + 
      (xlv_COLOR.w * 1.4)
    ))))
   * _AlphaBrightness)), 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_29;
  aseOutColor_2 = mix (aseOutColor_2, vec3(dot (aseOutColor_2, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = aseOutColor_2;
  tmpvar_30.w = aseOutAlpha_1;
  gl_FragData[0] = tmpvar_30;
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
Keywords { "_FIRETOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_FIRETOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_FIRETOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_FIRETOGGLE_ON" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MiHoYoASEMaterialInspector"
}