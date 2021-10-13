//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Terrain_Weather_LightMap (Reflecting Light)" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_Splat0Tex ("Splat0 Tex (RGB)", 2D) = "black" { }
_Splat1Tex ("Splat1 Tex (RGB)", 2D) = "black" { }
_Splat2Tex ("Splat2 Tex (RGB)", 2D) = "black" { }
_Splat3Tex ("Splat2 Tex (RGB)", 2D) = "black" { }
_ControlTex ("Control Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
[Toggle(USINGRIMGLOW)] _UsingRimGlow ("Using Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
_RGControlTexRRatio ("Rim Glow R Channel Ratio Of Control Tex", Range(0, 1)) = 1
_RGControlTexGRatio ("Rim Glow G Channel Ratio Of Control Tex", Range(0, 1)) = 1
_RGControlTexBRatio ("Rim Glow B Channel Ratio Of Control Tex", Range(0, 1)) = 1
_RGControlTexARatio ("Rim Glow A Channel Ratio Of Control Tex", Range(0, 1)) = 1
_ReflectionTex ("Reflection", 2D) = "black" { }
_ReflectMaskTex ("Reflect Mask Tex(R)", 2D) = "white" { }
_ReflectionEmissionAdjust ("Reflection Emission Adjust", Float) = 1
_FresnelParams ("Fresnel Parameters", Vector) = (1,1,0,0)
_MaskTex ("Mask", 2D) = "black" { }
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 26592
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = tmpvar_9.xyz;
  tmpvar_4 = tmpvar_10;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_6.zw;
  tmpvar_5 = o_11;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_8)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump float _DiffuseRatio;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD1.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD1.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD2.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD2.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0.xy);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD4), normalize(xlv_TEXCOORD3))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (colorBlendLightMap_1 * _DiffuseRatio);
  tmpvar_19.w = _BloomFactor;
  outColor_9.xyz = tmpvar_19.xyz;
  highp float tmpvar_20;
  tmpvar_20 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_20;
  gl_FragData[0] = outColor_9;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = tmpvar_9.xyz;
  tmpvar_4 = tmpvar_10;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_6.zw;
  tmpvar_5 = o_11;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_8)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump float _DiffuseRatio;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD1.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD1.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD2.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD2.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0.xy);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD4), normalize(xlv_TEXCOORD3))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (colorBlendLightMap_1 * _DiffuseRatio);
  tmpvar_19.w = _BloomFactor;
  outColor_9.xyz = tmpvar_19.xyz;
  highp float tmpvar_20;
  tmpvar_20 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_20;
  gl_FragData[0] = outColor_9;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = tmpvar_9.xyz;
  tmpvar_4 = tmpvar_10;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_6.zw;
  tmpvar_5 = o_11;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_8)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform mediump float _DiffuseRatio;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump float ratio_3;
  mediump vec4 Control_Color_4;
  mediump vec4 Splat3_Color_5;
  mediump vec4 Splat2_Color_6;
  mediump vec4 Splat1_Color_7;
  mediump vec4 Splat0_Color_8;
  mediump vec4 outColor_9;
  outColor_9 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Splat0Tex, xlv_TEXCOORD1.xy);
  Splat0_Color_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Splat1Tex, xlv_TEXCOORD1.zw);
  Splat1_Color_7 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Splat2Tex, xlv_TEXCOORD2.xy);
  Splat2_Color_6 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Splat3Tex, xlv_TEXCOORD2.zw);
  Splat3_Color_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ControlTex, xlv_TEXCOORD0.xy);
  Control_Color_4 = tmpvar_14;
  ratio_3 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD4), normalize(xlv_TEXCOORD3))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_15 = (_RGBias + (tmpvar_16 * _RGScale));
    mediump vec3 tmpvar_17;
    tmpvar_17 = (tmpvar_15 * _RGColor).xyz;
    ratio_3 = (clamp (tmpvar_15, 0.0, 1.0) * _RGRatio);
    Splat0_Color_8.xyz = (Splat0_Color_8.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexRRatio));
    Splat1_Color_7.xyz = (Splat1_Color_7.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexGRatio));
    Splat2_Color_6.xyz = (Splat2_Color_6.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexBRatio));
    Splat3_Color_5.xyz = (Splat3_Color_5.xyz + ((tmpvar_17 * ratio_3) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_2 = tmpvar_18;
  colorBlendLightMap_1 = (((
    (((Splat0_Color_8 * Control_Color_4.x) + (Splat1_Color_7 * Control_Color_4.y)) + (Splat2_Color_6 * Control_Color_4.z))
   + 
    (Splat3_Color_5 * Control_Color_4.w)
  ).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (colorBlendLightMap_1 * _DiffuseRatio);
  tmpvar_19.w = _BloomFactor;
  outColor_9.xyz = tmpvar_19.xyz;
  highp float tmpvar_20;
  tmpvar_20 = mix (_BloomFactor, _RGBloomFactor, ratio_3);
  outColor_9.w = tmpvar_20;
  gl_FragData[0] = outColor_9;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = tmpvar_9.xyz;
  tmpvar_4 = tmpvar_10;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_6.zw;
  tmpvar_5 = o_11;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_8)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
uniform mediump float _DiffuseRatio;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD1.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD1.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD2.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD2.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0.xy);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD4), normalize(xlv_TEXCOORD3))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD3;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = (colorBlendLightMap_4 * _DiffuseRatio);
  tmpvar_28.w = _BloomFactor;
  outColor_13.xyz = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ))).xyz;
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  gl_FragData[0] = outColor_13;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = tmpvar_9.xyz;
  tmpvar_4 = tmpvar_10;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_6.zw;
  tmpvar_5 = o_11;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_8)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
