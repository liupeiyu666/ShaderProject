//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop_Toon" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Environment Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_LightMapTex ("Light Map Tex (RGB)", 2D) = "gray" { }
[Toggle] _UseLightDir ("Use Light Dir", Float) = 0
_LightDir ("Light Dir (world space)", Vector) = (0.4,-0.2,0.9,0)
_LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
_LightArea ("Light Area Threshold", Range(0, 1)) = 0.51
_SecondShadow ("Second Shadow Threshold", Range(0, 1)) = 0.51
_FirstShadowMultColor ("First Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
_SecondShadowMultColor ("Second Shadow Multiply Color", Color) = (0.75,0.6,0.65,1)
_Shininess ("Specular Shininess", Range(0.1, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_OutlineCamStart ("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
[Toggle(CHANNLE_MIX)] _ChannelMix ("Channle Mix", Float) = 0
_TintColor0 ("Tint Color0", Color) = (0.5,0.5,0.5,0.5)
_TintColor1 ("Tint Color1", Color) = (0.5,0.5,0.5,0.5)
_TintColor2 ("Tint Color2", Color) = (0.5,0.5,0.5,0.5)
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
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Geometry" "Reflected" = "Reflected" "RenderType" = "Opaque" }
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Geometry" "Reflected" = "Reflected" "RenderType" = "Opaque" }
  GpuProgramID 16147
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = (outColor_4.xyz * _Color.xyz);
  mediump vec3 tmpvar_20;
  highp vec3 N_21;
  N_21 = tmpvar_12;
  highp vec3 V_22;
  V_22 = V_1;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = pow (clamp ((1.001 - 
    dot (V_22, N_21)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_23 = (_RGBias + (tmpvar_24 * _RGScale));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _RGColor).xyz;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (tmpvar_23, 0.0, 1.0);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (outColor_4.xyz, tmpvar_25, vec3((tmpvar_26 * _RGRatio)));
  tmpvar_20 = tmpvar_27;
  outColor_4.xyz = tmpvar_20;
  gl_FragData[0] = outColor_4;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  gl_FragData[0] = outColor_4;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform bool _UseLightDir;
uniform mediump vec3 _LightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  tmpvar_4 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  tmpvar_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  if (_UseLightDir) {
    mediump vec3 tmpvar_12;
    tmpvar_12 = normalize(_LightDir);
    tmpvar_11 = tmpvar_12;
  } else {
    tmpvar_11 = _WorldSpaceLightPos0.xyz;
  };
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_13;
  L_13 = tmpvar_5;
  if ((_CustomLightDir.w > 0.5)) {
    L_13 = _CustomLightDir.xyz;
  };
  highp vec4 spuvs_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  spuvs_14.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  spuvs_14.zw = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = spuvs_14;
  xlv_COLOR1 = ((dot (tmpvar_3, L_13) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _BloomFactor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform bool _ChannelMix;
uniform mediump vec3 _TintColor0;
uniform mediump vec3 _TintColor1;
uniform mediump vec3 _TintColor2;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump float xlv_COLOR1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec3 V_1;
  mediump vec3 baseTexColor_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_6;
  if (_ChannelMix) {
    mediump vec3 srcColor_7;
    srcColor_7 = baseTexColor_2;
    baseTexColor_2 = mix (_TintColor0, _TintColor1, baseTexColor_2.xxx);
    baseTexColor_2 = mix (baseTexColor_2, _TintColor2, srcColor_7.yyy);
  };
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_2 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_2 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_2;
    };
  };
  outColor_4.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  V_1 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((xlv_TEXCOORD4 + V_1));
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = tmpvar_14;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((tmpvar_14 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_3.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_10 + color_15);
  outColor_4.w = _BloomFactor;
  mediump vec3 reflection_20;
  mediump vec3 R_21;
  mediump float intensity_22;
  mediump vec4 noiseTex_23;
  mediump vec4 spColor_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_SPTex, xlv_TEXCOORD5.xy);
  spColor_24.xyz = tmpvar_25.xyz;
  spColor_24.w = outColor_4.w;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_SPNoiseTex, xlv_TEXCOORD5.zw);
  noiseTex_23 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (((1.99 * noiseTex_23.x) * _SPNoiseScaler) - 1.0);
  intensity_22 = tmpvar_27;
  highp vec3 tmpvar_28;
  highp vec3 I_29;
  I_29 = ((normalize(
    (V_1 - _WorldSpaceCameraPos)
  ) + (noiseTex_23 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_28 = (I_29 - (2.0 * (
    dot (tmpvar_12, I_29)
   * tmpvar_12)));
  R_21 = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = textureCube (_SPCubeMap, R_21).xyz;
  reflection_20 = tmpvar_30;
  highp vec3 tmpvar_31;
  mediump vec3 x_32;
  x_32 = (spColor_24.xyz * _SPOldColor.xyz);
  tmpvar_31 = mix (x_32, ((reflection_20 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_24.xyz = tmpvar_31;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_22 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_22 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_33;
      tmpvar_33 = mix (spColor_24, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_22) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_24 = tmpvar_33;
    };
  };
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (outColor_4.xyz, spColor_24.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_24.xyz = tmpvar_34;
  outColor_4.w = spColor_24.w;
  outColor_4.xyz = (spColor_24.xyz * _Color.xyz);
  mediump vec3 tmpvar_35;
  highp vec3 N_36;
  N_36 = tmpvar_12;
  highp vec3 V_37;
  V_37 = V_1;
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = pow (clamp ((1.001 - 
    dot (V_37, N_36)
  ), 0.001, 1.0), _RGShininess);
  tmpvar_38 = (_RGBias + (tmpvar_39 * _RGScale));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_38 * _RGColor).xyz;
  mediump float tmpvar_41;
  tmpvar_41 = clamp (tmpvar_38, 0.0, 1.0);
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_4.xyz, tmpvar_40, vec3((tmpvar_41 * _RGRatio)));
  tmpvar_35 = tmpvar_42;
  outColor_4.xyz = tmpvar_35;
  gl_FragData[0] = outColor_4;
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
Keywords { "ALPHA_ORIG" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "RIM_GLOW" }
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
Keywords { "ALPHA_ORIG" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "SPECIAL_STATE" }
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
Keywords { "ALPHA_ORIG" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" "SPECIAL_STATE" "RIM_GLOW" }
""
}
}
}
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Geometry" "Reflected" = "Reflected" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 117441
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
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
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
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
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
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
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
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = xlv_COLOR0;
  };
  color_1.w = outColor_4.w;
  color_1.xyz = (outColor_4.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD3;
    mediump float a_8;
    a_8 = xlv_TEXCOORD3.z;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_8 = (a_8 * 17.0);
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_7.y / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_7.x / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float x_15;
      x_15 = ((a_8 - _DITHERMATRIX[
        int(tmpvar_11)
      ][
        int(tmpvar_14)
      ]) - 0.01);
      if ((x_15 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (outColor_4.w, 0.0, 1.0);
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
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = xlv_COLOR0;
  };
  color_1.w = outColor_4.w;
  color_1.xyz = (outColor_4.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD3;
    mediump float a_8;
    a_8 = xlv_TEXCOORD3.z;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_8 = (a_8 * 17.0);
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_7.y / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_7.x / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float x_15;
      x_15 = ((a_8 - _DITHERMATRIX[
        int(tmpvar_11)
      ][
        int(tmpvar_14)
      ]) - 0.01);
      if ((x_15 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (outColor_4.w, 0.0, 1.0);
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
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = xlv_COLOR0;
  };
  color_1.w = outColor_4.w;
  color_1.xyz = (outColor_4.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD3;
    mediump float a_8;
    a_8 = xlv_TEXCOORD3.z;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_8 = (a_8 * 17.0);
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_7.y / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_7.x / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float x_15;
      x_15 = ((a_8 - _DITHERMATRIX[
        int(tmpvar_11)
      ][
        int(tmpvar_14)
      ]) - 0.01);
      if ((x_15 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (outColor_4.w, 0.0, 1.0);
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
}
Fallback "Diffuse"
CustomEditor "MoleMole.CharacterShaderEditorBase"
}