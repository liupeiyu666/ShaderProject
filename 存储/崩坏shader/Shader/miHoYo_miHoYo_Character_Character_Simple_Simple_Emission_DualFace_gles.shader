//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Simple/Simple_Emission_DualFace" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_EmissionColor ("Emmisive Color", Color) = (0.5,0.5,0.5,1)
_BackFaceColor ("Back Face Color", Color) = (1,1,1,1)
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Outline ("Outline Width", Float) = 0.02
[Toggle] _OutlineUseTangent ("Use Tangent For Outline", Float) = 0
_SpecMulti ("Specular Multiply", Float) = 1
_Shininess ("Shininess", Range(0.1, 100)) = 2
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_Ramp ("Toon Ramp (RGB)", 2D) = "white" { }
_SpecRamp ("Specular Ramp (RGB)", 2D) = "black" { }
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_Emission ("Emission", Range(1, 100)) = 1
_EmissionBloomFactor ("Emission Bloom Factor", Float) = 1
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
[Toggle(TRANSPARENT)] _Transparent ("Transparent", Float) = 0
_MainAlpha ("Main Alpha Range(0, 1)", Range(0, 1)) = 1
_AdditiveLightIntensity ("Addtive Light Intensity", Range(0, 5)) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
_OffestFactor ("OFfset Factor", Range(-100, 100)) = 0
_OffestUnit ("OFfset Unit", Range(-100, 100)) = 0
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "DrawDepth" = "DualFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Geometry+10" "Reflected" = "Reflected" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "DualFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Geometry+10" "Reflected" = "Reflected" "RenderType" = "Opaque" }
  GpuProgramID 43373
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  highp float tmpvar_11;
  tmpvar_11 = ((dot (tmpvar_10, tmpvar_8.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = d_2;
  tmpvar_12.y = d_2;
  highp float tmpvar_13;
  tmpvar_13 = pow (max (dot (tmpvar_10, 
    normalize((tmpvar_8.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_1 = tmpvar_13;
  mediump float tmpvar_14;
  if ((d_2 < 0.5)) {
    tmpvar_14 = 0.025;
  } else {
    tmpvar_14 = s_1;
  };
  s_1 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = tmpvar_14;
  highp vec4 o_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_6.zw;
  tmpvar_5.xyw = o_16.xyw;
  tmpvar_5.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_15;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = _BloomFactor;
  highp vec4 scrpos_12;
  scrpos_12 = xlv_TEXCOORD7;
  mediump float a_13;
  a_13 = xlv_TEXCOORD7.z;
  if ((a_13 < 0.95)) {
    scrpos_12.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_13 = (a_13 * 17.0);
    highp float tmpvar_14;
    tmpvar_14 = (scrpos_12.y / 4.0);
    highp float tmpvar_15;
    tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
    highp float tmpvar_16;
    if ((tmpvar_14 >= 0.0)) {
      tmpvar_16 = tmpvar_15;
    } else {
      tmpvar_16 = -(tmpvar_15);
    };
    highp float tmpvar_17;
    tmpvar_17 = (scrpos_12.x / 4.0);
    highp float tmpvar_18;
    tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
    highp float tmpvar_19;
    if ((tmpvar_17 >= 0.0)) {
      tmpvar_19 = tmpvar_18;
    } else {
      tmpvar_19 = -(tmpvar_18);
    };
    highp float x_20;
    x_20 = ((a_13 - _DITHERMATRIX[
      int(tmpvar_16)
    ][
      int(tmpvar_19)
    ]) - 0.01);
    if ((x_20 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_4.w);
  tmpvar_1 = outColor_5;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  highp float tmpvar_11;
  tmpvar_11 = ((dot (tmpvar_10, tmpvar_8.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = d_2;
  tmpvar_12.y = d_2;
  highp float tmpvar_13;
  tmpvar_13 = pow (max (dot (tmpvar_10, 
    normalize((tmpvar_8.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_1 = tmpvar_13;
  mediump float tmpvar_14;
  if ((d_2 < 0.5)) {
    tmpvar_14 = 0.025;
  } else {
    tmpvar_14 = s_1;
  };
  s_1 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = tmpvar_14;
  highp vec4 o_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_6.zw;
  tmpvar_5.xyw = o_16.xyw;
  tmpvar_5.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_15;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = _BloomFactor;
  highp vec4 scrpos_12;
  scrpos_12 = xlv_TEXCOORD7;
  mediump float a_13;
  a_13 = xlv_TEXCOORD7.z;
  if ((a_13 < 0.95)) {
    scrpos_12.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_13 = (a_13 * 17.0);
    highp float tmpvar_14;
    tmpvar_14 = (scrpos_12.y / 4.0);
    highp float tmpvar_15;
    tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
    highp float tmpvar_16;
    if ((tmpvar_14 >= 0.0)) {
      tmpvar_16 = tmpvar_15;
    } else {
      tmpvar_16 = -(tmpvar_15);
    };
    highp float tmpvar_17;
    tmpvar_17 = (scrpos_12.x / 4.0);
    highp float tmpvar_18;
    tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
    highp float tmpvar_19;
    if ((tmpvar_17 >= 0.0)) {
      tmpvar_19 = tmpvar_18;
    } else {
      tmpvar_19 = -(tmpvar_18);
    };
    highp float x_20;
    x_20 = ((a_13 - _DITHERMATRIX[
      int(tmpvar_16)
    ][
      int(tmpvar_19)
    ]) - 0.01);
    if ((x_20 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_4.w);
  tmpvar_1 = outColor_5;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  highp float tmpvar_11;
  tmpvar_11 = ((dot (tmpvar_10, tmpvar_8.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = d_2;
  tmpvar_12.y = d_2;
  highp float tmpvar_13;
  tmpvar_13 = pow (max (dot (tmpvar_10, 
    normalize((tmpvar_8.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_1 = tmpvar_13;
  mediump float tmpvar_14;
  if ((d_2 < 0.5)) {
    tmpvar_14 = 0.025;
  } else {
    tmpvar_14 = s_1;
  };
  s_1 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = tmpvar_14;
  highp vec4 o_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_6.zw;
  tmpvar_5.xyw = o_16.xyw;
  tmpvar_5.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_15;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = _BloomFactor;
  highp vec4 scrpos_12;
  scrpos_12 = xlv_TEXCOORD7;
  mediump float a_13;
  a_13 = xlv_TEXCOORD7.z;
  if ((a_13 < 0.95)) {
    scrpos_12.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_13 = (a_13 * 17.0);
    highp float tmpvar_14;
    tmpvar_14 = (scrpos_12.y / 4.0);
    highp float tmpvar_15;
    tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
    highp float tmpvar_16;
    if ((tmpvar_14 >= 0.0)) {
      tmpvar_16 = tmpvar_15;
    } else {
      tmpvar_16 = -(tmpvar_15);
    };
    highp float tmpvar_17;
    tmpvar_17 = (scrpos_12.x / 4.0);
    highp float tmpvar_18;
    tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
    highp float tmpvar_19;
    if ((tmpvar_17 >= 0.0)) {
      tmpvar_19 = tmpvar_18;
    } else {
      tmpvar_19 = -(tmpvar_18);
    };
    highp float x_20;
    x_20 = ((a_13 - _DITHERMATRIX[
      int(tmpvar_16)
    ][
      int(tmpvar_19)
    ]) - 0.01);
    if ((x_20 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_4.w);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_glesNormal * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = ((dot (tmpvar_11, tmpvar_9.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_2;
  tmpvar_13.y = d_2;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_15;
  tmpvar_15 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + normalize((_WorldSpaceCameraPos - tmpvar_14.xyz))))
  ), 0.0), _Shininess);
  s_1 = tmpvar_15;
  mediump float tmpvar_16;
  if ((d_2 < 0.5)) {
    tmpvar_16 = 0.025;
  } else {
    tmpvar_16 = s_1;
  };
  s_1 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = tmpvar_16;
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_7.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  mediump vec3 tmpvar_21;
  highp vec3 lightColor0_22;
  lightColor0_22 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_23;
  lightColor1_23 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_24;
  lightColor2_24 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_25;
  lightColor3_25 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_26;
  lightAttenSq_26 = unity_4LightAtten0;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_14.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_14.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_14.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * tmpvar_11.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * tmpvar_11.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * tmpvar_11.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_26)
  ))));
  col_27 = (lightColor0_22 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_23 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_24 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_25 * tmpvar_35.w));
  tmpvar_21 = col_27;
  tmpvar_6 = tmpvar_21;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_5;
  xlv_TEXCOORD8 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz + (outColor_5.xyz * xlv_TEXCOORD8));
  highp vec4 scrpos_12;
  scrpos_12 = xlv_TEXCOORD7;
  mediump float a_13;
  a_13 = xlv_TEXCOORD7.z;
  if ((a_13 < 0.95)) {
    scrpos_12.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_13 = (a_13 * 17.0);
    highp float tmpvar_14;
    tmpvar_14 = (scrpos_12.y / 4.0);
    highp float tmpvar_15;
    tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
    highp float tmpvar_16;
    if ((tmpvar_14 >= 0.0)) {
      tmpvar_16 = tmpvar_15;
    } else {
      tmpvar_16 = -(tmpvar_15);
    };
    highp float tmpvar_17;
    tmpvar_17 = (scrpos_12.x / 4.0);
    highp float tmpvar_18;
    tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
    highp float tmpvar_19;
    if ((tmpvar_17 >= 0.0)) {
      tmpvar_19 = tmpvar_18;
    } else {
      tmpvar_19 = -(tmpvar_18);
    };
    highp float x_20;
    x_20 = ((a_13 - _DITHERMATRIX[
      int(tmpvar_16)
    ][
      int(tmpvar_19)
    ]) - 0.01);
    if ((x_20 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_4.w);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_glesNormal * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = ((dot (tmpvar_11, tmpvar_9.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_2;
  tmpvar_13.y = d_2;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_15;
  tmpvar_15 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + normalize((_WorldSpaceCameraPos - tmpvar_14.xyz))))
  ), 0.0), _Shininess);
  s_1 = tmpvar_15;
  mediump float tmpvar_16;
  if ((d_2 < 0.5)) {
    tmpvar_16 = 0.025;
  } else {
    tmpvar_16 = s_1;
  };
  s_1 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = tmpvar_16;
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_7.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  mediump vec3 tmpvar_21;
  highp vec3 lightColor0_22;
  lightColor0_22 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_23;
  lightColor1_23 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_24;
  lightColor2_24 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_25;
  lightColor3_25 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_26;
  lightAttenSq_26 = unity_4LightAtten0;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_14.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_14.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_14.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * tmpvar_11.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * tmpvar_11.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * tmpvar_11.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_26)
  ))));
  col_27 = (lightColor0_22 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_23 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_24 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_25 * tmpvar_35.w));
  tmpvar_21 = col_27;
  tmpvar_6 = tmpvar_21;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_5;
  xlv_TEXCOORD8 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz + (outColor_5.xyz * xlv_TEXCOORD8));
  highp vec4 scrpos_12;
  scrpos_12 = xlv_TEXCOORD7;
  mediump float a_13;
  a_13 = xlv_TEXCOORD7.z;
  if ((a_13 < 0.95)) {
    scrpos_12.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_13 = (a_13 * 17.0);
    highp float tmpvar_14;
    tmpvar_14 = (scrpos_12.y / 4.0);
    highp float tmpvar_15;
    tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
    highp float tmpvar_16;
    if ((tmpvar_14 >= 0.0)) {
      tmpvar_16 = tmpvar_15;
    } else {
      tmpvar_16 = -(tmpvar_15);
    };
    highp float tmpvar_17;
    tmpvar_17 = (scrpos_12.x / 4.0);
    highp float tmpvar_18;
    tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
    highp float tmpvar_19;
    if ((tmpvar_17 >= 0.0)) {
      tmpvar_19 = tmpvar_18;
    } else {
      tmpvar_19 = -(tmpvar_18);
    };
    highp float x_20;
    x_20 = ((a_13 - _DITHERMATRIX[
      int(tmpvar_16)
    ][
      int(tmpvar_19)
    ]) - 0.01);
    if ((x_20 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_4.w);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_glesNormal * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = ((dot (tmpvar_11, tmpvar_9.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_2;
  tmpvar_13.y = d_2;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_15;
  tmpvar_15 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + normalize((_WorldSpaceCameraPos - tmpvar_14.xyz))))
  ), 0.0), _Shininess);
  s_1 = tmpvar_15;
  mediump float tmpvar_16;
  if ((d_2 < 0.5)) {
    tmpvar_16 = 0.025;
  } else {
    tmpvar_16 = s_1;
  };
  s_1 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = tmpvar_16;
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_7.zw;
  tmpvar_5.xyw = o_18.xyw;
  tmpvar_5.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  mediump vec3 tmpvar_21;
  highp vec3 lightColor0_22;
  lightColor0_22 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_23;
  lightColor1_23 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_24;
  lightColor2_24 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_25;
  lightColor3_25 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_26;
  lightAttenSq_26 = unity_4LightAtten0;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_14.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_14.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_14.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * tmpvar_11.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * tmpvar_11.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * tmpvar_11.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_26)
  ))));
  col_27 = (lightColor0_22 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_23 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_24 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_25 * tmpvar_35.w));
  tmpvar_21 = col_27;
  tmpvar_6 = tmpvar_21;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_5;
  xlv_TEXCOORD8 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz + (outColor_5.xyz * xlv_TEXCOORD8));
  highp vec4 scrpos_12;
  scrpos_12 = xlv_TEXCOORD7;
  mediump float a_13;
  a_13 = xlv_TEXCOORD7.z;
  if ((a_13 < 0.95)) {
    scrpos_12.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_13 = (a_13 * 17.0);
    highp float tmpvar_14;
    tmpvar_14 = (scrpos_12.y / 4.0);
    highp float tmpvar_15;
    tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
    highp float tmpvar_16;
    if ((tmpvar_14 >= 0.0)) {
      tmpvar_16 = tmpvar_15;
    } else {
      tmpvar_16 = -(tmpvar_15);
    };
    highp float tmpvar_17;
    tmpvar_17 = (scrpos_12.x / 4.0);
    highp float tmpvar_18;
    tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
    highp float tmpvar_19;
    if ((tmpvar_17 >= 0.0)) {
      tmpvar_19 = tmpvar_18;
    } else {
      tmpvar_19 = -(tmpvar_18);
    };
    highp float x_20;
    x_20 = ((a_13 - _DITHERMATRIX[
      int(tmpvar_16)
    ][
      int(tmpvar_19)
    ]) - 0.01);
    if ((x_20 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_4.w);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  highp float tmpvar_11;
  tmpvar_11 = ((dot (tmpvar_10, tmpvar_8.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = d_2;
  tmpvar_12.y = d_2;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_10, 
    normalize((tmpvar_8.xyz + tmpvar_13))
  ), 0.0), _Shininess);
  s_1 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_2 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_1;
  };
  s_1 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = tmpvar_15;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_6.zw;
  tmpvar_5.xyw = o_17.xyw;
  tmpvar_5.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = _BloomFactor;
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD6))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_13 = (_RGBias + (tmpvar_14 * _RGScale));
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _RGColor).xyz;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (tmpvar_13, 0.0, 1.0);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (outColor_5.xyz, tmpvar_15, vec3((tmpvar_16 * _RGRatio)));
  tmpvar_12 = tmpvar_17;
  outColor_5.xyz = tmpvar_12;
  highp vec4 scrpos_18;
  scrpos_18 = xlv_TEXCOORD7;
  mediump float a_19;
  a_19 = xlv_TEXCOORD7.z;
  if ((a_19 < 0.95)) {
    scrpos_18.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_19 = (a_19 * 17.0);
    highp float tmpvar_20;
    tmpvar_20 = (scrpos_18.y / 4.0);
    highp float tmpvar_21;
    tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
    highp float tmpvar_22;
    if ((tmpvar_20 >= 0.0)) {
      tmpvar_22 = tmpvar_21;
    } else {
      tmpvar_22 = -(tmpvar_21);
    };
    highp float tmpvar_23;
    tmpvar_23 = (scrpos_18.x / 4.0);
    highp float tmpvar_24;
    tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
    highp float tmpvar_25;
    if ((tmpvar_23 >= 0.0)) {
      tmpvar_25 = tmpvar_24;
    } else {
      tmpvar_25 = -(tmpvar_24);
    };
    highp float x_26;
    x_26 = ((a_19 - _DITHERMATRIX[
      int(tmpvar_22)
    ][
      int(tmpvar_25)
    ]) - 0.01);
    if ((x_26 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_4.w);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  highp float tmpvar_11;
  tmpvar_11 = ((dot (tmpvar_10, tmpvar_8.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = d_2;
  tmpvar_12.y = d_2;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_10, 
    normalize((tmpvar_8.xyz + tmpvar_13))
  ), 0.0), _Shininess);
  s_1 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_2 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_1;
  };
  s_1 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = tmpvar_15;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_6.zw;
  tmpvar_5.xyw = o_17.xyw;
  tmpvar_5.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = _BloomFactor;
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD6))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_13 = (_RGBias + (tmpvar_14 * _RGScale));
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _RGColor).xyz;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (tmpvar_13, 0.0, 1.0);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (outColor_5.xyz, tmpvar_15, vec3((tmpvar_16 * _RGRatio)));
  tmpvar_12 = tmpvar_17;
  outColor_5.xyz = tmpvar_12;
  highp vec4 scrpos_18;
  scrpos_18 = xlv_TEXCOORD7;
  mediump float a_19;
  a_19 = xlv_TEXCOORD7.z;
  if ((a_19 < 0.95)) {
    scrpos_18.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_19 = (a_19 * 17.0);
    highp float tmpvar_20;
    tmpvar_20 = (scrpos_18.y / 4.0);
    highp float tmpvar_21;
    tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
    highp float tmpvar_22;
    if ((tmpvar_20 >= 0.0)) {
      tmpvar_22 = tmpvar_21;
    } else {
      tmpvar_22 = -(tmpvar_21);
    };
    highp float tmpvar_23;
    tmpvar_23 = (scrpos_18.x / 4.0);
    highp float tmpvar_24;
    tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
    highp float tmpvar_25;
    if ((tmpvar_23 >= 0.0)) {
      tmpvar_25 = tmpvar_24;
    } else {
      tmpvar_25 = -(tmpvar_24);
    };
    highp float x_26;
    x_26 = ((a_19 - _DITHERMATRIX[
      int(tmpvar_22)
    ][
      int(tmpvar_25)
    ]) - 0.01);
    if ((x_26 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_4.w);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_8;
  tmpvar_8 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(normalize((_glesNormal * tmpvar_9)));
  highp float tmpvar_11;
  tmpvar_11 = ((dot (tmpvar_10, tmpvar_8.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = d_2;
  tmpvar_12.y = d_2;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_10, 
    normalize((tmpvar_8.xyz + tmpvar_13))
  ), 0.0), _Shininess);
  s_1 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_2 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_1;
  };
  s_1 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = tmpvar_15;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_6.zw;
  tmpvar_5.xyw = o_17.xyw;
  tmpvar_5.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = _BloomFactor;
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD6))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_13 = (_RGBias + (tmpvar_14 * _RGScale));
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _RGColor).xyz;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (tmpvar_13, 0.0, 1.0);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (outColor_5.xyz, tmpvar_15, vec3((tmpvar_16 * _RGRatio)));
  tmpvar_12 = tmpvar_17;
  outColor_5.xyz = tmpvar_12;
  highp vec4 scrpos_18;
  scrpos_18 = xlv_TEXCOORD7;
  mediump float a_19;
  a_19 = xlv_TEXCOORD7.z;
  if ((a_19 < 0.95)) {
    scrpos_18.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_19 = (a_19 * 17.0);
    highp float tmpvar_20;
    tmpvar_20 = (scrpos_18.y / 4.0);
    highp float tmpvar_21;
    tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
    highp float tmpvar_22;
    if ((tmpvar_20 >= 0.0)) {
      tmpvar_22 = tmpvar_21;
    } else {
      tmpvar_22 = -(tmpvar_21);
    };
    highp float tmpvar_23;
    tmpvar_23 = (scrpos_18.x / 4.0);
    highp float tmpvar_24;
    tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
    highp float tmpvar_25;
    if ((tmpvar_23 >= 0.0)) {
      tmpvar_25 = tmpvar_24;
    } else {
      tmpvar_25 = -(tmpvar_24);
    };
    highp float x_26;
    x_26 = ((a_19 - _DITHERMATRIX[
      int(tmpvar_22)
    ][
      int(tmpvar_25)
    ]) - 0.01);
    if ((x_26 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_4.w);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_glesNormal * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = ((dot (tmpvar_11, tmpvar_9.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_2;
  tmpvar_13.y = d_2;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  highp float tmpvar_16;
  tmpvar_16 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + tmpvar_15))
  ), 0.0), _Shininess);
  s_1 = tmpvar_16;
  mediump float tmpvar_17;
  if ((d_2 < 0.5)) {
    tmpvar_17 = 0.025;
  } else {
    tmpvar_17 = s_1;
  };
  s_1 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17;
  tmpvar_18.y = tmpvar_17;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_7.zw;
  tmpvar_5.xyw = o_19.xyw;
  tmpvar_5.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  mediump vec3 tmpvar_22;
  highp vec3 lightColor0_23;
  lightColor0_23 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_24;
  lightColor1_24 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_25;
  lightColor2_25 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_26;
  lightColor3_26 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_27;
  lightAttenSq_27 = unity_4LightAtten0;
  highp vec3 col_28;
  highp vec4 ndotl_29;
  highp vec4 lengthSq_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_14.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_14.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_14.z);
  lengthSq_30 = (tmpvar_31 * tmpvar_31);
  lengthSq_30 = (lengthSq_30 + (tmpvar_32 * tmpvar_32));
  lengthSq_30 = (lengthSq_30 + (tmpvar_33 * tmpvar_33));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (lengthSq_30, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_30 = tmpvar_34;
  ndotl_29 = (tmpvar_31 * tmpvar_11.x);
  ndotl_29 = (ndotl_29 + (tmpvar_32 * tmpvar_11.y));
  ndotl_29 = (ndotl_29 + (tmpvar_33 * tmpvar_11.z));
  highp vec4 tmpvar_35;
  tmpvar_35 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_29 * inversesqrt(tmpvar_34)));
  ndotl_29 = tmpvar_35;
  highp vec4 tmpvar_36;
  tmpvar_36 = (tmpvar_35 * (1.0/((1.0 + 
    (tmpvar_34 * lightAttenSq_27)
  ))));
  col_28 = (lightColor0_23 * tmpvar_36.x);
  col_28 = (col_28 + (lightColor1_24 * tmpvar_36.y));
  col_28 = (col_28 + (lightColor2_25 * tmpvar_36.z));
  col_28 = (col_28 + (lightColor3_26 * tmpvar_36.w));
  tmpvar_22 = col_28;
  tmpvar_6 = tmpvar_22;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_5;
  xlv_TEXCOORD8 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz + (outColor_5.xyz * xlv_TEXCOORD8));
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD6))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_13 = (_RGBias + (tmpvar_14 * _RGScale));
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _RGColor).xyz;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (tmpvar_13, 0.0, 1.0);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (outColor_5.xyz, tmpvar_15, vec3((tmpvar_16 * _RGRatio)));
  tmpvar_12 = tmpvar_17;
  outColor_5.xyz = tmpvar_12;
  highp vec4 scrpos_18;
  scrpos_18 = xlv_TEXCOORD7;
  mediump float a_19;
  a_19 = xlv_TEXCOORD7.z;
  if ((a_19 < 0.95)) {
    scrpos_18.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_19 = (a_19 * 17.0);
    highp float tmpvar_20;
    tmpvar_20 = (scrpos_18.y / 4.0);
    highp float tmpvar_21;
    tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
    highp float tmpvar_22;
    if ((tmpvar_20 >= 0.0)) {
      tmpvar_22 = tmpvar_21;
    } else {
      tmpvar_22 = -(tmpvar_21);
    };
    highp float tmpvar_23;
    tmpvar_23 = (scrpos_18.x / 4.0);
    highp float tmpvar_24;
    tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
    highp float tmpvar_25;
    if ((tmpvar_23 >= 0.0)) {
      tmpvar_25 = tmpvar_24;
    } else {
      tmpvar_25 = -(tmpvar_24);
    };
    highp float x_26;
    x_26 = ((a_19 - _DITHERMATRIX[
      int(tmpvar_22)
    ][
      int(tmpvar_25)
    ]) - 0.01);
    if ((x_26 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_4.w);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_glesNormal * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = ((dot (tmpvar_11, tmpvar_9.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_2;
  tmpvar_13.y = d_2;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  highp float tmpvar_16;
  tmpvar_16 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + tmpvar_15))
  ), 0.0), _Shininess);
  s_1 = tmpvar_16;
  mediump float tmpvar_17;
  if ((d_2 < 0.5)) {
    tmpvar_17 = 0.025;
  } else {
    tmpvar_17 = s_1;
  };
  s_1 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17;
  tmpvar_18.y = tmpvar_17;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_7.zw;
  tmpvar_5.xyw = o_19.xyw;
  tmpvar_5.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  mediump vec3 tmpvar_22;
  highp vec3 lightColor0_23;
  lightColor0_23 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_24;
  lightColor1_24 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_25;
  lightColor2_25 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_26;
  lightColor3_26 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_27;
  lightAttenSq_27 = unity_4LightAtten0;
  highp vec3 col_28;
  highp vec4 ndotl_29;
  highp vec4 lengthSq_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_14.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_14.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_14.z);
  lengthSq_30 = (tmpvar_31 * tmpvar_31);
  lengthSq_30 = (lengthSq_30 + (tmpvar_32 * tmpvar_32));
  lengthSq_30 = (lengthSq_30 + (tmpvar_33 * tmpvar_33));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (lengthSq_30, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_30 = tmpvar_34;
  ndotl_29 = (tmpvar_31 * tmpvar_11.x);
  ndotl_29 = (ndotl_29 + (tmpvar_32 * tmpvar_11.y));
  ndotl_29 = (ndotl_29 + (tmpvar_33 * tmpvar_11.z));
  highp vec4 tmpvar_35;
  tmpvar_35 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_29 * inversesqrt(tmpvar_34)));
  ndotl_29 = tmpvar_35;
  highp vec4 tmpvar_36;
  tmpvar_36 = (tmpvar_35 * (1.0/((1.0 + 
    (tmpvar_34 * lightAttenSq_27)
  ))));
  col_28 = (lightColor0_23 * tmpvar_36.x);
  col_28 = (col_28 + (lightColor1_24 * tmpvar_36.y));
  col_28 = (col_28 + (lightColor2_25 * tmpvar_36.z));
  col_28 = (col_28 + (lightColor3_26 * tmpvar_36.w));
  tmpvar_22 = col_28;
  tmpvar_6 = tmpvar_22;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_5;
  xlv_TEXCOORD8 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz + (outColor_5.xyz * xlv_TEXCOORD8));
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD6))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_13 = (_RGBias + (tmpvar_14 * _RGScale));
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _RGColor).xyz;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (tmpvar_13, 0.0, 1.0);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (outColor_5.xyz, tmpvar_15, vec3((tmpvar_16 * _RGRatio)));
  tmpvar_12 = tmpvar_17;
  outColor_5.xyz = tmpvar_12;
  highp vec4 scrpos_18;
  scrpos_18 = xlv_TEXCOORD7;
  mediump float a_19;
  a_19 = xlv_TEXCOORD7.z;
  if ((a_19 < 0.95)) {
    scrpos_18.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_19 = (a_19 * 17.0);
    highp float tmpvar_20;
    tmpvar_20 = (scrpos_18.y / 4.0);
    highp float tmpvar_21;
    tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
    highp float tmpvar_22;
    if ((tmpvar_20 >= 0.0)) {
      tmpvar_22 = tmpvar_21;
    } else {
      tmpvar_22 = -(tmpvar_21);
    };
    highp float tmpvar_23;
    tmpvar_23 = (scrpos_18.x / 4.0);
    highp float tmpvar_24;
    tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
    highp float tmpvar_25;
    if ((tmpvar_23 >= 0.0)) {
      tmpvar_25 = tmpvar_24;
    } else {
      tmpvar_25 = -(tmpvar_24);
    };
    highp float x_26;
    x_26 = ((a_19 - _DITHERMATRIX[
      int(tmpvar_22)
    ][
      int(tmpvar_25)
    ]) - 0.01);
    if ((x_26 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_4.w);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(normalize((_glesNormal * tmpvar_10)));
  highp float tmpvar_12;
  tmpvar_12 = ((dot (tmpvar_11, tmpvar_9.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_2;
  tmpvar_13.y = d_2;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - tmpvar_14.xyz));
  highp float tmpvar_16;
  tmpvar_16 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + tmpvar_15))
  ), 0.0), _Shininess);
  s_1 = tmpvar_16;
  mediump float tmpvar_17;
  if ((d_2 < 0.5)) {
    tmpvar_17 = 0.025;
  } else {
    tmpvar_17 = s_1;
  };
  s_1 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17;
  tmpvar_18.y = tmpvar_17;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_7.zw;
  tmpvar_5.xyw = o_19.xyw;
  tmpvar_5.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  mediump vec3 tmpvar_22;
  highp vec3 lightColor0_23;
  lightColor0_23 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_24;
  lightColor1_24 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_25;
  lightColor2_25 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_26;
  lightColor3_26 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_27;
  lightAttenSq_27 = unity_4LightAtten0;
  highp vec3 col_28;
  highp vec4 ndotl_29;
  highp vec4 lengthSq_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_14.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_14.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_14.z);
  lengthSq_30 = (tmpvar_31 * tmpvar_31);
  lengthSq_30 = (lengthSq_30 + (tmpvar_32 * tmpvar_32));
  lengthSq_30 = (lengthSq_30 + (tmpvar_33 * tmpvar_33));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (lengthSq_30, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_30 = tmpvar_34;
  ndotl_29 = (tmpvar_31 * tmpvar_11.x);
  ndotl_29 = (ndotl_29 + (tmpvar_32 * tmpvar_11.y));
  ndotl_29 = (ndotl_29 + (tmpvar_33 * tmpvar_11.z));
  highp vec4 tmpvar_35;
  tmpvar_35 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_29 * inversesqrt(tmpvar_34)));
  ndotl_29 = tmpvar_35;
  highp vec4 tmpvar_36;
  tmpvar_36 = (tmpvar_35 * (1.0/((1.0 + 
    (tmpvar_34 * lightAttenSq_27)
  ))));
  col_28 = (lightColor0_23 * tmpvar_36.x);
  col_28 = (col_28 + (lightColor1_24 * tmpvar_36.y));
  col_28 = (col_28 + (lightColor2_25 * tmpvar_36.z));
  col_28 = (col_28 + (lightColor3_26 * tmpvar_36.w));
  tmpvar_22 = col_28;
  tmpvar_6 = tmpvar_22;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD5 = tmpvar_15;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_5;
  xlv_TEXCOORD8 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 specRamp_2;
  mediump vec3 ramp_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  outColor_5.w = 0.0;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = ((tmpvar_8.xyz * _SpecMulti) + 1.0);
  specRamp_2 = tmpvar_9;
  outColor_5.xyz = ((tex_C_Color_4.xyz * specRamp_2) * ramp_3);
  outColor_5.xyz = (outColor_5.xyz * _LightColor0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix ((_Color * _EnvColor), tmpvar_10, tex_C_Color_4.wwww);
  outColor_5.xyz = (outColor_5.xyz * tmpvar_11.xyz);
  outColor_5.w = _BloomFactor;
  outColor_5.xyz = (outColor_5.xyz + (outColor_5.xyz * xlv_TEXCOORD8));
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD6))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_13 = (_RGBias + (tmpvar_14 * _RGScale));
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _RGColor).xyz;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (tmpvar_13, 0.0, 1.0);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (outColor_5.xyz, tmpvar_15, vec3((tmpvar_16 * _RGRatio)));
  tmpvar_12 = tmpvar_17;
  outColor_5.xyz = tmpvar_12;
  highp vec4 scrpos_18;
  scrpos_18 = xlv_TEXCOORD7;
  mediump float a_19;
  a_19 = xlv_TEXCOORD7.z;
  if ((a_19 < 0.95)) {
    scrpos_18.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_19 = (a_19 * 17.0);
    highp float tmpvar_20;
    tmpvar_20 = (scrpos_18.y / 4.0);
    highp float tmpvar_21;
    tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
    highp float tmpvar_22;
    if ((tmpvar_20 >= 0.0)) {
      tmpvar_22 = tmpvar_21;
    } else {
      tmpvar_22 = -(tmpvar_21);
    };
    highp float tmpvar_23;
    tmpvar_23 = (scrpos_18.x / 4.0);
    highp float tmpvar_24;
    tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
    highp float tmpvar_25;
    if ((tmpvar_23 >= 0.0)) {
      tmpvar_25 = tmpvar_24;
    } else {
      tmpvar_25 = -(tmpvar_24);
    };
    highp float x_26;
    x_26 = ((a_19 - _DITHERMATRIX[
      int(tmpvar_22)
    ][
      int(tmpvar_25)
    ]) - 0.01);
    if ((x_26 < 0.0)) {
      discard;
    };
  };
  outColor_5.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_4.w);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(normalize((_glesNormal * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = ((dot (tmpvar_12, tmpvar_10.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = d_3;
  tmpvar_14.y = d_3;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_16;
  tmpvar_16 = pow (max (dot (tmpvar_12, 
    normalize((tmpvar_10.xyz + normalize((_WorldSpaceCameraPos - tmpvar_15.xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_16;
  mediump float tmpvar_17;
  if ((d_3 < 0.5)) {
    tmpvar_17 = 0.025;
  } else {
    tmpvar_17 = s_2;
  };
  s_2 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17;
  tmpvar_18.y = tmpvar_17;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_8.zw;
  tmpvar_7.xyw = o_19.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_4.w = _Opaqueness;
  highp vec2 uv_22;
  uv_22 = tmpvar_1;
  highp vec4 spuvs_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_glesVertex * 0.5);
  spuvs_23.xy = ((uv_22 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_25;
  tmpvar_25.x = (tmpvar_24.x + (tmpvar_24.z * tmpvar_24.z));
  tmpvar_25.y = ((tmpvar_24.y + (0.5 * tmpvar_24.z)) + ((0.5 * tmpvar_24.x) * tmpvar_24.x));
  spuvs_23.zw = ((tmpvar_25 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_6 = (tmpvar_15.xyz / tmpvar_15.w);
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = spuvs_23;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
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
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD6);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20.xyz = tmpvar_21.xyz;
  spColor_20.w = outColor_7.w;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * noiseTex_19.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_29;
      tmpvar_29 = mix (spColor_20, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20 = tmpvar_29;
    };
  };
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (outColor_7.xyz, spColor_20.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_20.xyz = tmpvar_30;
  outColor_7 = spColor_20;
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD7;
  mediump float a_32;
  a_32 = xlv_TEXCOORD7.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_32 = (a_32 * 17.0);
    highp float tmpvar_33;
    tmpvar_33 = (scrpos_31.y / 4.0);
    highp float tmpvar_34;
    tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
    highp float tmpvar_35;
    if ((tmpvar_33 >= 0.0)) {
      tmpvar_35 = tmpvar_34;
    } else {
      tmpvar_35 = -(tmpvar_34);
    };
    highp float tmpvar_36;
    tmpvar_36 = (scrpos_31.x / 4.0);
    highp float tmpvar_37;
    tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
    highp float tmpvar_38;
    if ((tmpvar_36 >= 0.0)) {
      tmpvar_38 = tmpvar_37;
    } else {
      tmpvar_38 = -(tmpvar_37);
    };
    highp float x_39;
    x_39 = ((a_32 - _DITHERMATRIX[
      int(tmpvar_35)
    ][
      int(tmpvar_38)
    ]) - 0.01);
    if ((x_39 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = mix (spColor_20.w, _EmissionBloomFactor, tex_C_Color_6.w);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(normalize((_glesNormal * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = ((dot (tmpvar_12, tmpvar_10.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = d_3;
  tmpvar_14.y = d_3;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_16;
  tmpvar_16 = pow (max (dot (tmpvar_12, 
    normalize((tmpvar_10.xyz + normalize((_WorldSpaceCameraPos - tmpvar_15.xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_16;
  mediump float tmpvar_17;
  if ((d_3 < 0.5)) {
    tmpvar_17 = 0.025;
  } else {
    tmpvar_17 = s_2;
  };
  s_2 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17;
  tmpvar_18.y = tmpvar_17;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_8.zw;
  tmpvar_7.xyw = o_19.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_4.w = _Opaqueness;
  highp vec2 uv_22;
  uv_22 = tmpvar_1;
  highp vec4 spuvs_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_glesVertex * 0.5);
  spuvs_23.xy = ((uv_22 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_25;
  tmpvar_25.x = (tmpvar_24.x + (tmpvar_24.z * tmpvar_24.z));
  tmpvar_25.y = ((tmpvar_24.y + (0.5 * tmpvar_24.z)) + ((0.5 * tmpvar_24.x) * tmpvar_24.x));
  spuvs_23.zw = ((tmpvar_25 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_6 = (tmpvar_15.xyz / tmpvar_15.w);
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = spuvs_23;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
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
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD6);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20.xyz = tmpvar_21.xyz;
  spColor_20.w = outColor_7.w;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * noiseTex_19.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_29;
      tmpvar_29 = mix (spColor_20, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20 = tmpvar_29;
    };
  };
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (outColor_7.xyz, spColor_20.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_20.xyz = tmpvar_30;
  outColor_7 = spColor_20;
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD7;
  mediump float a_32;
  a_32 = xlv_TEXCOORD7.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_32 = (a_32 * 17.0);
    highp float tmpvar_33;
    tmpvar_33 = (scrpos_31.y / 4.0);
    highp float tmpvar_34;
    tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
    highp float tmpvar_35;
    if ((tmpvar_33 >= 0.0)) {
      tmpvar_35 = tmpvar_34;
    } else {
      tmpvar_35 = -(tmpvar_34);
    };
    highp float tmpvar_36;
    tmpvar_36 = (scrpos_31.x / 4.0);
    highp float tmpvar_37;
    tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
    highp float tmpvar_38;
    if ((tmpvar_36 >= 0.0)) {
      tmpvar_38 = tmpvar_37;
    } else {
      tmpvar_38 = -(tmpvar_37);
    };
    highp float x_39;
    x_39 = ((a_32 - _DITHERMATRIX[
      int(tmpvar_35)
    ][
      int(tmpvar_38)
    ]) - 0.01);
    if ((x_39 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = mix (spColor_20.w, _EmissionBloomFactor, tex_C_Color_6.w);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(normalize((_glesNormal * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = ((dot (tmpvar_12, tmpvar_10.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = d_3;
  tmpvar_14.y = d_3;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_16;
  tmpvar_16 = pow (max (dot (tmpvar_12, 
    normalize((tmpvar_10.xyz + normalize((_WorldSpaceCameraPos - tmpvar_15.xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_16;
  mediump float tmpvar_17;
  if ((d_3 < 0.5)) {
    tmpvar_17 = 0.025;
  } else {
    tmpvar_17 = s_2;
  };
  s_2 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17;
  tmpvar_18.y = tmpvar_17;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_8.zw;
  tmpvar_7.xyw = o_19.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_4.w = _Opaqueness;
  highp vec2 uv_22;
  uv_22 = tmpvar_1;
  highp vec4 spuvs_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_glesVertex * 0.5);
  spuvs_23.xy = ((uv_22 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_25;
  tmpvar_25.x = (tmpvar_24.x + (tmpvar_24.z * tmpvar_24.z));
  tmpvar_25.y = ((tmpvar_24.y + (0.5 * tmpvar_24.z)) + ((0.5 * tmpvar_24.x) * tmpvar_24.x));
  spuvs_23.zw = ((tmpvar_25 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_6 = (tmpvar_15.xyz / tmpvar_15.w);
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = spuvs_23;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
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
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD6);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20.xyz = tmpvar_21.xyz;
  spColor_20.w = outColor_7.w;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * noiseTex_19.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_29;
      tmpvar_29 = mix (spColor_20, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20 = tmpvar_29;
    };
  };
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (outColor_7.xyz, spColor_20.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_20.xyz = tmpvar_30;
  outColor_7 = spColor_20;
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD7;
  mediump float a_32;
  a_32 = xlv_TEXCOORD7.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_32 = (a_32 * 17.0);
    highp float tmpvar_33;
    tmpvar_33 = (scrpos_31.y / 4.0);
    highp float tmpvar_34;
    tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
    highp float tmpvar_35;
    if ((tmpvar_33 >= 0.0)) {
      tmpvar_35 = tmpvar_34;
    } else {
      tmpvar_35 = -(tmpvar_34);
    };
    highp float tmpvar_36;
    tmpvar_36 = (scrpos_31.x / 4.0);
    highp float tmpvar_37;
    tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
    highp float tmpvar_38;
    if ((tmpvar_36 >= 0.0)) {
      tmpvar_38 = tmpvar_37;
    } else {
      tmpvar_38 = -(tmpvar_37);
    };
    highp float x_39;
    x_39 = ((a_32 - _DITHERMATRIX[
      int(tmpvar_35)
    ][
      int(tmpvar_38)
    ]) - 0.01);
    if ((x_39 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = mix (spColor_20.w, _EmissionBloomFactor, tex_C_Color_6.w);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = ((dot (tmpvar_13, tmpvar_11.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = d_3;
  tmpvar_15.y = d_3;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_17;
  tmpvar_17 = pow (max (dot (tmpvar_13, 
    normalize((tmpvar_11.xyz + normalize((_WorldSpaceCameraPos - tmpvar_16.xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_17;
  mediump float tmpvar_18;
  if ((d_3 < 0.5)) {
    tmpvar_18 = 0.025;
  } else {
    tmpvar_18 = s_2;
  };
  s_2 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18;
  tmpvar_19.y = tmpvar_18;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_9.zw;
  tmpvar_7.xyw = o_20.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_4.w = _Opaqueness;
  highp vec2 uv_23;
  uv_23 = tmpvar_1;
  highp vec4 spuvs_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (_glesVertex * 0.5);
  spuvs_24.xy = ((uv_23 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_26;
  tmpvar_26.x = (tmpvar_25.x + (tmpvar_25.z * tmpvar_25.z));
  tmpvar_26.y = ((tmpvar_25.y + (0.5 * tmpvar_25.z)) + ((0.5 * tmpvar_25.x) * tmpvar_25.x));
  spuvs_24.zw = ((tmpvar_26 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_6 = (tmpvar_16.xyz / tmpvar_16.w);
  mediump vec3 tmpvar_27;
  highp vec3 lightColor0_28;
  lightColor0_28 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_29;
  lightColor1_29 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_30;
  lightColor2_30 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_31;
  lightColor3_31 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_32;
  lightAttenSq_32 = unity_4LightAtten0;
  highp vec3 col_33;
  highp vec4 ndotl_34;
  highp vec4 lengthSq_35;
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosX0 - tmpvar_16.x);
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosY0 - tmpvar_16.y);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosZ0 - tmpvar_16.z);
  lengthSq_35 = (tmpvar_36 * tmpvar_36);
  lengthSq_35 = (lengthSq_35 + (tmpvar_37 * tmpvar_37));
  lengthSq_35 = (lengthSq_35 + (tmpvar_38 * tmpvar_38));
  highp vec4 tmpvar_39;
  tmpvar_39 = max (lengthSq_35, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_35 = tmpvar_39;
  ndotl_34 = (tmpvar_36 * tmpvar_13.x);
  ndotl_34 = (ndotl_34 + (tmpvar_37 * tmpvar_13.y));
  ndotl_34 = (ndotl_34 + (tmpvar_38 * tmpvar_13.z));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_34 * inversesqrt(tmpvar_39)));
  ndotl_34 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = (tmpvar_40 * (1.0/((1.0 + 
    (tmpvar_39 * lightAttenSq_32)
  ))));
  col_33 = (lightColor0_28 * tmpvar_41.x);
  col_33 = (col_33 + (lightColor1_29 * tmpvar_41.y));
  col_33 = (col_33 + (lightColor2_30 * tmpvar_41.z));
  col_33 = (col_33 + (lightColor3_31 * tmpvar_41.w));
  tmpvar_27 = col_33;
  tmpvar_8 = tmpvar_27;
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = spuvs_24;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
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
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = _BloomFactor;
  outColor_7.xyz = (outColor_7.xyz + (outColor_7.xyz * xlv_TEXCOORD8));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD6);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20.xyz = tmpvar_21.xyz;
  spColor_20.w = outColor_7.w;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * noiseTex_19.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_29;
      tmpvar_29 = mix (spColor_20, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20 = tmpvar_29;
    };
  };
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (outColor_7.xyz, spColor_20.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_20.xyz = tmpvar_30;
  outColor_7 = spColor_20;
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD7;
  mediump float a_32;
  a_32 = xlv_TEXCOORD7.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_32 = (a_32 * 17.0);
    highp float tmpvar_33;
    tmpvar_33 = (scrpos_31.y / 4.0);
    highp float tmpvar_34;
    tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
    highp float tmpvar_35;
    if ((tmpvar_33 >= 0.0)) {
      tmpvar_35 = tmpvar_34;
    } else {
      tmpvar_35 = -(tmpvar_34);
    };
    highp float tmpvar_36;
    tmpvar_36 = (scrpos_31.x / 4.0);
    highp float tmpvar_37;
    tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
    highp float tmpvar_38;
    if ((tmpvar_36 >= 0.0)) {
      tmpvar_38 = tmpvar_37;
    } else {
      tmpvar_38 = -(tmpvar_37);
    };
    highp float x_39;
    x_39 = ((a_32 - _DITHERMATRIX[
      int(tmpvar_35)
    ][
      int(tmpvar_38)
    ]) - 0.01);
    if ((x_39 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = mix (spColor_20.w, _EmissionBloomFactor, tex_C_Color_6.w);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = ((dot (tmpvar_13, tmpvar_11.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = d_3;
  tmpvar_15.y = d_3;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_17;
  tmpvar_17 = pow (max (dot (tmpvar_13, 
    normalize((tmpvar_11.xyz + normalize((_WorldSpaceCameraPos - tmpvar_16.xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_17;
  mediump float tmpvar_18;
  if ((d_3 < 0.5)) {
    tmpvar_18 = 0.025;
  } else {
    tmpvar_18 = s_2;
  };
  s_2 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18;
  tmpvar_19.y = tmpvar_18;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_9.zw;
  tmpvar_7.xyw = o_20.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_4.w = _Opaqueness;
  highp vec2 uv_23;
  uv_23 = tmpvar_1;
  highp vec4 spuvs_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (_glesVertex * 0.5);
  spuvs_24.xy = ((uv_23 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_26;
  tmpvar_26.x = (tmpvar_25.x + (tmpvar_25.z * tmpvar_25.z));
  tmpvar_26.y = ((tmpvar_25.y + (0.5 * tmpvar_25.z)) + ((0.5 * tmpvar_25.x) * tmpvar_25.x));
  spuvs_24.zw = ((tmpvar_26 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_6 = (tmpvar_16.xyz / tmpvar_16.w);
  mediump vec3 tmpvar_27;
  highp vec3 lightColor0_28;
  lightColor0_28 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_29;
  lightColor1_29 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_30;
  lightColor2_30 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_31;
  lightColor3_31 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_32;
  lightAttenSq_32 = unity_4LightAtten0;
  highp vec3 col_33;
  highp vec4 ndotl_34;
  highp vec4 lengthSq_35;
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosX0 - tmpvar_16.x);
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosY0 - tmpvar_16.y);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosZ0 - tmpvar_16.z);
  lengthSq_35 = (tmpvar_36 * tmpvar_36);
  lengthSq_35 = (lengthSq_35 + (tmpvar_37 * tmpvar_37));
  lengthSq_35 = (lengthSq_35 + (tmpvar_38 * tmpvar_38));
  highp vec4 tmpvar_39;
  tmpvar_39 = max (lengthSq_35, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_35 = tmpvar_39;
  ndotl_34 = (tmpvar_36 * tmpvar_13.x);
  ndotl_34 = (ndotl_34 + (tmpvar_37 * tmpvar_13.y));
  ndotl_34 = (ndotl_34 + (tmpvar_38 * tmpvar_13.z));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_34 * inversesqrt(tmpvar_39)));
  ndotl_34 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = (tmpvar_40 * (1.0/((1.0 + 
    (tmpvar_39 * lightAttenSq_32)
  ))));
  col_33 = (lightColor0_28 * tmpvar_41.x);
  col_33 = (col_33 + (lightColor1_29 * tmpvar_41.y));
  col_33 = (col_33 + (lightColor2_30 * tmpvar_41.z));
  col_33 = (col_33 + (lightColor3_31 * tmpvar_41.w));
  tmpvar_27 = col_33;
  tmpvar_8 = tmpvar_27;
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = spuvs_24;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
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
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = _BloomFactor;
  outColor_7.xyz = (outColor_7.xyz + (outColor_7.xyz * xlv_TEXCOORD8));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD6);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20.xyz = tmpvar_21.xyz;
  spColor_20.w = outColor_7.w;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * noiseTex_19.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_29;
      tmpvar_29 = mix (spColor_20, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20 = tmpvar_29;
    };
  };
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (outColor_7.xyz, spColor_20.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_20.xyz = tmpvar_30;
  outColor_7 = spColor_20;
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD7;
  mediump float a_32;
  a_32 = xlv_TEXCOORD7.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_32 = (a_32 * 17.0);
    highp float tmpvar_33;
    tmpvar_33 = (scrpos_31.y / 4.0);
    highp float tmpvar_34;
    tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
    highp float tmpvar_35;
    if ((tmpvar_33 >= 0.0)) {
      tmpvar_35 = tmpvar_34;
    } else {
      tmpvar_35 = -(tmpvar_34);
    };
    highp float tmpvar_36;
    tmpvar_36 = (scrpos_31.x / 4.0);
    highp float tmpvar_37;
    tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
    highp float tmpvar_38;
    if ((tmpvar_36 >= 0.0)) {
      tmpvar_38 = tmpvar_37;
    } else {
      tmpvar_38 = -(tmpvar_37);
    };
    highp float x_39;
    x_39 = ((a_32 - _DITHERMATRIX[
      int(tmpvar_35)
    ][
      int(tmpvar_38)
    ]) - 0.01);
    if ((x_39 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = mix (spColor_20.w, _EmissionBloomFactor, tex_C_Color_6.w);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = ((dot (tmpvar_13, tmpvar_11.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = d_3;
  tmpvar_15.y = d_3;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_17;
  tmpvar_17 = pow (max (dot (tmpvar_13, 
    normalize((tmpvar_11.xyz + normalize((_WorldSpaceCameraPos - tmpvar_16.xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_17;
  mediump float tmpvar_18;
  if ((d_3 < 0.5)) {
    tmpvar_18 = 0.025;
  } else {
    tmpvar_18 = s_2;
  };
  s_2 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18;
  tmpvar_19.y = tmpvar_18;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_9.zw;
  tmpvar_7.xyw = o_20.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_4.w = _Opaqueness;
  highp vec2 uv_23;
  uv_23 = tmpvar_1;
  highp vec4 spuvs_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (_glesVertex * 0.5);
  spuvs_24.xy = ((uv_23 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_26;
  tmpvar_26.x = (tmpvar_25.x + (tmpvar_25.z * tmpvar_25.z));
  tmpvar_26.y = ((tmpvar_25.y + (0.5 * tmpvar_25.z)) + ((0.5 * tmpvar_25.x) * tmpvar_25.x));
  spuvs_24.zw = ((tmpvar_26 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_6 = (tmpvar_16.xyz / tmpvar_16.w);
  mediump vec3 tmpvar_27;
  highp vec3 lightColor0_28;
  lightColor0_28 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_29;
  lightColor1_29 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_30;
  lightColor2_30 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_31;
  lightColor3_31 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_32;
  lightAttenSq_32 = unity_4LightAtten0;
  highp vec3 col_33;
  highp vec4 ndotl_34;
  highp vec4 lengthSq_35;
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosX0 - tmpvar_16.x);
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosY0 - tmpvar_16.y);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosZ0 - tmpvar_16.z);
  lengthSq_35 = (tmpvar_36 * tmpvar_36);
  lengthSq_35 = (lengthSq_35 + (tmpvar_37 * tmpvar_37));
  lengthSq_35 = (lengthSq_35 + (tmpvar_38 * tmpvar_38));
  highp vec4 tmpvar_39;
  tmpvar_39 = max (lengthSq_35, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_35 = tmpvar_39;
  ndotl_34 = (tmpvar_36 * tmpvar_13.x);
  ndotl_34 = (ndotl_34 + (tmpvar_37 * tmpvar_13.y));
  ndotl_34 = (ndotl_34 + (tmpvar_38 * tmpvar_13.z));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_34 * inversesqrt(tmpvar_39)));
  ndotl_34 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = (tmpvar_40 * (1.0/((1.0 + 
    (tmpvar_39 * lightAttenSq_32)
  ))));
  col_33 = (lightColor0_28 * tmpvar_41.x);
  col_33 = (col_33 + (lightColor1_29 * tmpvar_41.y));
  col_33 = (col_33 + (lightColor2_30 * tmpvar_41.z));
  col_33 = (col_33 + (lightColor3_31 * tmpvar_41.w));
  tmpvar_27 = col_33;
  tmpvar_8 = tmpvar_27;
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = spuvs_24;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
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
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = _BloomFactor;
  outColor_7.xyz = (outColor_7.xyz + (outColor_7.xyz * xlv_TEXCOORD8));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD6);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20.xyz = tmpvar_21.xyz;
  spColor_20.w = outColor_7.w;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * noiseTex_19.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_29;
      tmpvar_29 = mix (spColor_20, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20 = tmpvar_29;
    };
  };
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (outColor_7.xyz, spColor_20.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_20.xyz = tmpvar_30;
  outColor_7 = spColor_20;
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD7;
  mediump float a_32;
  a_32 = xlv_TEXCOORD7.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_32 = (a_32 * 17.0);
    highp float tmpvar_33;
    tmpvar_33 = (scrpos_31.y / 4.0);
    highp float tmpvar_34;
    tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
    highp float tmpvar_35;
    if ((tmpvar_33 >= 0.0)) {
      tmpvar_35 = tmpvar_34;
    } else {
      tmpvar_35 = -(tmpvar_34);
    };
    highp float tmpvar_36;
    tmpvar_36 = (scrpos_31.x / 4.0);
    highp float tmpvar_37;
    tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
    highp float tmpvar_38;
    if ((tmpvar_36 >= 0.0)) {
      tmpvar_38 = tmpvar_37;
    } else {
      tmpvar_38 = -(tmpvar_37);
    };
    highp float x_39;
    x_39 = ((a_32 - _DITHERMATRIX[
      int(tmpvar_35)
    ][
      int(tmpvar_38)
    ]) - 0.01);
    if ((x_39 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = mix (spColor_20.w, _EmissionBloomFactor, tex_C_Color_6.w);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(normalize((_glesNormal * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = ((dot (tmpvar_12, tmpvar_10.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = d_3;
  tmpvar_14.y = d_3;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - tmpvar_15.xyz));
  highp float tmpvar_17;
  tmpvar_17 = pow (max (dot (tmpvar_12, 
    normalize((tmpvar_10.xyz + tmpvar_16))
  ), 0.0), _Shininess);
  s_2 = tmpvar_17;
  mediump float tmpvar_18;
  if ((d_3 < 0.5)) {
    tmpvar_18 = 0.025;
  } else {
    tmpvar_18 = s_2;
  };
  s_2 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18;
  tmpvar_19.y = tmpvar_18;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_8.zw;
  tmpvar_7.xyw = o_20.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_4.w = _Opaqueness;
  highp vec2 uv_23;
  uv_23 = tmpvar_1;
  highp vec4 spuvs_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (_glesVertex * 0.5);
  spuvs_24.xy = ((uv_23 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_26;
  tmpvar_26.x = (tmpvar_25.x + (tmpvar_25.z * tmpvar_25.z));
  tmpvar_26.y = ((tmpvar_25.y + (0.5 * tmpvar_25.z)) + ((0.5 * tmpvar_25.x) * tmpvar_25.x));
  spuvs_24.zw = ((tmpvar_26 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_6 = (tmpvar_15.xyz / tmpvar_15.w);
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = spuvs_24;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
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
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD6);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20.xyz = tmpvar_21.xyz;
  spColor_20.w = outColor_7.w;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * noiseTex_19.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_29;
      tmpvar_29 = mix (spColor_20, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20 = tmpvar_29;
    };
  };
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (outColor_7.xyz, spColor_20.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_20.xyz = tmpvar_30;
  outColor_7.w = spColor_20.w;
  mediump vec3 tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD6))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_32 = (_RGBias + (tmpvar_33 * _RGScale));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_32 * _RGColor).xyz;
  mediump float tmpvar_35;
  tmpvar_35 = clamp (tmpvar_32, 0.0, 1.0);
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (spColor_20.xyz, tmpvar_34, vec3((tmpvar_35 * _RGRatio)));
  tmpvar_31 = tmpvar_36;
  outColor_7.xyz = tmpvar_31;
  highp vec4 scrpos_37;
  scrpos_37 = xlv_TEXCOORD7;
  mediump float a_38;
  a_38 = xlv_TEXCOORD7.z;
  if ((a_38 < 0.95)) {
    scrpos_37.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_38 = (a_38 * 17.0);
    highp float tmpvar_39;
    tmpvar_39 = (scrpos_37.y / 4.0);
    highp float tmpvar_40;
    tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
    highp float tmpvar_41;
    if ((tmpvar_39 >= 0.0)) {
      tmpvar_41 = tmpvar_40;
    } else {
      tmpvar_41 = -(tmpvar_40);
    };
    highp float tmpvar_42;
    tmpvar_42 = (scrpos_37.x / 4.0);
    highp float tmpvar_43;
    tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
    highp float tmpvar_44;
    if ((tmpvar_42 >= 0.0)) {
      tmpvar_44 = tmpvar_43;
    } else {
      tmpvar_44 = -(tmpvar_43);
    };
    highp float x_45;
    x_45 = ((a_38 - _DITHERMATRIX[
      int(tmpvar_41)
    ][
      int(tmpvar_44)
    ]) - 0.01);
    if ((x_45 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = mix (spColor_20.w, _EmissionBloomFactor, tex_C_Color_6.w);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(normalize((_glesNormal * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = ((dot (tmpvar_12, tmpvar_10.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = d_3;
  tmpvar_14.y = d_3;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - tmpvar_15.xyz));
  highp float tmpvar_17;
  tmpvar_17 = pow (max (dot (tmpvar_12, 
    normalize((tmpvar_10.xyz + tmpvar_16))
  ), 0.0), _Shininess);
  s_2 = tmpvar_17;
  mediump float tmpvar_18;
  if ((d_3 < 0.5)) {
    tmpvar_18 = 0.025;
  } else {
    tmpvar_18 = s_2;
  };
  s_2 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18;
  tmpvar_19.y = tmpvar_18;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_8.zw;
  tmpvar_7.xyw = o_20.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_4.w = _Opaqueness;
  highp vec2 uv_23;
  uv_23 = tmpvar_1;
  highp vec4 spuvs_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (_glesVertex * 0.5);
  spuvs_24.xy = ((uv_23 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_26;
  tmpvar_26.x = (tmpvar_25.x + (tmpvar_25.z * tmpvar_25.z));
  tmpvar_26.y = ((tmpvar_25.y + (0.5 * tmpvar_25.z)) + ((0.5 * tmpvar_25.x) * tmpvar_25.x));
  spuvs_24.zw = ((tmpvar_26 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_6 = (tmpvar_15.xyz / tmpvar_15.w);
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = spuvs_24;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
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
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD6);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20.xyz = tmpvar_21.xyz;
  spColor_20.w = outColor_7.w;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * noiseTex_19.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_29;
      tmpvar_29 = mix (spColor_20, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20 = tmpvar_29;
    };
  };
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (outColor_7.xyz, spColor_20.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_20.xyz = tmpvar_30;
  outColor_7.w = spColor_20.w;
  mediump vec3 tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD6))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_32 = (_RGBias + (tmpvar_33 * _RGScale));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_32 * _RGColor).xyz;
  mediump float tmpvar_35;
  tmpvar_35 = clamp (tmpvar_32, 0.0, 1.0);
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (spColor_20.xyz, tmpvar_34, vec3((tmpvar_35 * _RGRatio)));
  tmpvar_31 = tmpvar_36;
  outColor_7.xyz = tmpvar_31;
  highp vec4 scrpos_37;
  scrpos_37 = xlv_TEXCOORD7;
  mediump float a_38;
  a_38 = xlv_TEXCOORD7.z;
  if ((a_38 < 0.95)) {
    scrpos_37.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_38 = (a_38 * 17.0);
    highp float tmpvar_39;
    tmpvar_39 = (scrpos_37.y / 4.0);
    highp float tmpvar_40;
    tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
    highp float tmpvar_41;
    if ((tmpvar_39 >= 0.0)) {
      tmpvar_41 = tmpvar_40;
    } else {
      tmpvar_41 = -(tmpvar_40);
    };
    highp float tmpvar_42;
    tmpvar_42 = (scrpos_37.x / 4.0);
    highp float tmpvar_43;
    tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
    highp float tmpvar_44;
    if ((tmpvar_42 >= 0.0)) {
      tmpvar_44 = tmpvar_43;
    } else {
      tmpvar_44 = -(tmpvar_43);
    };
    highp float x_45;
    x_45 = ((a_38 - _DITHERMATRIX[
      int(tmpvar_41)
    ][
      int(tmpvar_44)
    ]) - 0.01);
    if ((x_45 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = mix (spColor_20.w, _EmissionBloomFactor, tex_C_Color_6.w);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(normalize((_glesNormal * tmpvar_11)));
  highp float tmpvar_13;
  tmpvar_13 = ((dot (tmpvar_12, tmpvar_10.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = d_3;
  tmpvar_14.y = d_3;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_WorldSpaceCameraPos - tmpvar_15.xyz));
  highp float tmpvar_17;
  tmpvar_17 = pow (max (dot (tmpvar_12, 
    normalize((tmpvar_10.xyz + tmpvar_16))
  ), 0.0), _Shininess);
  s_2 = tmpvar_17;
  mediump float tmpvar_18;
  if ((d_3 < 0.5)) {
    tmpvar_18 = 0.025;
  } else {
    tmpvar_18 = s_2;
  };
  s_2 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18;
  tmpvar_19.y = tmpvar_18;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_8.zw;
  tmpvar_7.xyw = o_20.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_4.w = _Opaqueness;
  highp vec2 uv_23;
  uv_23 = tmpvar_1;
  highp vec4 spuvs_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (_glesVertex * 0.5);
  spuvs_24.xy = ((uv_23 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_26;
  tmpvar_26.x = (tmpvar_25.x + (tmpvar_25.z * tmpvar_25.z));
  tmpvar_26.y = ((tmpvar_25.y + (0.5 * tmpvar_25.z)) + ((0.5 * tmpvar_25.x) * tmpvar_25.x));
  spuvs_24.zw = ((tmpvar_26 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_6 = (tmpvar_15.xyz / tmpvar_15.w);
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = spuvs_24;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
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
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = _BloomFactor;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD6);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20.xyz = tmpvar_21.xyz;
  spColor_20.w = outColor_7.w;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * noiseTex_19.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_29;
      tmpvar_29 = mix (spColor_20, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20 = tmpvar_29;
    };
  };
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (outColor_7.xyz, spColor_20.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_20.xyz = tmpvar_30;
  outColor_7.w = spColor_20.w;
  mediump vec3 tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD6))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_32 = (_RGBias + (tmpvar_33 * _RGScale));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_32 * _RGColor).xyz;
  mediump float tmpvar_35;
  tmpvar_35 = clamp (tmpvar_32, 0.0, 1.0);
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (spColor_20.xyz, tmpvar_34, vec3((tmpvar_35 * _RGRatio)));
  tmpvar_31 = tmpvar_36;
  outColor_7.xyz = tmpvar_31;
  highp vec4 scrpos_37;
  scrpos_37 = xlv_TEXCOORD7;
  mediump float a_38;
  a_38 = xlv_TEXCOORD7.z;
  if ((a_38 < 0.95)) {
    scrpos_37.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_38 = (a_38 * 17.0);
    highp float tmpvar_39;
    tmpvar_39 = (scrpos_37.y / 4.0);
    highp float tmpvar_40;
    tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
    highp float tmpvar_41;
    if ((tmpvar_39 >= 0.0)) {
      tmpvar_41 = tmpvar_40;
    } else {
      tmpvar_41 = -(tmpvar_40);
    };
    highp float tmpvar_42;
    tmpvar_42 = (scrpos_37.x / 4.0);
    highp float tmpvar_43;
    tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
    highp float tmpvar_44;
    if ((tmpvar_42 >= 0.0)) {
      tmpvar_44 = tmpvar_43;
    } else {
      tmpvar_44 = -(tmpvar_43);
    };
    highp float x_45;
    x_45 = ((a_38 - _DITHERMATRIX[
      int(tmpvar_41)
    ][
      int(tmpvar_44)
    ]) - 0.01);
    if ((x_45 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = mix (spColor_20.w, _EmissionBloomFactor, tex_C_Color_6.w);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = ((dot (tmpvar_13, tmpvar_11.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = d_3;
  tmpvar_15.y = d_3;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - tmpvar_16.xyz));
  highp float tmpvar_18;
  tmpvar_18 = pow (max (dot (tmpvar_13, 
    normalize((tmpvar_11.xyz + tmpvar_17))
  ), 0.0), _Shininess);
  s_2 = tmpvar_18;
  mediump float tmpvar_19;
  if ((d_3 < 0.5)) {
    tmpvar_19 = 0.025;
  } else {
    tmpvar_19 = s_2;
  };
  s_2 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19;
  tmpvar_20.y = tmpvar_19;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  tmpvar_7.xyw = o_21.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_4.w = _Opaqueness;
  highp vec2 uv_24;
  uv_24 = tmpvar_1;
  highp vec4 spuvs_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (_glesVertex * 0.5);
  spuvs_25.xy = ((uv_24 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_27;
  tmpvar_27.x = (tmpvar_26.x + (tmpvar_26.z * tmpvar_26.z));
  tmpvar_27.y = ((tmpvar_26.y + (0.5 * tmpvar_26.z)) + ((0.5 * tmpvar_26.x) * tmpvar_26.x));
  spuvs_25.zw = ((tmpvar_27 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_6 = (tmpvar_16.xyz / tmpvar_16.w);
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_16.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_16.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_16.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_13.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_13.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_13.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_8 = tmpvar_28;
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_20;
  xlv_TEXCOORD3 = spuvs_25;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
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
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = _BloomFactor;
  outColor_7.xyz = (outColor_7.xyz + (outColor_7.xyz * xlv_TEXCOORD8));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD6);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20.xyz = tmpvar_21.xyz;
  spColor_20.w = outColor_7.w;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * noiseTex_19.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_29;
      tmpvar_29 = mix (spColor_20, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20 = tmpvar_29;
    };
  };
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (outColor_7.xyz, spColor_20.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_20.xyz = tmpvar_30;
  outColor_7.w = spColor_20.w;
  mediump vec3 tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD6))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_32 = (_RGBias + (tmpvar_33 * _RGScale));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_32 * _RGColor).xyz;
  mediump float tmpvar_35;
  tmpvar_35 = clamp (tmpvar_32, 0.0, 1.0);
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (spColor_20.xyz, tmpvar_34, vec3((tmpvar_35 * _RGRatio)));
  tmpvar_31 = tmpvar_36;
  outColor_7.xyz = tmpvar_31;
  highp vec4 scrpos_37;
  scrpos_37 = xlv_TEXCOORD7;
  mediump float a_38;
  a_38 = xlv_TEXCOORD7.z;
  if ((a_38 < 0.95)) {
    scrpos_37.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_38 = (a_38 * 17.0);
    highp float tmpvar_39;
    tmpvar_39 = (scrpos_37.y / 4.0);
    highp float tmpvar_40;
    tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
    highp float tmpvar_41;
    if ((tmpvar_39 >= 0.0)) {
      tmpvar_41 = tmpvar_40;
    } else {
      tmpvar_41 = -(tmpvar_40);
    };
    highp float tmpvar_42;
    tmpvar_42 = (scrpos_37.x / 4.0);
    highp float tmpvar_43;
    tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
    highp float tmpvar_44;
    if ((tmpvar_42 >= 0.0)) {
      tmpvar_44 = tmpvar_43;
    } else {
      tmpvar_44 = -(tmpvar_43);
    };
    highp float x_45;
    x_45 = ((a_38 - _DITHERMATRIX[
      int(tmpvar_41)
    ][
      int(tmpvar_44)
    ]) - 0.01);
    if ((x_45 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = mix (spColor_20.w, _EmissionBloomFactor, tex_C_Color_6.w);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = ((dot (tmpvar_13, tmpvar_11.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = d_3;
  tmpvar_15.y = d_3;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - tmpvar_16.xyz));
  highp float tmpvar_18;
  tmpvar_18 = pow (max (dot (tmpvar_13, 
    normalize((tmpvar_11.xyz + tmpvar_17))
  ), 0.0), _Shininess);
  s_2 = tmpvar_18;
  mediump float tmpvar_19;
  if ((d_3 < 0.5)) {
    tmpvar_19 = 0.025;
  } else {
    tmpvar_19 = s_2;
  };
  s_2 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19;
  tmpvar_20.y = tmpvar_19;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  tmpvar_7.xyw = o_21.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_4.w = _Opaqueness;
  highp vec2 uv_24;
  uv_24 = tmpvar_1;
  highp vec4 spuvs_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (_glesVertex * 0.5);
  spuvs_25.xy = ((uv_24 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_27;
  tmpvar_27.x = (tmpvar_26.x + (tmpvar_26.z * tmpvar_26.z));
  tmpvar_27.y = ((tmpvar_26.y + (0.5 * tmpvar_26.z)) + ((0.5 * tmpvar_26.x) * tmpvar_26.x));
  spuvs_25.zw = ((tmpvar_27 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_6 = (tmpvar_16.xyz / tmpvar_16.w);
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_16.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_16.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_16.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_13.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_13.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_13.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_8 = tmpvar_28;
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_20;
  xlv_TEXCOORD3 = spuvs_25;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
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
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = _BloomFactor;
  outColor_7.xyz = (outColor_7.xyz + (outColor_7.xyz * xlv_TEXCOORD8));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD6);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20.xyz = tmpvar_21.xyz;
  spColor_20.w = outColor_7.w;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * noiseTex_19.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_29;
      tmpvar_29 = mix (spColor_20, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20 = tmpvar_29;
    };
  };
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (outColor_7.xyz, spColor_20.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_20.xyz = tmpvar_30;
  outColor_7.w = spColor_20.w;
  mediump vec3 tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD6))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_32 = (_RGBias + (tmpvar_33 * _RGScale));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_32 * _RGColor).xyz;
  mediump float tmpvar_35;
  tmpvar_35 = clamp (tmpvar_32, 0.0, 1.0);
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (spColor_20.xyz, tmpvar_34, vec3((tmpvar_35 * _RGRatio)));
  tmpvar_31 = tmpvar_36;
  outColor_7.xyz = tmpvar_31;
  highp vec4 scrpos_37;
  scrpos_37 = xlv_TEXCOORD7;
  mediump float a_38;
  a_38 = xlv_TEXCOORD7.z;
  if ((a_38 < 0.95)) {
    scrpos_37.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_38 = (a_38 * 17.0);
    highp float tmpvar_39;
    tmpvar_39 = (scrpos_37.y / 4.0);
    highp float tmpvar_40;
    tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
    highp float tmpvar_41;
    if ((tmpvar_39 >= 0.0)) {
      tmpvar_41 = tmpvar_40;
    } else {
      tmpvar_41 = -(tmpvar_40);
    };
    highp float tmpvar_42;
    tmpvar_42 = (scrpos_37.x / 4.0);
    highp float tmpvar_43;
    tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
    highp float tmpvar_44;
    if ((tmpvar_42 >= 0.0)) {
      tmpvar_44 = tmpvar_43;
    } else {
      tmpvar_44 = -(tmpvar_43);
    };
    highp float x_45;
    x_45 = ((a_38 - _DITHERMATRIX[
      int(tmpvar_41)
    ][
      int(tmpvar_44)
    ]) - 0.01);
    if ((x_45 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = mix (spColor_20.w, _EmissionBloomFactor, tex_C_Color_6.w);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec3(0.0, 0.0, 0.0);
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(normalize((_glesNormal * tmpvar_12)));
  highp float tmpvar_14;
  tmpvar_14 = ((dot (tmpvar_13, tmpvar_11.xyz) * 0.4975) + 0.5);
  d_3 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = d_3;
  tmpvar_15.y = d_3;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - tmpvar_16.xyz));
  highp float tmpvar_18;
  tmpvar_18 = pow (max (dot (tmpvar_13, 
    normalize((tmpvar_11.xyz + tmpvar_17))
  ), 0.0), _Shininess);
  s_2 = tmpvar_18;
  mediump float tmpvar_19;
  if ((d_3 < 0.5)) {
    tmpvar_19 = 0.025;
  } else {
    tmpvar_19 = s_2;
  };
  s_2 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19;
  tmpvar_20.y = tmpvar_19;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  tmpvar_7.xyw = o_21.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_4.w = _Opaqueness;
  highp vec2 uv_24;
  uv_24 = tmpvar_1;
  highp vec4 spuvs_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (_glesVertex * 0.5);
  spuvs_25.xy = ((uv_24 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_27;
  tmpvar_27.x = (tmpvar_26.x + (tmpvar_26.z * tmpvar_26.z));
  tmpvar_27.y = ((tmpvar_26.y + (0.5 * tmpvar_26.z)) + ((0.5 * tmpvar_26.x) * tmpvar_26.x));
  spuvs_25.zw = ((tmpvar_27 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_6 = (tmpvar_16.xyz / tmpvar_16.w);
  mediump vec3 tmpvar_28;
  highp vec3 lightColor0_29;
  lightColor0_29 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_30;
  lightColor1_30 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_31;
  lightColor2_31 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_32;
  lightColor3_32 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_33;
  lightAttenSq_33 = unity_4LightAtten0;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_16.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_16.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_16.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * tmpvar_13.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * tmpvar_13.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * tmpvar_13.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_33)
  ))));
  col_34 = (lightColor0_29 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_30 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_31 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_32 * tmpvar_42.w));
  tmpvar_28 = col_34;
  tmpvar_8 = tmpvar_28;
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_15;
  xlv_TEXCOORD2 = tmpvar_20;
  xlv_TEXCOORD3 = spuvs_25;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_17;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
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
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 specRamp_4;
  mediump vec3 ramp_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_6 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10.xyz * _SpecMulti) + 1.0);
  specRamp_4 = tmpvar_11;
  outColor_7.xyz = ((tex_C_Color_6.xyz * specRamp_4) * ramp_5);
  outColor_7.xyz = (outColor_7.xyz * _LightColor0);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13 = mix ((_Color * _EnvColor), tmpvar_12, tex_C_Color_6.wwww);
  outColor_7.xyz = (outColor_7.xyz * tmpvar_13.xyz);
  outColor_7.w = _BloomFactor;
  outColor_7.xyz = (outColor_7.xyz + (outColor_7.xyz * xlv_TEXCOORD8));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD6);
  N_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_15;
  mediump vec3 reflection_16;
  mediump vec3 R_17;
  mediump float intensity_18;
  mediump vec4 noiseTex_19;
  mediump vec4 spColor_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_20.xyz = tmpvar_21.xyz;
  spColor_20.w = outColor_7.w;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * noiseTex_19.x) * _SPNoiseScaler) - 1.0);
  intensity_18 = tmpvar_23;
  highp vec3 tmpvar_24;
  highp vec3 I_25;
  I_25 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_19 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_24 = (I_25 - (2.0 * (
    dot (N_3, I_25)
   * N_3)));
  R_17 = tmpvar_24;
  lowp vec3 tmpvar_26;
  tmpvar_26 = textureCube (_SPCubeMap, R_17).xyz;
  reflection_16 = tmpvar_26;
  highp vec3 tmpvar_27;
  mediump vec3 x_28;
  x_28 = (spColor_20.xyz * _SPOldColor.xyz);
  tmpvar_27 = mix (x_28, ((reflection_16 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_20.xyz = tmpvar_27;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_18 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_18 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_29;
      tmpvar_29 = mix (spColor_20, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20 = tmpvar_29;
    };
  };
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (outColor_7.xyz, spColor_20.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_20.xyz = tmpvar_30;
  outColor_7.w = spColor_20.w;
  mediump vec3 tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD5), normalize(xlv_TEXCOORD6))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_32 = (_RGBias + (tmpvar_33 * _RGScale));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_32 * _RGColor).xyz;
  mediump float tmpvar_35;
  tmpvar_35 = clamp (tmpvar_32, 0.0, 1.0);
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (spColor_20.xyz, tmpvar_34, vec3((tmpvar_35 * _RGRatio)));
  tmpvar_31 = tmpvar_36;
  outColor_7.xyz = tmpvar_31;
  highp vec4 scrpos_37;
  scrpos_37 = xlv_TEXCOORD7;
  mediump float a_38;
  a_38 = xlv_TEXCOORD7.z;
  if ((a_38 < 0.95)) {
    scrpos_37.xy = ((xlv_TEXCOORD7.xy / xlv_TEXCOORD7.w) * _ScreenParams.xy);
    a_38 = (a_38 * 17.0);
    highp float tmpvar_39;
    tmpvar_39 = (scrpos_37.y / 4.0);
    highp float tmpvar_40;
    tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
    highp float tmpvar_41;
    if ((tmpvar_39 >= 0.0)) {
      tmpvar_41 = tmpvar_40;
    } else {
      tmpvar_41 = -(tmpvar_40);
    };
    highp float tmpvar_42;
    tmpvar_42 = (scrpos_37.x / 4.0);
    highp float tmpvar_43;
    tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
    highp float tmpvar_44;
    if ((tmpvar_42 >= 0.0)) {
      tmpvar_44 = tmpvar_43;
    } else {
      tmpvar_44 = -(tmpvar_43);
    };
    highp float x_45;
    x_45 = ((a_38 - _DITHERMATRIX[
      int(tmpvar_41)
    ][
      int(tmpvar_44)
    ]) - 0.01);
    if ((x_45 < 0.0)) {
      discard;
    };
  };
  outColor_7.w = mix (spColor_20.w, _EmissionBloomFactor, tex_C_Color_6.w);
  tmpvar_1 = outColor_7;
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
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
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
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
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
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
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
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
}
}
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "DualFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Geometry+10" "Reflected" = "Reflected" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 76901
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = _DitherAlpha;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomFactor;
uniform mediump vec4 _BackFaceColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.w = _BloomFactor;
  outColor_1.xyz = (_BackFaceColor.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_2;
  color_2 = outColor_1.xyz;
  mediump vec3 tmpvar_3;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_3 = _lightProbColor.xyz;
  } else {
    tmpvar_3 = vec3(1.0, 1.0, 1.0);
  };
  color_2 = (outColor_1.xyz * tmpvar_3);
  outColor_1.xyz = color_2;
  highp vec4 scrpos_4;
  scrpos_4 = xlv_TEXCOORD0;
  mediump float a_5;
  a_5 = xlv_TEXCOORD0.z;
  if ((a_5 < 0.95)) {
    scrpos_4.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
    a_5 = (a_5 * 17.0);
    highp float tmpvar_6;
    tmpvar_6 = (scrpos_4.y / 4.0);
    highp float tmpvar_7;
    tmpvar_7 = (fract(abs(tmpvar_6)) * 4.0);
    highp float tmpvar_8;
    if ((tmpvar_6 >= 0.0)) {
      tmpvar_8 = tmpvar_7;
    } else {
      tmpvar_8 = -(tmpvar_7);
    };
    highp float tmpvar_9;
    tmpvar_9 = (scrpos_4.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float x_12;
    x_12 = ((a_5 - _DITHERMATRIX[
      int(tmpvar_8)
    ][
      int(tmpvar_11)
    ]) - 0.01);
    if ((x_12 < 0.0)) {
      discard;
    };
  };
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = _DitherAlpha;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomFactor;
uniform mediump vec4 _BackFaceColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.w = _BloomFactor;
  outColor_1.xyz = (_BackFaceColor.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_2;
  color_2 = outColor_1.xyz;
  mediump vec3 tmpvar_3;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_3 = _lightProbColor.xyz;
  } else {
    tmpvar_3 = vec3(1.0, 1.0, 1.0);
  };
  color_2 = (outColor_1.xyz * tmpvar_3);
  outColor_1.xyz = color_2;
  highp vec4 scrpos_4;
  scrpos_4 = xlv_TEXCOORD0;
  mediump float a_5;
  a_5 = xlv_TEXCOORD0.z;
  if ((a_5 < 0.95)) {
    scrpos_4.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
    a_5 = (a_5 * 17.0);
    highp float tmpvar_6;
    tmpvar_6 = (scrpos_4.y / 4.0);
    highp float tmpvar_7;
    tmpvar_7 = (fract(abs(tmpvar_6)) * 4.0);
    highp float tmpvar_8;
    if ((tmpvar_6 >= 0.0)) {
      tmpvar_8 = tmpvar_7;
    } else {
      tmpvar_8 = -(tmpvar_7);
    };
    highp float tmpvar_9;
    tmpvar_9 = (scrpos_4.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float x_12;
    x_12 = ((a_5 - _DITHERMATRIX[
      int(tmpvar_8)
    ][
      int(tmpvar_11)
    ]) - 0.01);
    if ((x_12 < 0.0)) {
      discard;
    };
  };
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_4.xyw;
  tmpvar_1.z = _DitherAlpha;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomFactor;
uniform mediump vec4 _BackFaceColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.w = _BloomFactor;
  outColor_1.xyz = (_BackFaceColor.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_2;
  color_2 = outColor_1.xyz;
  mediump vec3 tmpvar_3;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_3 = _lightProbColor.xyz;
  } else {
    tmpvar_3 = vec3(1.0, 1.0, 1.0);
  };
  color_2 = (outColor_1.xyz * tmpvar_3);
  outColor_1.xyz = color_2;
  highp vec4 scrpos_4;
  scrpos_4 = xlv_TEXCOORD0;
  mediump float a_5;
  a_5 = xlv_TEXCOORD0.z;
  if ((a_5 < 0.95)) {
    scrpos_4.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
    a_5 = (a_5 * 17.0);
    highp float tmpvar_6;
    tmpvar_6 = (scrpos_4.y / 4.0);
    highp float tmpvar_7;
    tmpvar_7 = (fract(abs(tmpvar_6)) * 4.0);
    highp float tmpvar_8;
    if ((tmpvar_6 >= 0.0)) {
      tmpvar_8 = tmpvar_7;
    } else {
      tmpvar_8 = -(tmpvar_7);
    };
    highp float tmpvar_9;
    tmpvar_9 = (scrpos_4.x / 4.0);
    highp float tmpvar_10;
    tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
    highp float tmpvar_11;
    if ((tmpvar_9 >= 0.0)) {
      tmpvar_11 = tmpvar_10;
    } else {
      tmpvar_11 = -(tmpvar_10);
    };
    highp float x_12;
    x_12 = ((a_5 - _DITHERMATRIX[
      int(tmpvar_8)
    ][
      int(tmpvar_11)
    ]) - 0.01);
    if ((x_12 < 0.0)) {
      discard;
    };
  };
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 spuvs_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (_glesVertex * 0.5);
  spuvs_4.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_5.x + (tmpvar_5.z * tmpvar_5.z));
  tmpvar_6.y = ((tmpvar_5.y + (0.5 * tmpvar_5.z)) + ((0.5 * tmpvar_5.x) * tmpvar_5.x));
  spuvs_4.zw = ((tmpvar_6 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_7.xyw;
  tmpvar_1.z = _DitherAlpha;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = spuvs_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomFactor;
uniform mediump vec4 _BackFaceColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec4 outColor_1;
  outColor_1.xyz = _BackFaceColor.xyz;
  outColor_1.w = _BloomFactor;
  mediump float intensity_2;
  mediump vec4 spColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPTex, xlv_TEXCOORD1.xy);
  spColor_3.xyz = tmpvar_4.xyz;
  spColor_3.w = outColor_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1.zw);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_2 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_7;
      tmpvar_7 = mix (spColor_3, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_2) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_3 = tmpvar_7;
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_BackFaceColor.xyz, spColor_3.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_3.xyz = tmpvar_8;
  outColor_1.w = spColor_3.w;
  outColor_1.xyz = (spColor_3.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_9;
  color_9 = outColor_1.xyz;
  mediump vec3 tmpvar_10;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_10 = _lightProbColor.xyz;
  } else {
    tmpvar_10 = vec3(1.0, 1.0, 1.0);
  };
  color_9 = (outColor_1.xyz * tmpvar_10);
  outColor_1.xyz = color_9;
  highp vec4 scrpos_11;
  scrpos_11 = xlv_TEXCOORD0;
  mediump float a_12;
  a_12 = xlv_TEXCOORD0.z;
  if ((a_12 < 0.95)) {
    scrpos_11.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
    a_12 = (a_12 * 17.0);
    highp float tmpvar_13;
    tmpvar_13 = (scrpos_11.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float tmpvar_16;
    tmpvar_16 = (scrpos_11.x / 4.0);
    highp float tmpvar_17;
    tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
    highp float tmpvar_18;
    if ((tmpvar_16 >= 0.0)) {
      tmpvar_18 = tmpvar_17;
    } else {
      tmpvar_18 = -(tmpvar_17);
    };
    highp float x_19;
    x_19 = ((a_12 - _DITHERMATRIX[
      int(tmpvar_15)
    ][
      int(tmpvar_18)
    ]) - 0.01);
    if ((x_19 < 0.0)) {
      discard;
    };
  };
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 spuvs_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (_glesVertex * 0.5);
  spuvs_4.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_5.x + (tmpvar_5.z * tmpvar_5.z));
  tmpvar_6.y = ((tmpvar_5.y + (0.5 * tmpvar_5.z)) + ((0.5 * tmpvar_5.x) * tmpvar_5.x));
  spuvs_4.zw = ((tmpvar_6 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_7.xyw;
  tmpvar_1.z = _DitherAlpha;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = spuvs_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomFactor;
uniform mediump vec4 _BackFaceColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec4 outColor_1;
  outColor_1.xyz = _BackFaceColor.xyz;
  outColor_1.w = _BloomFactor;
  mediump float intensity_2;
  mediump vec4 spColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPTex, xlv_TEXCOORD1.xy);
  spColor_3.xyz = tmpvar_4.xyz;
  spColor_3.w = outColor_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1.zw);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_2 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_7;
      tmpvar_7 = mix (spColor_3, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_2) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_3 = tmpvar_7;
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_BackFaceColor.xyz, spColor_3.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_3.xyz = tmpvar_8;
  outColor_1.w = spColor_3.w;
  outColor_1.xyz = (spColor_3.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_9;
  color_9 = outColor_1.xyz;
  mediump vec3 tmpvar_10;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_10 = _lightProbColor.xyz;
  } else {
    tmpvar_10 = vec3(1.0, 1.0, 1.0);
  };
  color_9 = (outColor_1.xyz * tmpvar_10);
  outColor_1.xyz = color_9;
  highp vec4 scrpos_11;
  scrpos_11 = xlv_TEXCOORD0;
  mediump float a_12;
  a_12 = xlv_TEXCOORD0.z;
  if ((a_12 < 0.95)) {
    scrpos_11.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
    a_12 = (a_12 * 17.0);
    highp float tmpvar_13;
    tmpvar_13 = (scrpos_11.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float tmpvar_16;
    tmpvar_16 = (scrpos_11.x / 4.0);
    highp float tmpvar_17;
    tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
    highp float tmpvar_18;
    if ((tmpvar_16 >= 0.0)) {
      tmpvar_18 = tmpvar_17;
    } else {
      tmpvar_18 = -(tmpvar_17);
    };
    highp float x_19;
    x_19 = ((a_12 - _DITHERMATRIX[
      int(tmpvar_15)
    ][
      int(tmpvar_18)
    ]) - 0.01);
    if ((x_19 < 0.0)) {
      discard;
    };
  };
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 spuvs_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (_glesVertex * 0.5);
  spuvs_4.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_5.x + (tmpvar_5.z * tmpvar_5.z));
  tmpvar_6.y = ((tmpvar_5.y + (0.5 * tmpvar_5.z)) + ((0.5 * tmpvar_5.x) * tmpvar_5.x));
  spuvs_4.zw = ((tmpvar_6 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_7.xyw;
  tmpvar_1.z = _DitherAlpha;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = spuvs_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform mediump float _lightProbToggle;
uniform mediump vec4 _lightProbColor;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform highp float _SPTransitionEmissionScaler;
uniform highp float _SPTransitionBloomFactor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform mediump float _BloomFactor;
uniform mediump vec4 _BackFaceColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  mediump vec4 outColor_1;
  outColor_1.xyz = _BackFaceColor.xyz;
  outColor_1.w = _BloomFactor;
  mediump float intensity_2;
  mediump vec4 spColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPTex, xlv_TEXCOORD1.xy);
  spColor_3.xyz = tmpvar_4.xyz;
  spColor_3.w = outColor_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1.zw);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_2 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_7;
      tmpvar_7 = mix (spColor_3, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_2) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_3 = tmpvar_7;
    };
  };
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_BackFaceColor.xyz, spColor_3.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_3.xyz = tmpvar_8;
  outColor_1.w = spColor_3.w;
  outColor_1.xyz = (spColor_3.xyz * (_Color * _EnvColor).xyz);
  mediump vec3 color_9;
  color_9 = outColor_1.xyz;
  mediump vec3 tmpvar_10;
  if ((_lightProbToggle > 0.5)) {
    tmpvar_10 = _lightProbColor.xyz;
  } else {
    tmpvar_10 = vec3(1.0, 1.0, 1.0);
  };
  color_9 = (outColor_1.xyz * tmpvar_10);
  outColor_1.xyz = color_9;
  highp vec4 scrpos_11;
  scrpos_11 = xlv_TEXCOORD0;
  mediump float a_12;
  a_12 = xlv_TEXCOORD0.z;
  if ((a_12 < 0.95)) {
    scrpos_11.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
    a_12 = (a_12 * 17.0);
    highp float tmpvar_13;
    tmpvar_13 = (scrpos_11.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float tmpvar_16;
    tmpvar_16 = (scrpos_11.x / 4.0);
    highp float tmpvar_17;
    tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
    highp float tmpvar_18;
    if ((tmpvar_16 >= 0.0)) {
      tmpvar_18 = tmpvar_17;
    } else {
      tmpvar_18 = -(tmpvar_17);
    };
    highp float x_19;
    x_19 = ((a_12 - _DITHERMATRIX[
      int(tmpvar_15)
    ][
      int(tmpvar_18)
    ]) - 0.01);
    if ((x_19 < 0.0)) {
      discard;
    };
  };
  gl_FragData[0] = outColor_1;
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
  Name "OUTLINE"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "DualFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Geometry+10" "Reflected" = "Reflected" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 134038
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlpha;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  highp vec4 scrpos_3;
  scrpos_3 = xlv_TEXCOORD0;
  mediump float a_4;
  a_4 = xlv_TEXCOORD0.z;
  if ((a_4 < 0.95)) {
    scrpos_3.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlpha;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  highp vec4 scrpos_3;
  scrpos_3 = xlv_TEXCOORD0;
  mediump float a_4;
  a_4 = xlv_TEXCOORD0.z;
  if ((a_4 < 0.95)) {
    scrpos_3.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlpha;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  highp vec4 scrpos_3;
  scrpos_3 = xlv_TEXCOORD0;
  mediump float a_4;
  a_4 = xlv_TEXCOORD0.z;
  if ((a_4 < 0.95)) {
    scrpos_3.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlpha;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = outColor_2;
  };
  outColor_2 = outColor_4;
  highp vec4 scrpos_7;
  scrpos_7 = xlv_TEXCOORD0;
  mediump float a_8;
  a_8 = xlv_TEXCOORD0.z;
  if ((a_8 < 0.95)) {
    scrpos_7.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_4;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlpha;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = outColor_2;
  };
  outColor_2 = outColor_4;
  highp vec4 scrpos_7;
  scrpos_7 = xlv_TEXCOORD0;
  mediump float a_8;
  a_8 = xlv_TEXCOORD0.z;
  if ((a_8 < 0.95)) {
    scrpos_7.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_4;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform mediump float _OutlineUseTangent;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesNormal;
  highp vec4 tmpvar_6;
  tmpvar_6 = _glesTANGENT;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_7 = tmpvar_9;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_12;
  if (bool(_OutlineUseTangent)) {
    tmpvar_12 = tmpvar_6.xyz;
  } else {
    tmpvar_12 = tmpvar_5;
  };
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_9.xy + ((tmpvar_13 * 
    normalize((tmpvar_11 * tmpvar_12))
  .xy) * _Outline));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_8.xyw = o_14.xyw;
  tmpvar_8.z = _DitherAlpha;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = _OutlineColor;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 outColor_2;
  outColor_2 = xlv_COLOR0;
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = outColor_2;
  };
  outColor_2 = outColor_4;
  highp vec4 scrpos_7;
  scrpos_7 = xlv_TEXCOORD0;
  mediump float a_8;
  a_8 = xlv_TEXCOORD0.z;
  if ((a_8 < 0.95)) {
    scrpos_7.xy = ((xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w) * _ScreenParams.xy);
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
  tmpvar_1 = outColor_4;
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