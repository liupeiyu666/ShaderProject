//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_Dis_Mask" {
Properties {
_EnvColor ("Env Color", Color) = (1,1,1,1)
_MainSmokeTexture ("MainSmokeTexture", 2D) = "white" { }
_SmokeBrightness ("SmokeBrightness", Float) = 1
_Opacity ("Opacity", Range(0, 1)) = 1
_DisTexture ("DisTexture", 2D) = "white" { }
_DisUvR ("DisUv (R)", Vector) = (0,0,0,0)
_DisUvG ("DisUv(G)", Vector) = (0,0,1,1)
_DisNoise ("DisNoise", Range(-5, 2)) = -1
_DarkDisCt ("DarkDisCt", Range(-2, 0)) = 0
_Smoothstep ("Smoothstep", Range(0.5, 1)) = 0.5
_LightColor ("LightColor", Color) = (1,1,1,1)
_DarkColor ("DarkColor", Color) = (1,1,1,0)
[Toggle(_RIM_SWITCH_ON)] _Rim_Switch ("Rim_Switch", Float) = 0
_Rim ("Rim", Range(-0.1, 1)) = 0
_RimColor ("RimColor", Color) = (1,1,1,0)
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Toggle(SPECIAL_STATE)] _SpecialState ("Special State", Float) = 0
_SPTex ("SP Tex", 2D) = "white" { }
_SPNoiseTex ("SP Noise Tex", 2D) = "white" { }
_SPNoiseScaler ("SP Noise Scaler", Range(0, 10)) = 1
_SPIntensity ("SP Intensity", Range(0, 1)) = 0.5
_SPTransition ("SP Transition", Range(0, 1)) = 0
_SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
_SPOpaqueness ("SP Opaqueness", Range(0, 1)) = 1
_SPOutlineColor ("SP Outline Color", Color) = (1,1,1,1)
_SPTransitionEmissionScaler ("SP Transition Emission Scaler", Range(1, 100)) = 1
_SPTransitionBloomFactor ("SP Transition Bloom Factor", Float) = 1
_SPCubeMap ("SP CubeMap", Cube) = "white" { }
_SPCubeMapColor ("SP CubeMap Color", Color) = (1,1,1,0)
_SPCubeMapOffset ("SP CubeMap Offset", Vector) = (0,0,0,0)
_SPCubeMapIntensity ("SP CubeMap Intensity", Range(0, 1)) = 0
_SPCubeMapNoiseIntensity ("SP CubeMap Noise Intensity", Range(0, 5)) = 0
_SPCubeMapBrightness ("SP CubeMap Brightness", Float) = 1.26
_SPOldColor ("SP Old Color", Color) = (1,1,1,0)
[Toggle(RIM_GLOW)] _RimGlow ("Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DTTex ("Distortion Tex", 2D) = "gray" { }
_DTIntensity ("Distortion Intensity", Range(1, 9)) = 5
_DTPlaySpeed ("Distortion Play Speed", Float) = 0
_DTNormalDisplacment ("Distortion Normal Displacment", Float) = 0
_DTUVScaleInX ("Distortion UV Scale in X", Float) = 1
_DTUVScaleInY ("Distortion UV Scale in Y", Float) = 1
_DTFresnel ("Distortion Fresnel Params", Vector) = (1,1,0,0)
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Keep = 0, Replace = 2", Float) = 2
}
SubShader {
 LOD 100
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 58080
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
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_6 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_6 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _Opacity;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 aseOutColor_1;
  mediump vec3 staticSwitch220_2;
  mediump float temp_output_231_0_3;
  mediump vec4 tex2DNode10_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_4 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_7;
  tmpvar_7 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_3 = tmpvar_7;
  mediump float tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - _Smoothstep);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    (tmpvar_6 + temp_output_231_0_3)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_8 = (tmpvar_10 * (tmpvar_10 * (3.0 - 
    (2.0 * tmpvar_10)
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tex2DNode10_4.xyz * _DarkColor);
  mediump float tmpvar_12;
  tmpvar_12 = ((tmpvar_6 + temp_output_231_0_3) + _DarkDisCt);
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((
    (tmpvar_12 + _Rim)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  staticSwitch220_2 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_2 = mix (tmpvar_11, (tex2DNode10_4.xyz * _RimColor), vec3(tmpvar_13));
  } else {
    staticSwitch220_2 = tmpvar_11;
  };
  mediump float edge0_15;
  edge0_15 = (1.0 - _Smoothstep);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((tmpvar_12 - edge0_15) / (_Smoothstep - edge0_15)), 0.0, 1.0);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = (_SmokeBrightness * mix (staticSwitch220_2, (
    (tex2DNode10_4.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  ))));
  aseOutColor_1.w = tmpvar_17.w;
  aseOutColor_1.xyz = (tmpvar_17.xyz * _EnvColor.xyz);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1.xyz;
  tmpvar_18.w = clamp (((_LightColor.w * tex2DNode10_4.w) * (tmpvar_8 * _Opacity)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_18;
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
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_6 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_6 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _Opacity;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 aseOutColor_1;
  mediump vec3 staticSwitch220_2;
  mediump float temp_output_231_0_3;
  mediump vec4 tex2DNode10_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_4 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_7;
  tmpvar_7 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_3 = tmpvar_7;
  mediump float tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - _Smoothstep);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    (tmpvar_6 + temp_output_231_0_3)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_8 = (tmpvar_10 * (tmpvar_10 * (3.0 - 
    (2.0 * tmpvar_10)
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tex2DNode10_4.xyz * _DarkColor);
  mediump float tmpvar_12;
  tmpvar_12 = ((tmpvar_6 + temp_output_231_0_3) + _DarkDisCt);
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((
    (tmpvar_12 + _Rim)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  staticSwitch220_2 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_2 = mix (tmpvar_11, (tex2DNode10_4.xyz * _RimColor), vec3(tmpvar_13));
  } else {
    staticSwitch220_2 = tmpvar_11;
  };
  mediump float edge0_15;
  edge0_15 = (1.0 - _Smoothstep);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((tmpvar_12 - edge0_15) / (_Smoothstep - edge0_15)), 0.0, 1.0);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = (_SmokeBrightness * mix (staticSwitch220_2, (
    (tex2DNode10_4.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  ))));
  aseOutColor_1.w = tmpvar_17.w;
  aseOutColor_1.xyz = (tmpvar_17.xyz * _EnvColor.xyz);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1.xyz;
  tmpvar_18.w = clamp (((_LightColor.w * tex2DNode10_4.w) * (tmpvar_8 * _Opacity)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_18;
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
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_6 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_6 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _Opacity;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 aseOutColor_1;
  mediump vec3 staticSwitch220_2;
  mediump float temp_output_231_0_3;
  mediump vec4 tex2DNode10_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_4 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_7;
  tmpvar_7 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_3 = tmpvar_7;
  mediump float tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - _Smoothstep);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    (tmpvar_6 + temp_output_231_0_3)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_8 = (tmpvar_10 * (tmpvar_10 * (3.0 - 
    (2.0 * tmpvar_10)
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tex2DNode10_4.xyz * _DarkColor);
  mediump float tmpvar_12;
  tmpvar_12 = ((tmpvar_6 + temp_output_231_0_3) + _DarkDisCt);
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((
    (tmpvar_12 + _Rim)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  staticSwitch220_2 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_2 = mix (tmpvar_11, (tex2DNode10_4.xyz * _RimColor), vec3(tmpvar_13));
  } else {
    staticSwitch220_2 = tmpvar_11;
  };
  mediump float edge0_15;
  edge0_15 = (1.0 - _Smoothstep);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((tmpvar_12 - edge0_15) / (_Smoothstep - edge0_15)), 0.0, 1.0);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = (_SmokeBrightness * mix (staticSwitch220_2, (
    (tex2DNode10_4.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  ))));
  aseOutColor_1.w = tmpvar_17.w;
  aseOutColor_1.xyz = (tmpvar_17.xyz * _EnvColor.xyz);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1.xyz;
  tmpvar_18.w = clamp (((_LightColor.w * tex2DNode10_4.w) * (tmpvar_8 * _Opacity)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_18;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_6 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_6 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _Opacity;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_19.w;
  aseOutColor_3.xyz = (tmpvar_19.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_21;
  mediump vec3 tmpvar_22;
  highp vec3 N_23;
  N_23 = N_2;
  highp vec3 V_24;
  V_24 = V_1;
  mediump float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = pow (clamp ((1.001 - 
    dot (V_24, N_23)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_25 = (_RGBias + (tmpvar_26 * _RGScale));
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_25 * _RGColor).xyz;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (tmpvar_25, 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (aseOutColor_3.xyz, tmpvar_27, vec3((tmpvar_28 * _RGRatio)));
  tmpvar_22 = tmpvar_29;
  aseOutColor_3.xyz = tmpvar_22;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = aseOutColor_3.xyz;
  tmpvar_30.w = clamp (((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_6 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_6 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _Opacity;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_19.w;
  aseOutColor_3.xyz = (tmpvar_19.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_21;
  mediump vec3 tmpvar_22;
  highp vec3 N_23;
  N_23 = N_2;
  highp vec3 V_24;
  V_24 = V_1;
  mediump float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = pow (clamp ((1.001 - 
    dot (V_24, N_23)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_25 = (_RGBias + (tmpvar_26 * _RGScale));
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_25 * _RGColor).xyz;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (tmpvar_25, 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (aseOutColor_3.xyz, tmpvar_27, vec3((tmpvar_28 * _RGRatio)));
  tmpvar_22 = tmpvar_29;
  aseOutColor_3.xyz = tmpvar_22;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = aseOutColor_3.xyz;
  tmpvar_30.w = clamp (((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_6 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_6 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _Opacity;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_19.w;
  aseOutColor_3.xyz = (tmpvar_19.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_21;
  mediump vec3 tmpvar_22;
  highp vec3 N_23;
  N_23 = N_2;
  highp vec3 V_24;
  V_24 = V_1;
  mediump float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = pow (clamp ((1.001 - 
    dot (V_24, N_23)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_25 = (_RGBias + (tmpvar_26 * _RGScale));
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_25 * _RGColor).xyz;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (tmpvar_25, 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (aseOutColor_3.xyz, tmpvar_27, vec3((tmpvar_28 * _RGRatio)));
  tmpvar_22 = tmpvar_29;
  aseOutColor_3.xyz = tmpvar_22;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = aseOutColor_3.xyz;
  tmpvar_30.w = clamp (((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec4 spuvs_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (_glesVertex * 0.5);
  spuvs_7.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (tmpvar_8.x + (tmpvar_8.z * tmpvar_8.z));
  tmpvar_9.y = ((tmpvar_8.y + (0.5 * tmpvar_8.z)) + ((0.5 * tmpvar_8.x) * tmpvar_8.x));
  spuvs_7.zw = ((tmpvar_9 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = spuvs_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _Opacity;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = ((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_20.w;
  aseOutColor_3.xyz = (tmpvar_20.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_22;
  mediump vec3 reflection_23;
  mediump vec3 R_24;
  mediump float intensity_25;
  mediump vec4 noiseTex_26;
  mediump vec4 spColor_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_27.xyz = tmpvar_28.xyz;
  spColor_27.w = aseOutColor_3.w;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_26 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((1.99 * noiseTex_26.x) * _SPNoiseScaler) - 1.0);
  intensity_25 = tmpvar_30;
  highp vec3 tmpvar_31;
  highp vec3 I_32;
  I_32 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_26 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (N_2, I_32)
   * N_2)));
  R_24 = tmpvar_31;
  lowp vec3 tmpvar_33;
  tmpvar_33 = textureCube (_SPCubeMap, R_24).xyz;
  reflection_23 = tmpvar_33;
  highp vec3 tmpvar_34;
  mediump vec3 x_35;
  x_35 = (spColor_27.xyz * _SPOldColor.xyz);
  tmpvar_34 = mix (x_35, ((reflection_23 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_27.xyz = tmpvar_34;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_25 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_25 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_36;
      tmpvar_36 = mix (spColor_27, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_25) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_27 = tmpvar_36;
    };
  };
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (aseOutColor_3.xyz, spColor_27.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_27.xyz = tmpvar_37;
  aseOutColor_3 = spColor_27;
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = spColor_27.xyz;
  tmpvar_38.w = clamp (tmpvar_19, 0.0, 1.0);
  gl_FragData[0] = tmpvar_38;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec4 spuvs_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (_glesVertex * 0.5);
  spuvs_7.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (tmpvar_8.x + (tmpvar_8.z * tmpvar_8.z));
  tmpvar_9.y = ((tmpvar_8.y + (0.5 * tmpvar_8.z)) + ((0.5 * tmpvar_8.x) * tmpvar_8.x));
  spuvs_7.zw = ((tmpvar_9 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = spuvs_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _Opacity;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = ((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_20.w;
  aseOutColor_3.xyz = (tmpvar_20.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_22;
  mediump vec3 reflection_23;
  mediump vec3 R_24;
  mediump float intensity_25;
  mediump vec4 noiseTex_26;
  mediump vec4 spColor_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_27.xyz = tmpvar_28.xyz;
  spColor_27.w = aseOutColor_3.w;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_26 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((1.99 * noiseTex_26.x) * _SPNoiseScaler) - 1.0);
  intensity_25 = tmpvar_30;
  highp vec3 tmpvar_31;
  highp vec3 I_32;
  I_32 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_26 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (N_2, I_32)
   * N_2)));
  R_24 = tmpvar_31;
  lowp vec3 tmpvar_33;
  tmpvar_33 = textureCube (_SPCubeMap, R_24).xyz;
  reflection_23 = tmpvar_33;
  highp vec3 tmpvar_34;
  mediump vec3 x_35;
  x_35 = (spColor_27.xyz * _SPOldColor.xyz);
  tmpvar_34 = mix (x_35, ((reflection_23 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_27.xyz = tmpvar_34;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_25 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_25 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_36;
      tmpvar_36 = mix (spColor_27, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_25) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_27 = tmpvar_36;
    };
  };
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (aseOutColor_3.xyz, spColor_27.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_27.xyz = tmpvar_37;
  aseOutColor_3 = spColor_27;
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = spColor_27.xyz;
  tmpvar_38.w = clamp (tmpvar_19, 0.0, 1.0);
  gl_FragData[0] = tmpvar_38;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec4 spuvs_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (_glesVertex * 0.5);
  spuvs_7.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (tmpvar_8.x + (tmpvar_8.z * tmpvar_8.z));
  tmpvar_9.y = ((tmpvar_8.y + (0.5 * tmpvar_8.z)) + ((0.5 * tmpvar_8.x) * tmpvar_8.x));
  spuvs_7.zw = ((tmpvar_9 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = spuvs_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _Opacity;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = ((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_20.w;
  aseOutColor_3.xyz = (tmpvar_20.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_22;
  mediump vec3 reflection_23;
  mediump vec3 R_24;
  mediump float intensity_25;
  mediump vec4 noiseTex_26;
  mediump vec4 spColor_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_27.xyz = tmpvar_28.xyz;
  spColor_27.w = aseOutColor_3.w;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_26 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((1.99 * noiseTex_26.x) * _SPNoiseScaler) - 1.0);
  intensity_25 = tmpvar_30;
  highp vec3 tmpvar_31;
  highp vec3 I_32;
  I_32 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_26 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (N_2, I_32)
   * N_2)));
  R_24 = tmpvar_31;
  lowp vec3 tmpvar_33;
  tmpvar_33 = textureCube (_SPCubeMap, R_24).xyz;
  reflection_23 = tmpvar_33;
  highp vec3 tmpvar_34;
  mediump vec3 x_35;
  x_35 = (spColor_27.xyz * _SPOldColor.xyz);
  tmpvar_34 = mix (x_35, ((reflection_23 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_27.xyz = tmpvar_34;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_25 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_25 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_36;
      tmpvar_36 = mix (spColor_27, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_25) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_27 = tmpvar_36;
    };
  };
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (aseOutColor_3.xyz, spColor_27.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_27.xyz = tmpvar_37;
  aseOutColor_3 = spColor_27;
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = spColor_27.xyz;
  tmpvar_38.w = clamp (tmpvar_19, 0.0, 1.0);
  gl_FragData[0] = tmpvar_38;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec4 spuvs_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (_glesVertex * 0.5);
  spuvs_7.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (tmpvar_8.x + (tmpvar_8.z * tmpvar_8.z));
  tmpvar_9.y = ((tmpvar_8.y + (0.5 * tmpvar_8.z)) + ((0.5 * tmpvar_8.x) * tmpvar_8.x));
  spuvs_7.zw = ((tmpvar_9 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = spuvs_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _Opacity;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = ((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_20.w;
  aseOutColor_3.xyz = (tmpvar_20.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_22;
  mediump vec3 reflection_23;
  mediump vec3 R_24;
  mediump float intensity_25;
  mediump vec4 noiseTex_26;
  mediump vec4 spColor_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_27.xyz = tmpvar_28.xyz;
  spColor_27.w = aseOutColor_3.w;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_26 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((1.99 * noiseTex_26.x) * _SPNoiseScaler) - 1.0);
  intensity_25 = tmpvar_30;
  highp vec3 tmpvar_31;
  highp vec3 I_32;
  I_32 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_26 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (N_2, I_32)
   * N_2)));
  R_24 = tmpvar_31;
  lowp vec3 tmpvar_33;
  tmpvar_33 = textureCube (_SPCubeMap, R_24).xyz;
  reflection_23 = tmpvar_33;
  highp vec3 tmpvar_34;
  mediump vec3 x_35;
  x_35 = (spColor_27.xyz * _SPOldColor.xyz);
  tmpvar_34 = mix (x_35, ((reflection_23 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_27.xyz = tmpvar_34;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_25 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_25 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_36;
      tmpvar_36 = mix (spColor_27, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_25) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_27 = tmpvar_36;
    };
  };
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (aseOutColor_3.xyz, spColor_27.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_27.xyz = tmpvar_37;
  aseOutColor_3.w = spColor_27.w;
  mediump vec3 tmpvar_38;
  highp vec3 N_39;
  N_39 = N_2;
  highp vec3 V_40;
  V_40 = V_1;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = pow (clamp ((1.001 - 
    dot (V_40, N_39)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_41 = (_RGBias + (tmpvar_42 * _RGScale));
  mediump vec3 tmpvar_43;
  tmpvar_43 = (tmpvar_41 * _RGColor).xyz;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (tmpvar_41, 0.0, 1.0);
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (spColor_27.xyz, tmpvar_43, vec3((tmpvar_44 * _RGRatio)));
  tmpvar_38 = tmpvar_45;
  aseOutColor_3.xyz = tmpvar_38;
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = aseOutColor_3.xyz;
  tmpvar_46.w = clamp (tmpvar_19, 0.0, 1.0);
  gl_FragData[0] = tmpvar_46;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec4 spuvs_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (_glesVertex * 0.5);
  spuvs_7.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (tmpvar_8.x + (tmpvar_8.z * tmpvar_8.z));
  tmpvar_9.y = ((tmpvar_8.y + (0.5 * tmpvar_8.z)) + ((0.5 * tmpvar_8.x) * tmpvar_8.x));
  spuvs_7.zw = ((tmpvar_9 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = spuvs_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _Opacity;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = ((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_20.w;
  aseOutColor_3.xyz = (tmpvar_20.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_22;
  mediump vec3 reflection_23;
  mediump vec3 R_24;
  mediump float intensity_25;
  mediump vec4 noiseTex_26;
  mediump vec4 spColor_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_27.xyz = tmpvar_28.xyz;
  spColor_27.w = aseOutColor_3.w;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_26 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((1.99 * noiseTex_26.x) * _SPNoiseScaler) - 1.0);
  intensity_25 = tmpvar_30;
  highp vec3 tmpvar_31;
  highp vec3 I_32;
  I_32 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_26 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (N_2, I_32)
   * N_2)));
  R_24 = tmpvar_31;
  lowp vec3 tmpvar_33;
  tmpvar_33 = textureCube (_SPCubeMap, R_24).xyz;
  reflection_23 = tmpvar_33;
  highp vec3 tmpvar_34;
  mediump vec3 x_35;
  x_35 = (spColor_27.xyz * _SPOldColor.xyz);
  tmpvar_34 = mix (x_35, ((reflection_23 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_27.xyz = tmpvar_34;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_25 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_25 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_36;
      tmpvar_36 = mix (spColor_27, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_25) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_27 = tmpvar_36;
    };
  };
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (aseOutColor_3.xyz, spColor_27.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_27.xyz = tmpvar_37;
  aseOutColor_3.w = spColor_27.w;
  mediump vec3 tmpvar_38;
  highp vec3 N_39;
  N_39 = N_2;
  highp vec3 V_40;
  V_40 = V_1;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = pow (clamp ((1.001 - 
    dot (V_40, N_39)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_41 = (_RGBias + (tmpvar_42 * _RGScale));
  mediump vec3 tmpvar_43;
  tmpvar_43 = (tmpvar_41 * _RGColor).xyz;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (tmpvar_41, 0.0, 1.0);
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (spColor_27.xyz, tmpvar_43, vec3((tmpvar_44 * _RGRatio)));
  tmpvar_38 = tmpvar_45;
  aseOutColor_3.xyz = tmpvar_38;
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = aseOutColor_3.xyz;
  tmpvar_46.w = clamp (tmpvar_19, 0.0, 1.0);
  gl_FragData[0] = tmpvar_46;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec4 spuvs_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (_glesVertex * 0.5);
  spuvs_7.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (tmpvar_8.x + (tmpvar_8.z * tmpvar_8.z));
  tmpvar_9.y = ((tmpvar_8.y + (0.5 * tmpvar_8.z)) + ((0.5 * tmpvar_8.x) * tmpvar_8.x));
  spuvs_7.zw = ((tmpvar_9 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = spuvs_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _Opacity;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = ((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_20.w;
  aseOutColor_3.xyz = (tmpvar_20.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_22;
  mediump vec3 reflection_23;
  mediump vec3 R_24;
  mediump float intensity_25;
  mediump vec4 noiseTex_26;
  mediump vec4 spColor_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_27.xyz = tmpvar_28.xyz;
  spColor_27.w = aseOutColor_3.w;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_26 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((1.99 * noiseTex_26.x) * _SPNoiseScaler) - 1.0);
  intensity_25 = tmpvar_30;
  highp vec3 tmpvar_31;
  highp vec3 I_32;
  I_32 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_26 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (N_2, I_32)
   * N_2)));
  R_24 = tmpvar_31;
  lowp vec3 tmpvar_33;
  tmpvar_33 = textureCube (_SPCubeMap, R_24).xyz;
  reflection_23 = tmpvar_33;
  highp vec3 tmpvar_34;
  mediump vec3 x_35;
  x_35 = (spColor_27.xyz * _SPOldColor.xyz);
  tmpvar_34 = mix (x_35, ((reflection_23 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_27.xyz = tmpvar_34;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_25 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_25 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_36;
      tmpvar_36 = mix (spColor_27, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_25) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_27 = tmpvar_36;
    };
  };
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (aseOutColor_3.xyz, spColor_27.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_27.xyz = tmpvar_37;
  aseOutColor_3.w = spColor_27.w;
  mediump vec3 tmpvar_38;
  highp vec3 N_39;
  N_39 = N_2;
  highp vec3 V_40;
  V_40 = V_1;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = pow (clamp ((1.001 - 
    dot (V_40, N_39)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_41 = (_RGBias + (tmpvar_42 * _RGScale));
  mediump vec3 tmpvar_43;
  tmpvar_43 = (tmpvar_41 * _RGColor).xyz;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (tmpvar_41, 0.0, 1.0);
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (spColor_27.xyz, tmpvar_43, vec3((tmpvar_44 * _RGRatio)));
  tmpvar_38 = tmpvar_45;
  aseOutColor_3.xyz = tmpvar_38;
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = aseOutColor_3.xyz;
  tmpvar_46.w = clamp (tmpvar_19, 0.0, 1.0);
  gl_FragData[0] = tmpvar_46;
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_6 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_6 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
uniform mediump float _Opacity;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 aseOutColor_1;
  mediump vec3 staticSwitch220_2;
  mediump float temp_output_231_0_3;
  mediump vec4 tex2DNode10_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_4 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_7;
  tmpvar_7 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_3 = tmpvar_7;
  mediump float tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - _Smoothstep);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    (tmpvar_6 + temp_output_231_0_3)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_8 = (tmpvar_10 * (tmpvar_10 * (3.0 - 
    (2.0 * tmpvar_10)
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tex2DNode10_4.xyz * _DarkColor);
  mediump float tmpvar_12;
  tmpvar_12 = ((tmpvar_6 + temp_output_231_0_3) + _DarkDisCt);
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((
    (tmpvar_12 + _Rim)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  staticSwitch220_2 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_2 = mix (tmpvar_11, (tex2DNode10_4.xyz * _RimColor), vec3(tmpvar_13));
  } else {
    staticSwitch220_2 = tmpvar_11;
  };
  mediump float edge0_15;
  edge0_15 = (1.0 - _Smoothstep);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((tmpvar_12 - edge0_15) / (_Smoothstep - edge0_15)), 0.0, 1.0);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = (_SmokeBrightness * mix (staticSwitch220_2, (
    (tex2DNode10_4.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  ))));
  aseOutColor_1.w = tmpvar_17.w;
  aseOutColor_1.xyz = (tmpvar_17.xyz * _EnvColor.xyz);
  aseOutColor_1.xyz = mix (aseOutColor_1.xyz, vec3(dot (aseOutColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1.xyz;
  tmpvar_18.w = clamp (((_LightColor.w * tex2DNode10_4.w) * (tmpvar_8 * _Opacity)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_18;
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_6 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_6 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
uniform mediump float _Opacity;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 aseOutColor_1;
  mediump vec3 staticSwitch220_2;
  mediump float temp_output_231_0_3;
  mediump vec4 tex2DNode10_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_4 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_7;
  tmpvar_7 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_3 = tmpvar_7;
  mediump float tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - _Smoothstep);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    (tmpvar_6 + temp_output_231_0_3)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_8 = (tmpvar_10 * (tmpvar_10 * (3.0 - 
    (2.0 * tmpvar_10)
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tex2DNode10_4.xyz * _DarkColor);
  mediump float tmpvar_12;
  tmpvar_12 = ((tmpvar_6 + temp_output_231_0_3) + _DarkDisCt);
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((
    (tmpvar_12 + _Rim)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  staticSwitch220_2 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_2 = mix (tmpvar_11, (tex2DNode10_4.xyz * _RimColor), vec3(tmpvar_13));
  } else {
    staticSwitch220_2 = tmpvar_11;
  };
  mediump float edge0_15;
  edge0_15 = (1.0 - _Smoothstep);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((tmpvar_12 - edge0_15) / (_Smoothstep - edge0_15)), 0.0, 1.0);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = (_SmokeBrightness * mix (staticSwitch220_2, (
    (tex2DNode10_4.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  ))));
  aseOutColor_1.w = tmpvar_17.w;
  aseOutColor_1.xyz = (tmpvar_17.xyz * _EnvColor.xyz);
  aseOutColor_1.xyz = mix (aseOutColor_1.xyz, vec3(dot (aseOutColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1.xyz;
  tmpvar_18.w = clamp (((_LightColor.w * tex2DNode10_4.w) * (tmpvar_8 * _Opacity)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_18;
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_6 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_6 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
uniform mediump float _Opacity;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 aseOutColor_1;
  mediump vec3 staticSwitch220_2;
  mediump float temp_output_231_0_3;
  mediump vec4 tex2DNode10_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_4 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_7;
  tmpvar_7 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_3 = tmpvar_7;
  mediump float tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - _Smoothstep);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    (tmpvar_6 + temp_output_231_0_3)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_8 = (tmpvar_10 * (tmpvar_10 * (3.0 - 
    (2.0 * tmpvar_10)
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tex2DNode10_4.xyz * _DarkColor);
  mediump float tmpvar_12;
  tmpvar_12 = ((tmpvar_6 + temp_output_231_0_3) + _DarkDisCt);
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((
    (tmpvar_12 + _Rim)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  staticSwitch220_2 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_2 = mix (tmpvar_11, (tex2DNode10_4.xyz * _RimColor), vec3(tmpvar_13));
  } else {
    staticSwitch220_2 = tmpvar_11;
  };
  mediump float edge0_15;
  edge0_15 = (1.0 - _Smoothstep);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((tmpvar_12 - edge0_15) / (_Smoothstep - edge0_15)), 0.0, 1.0);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = (_SmokeBrightness * mix (staticSwitch220_2, (
    (tex2DNode10_4.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  ))));
  aseOutColor_1.w = tmpvar_17.w;
  aseOutColor_1.xyz = (tmpvar_17.xyz * _EnvColor.xyz);
  aseOutColor_1.xyz = mix (aseOutColor_1.xyz, vec3(dot (aseOutColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1.xyz;
  tmpvar_18.w = clamp (((_LightColor.w * tex2DNode10_4.w) * (tmpvar_8 * _Opacity)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_18;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_6 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_6 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
uniform mediump float _Opacity;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_19.w;
  aseOutColor_3.xyz = (tmpvar_19.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_21;
  mediump vec3 tmpvar_22;
  highp vec3 N_23;
  N_23 = N_2;
  highp vec3 V_24;
  V_24 = V_1;
  mediump float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = pow (clamp ((1.001 - 
    dot (V_24, N_23)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_25 = (_RGBias + (tmpvar_26 * _RGScale));
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_25 * _RGColor).xyz;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (tmpvar_25, 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (aseOutColor_3.xyz, tmpvar_27, vec3((tmpvar_28 * _RGRatio)));
  tmpvar_22 = tmpvar_29;
  aseOutColor_3.xyz = mix (tmpvar_22, vec3(dot (tmpvar_22, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = aseOutColor_3.xyz;
  tmpvar_30.w = clamp (((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_6 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_6 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
uniform mediump float _Opacity;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_19.w;
  aseOutColor_3.xyz = (tmpvar_19.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_21;
  mediump vec3 tmpvar_22;
  highp vec3 N_23;
  N_23 = N_2;
  highp vec3 V_24;
  V_24 = V_1;
  mediump float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = pow (clamp ((1.001 - 
    dot (V_24, N_23)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_25 = (_RGBias + (tmpvar_26 * _RGScale));
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_25 * _RGColor).xyz;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (tmpvar_25, 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (aseOutColor_3.xyz, tmpvar_27, vec3((tmpvar_28 * _RGRatio)));
  tmpvar_22 = tmpvar_29;
  aseOutColor_3.xyz = mix (tmpvar_22, vec3(dot (tmpvar_22, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = aseOutColor_3.xyz;
  tmpvar_30.w = clamp (((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_6 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_6 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
uniform mediump float _Opacity;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_19.w;
  aseOutColor_3.xyz = (tmpvar_19.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_21;
  mediump vec3 tmpvar_22;
  highp vec3 N_23;
  N_23 = N_2;
  highp vec3 V_24;
  V_24 = V_1;
  mediump float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = pow (clamp ((1.001 - 
    dot (V_24, N_23)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_25 = (_RGBias + (tmpvar_26 * _RGScale));
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_25 * _RGColor).xyz;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (tmpvar_25, 0.0, 1.0);
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (aseOutColor_3.xyz, tmpvar_27, vec3((tmpvar_28 * _RGRatio)));
  tmpvar_22 = tmpvar_29;
  aseOutColor_3.xyz = mix (tmpvar_22, vec3(dot (tmpvar_22, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = aseOutColor_3.xyz;
  tmpvar_30.w = clamp (((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec4 spuvs_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (_glesVertex * 0.5);
  spuvs_7.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (tmpvar_8.x + (tmpvar_8.z * tmpvar_8.z));
  tmpvar_9.y = ((tmpvar_8.y + (0.5 * tmpvar_8.z)) + ((0.5 * tmpvar_8.x) * tmpvar_8.x));
  spuvs_7.zw = ((tmpvar_9 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = spuvs_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
uniform mediump float _Opacity;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = ((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_20.w;
  aseOutColor_3.xyz = (tmpvar_20.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_22;
  mediump vec3 reflection_23;
  mediump vec3 R_24;
  mediump float intensity_25;
  mediump vec4 noiseTex_26;
  mediump vec4 spColor_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_27.xyz = tmpvar_28.xyz;
  spColor_27.w = aseOutColor_3.w;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_26 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((1.99 * noiseTex_26.x) * _SPNoiseScaler) - 1.0);
  intensity_25 = tmpvar_30;
  highp vec3 tmpvar_31;
  highp vec3 I_32;
  I_32 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_26 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (N_2, I_32)
   * N_2)));
  R_24 = tmpvar_31;
  lowp vec3 tmpvar_33;
  tmpvar_33 = textureCube (_SPCubeMap, R_24).xyz;
  reflection_23 = tmpvar_33;
  highp vec3 tmpvar_34;
  mediump vec3 x_35;
  x_35 = (spColor_27.xyz * _SPOldColor.xyz);
  tmpvar_34 = mix (x_35, ((reflection_23 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_27.xyz = tmpvar_34;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_25 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_25 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_36;
      tmpvar_36 = mix (spColor_27, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_25) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_27 = tmpvar_36;
    };
  };
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (aseOutColor_3.xyz, spColor_27.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_27.xyz = tmpvar_37;
  aseOutColor_3.w = spColor_27.w;
  aseOutColor_3.xyz = mix (spColor_27.xyz, vec3(dot (spColor_27.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = aseOutColor_3.xyz;
  tmpvar_38.w = clamp (tmpvar_19, 0.0, 1.0);
  gl_FragData[0] = tmpvar_38;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec4 spuvs_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (_glesVertex * 0.5);
  spuvs_7.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (tmpvar_8.x + (tmpvar_8.z * tmpvar_8.z));
  tmpvar_9.y = ((tmpvar_8.y + (0.5 * tmpvar_8.z)) + ((0.5 * tmpvar_8.x) * tmpvar_8.x));
  spuvs_7.zw = ((tmpvar_9 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = spuvs_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
uniform mediump float _Opacity;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = ((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_20.w;
  aseOutColor_3.xyz = (tmpvar_20.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_22;
  mediump vec3 reflection_23;
  mediump vec3 R_24;
  mediump float intensity_25;
  mediump vec4 noiseTex_26;
  mediump vec4 spColor_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_27.xyz = tmpvar_28.xyz;
  spColor_27.w = aseOutColor_3.w;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_26 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((1.99 * noiseTex_26.x) * _SPNoiseScaler) - 1.0);
  intensity_25 = tmpvar_30;
  highp vec3 tmpvar_31;
  highp vec3 I_32;
  I_32 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_26 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (N_2, I_32)
   * N_2)));
  R_24 = tmpvar_31;
  lowp vec3 tmpvar_33;
  tmpvar_33 = textureCube (_SPCubeMap, R_24).xyz;
  reflection_23 = tmpvar_33;
  highp vec3 tmpvar_34;
  mediump vec3 x_35;
  x_35 = (spColor_27.xyz * _SPOldColor.xyz);
  tmpvar_34 = mix (x_35, ((reflection_23 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_27.xyz = tmpvar_34;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_25 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_25 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_36;
      tmpvar_36 = mix (spColor_27, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_25) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_27 = tmpvar_36;
    };
  };
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (aseOutColor_3.xyz, spColor_27.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_27.xyz = tmpvar_37;
  aseOutColor_3.w = spColor_27.w;
  aseOutColor_3.xyz = mix (spColor_27.xyz, vec3(dot (spColor_27.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = aseOutColor_3.xyz;
  tmpvar_38.w = clamp (tmpvar_19, 0.0, 1.0);
  gl_FragData[0] = tmpvar_38;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec4 spuvs_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (_glesVertex * 0.5);
  spuvs_7.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (tmpvar_8.x + (tmpvar_8.z * tmpvar_8.z));
  tmpvar_9.y = ((tmpvar_8.y + (0.5 * tmpvar_8.z)) + ((0.5 * tmpvar_8.x) * tmpvar_8.x));
  spuvs_7.zw = ((tmpvar_9 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = spuvs_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
uniform mediump float _Opacity;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = ((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_20.w;
  aseOutColor_3.xyz = (tmpvar_20.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_22;
  mediump vec3 reflection_23;
  mediump vec3 R_24;
  mediump float intensity_25;
  mediump vec4 noiseTex_26;
  mediump vec4 spColor_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_27.xyz = tmpvar_28.xyz;
  spColor_27.w = aseOutColor_3.w;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_26 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((1.99 * noiseTex_26.x) * _SPNoiseScaler) - 1.0);
  intensity_25 = tmpvar_30;
  highp vec3 tmpvar_31;
  highp vec3 I_32;
  I_32 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_26 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (N_2, I_32)
   * N_2)));
  R_24 = tmpvar_31;
  lowp vec3 tmpvar_33;
  tmpvar_33 = textureCube (_SPCubeMap, R_24).xyz;
  reflection_23 = tmpvar_33;
  highp vec3 tmpvar_34;
  mediump vec3 x_35;
  x_35 = (spColor_27.xyz * _SPOldColor.xyz);
  tmpvar_34 = mix (x_35, ((reflection_23 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_27.xyz = tmpvar_34;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_25 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_25 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_36;
      tmpvar_36 = mix (spColor_27, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_25) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_27 = tmpvar_36;
    };
  };
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (aseOutColor_3.xyz, spColor_27.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_27.xyz = tmpvar_37;
  aseOutColor_3.w = spColor_27.w;
  aseOutColor_3.xyz = mix (spColor_27.xyz, vec3(dot (spColor_27.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = aseOutColor_3.xyz;
  tmpvar_38.w = clamp (tmpvar_19, 0.0, 1.0);
  gl_FragData[0] = tmpvar_38;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec4 spuvs_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (_glesVertex * 0.5);
  spuvs_7.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (tmpvar_8.x + (tmpvar_8.z * tmpvar_8.z));
  tmpvar_9.y = ((tmpvar_8.y + (0.5 * tmpvar_8.z)) + ((0.5 * tmpvar_8.x) * tmpvar_8.x));
  spuvs_7.zw = ((tmpvar_9 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = spuvs_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
uniform mediump float _Opacity;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = ((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_20.w;
  aseOutColor_3.xyz = (tmpvar_20.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_22;
  mediump vec3 reflection_23;
  mediump vec3 R_24;
  mediump float intensity_25;
  mediump vec4 noiseTex_26;
  mediump vec4 spColor_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_27.xyz = tmpvar_28.xyz;
  spColor_27.w = aseOutColor_3.w;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_26 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((1.99 * noiseTex_26.x) * _SPNoiseScaler) - 1.0);
  intensity_25 = tmpvar_30;
  highp vec3 tmpvar_31;
  highp vec3 I_32;
  I_32 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_26 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (N_2, I_32)
   * N_2)));
  R_24 = tmpvar_31;
  lowp vec3 tmpvar_33;
  tmpvar_33 = textureCube (_SPCubeMap, R_24).xyz;
  reflection_23 = tmpvar_33;
  highp vec3 tmpvar_34;
  mediump vec3 x_35;
  x_35 = (spColor_27.xyz * _SPOldColor.xyz);
  tmpvar_34 = mix (x_35, ((reflection_23 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_27.xyz = tmpvar_34;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_25 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_25 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_36;
      tmpvar_36 = mix (spColor_27, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_25) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_27 = tmpvar_36;
    };
  };
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (aseOutColor_3.xyz, spColor_27.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_27.xyz = tmpvar_37;
  aseOutColor_3.w = spColor_27.w;
  mediump vec3 tmpvar_38;
  highp vec3 N_39;
  N_39 = N_2;
  highp vec3 V_40;
  V_40 = V_1;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = pow (clamp ((1.001 - 
    dot (V_40, N_39)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_41 = (_RGBias + (tmpvar_42 * _RGScale));
  mediump vec3 tmpvar_43;
  tmpvar_43 = (tmpvar_41 * _RGColor).xyz;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (tmpvar_41, 0.0, 1.0);
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (spColor_27.xyz, tmpvar_43, vec3((tmpvar_44 * _RGRatio)));
  tmpvar_38 = tmpvar_45;
  aseOutColor_3.xyz = mix (tmpvar_38, vec3(dot (tmpvar_38, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = aseOutColor_3.xyz;
  tmpvar_46.w = clamp (tmpvar_19, 0.0, 1.0);
  gl_FragData[0] = tmpvar_46;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec4 spuvs_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (_glesVertex * 0.5);
  spuvs_7.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (tmpvar_8.x + (tmpvar_8.z * tmpvar_8.z));
  tmpvar_9.y = ((tmpvar_8.y + (0.5 * tmpvar_8.z)) + ((0.5 * tmpvar_8.x) * tmpvar_8.x));
  spuvs_7.zw = ((tmpvar_9 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = spuvs_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
uniform mediump float _Opacity;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = ((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_20.w;
  aseOutColor_3.xyz = (tmpvar_20.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_22;
  mediump vec3 reflection_23;
  mediump vec3 R_24;
  mediump float intensity_25;
  mediump vec4 noiseTex_26;
  mediump vec4 spColor_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_27.xyz = tmpvar_28.xyz;
  spColor_27.w = aseOutColor_3.w;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_26 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((1.99 * noiseTex_26.x) * _SPNoiseScaler) - 1.0);
  intensity_25 = tmpvar_30;
  highp vec3 tmpvar_31;
  highp vec3 I_32;
  I_32 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_26 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (N_2, I_32)
   * N_2)));
  R_24 = tmpvar_31;
  lowp vec3 tmpvar_33;
  tmpvar_33 = textureCube (_SPCubeMap, R_24).xyz;
  reflection_23 = tmpvar_33;
  highp vec3 tmpvar_34;
  mediump vec3 x_35;
  x_35 = (spColor_27.xyz * _SPOldColor.xyz);
  tmpvar_34 = mix (x_35, ((reflection_23 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_27.xyz = tmpvar_34;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_25 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_25 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_36;
      tmpvar_36 = mix (spColor_27, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_25) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_27 = tmpvar_36;
    };
  };
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (aseOutColor_3.xyz, spColor_27.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_27.xyz = tmpvar_37;
  aseOutColor_3.w = spColor_27.w;
  mediump vec3 tmpvar_38;
  highp vec3 N_39;
  N_39 = N_2;
  highp vec3 V_40;
  V_40 = V_1;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = pow (clamp ((1.001 - 
    dot (V_40, N_39)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_41 = (_RGBias + (tmpvar_42 * _RGScale));
  mediump vec3 tmpvar_43;
  tmpvar_43 = (tmpvar_41 * _RGColor).xyz;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (tmpvar_41, 0.0, 1.0);
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (spColor_27.xyz, tmpvar_43, vec3((tmpvar_44 * _RGRatio)));
  tmpvar_38 = tmpvar_45;
  aseOutColor_3.xyz = mix (tmpvar_38, vec3(dot (tmpvar_38, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = aseOutColor_3.xyz;
  tmpvar_46.w = clamp (tmpvar_19, 0.0, 1.0);
  gl_FragData[0] = tmpvar_46;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec4 spuvs_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (_glesVertex * 0.5);
  spuvs_7.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = (tmpvar_8.x + (tmpvar_8.z * tmpvar_8.z));
  tmpvar_9.y = ((tmpvar_8.y + (0.5 * tmpvar_8.z)) + ((0.5 * tmpvar_8.x) * tmpvar_8.x));
  spuvs_7.zw = ((tmpvar_9 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = spuvs_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
uniform mediump float _Opacity;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 N_2;
  mediump vec4 aseOutColor_3;
  mediump vec3 staticSwitch220_4;
  mediump float temp_output_231_0_5;
  mediump vec4 tex2DNode10_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_9;
  tmpvar_9 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_5 = tmpvar_9;
  mediump float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Smoothstep);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((
    (tmpvar_8 + temp_output_231_0_5)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tex2DNode10_6.xyz * _DarkColor);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_8 + temp_output_231_0_5) + _DarkDisCt);
  mediump float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (tmpvar_14 + _Rim)
   - tmpvar_11) / (_Smoothstep - tmpvar_11)), 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  staticSwitch220_4 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_4 = mix (tmpvar_13, (tex2DNode10_6.xyz * _RimColor), vec3(tmpvar_15));
  } else {
    staticSwitch220_4 = tmpvar_13;
  };
  mediump float edge0_17;
  edge0_17 = (1.0 - _Smoothstep);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_14 - edge0_17) / (_Smoothstep - edge0_17)), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = ((_LightColor.w * tex2DNode10_6.w) * (tmpvar_10 * _Opacity));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_4, (
    (tex2DNode10_6.xyz * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_18 * 
    (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))
  ))));
  aseOutColor_3.w = tmpvar_20.w;
  aseOutColor_3.xyz = (tmpvar_20.xyz * _EnvColor.xyz);
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  N_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_1 = tmpvar_22;
  mediump vec3 reflection_23;
  mediump vec3 R_24;
  mediump float intensity_25;
  mediump vec4 noiseTex_26;
  mediump vec4 spColor_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_27.xyz = tmpvar_28.xyz;
  spColor_27.w = aseOutColor_3.w;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_26 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((1.99 * noiseTex_26.x) * _SPNoiseScaler) - 1.0);
  intensity_25 = tmpvar_30;
  highp vec3 tmpvar_31;
  highp vec3 I_32;
  I_32 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_26 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_31 = (I_32 - (2.0 * (
    dot (N_2, I_32)
   * N_2)));
  R_24 = tmpvar_31;
  lowp vec3 tmpvar_33;
  tmpvar_33 = textureCube (_SPCubeMap, R_24).xyz;
  reflection_23 = tmpvar_33;
  highp vec3 tmpvar_34;
  mediump vec3 x_35;
  x_35 = (spColor_27.xyz * _SPOldColor.xyz);
  tmpvar_34 = mix (x_35, ((reflection_23 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_27.xyz = tmpvar_34;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_25 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_25 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_36;
      tmpvar_36 = mix (spColor_27, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_25) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_27 = tmpvar_36;
    };
  };
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (aseOutColor_3.xyz, spColor_27.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_27.xyz = tmpvar_37;
  aseOutColor_3.w = spColor_27.w;
  mediump vec3 tmpvar_38;
  highp vec3 N_39;
  N_39 = N_2;
  highp vec3 V_40;
  V_40 = V_1;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = pow (clamp ((1.001 - 
    dot (V_40, N_39)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_41 = (_RGBias + (tmpvar_42 * _RGScale));
  mediump vec3 tmpvar_43;
  tmpvar_43 = (tmpvar_41 * _RGColor).xyz;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (tmpvar_41, 0.0, 1.0);
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (spColor_27.xyz, tmpvar_43, vec3((tmpvar_44 * _RGRatio)));
  tmpvar_38 = tmpvar_45;
  aseOutColor_3.xyz = mix (tmpvar_38, vec3(dot (tmpvar_38, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = aseOutColor_3.xyz;
  tmpvar_46.w = clamp (tmpvar_19, 0.0, 1.0);
  gl_FragData[0] = tmpvar_46;
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
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" }
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
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
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
Keywords { "LUMINANCE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "RIM_GLOW" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.CharacterShaderEditorBase"
}