uniform mediump float _DiffuseRatio;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD1.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD1.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD2.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD2.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0.xy);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD4), normalize(xlv_TEXCOORD3))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD3;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = (colorBlendLightMap_4 * _DiffuseRatio);
  tmpvar_28.w = _BloomFactor;
  outColor_13.xyz = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ))).xyz;
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  gl_FragData[0] = outColor_13;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Splat0Tex_ST;
uniform mediump vec4 _Splat1Tex_ST;
uniform mediump vec4 _Splat2Tex_ST;
uniform mediump vec4 _Splat3Tex_ST;
uniform mediump vec4 _ControlTex_ST;
uniform mediump vec4 _ShadowTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _ControlTex_ST.xy) + _ControlTex_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat0Tex_ST.xy) + _Splat0Tex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat1Tex_ST.xy) + _Splat1Tex_ST.zw);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _Splat2Tex_ST.xy) + _Splat2Tex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Splat3Tex_ST.xy) + _Splat3Tex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_10;
  tmpvar_10 = tmpvar_9.xyz;
  tmpvar_4 = tmpvar_10;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_6.zw;
  tmpvar_5 = o_11;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = normalize(normalize((_glesNormal * tmpvar_8)));
  xlv_TEXCOORD4 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _Splat0Tex;
uniform sampler2D _Splat1Tex;
uniform sampler2D _Splat2Tex;
uniform sampler2D _Splat3Tex;
uniform sampler2D _ControlTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingRimGlow;
uniform highp float _RGControlTexRRatio;
uniform highp float _RGControlTexGRatio;
uniform highp float _RGControlTexBRatio;
uniform highp float _RGControlTexARatio;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectMaskTex;
uniform mediump float _ReflectionEmissionAdjust;
uniform mediump vec4 _FresnelParams;
uniform mediump float _DiffuseRatio;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 reflColor_1;
  highp vec2 uvSC_2;
  mediump vec3 I_3;
  mediump vec3 colorBlendLightMap_4;
  mediump float reflectMask_5;
  mediump vec4 tex_S_Color_6;
  mediump float ratio_7;
  mediump vec4 Control_Color_8;
  mediump vec4 Splat3_Color_9;
  mediump vec4 Splat2_Color_10;
  mediump vec4 Splat1_Color_11;
  mediump vec4 Splat0_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Splat0Tex, xlv_TEXCOORD1.xy);
  Splat0_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Splat1Tex, xlv_TEXCOORD1.zw);
  Splat1_Color_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Splat2Tex, xlv_TEXCOORD2.xy);
  Splat2_Color_10 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Splat3Tex, xlv_TEXCOORD2.zw);
  Splat3_Color_9 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ControlTex, xlv_TEXCOORD0.xy);
  Control_Color_8 = tmpvar_18;
  ratio_7 = 0.0;
  if (bool(_UsingRimGlow)) {
    mediump float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = pow (clamp ((1.0 - 
      dot (normalize(xlv_TEXCOORD4), normalize(xlv_TEXCOORD3))
    ), 0.0, 1.0), _RGShininess);
    tmpvar_19 = (_RGBias + (tmpvar_20 * _RGScale));
    mediump vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_19 * _RGColor).xyz;
    ratio_7 = (clamp (tmpvar_19, 0.0, 1.0) * _RGRatio);
    Splat0_Color_12.xyz = (Splat0_Color_12.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexRRatio));
    Splat1_Color_11.xyz = (Splat1_Color_11.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexGRatio));
    Splat2_Color_10.xyz = (Splat2_Color_10.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexBRatio));
    Splat3_Color_9.xyz = (Splat3_Color_9.xyz + ((tmpvar_21 * ratio_7) * _RGControlTexARatio));
  };
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  tex_S_Color_6 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2D (_ReflectMaskTex, xlv_TEXCOORD0.zw).x;
  reflectMask_5 = tmpvar_23;
  colorBlendLightMap_4 = (((
    (((Splat0_Color_12 * Control_Color_8.x) + (Splat1_Color_11 * Control_Color_8.y)) + (Splat2_Color_10 * Control_Color_8.z))
   + 
    (Splat3_Color_9 * Control_Color_8.w)
  ).xyz * (
    (((2.0 * tex_S_Color_6.xyz) * tex_S_Color_6.w) + 1.0)
   - tex_S_Color_6.w)) * _LightMapIntensity);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD5));
  I_3 = tmpvar_24;
  mediump vec3 N_25;
  N_25 = xlv_TEXCOORD3;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w);
  uvSC_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ReflectionTex, uvSC_2);
  reflColor_1 = tmpvar_27;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * reflectMask_5);
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = (colorBlendLightMap_4 * _DiffuseRatio);
  tmpvar_28.w = _BloomFactor;
  outColor_13.xyz = (tmpvar_28 + (reflColor_1 * (_FresnelParams.z + 
    max (0.0, (pow (clamp (
      (1.0 - dot (I_3, N_25))
    , 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y))
  ))).xyz;
  highp float tmpvar_29;
  tmpvar_29 = mix (_BloomFactor, _RGBloomFactor, ratio_7);
  outColor_13.w = tmpvar_29;
  gl_FragData[0] = outColor_13;
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
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" }
""
}
}
}
}
Fallback "Diffuse"
}