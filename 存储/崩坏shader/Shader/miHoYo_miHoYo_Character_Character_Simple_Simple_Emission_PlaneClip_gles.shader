//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Simple/Simple_Emission_PlaneClip" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_EmissionColor ("Emmisive Color", Color) = (0.5,0.5,0.5,1)
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Outline ("Outline Width", Float) = 0.02
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
[Toggle(CLIP_PLANE_WORLD)] _ClipPlaneWorld ("Clip Plane In World Space", Float) = 0
_ClipPlane ("Clip Plane", Vector) = (0,0,0,0)
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
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 46650
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_3 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_2;
  };
  s_2 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = tmpvar_15;
  alpha_1 = 1.0;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_17.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_20;
  clipPlane_20 = _ClipPlane;
  highp float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (_glesVertex.xyz, clipPlane_20.xyz);
  if ((tmpvar_22 < (clipPlane_20.w - 0.01))) {
    tmpvar_21 = 0.0;
  } else {
    tmpvar_21 = 1.0;
  };
  alpha_1 = tmpvar_21;
  tmpvar_4.w = alpha_1;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_3 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_2;
  };
  s_2 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = tmpvar_15;
  alpha_1 = 1.0;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_17.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_20;
  clipPlane_20 = _ClipPlane;
  highp float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (_glesVertex.xyz, clipPlane_20.xyz);
  if ((tmpvar_22 < (clipPlane_20.w - 0.01))) {
    tmpvar_21 = 0.0;
  } else {
    tmpvar_21 = 1.0;
  };
  alpha_1 = tmpvar_21;
  tmpvar_4.w = alpha_1;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_3 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_2;
  };
  s_2 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = tmpvar_15;
  alpha_1 = 1.0;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_17.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_20;
  clipPlane_20 = _ClipPlane;
  highp float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (_glesVertex.xyz, clipPlane_20.xyz);
  if ((tmpvar_22 < (clipPlane_20.w - 0.01))) {
    tmpvar_21 = 0.0;
  } else {
    tmpvar_21 = 1.0;
  };
  alpha_1 = tmpvar_21;
  tmpvar_4.w = alpha_1;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
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
  alpha_1 = 1.0;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_19.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_22;
  clipPlane_22 = _ClipPlane;
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (_glesVertex.xyz, clipPlane_22.xyz);
  if ((tmpvar_24 < (clipPlane_22.w - 0.01))) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_1 = tmpvar_23;
  tmpvar_4.w = alpha_1;
  mediump vec3 tmpvar_25;
  highp vec3 lightColor0_26;
  lightColor0_26 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_27;
  lightColor1_27 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_28;
  lightColor2_28 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_29;
  lightColor3_29 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_30;
  lightAttenSq_30 = unity_4LightAtten0;
  highp vec3 col_31;
  highp vec4 ndotl_32;
  highp vec4 lengthSq_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_33 = (tmpvar_34 * tmpvar_34);
  lengthSq_33 = (lengthSq_33 + (tmpvar_35 * tmpvar_35));
  lengthSq_33 = (lengthSq_33 + (tmpvar_36 * tmpvar_36));
  highp vec4 tmpvar_37;
  tmpvar_37 = max (lengthSq_33, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_33 = tmpvar_37;
  ndotl_32 = (tmpvar_34 * tmpvar_12.x);
  ndotl_32 = (ndotl_32 + (tmpvar_35 * tmpvar_12.y));
  ndotl_32 = (ndotl_32 + (tmpvar_36 * tmpvar_12.z));
  highp vec4 tmpvar_38;
  tmpvar_38 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_32 * inversesqrt(tmpvar_37)));
  ndotl_32 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (tmpvar_38 * (1.0/((1.0 + 
    (tmpvar_37 * lightAttenSq_30)
  ))));
  col_31 = (lightColor0_26 * tmpvar_39.x);
  col_31 = (col_31 + (lightColor1_27 * tmpvar_39.y));
  col_31 = (col_31 + (lightColor2_28 * tmpvar_39.z));
  col_31 = (col_31 + (lightColor3_29 * tmpvar_39.w));
  tmpvar_25 = col_31;
  tmpvar_7 = tmpvar_25;
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_6;
  xlv_TEXCOORD8 = tmpvar_7;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
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
  alpha_1 = 1.0;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_19.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_22;
  clipPlane_22 = _ClipPlane;
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (_glesVertex.xyz, clipPlane_22.xyz);
  if ((tmpvar_24 < (clipPlane_22.w - 0.01))) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_1 = tmpvar_23;
  tmpvar_4.w = alpha_1;
  mediump vec3 tmpvar_25;
  highp vec3 lightColor0_26;
  lightColor0_26 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_27;
  lightColor1_27 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_28;
  lightColor2_28 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_29;
  lightColor3_29 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_30;
  lightAttenSq_30 = unity_4LightAtten0;
  highp vec3 col_31;
  highp vec4 ndotl_32;
  highp vec4 lengthSq_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_33 = (tmpvar_34 * tmpvar_34);
  lengthSq_33 = (lengthSq_33 + (tmpvar_35 * tmpvar_35));
  lengthSq_33 = (lengthSq_33 + (tmpvar_36 * tmpvar_36));
  highp vec4 tmpvar_37;
  tmpvar_37 = max (lengthSq_33, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_33 = tmpvar_37;
  ndotl_32 = (tmpvar_34 * tmpvar_12.x);
  ndotl_32 = (ndotl_32 + (tmpvar_35 * tmpvar_12.y));
  ndotl_32 = (ndotl_32 + (tmpvar_36 * tmpvar_12.z));
  highp vec4 tmpvar_38;
  tmpvar_38 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_32 * inversesqrt(tmpvar_37)));
  ndotl_32 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (tmpvar_38 * (1.0/((1.0 + 
    (tmpvar_37 * lightAttenSq_30)
  ))));
  col_31 = (lightColor0_26 * tmpvar_39.x);
  col_31 = (col_31 + (lightColor1_27 * tmpvar_39.y));
  col_31 = (col_31 + (lightColor2_28 * tmpvar_39.z));
  col_31 = (col_31 + (lightColor3_29 * tmpvar_39.w));
  tmpvar_25 = col_31;
  tmpvar_7 = tmpvar_25;
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_6;
  xlv_TEXCOORD8 = tmpvar_7;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
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
  alpha_1 = 1.0;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_19.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_22;
  clipPlane_22 = _ClipPlane;
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (_glesVertex.xyz, clipPlane_22.xyz);
  if ((tmpvar_24 < (clipPlane_22.w - 0.01))) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_1 = tmpvar_23;
  tmpvar_4.w = alpha_1;
  mediump vec3 tmpvar_25;
  highp vec3 lightColor0_26;
  lightColor0_26 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_27;
  lightColor1_27 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_28;
  lightColor2_28 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_29;
  lightColor3_29 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_30;
  lightAttenSq_30 = unity_4LightAtten0;
  highp vec3 col_31;
  highp vec4 ndotl_32;
  highp vec4 lengthSq_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_33 = (tmpvar_34 * tmpvar_34);
  lengthSq_33 = (lengthSq_33 + (tmpvar_35 * tmpvar_35));
  lengthSq_33 = (lengthSq_33 + (tmpvar_36 * tmpvar_36));
  highp vec4 tmpvar_37;
  tmpvar_37 = max (lengthSq_33, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_33 = tmpvar_37;
  ndotl_32 = (tmpvar_34 * tmpvar_12.x);
  ndotl_32 = (ndotl_32 + (tmpvar_35 * tmpvar_12.y));
  ndotl_32 = (ndotl_32 + (tmpvar_36 * tmpvar_12.z));
  highp vec4 tmpvar_38;
  tmpvar_38 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_32 * inversesqrt(tmpvar_37)));
  ndotl_32 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (tmpvar_38 * (1.0/((1.0 + 
    (tmpvar_37 * lightAttenSq_30)
  ))));
  col_31 = (lightColor0_26 * tmpvar_39.x);
  col_31 = (col_31 + (lightColor1_27 * tmpvar_39.y));
  col_31 = (col_31 + (lightColor2_28 * tmpvar_39.z));
  col_31 = (col_31 + (lightColor3_29 * tmpvar_39.w));
  tmpvar_25 = col_31;
  tmpvar_7 = tmpvar_25;
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_6;
  xlv_TEXCOORD8 = tmpvar_7;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_3 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_2;
  };
  s_2 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = tmpvar_15;
  alpha_1 = 1.0;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_17.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_20;
  clipPlane_20 = _ClipPlane;
  highp float tmpvar_21;
  highp vec4 pointInPlane_22;
  highp float tmpvar_23;
  tmpvar_23 = abs(clipPlane_20.w);
  if ((tmpvar_23 < 0.001)) {
    pointInPlane_22 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_24;
    tmpvar_24.w = 1.0;
    tmpvar_24.xyz = (clipPlane_20.xyz * clipPlane_20.w);
    pointInPlane_22 = tmpvar_24;
  };
  pointInPlane_22 = (unity_WorldToObject * pointInPlane_22);
  pointInPlane_22 = (pointInPlane_22 / pointInPlane_22.w);
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * clipPlane_20.xyz);
  highp float tmpvar_27;
  tmpvar_27 = dot (pointInPlane_22.xyz, tmpvar_26);
  highp float tmpvar_28;
  tmpvar_28 = dot (_glesVertex.xyz, tmpvar_26);
  if ((tmpvar_28 < tmpvar_27)) {
    tmpvar_21 = 0.0;
  } else {
    tmpvar_21 = 1.0;
  };
  alpha_1 = tmpvar_21;
  tmpvar_4.w = alpha_1;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_3 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_2;
  };
  s_2 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = tmpvar_15;
  alpha_1 = 1.0;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_17.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_20;
  clipPlane_20 = _ClipPlane;
  highp float tmpvar_21;
  highp vec4 pointInPlane_22;
  highp float tmpvar_23;
  tmpvar_23 = abs(clipPlane_20.w);
  if ((tmpvar_23 < 0.001)) {
    pointInPlane_22 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_24;
    tmpvar_24.w = 1.0;
    tmpvar_24.xyz = (clipPlane_20.xyz * clipPlane_20.w);
    pointInPlane_22 = tmpvar_24;
  };
  pointInPlane_22 = (unity_WorldToObject * pointInPlane_22);
  pointInPlane_22 = (pointInPlane_22 / pointInPlane_22.w);
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * clipPlane_20.xyz);
  highp float tmpvar_27;
  tmpvar_27 = dot (pointInPlane_22.xyz, tmpvar_26);
  highp float tmpvar_28;
  tmpvar_28 = dot (_glesVertex.xyz, tmpvar_26);
  if ((tmpvar_28 < tmpvar_27)) {
    tmpvar_21 = 0.0;
  } else {
    tmpvar_21 = 1.0;
  };
  alpha_1 = tmpvar_21;
  tmpvar_4.w = alpha_1;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp float tmpvar_14;
  tmpvar_14 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_2 = tmpvar_14;
  mediump float tmpvar_15;
  if ((d_3 < 0.5)) {
    tmpvar_15 = 0.025;
  } else {
    tmpvar_15 = s_2;
  };
  s_2 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = tmpvar_15;
  alpha_1 = 1.0;
  highp vec4 o_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_18.x;
  tmpvar_19.y = (tmpvar_18.y * _ProjectionParams.x);
  o_17.xy = (tmpvar_19 + tmpvar_18.w);
  o_17.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_17.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_20;
  clipPlane_20 = _ClipPlane;
  highp float tmpvar_21;
  highp vec4 pointInPlane_22;
  highp float tmpvar_23;
  tmpvar_23 = abs(clipPlane_20.w);
  if ((tmpvar_23 < 0.001)) {
    pointInPlane_22 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_24;
    tmpvar_24.w = 1.0;
    tmpvar_24.xyz = (clipPlane_20.xyz * clipPlane_20.w);
    pointInPlane_22 = tmpvar_24;
  };
  pointInPlane_22 = (unity_WorldToObject * pointInPlane_22);
  pointInPlane_22 = (pointInPlane_22 / pointInPlane_22.w);
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * clipPlane_20.xyz);
  highp float tmpvar_27;
  tmpvar_27 = dot (pointInPlane_22.xyz, tmpvar_26);
  highp float tmpvar_28;
  tmpvar_28 = dot (_glesVertex.xyz, tmpvar_26);
  if ((tmpvar_28 < tmpvar_27)) {
    tmpvar_21 = 0.0;
  } else {
    tmpvar_21 = 1.0;
  };
  alpha_1 = tmpvar_21;
  tmpvar_4.w = alpha_1;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
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
  alpha_1 = 1.0;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_19.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_22;
  clipPlane_22 = _ClipPlane;
  highp float tmpvar_23;
  highp vec4 pointInPlane_24;
  highp float tmpvar_25;
  tmpvar_25 = abs(clipPlane_22.w);
  if ((tmpvar_25 < 0.001)) {
    pointInPlane_24 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_26;
    tmpvar_26.w = 1.0;
    tmpvar_26.xyz = (clipPlane_22.xyz * clipPlane_22.w);
    pointInPlane_24 = tmpvar_26;
  };
  pointInPlane_24 = (unity_WorldToObject * pointInPlane_24);
  pointInPlane_24 = (pointInPlane_24 / pointInPlane_24.w);
  highp mat3 tmpvar_27;
  tmpvar_27[0] = unity_WorldToObject[0].xyz;
  tmpvar_27[1] = unity_WorldToObject[1].xyz;
  tmpvar_27[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * clipPlane_22.xyz);
  highp float tmpvar_29;
  tmpvar_29 = dot (pointInPlane_24.xyz, tmpvar_28);
  highp float tmpvar_30;
  tmpvar_30 = dot (_glesVertex.xyz, tmpvar_28);
  if ((tmpvar_30 < tmpvar_29)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_1 = tmpvar_23;
  tmpvar_4.w = alpha_1;
  mediump vec3 tmpvar_31;
  highp vec3 lightColor0_32;
  lightColor0_32 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_33;
  lightColor1_33 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_34;
  lightColor2_34 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_35;
  lightColor3_35 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_36;
  lightAttenSq_36 = unity_4LightAtten0;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * tmpvar_12.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * tmpvar_12.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * tmpvar_12.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_36)
  ))));
  col_37 = (lightColor0_32 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_33 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_34 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_35 * tmpvar_45.w));
  tmpvar_31 = col_37;
  tmpvar_7 = tmpvar_31;
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_6;
  xlv_TEXCOORD8 = tmpvar_7;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
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
  alpha_1 = 1.0;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_19.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_22;
  clipPlane_22 = _ClipPlane;
  highp float tmpvar_23;
  highp vec4 pointInPlane_24;
  highp float tmpvar_25;
  tmpvar_25 = abs(clipPlane_22.w);
  if ((tmpvar_25 < 0.001)) {
    pointInPlane_24 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_26;
    tmpvar_26.w = 1.0;
    tmpvar_26.xyz = (clipPlane_22.xyz * clipPlane_22.w);
    pointInPlane_24 = tmpvar_26;
  };
  pointInPlane_24 = (unity_WorldToObject * pointInPlane_24);
  pointInPlane_24 = (pointInPlane_24 / pointInPlane_24.w);
  highp mat3 tmpvar_27;
  tmpvar_27[0] = unity_WorldToObject[0].xyz;
  tmpvar_27[1] = unity_WorldToObject[1].xyz;
  tmpvar_27[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * clipPlane_22.xyz);
  highp float tmpvar_29;
  tmpvar_29 = dot (pointInPlane_24.xyz, tmpvar_28);
  highp float tmpvar_30;
  tmpvar_30 = dot (_glesVertex.xyz, tmpvar_28);
  if ((tmpvar_30 < tmpvar_29)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_1 = tmpvar_23;
  tmpvar_4.w = alpha_1;
  mediump vec3 tmpvar_31;
  highp vec3 lightColor0_32;
  lightColor0_32 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_33;
  lightColor1_33 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_34;
  lightColor2_34 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_35;
  lightColor3_35 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_36;
  lightAttenSq_36 = unity_4LightAtten0;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * tmpvar_12.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * tmpvar_12.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * tmpvar_12.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_36)
  ))));
  col_37 = (lightColor0_32 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_33 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_34 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_35 * tmpvar_45.w));
  tmpvar_31 = col_37;
  tmpvar_7 = tmpvar_31;
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_6;
  xlv_TEXCOORD8 = tmpvar_7;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
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
  alpha_1 = 1.0;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_19.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_22;
  clipPlane_22 = _ClipPlane;
  highp float tmpvar_23;
  highp vec4 pointInPlane_24;
  highp float tmpvar_25;
  tmpvar_25 = abs(clipPlane_22.w);
  if ((tmpvar_25 < 0.001)) {
    pointInPlane_24 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_26;
    tmpvar_26.w = 1.0;
    tmpvar_26.xyz = (clipPlane_22.xyz * clipPlane_22.w);
    pointInPlane_24 = tmpvar_26;
  };
  pointInPlane_24 = (unity_WorldToObject * pointInPlane_24);
  pointInPlane_24 = (pointInPlane_24 / pointInPlane_24.w);
  highp mat3 tmpvar_27;
  tmpvar_27[0] = unity_WorldToObject[0].xyz;
  tmpvar_27[1] = unity_WorldToObject[1].xyz;
  tmpvar_27[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * clipPlane_22.xyz);
  highp float tmpvar_29;
  tmpvar_29 = dot (pointInPlane_24.xyz, tmpvar_28);
  highp float tmpvar_30;
  tmpvar_30 = dot (_glesVertex.xyz, tmpvar_28);
  if ((tmpvar_30 < tmpvar_29)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  alpha_1 = tmpvar_23;
  tmpvar_4.w = alpha_1;
  mediump vec3 tmpvar_31;
  highp vec3 lightColor0_32;
  lightColor0_32 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_33;
  lightColor1_33 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_34;
  lightColor2_34 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_35;
  lightColor3_35 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_36;
  lightAttenSq_36 = unity_4LightAtten0;
  highp vec3 col_37;
  highp vec4 ndotl_38;
  highp vec4 lengthSq_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_39 = (tmpvar_40 * tmpvar_40);
  lengthSq_39 = (lengthSq_39 + (tmpvar_41 * tmpvar_41));
  lengthSq_39 = (lengthSq_39 + (tmpvar_42 * tmpvar_42));
  highp vec4 tmpvar_43;
  tmpvar_43 = max (lengthSq_39, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_39 = tmpvar_43;
  ndotl_38 = (tmpvar_40 * tmpvar_12.x);
  ndotl_38 = (ndotl_38 + (tmpvar_41 * tmpvar_12.y));
  ndotl_38 = (ndotl_38 + (tmpvar_42 * tmpvar_12.z));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_38 * inversesqrt(tmpvar_43)));
  ndotl_38 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * (1.0/((1.0 + 
    (tmpvar_43 * lightAttenSq_36)
  ))));
  col_37 = (lightColor0_32 * tmpvar_45.x);
  col_37 = (col_37 + (lightColor1_33 * tmpvar_45.y));
  col_37 = (col_37 + (lightColor2_34 * tmpvar_45.z));
  col_37 = (col_37 + (lightColor3_35 * tmpvar_45.w));
  tmpvar_31 = col_37;
  tmpvar_7 = tmpvar_31;
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_6;
  xlv_TEXCOORD8 = tmpvar_7;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp float tmpvar_15;
  tmpvar_15 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + tmpvar_14))
  ), 0.0), _Shininess);
  s_2 = tmpvar_15;
  mediump float tmpvar_16;
  if ((d_3 < 0.5)) {
    tmpvar_16 = 0.025;
  } else {
    tmpvar_16 = s_2;
  };
  s_2 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = tmpvar_16;
  alpha_1 = 1.0;
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_18.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_21;
  clipPlane_21 = _ClipPlane;
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (_glesVertex.xyz, clipPlane_21.xyz);
  if ((tmpvar_23 < (clipPlane_21.w - 0.01))) {
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  alpha_1 = tmpvar_22;
  tmpvar_4.w = alpha_1;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp float tmpvar_15;
  tmpvar_15 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + tmpvar_14))
  ), 0.0), _Shininess);
  s_2 = tmpvar_15;
  mediump float tmpvar_16;
  if ((d_3 < 0.5)) {
    tmpvar_16 = 0.025;
  } else {
    tmpvar_16 = s_2;
  };
  s_2 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = tmpvar_16;
  alpha_1 = 1.0;
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_18.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_21;
  clipPlane_21 = _ClipPlane;
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (_glesVertex.xyz, clipPlane_21.xyz);
  if ((tmpvar_23 < (clipPlane_21.w - 0.01))) {
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  alpha_1 = tmpvar_22;
  tmpvar_4.w = alpha_1;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp float tmpvar_15;
  tmpvar_15 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + tmpvar_14))
  ), 0.0), _Shininess);
  s_2 = tmpvar_15;
  mediump float tmpvar_16;
  if ((d_3 < 0.5)) {
    tmpvar_16 = 0.025;
  } else {
    tmpvar_16 = s_2;
  };
  s_2 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = tmpvar_16;
  alpha_1 = 1.0;
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_18.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_21;
  clipPlane_21 = _ClipPlane;
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (_glesVertex.xyz, clipPlane_21.xyz);
  if ((tmpvar_23 < (clipPlane_21.w - 0.01))) {
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  alpha_1 = tmpvar_22;
  tmpvar_4.w = alpha_1;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
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
  alpha_1 = 1.0;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_20.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_23;
  clipPlane_23 = _ClipPlane;
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, clipPlane_23.xyz);
  if ((tmpvar_25 < (clipPlane_23.w - 0.01))) {
    tmpvar_24 = 0.0;
  } else {
    tmpvar_24 = 1.0;
  };
  alpha_1 = tmpvar_24;
  tmpvar_4.w = alpha_1;
  mediump vec3 tmpvar_26;
  highp vec3 lightColor0_27;
  lightColor0_27 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_28;
  lightColor1_28 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_29;
  lightColor2_29 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_30;
  lightColor3_30 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_31;
  lightAttenSq_31 = unity_4LightAtten0;
  highp vec3 col_32;
  highp vec4 ndotl_33;
  highp vec4 lengthSq_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_34 = (tmpvar_35 * tmpvar_35);
  lengthSq_34 = (lengthSq_34 + (tmpvar_36 * tmpvar_36));
  lengthSq_34 = (lengthSq_34 + (tmpvar_37 * tmpvar_37));
  highp vec4 tmpvar_38;
  tmpvar_38 = max (lengthSq_34, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_34 = tmpvar_38;
  ndotl_33 = (tmpvar_35 * tmpvar_12.x);
  ndotl_33 = (ndotl_33 + (tmpvar_36 * tmpvar_12.y));
  ndotl_33 = (ndotl_33 + (tmpvar_37 * tmpvar_12.z));
  highp vec4 tmpvar_39;
  tmpvar_39 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_33 * inversesqrt(tmpvar_38)));
  ndotl_33 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_39 * (1.0/((1.0 + 
    (tmpvar_38 * lightAttenSq_31)
  ))));
  col_32 = (lightColor0_27 * tmpvar_40.x);
  col_32 = (col_32 + (lightColor1_28 * tmpvar_40.y));
  col_32 = (col_32 + (lightColor2_29 * tmpvar_40.z));
  col_32 = (col_32 + (lightColor3_30 * tmpvar_40.w));
  tmpvar_26 = col_32;
  tmpvar_7 = tmpvar_26;
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_6;
  xlv_TEXCOORD8 = tmpvar_7;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
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
  alpha_1 = 1.0;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_20.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_23;
  clipPlane_23 = _ClipPlane;
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, clipPlane_23.xyz);
  if ((tmpvar_25 < (clipPlane_23.w - 0.01))) {
    tmpvar_24 = 0.0;
  } else {
    tmpvar_24 = 1.0;
  };
  alpha_1 = tmpvar_24;
  tmpvar_4.w = alpha_1;
  mediump vec3 tmpvar_26;
  highp vec3 lightColor0_27;
  lightColor0_27 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_28;
  lightColor1_28 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_29;
  lightColor2_29 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_30;
  lightColor3_30 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_31;
  lightAttenSq_31 = unity_4LightAtten0;
  highp vec3 col_32;
  highp vec4 ndotl_33;
  highp vec4 lengthSq_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_34 = (tmpvar_35 * tmpvar_35);
  lengthSq_34 = (lengthSq_34 + (tmpvar_36 * tmpvar_36));
  lengthSq_34 = (lengthSq_34 + (tmpvar_37 * tmpvar_37));
  highp vec4 tmpvar_38;
  tmpvar_38 = max (lengthSq_34, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_34 = tmpvar_38;
  ndotl_33 = (tmpvar_35 * tmpvar_12.x);
  ndotl_33 = (ndotl_33 + (tmpvar_36 * tmpvar_12.y));
  ndotl_33 = (ndotl_33 + (tmpvar_37 * tmpvar_12.z));
  highp vec4 tmpvar_39;
  tmpvar_39 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_33 * inversesqrt(tmpvar_38)));
  ndotl_33 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_39 * (1.0/((1.0 + 
    (tmpvar_38 * lightAttenSq_31)
  ))));
  col_32 = (lightColor0_27 * tmpvar_40.x);
  col_32 = (col_32 + (lightColor1_28 * tmpvar_40.y));
  col_32 = (col_32 + (lightColor2_29 * tmpvar_40.z));
  col_32 = (col_32 + (lightColor3_30 * tmpvar_40.w));
  tmpvar_26 = col_32;
  tmpvar_7 = tmpvar_26;
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_6;
  xlv_TEXCOORD8 = tmpvar_7;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
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
  alpha_1 = 1.0;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_20.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_23;
  clipPlane_23 = _ClipPlane;
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, clipPlane_23.xyz);
  if ((tmpvar_25 < (clipPlane_23.w - 0.01))) {
    tmpvar_24 = 0.0;
  } else {
    tmpvar_24 = 1.0;
  };
  alpha_1 = tmpvar_24;
  tmpvar_4.w = alpha_1;
  mediump vec3 tmpvar_26;
  highp vec3 lightColor0_27;
  lightColor0_27 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_28;
  lightColor1_28 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_29;
  lightColor2_29 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_30;
  lightColor3_30 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_31;
  lightAttenSq_31 = unity_4LightAtten0;
  highp vec3 col_32;
  highp vec4 ndotl_33;
  highp vec4 lengthSq_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_34 = (tmpvar_35 * tmpvar_35);
  lengthSq_34 = (lengthSq_34 + (tmpvar_36 * tmpvar_36));
  lengthSq_34 = (lengthSq_34 + (tmpvar_37 * tmpvar_37));
  highp vec4 tmpvar_38;
  tmpvar_38 = max (lengthSq_34, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_34 = tmpvar_38;
  ndotl_33 = (tmpvar_35 * tmpvar_12.x);
  ndotl_33 = (ndotl_33 + (tmpvar_36 * tmpvar_12.y));
  ndotl_33 = (ndotl_33 + (tmpvar_37 * tmpvar_12.z));
  highp vec4 tmpvar_39;
  tmpvar_39 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_33 * inversesqrt(tmpvar_38)));
  ndotl_33 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_39 * (1.0/((1.0 + 
    (tmpvar_38 * lightAttenSq_31)
  ))));
  col_32 = (lightColor0_27 * tmpvar_40.x);
  col_32 = (col_32 + (lightColor1_28 * tmpvar_40.y));
  col_32 = (col_32 + (lightColor2_29 * tmpvar_40.z));
  col_32 = (col_32 + (lightColor3_30 * tmpvar_40.w));
  tmpvar_26 = col_32;
  tmpvar_7 = tmpvar_26;
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_6;
  xlv_TEXCOORD8 = tmpvar_7;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp float tmpvar_15;
  tmpvar_15 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + tmpvar_14))
  ), 0.0), _Shininess);
  s_2 = tmpvar_15;
  mediump float tmpvar_16;
  if ((d_3 < 0.5)) {
    tmpvar_16 = 0.025;
  } else {
    tmpvar_16 = s_2;
  };
  s_2 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = tmpvar_16;
  alpha_1 = 1.0;
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_18.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_21;
  clipPlane_21 = _ClipPlane;
  highp float tmpvar_22;
  highp vec4 pointInPlane_23;
  highp float tmpvar_24;
  tmpvar_24 = abs(clipPlane_21.w);
  if ((tmpvar_24 < 0.001)) {
    pointInPlane_23 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_25;
    tmpvar_25.w = 1.0;
    tmpvar_25.xyz = (clipPlane_21.xyz * clipPlane_21.w);
    pointInPlane_23 = tmpvar_25;
  };
  pointInPlane_23 = (unity_WorldToObject * pointInPlane_23);
  pointInPlane_23 = (pointInPlane_23 / pointInPlane_23.w);
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * clipPlane_21.xyz);
  highp float tmpvar_28;
  tmpvar_28 = dot (pointInPlane_23.xyz, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = dot (_glesVertex.xyz, tmpvar_27);
  if ((tmpvar_29 < tmpvar_28)) {
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  alpha_1 = tmpvar_22;
  tmpvar_4.w = alpha_1;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp float tmpvar_15;
  tmpvar_15 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + tmpvar_14))
  ), 0.0), _Shininess);
  s_2 = tmpvar_15;
  mediump float tmpvar_16;
  if ((d_3 < 0.5)) {
    tmpvar_16 = 0.025;
  } else {
    tmpvar_16 = s_2;
  };
  s_2 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = tmpvar_16;
  alpha_1 = 1.0;
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_18.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_21;
  clipPlane_21 = _ClipPlane;
  highp float tmpvar_22;
  highp vec4 pointInPlane_23;
  highp float tmpvar_24;
  tmpvar_24 = abs(clipPlane_21.w);
  if ((tmpvar_24 < 0.001)) {
    pointInPlane_23 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_25;
    tmpvar_25.w = 1.0;
    tmpvar_25.xyz = (clipPlane_21.xyz * clipPlane_21.w);
    pointInPlane_23 = tmpvar_25;
  };
  pointInPlane_23 = (unity_WorldToObject * pointInPlane_23);
  pointInPlane_23 = (pointInPlane_23 / pointInPlane_23.w);
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * clipPlane_21.xyz);
  highp float tmpvar_28;
  tmpvar_28 = dot (pointInPlane_23.xyz, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = dot (_glesVertex.xyz, tmpvar_27);
  if ((tmpvar_29 < tmpvar_28)) {
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  alpha_1 = tmpvar_22;
  tmpvar_4.w = alpha_1;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  d_3 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = d_3;
  tmpvar_13.y = d_3;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp float tmpvar_15;
  tmpvar_15 = pow (max (dot (tmpvar_11, 
    normalize((tmpvar_9.xyz + tmpvar_14))
  ), 0.0), _Shininess);
  s_2 = tmpvar_15;
  mediump float tmpvar_16;
  if ((d_3 < 0.5)) {
    tmpvar_16 = 0.025;
  } else {
    tmpvar_16 = s_2;
  };
  s_2 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = tmpvar_16;
  alpha_1 = 1.0;
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_7.zw;
  tmpvar_6.xyw = o_18.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_21;
  clipPlane_21 = _ClipPlane;
  highp float tmpvar_22;
  highp vec4 pointInPlane_23;
  highp float tmpvar_24;
  tmpvar_24 = abs(clipPlane_21.w);
  if ((tmpvar_24 < 0.001)) {
    pointInPlane_23 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_25;
    tmpvar_25.w = 1.0;
    tmpvar_25.xyz = (clipPlane_21.xyz * clipPlane_21.w);
    pointInPlane_23 = tmpvar_25;
  };
  pointInPlane_23 = (unity_WorldToObject * pointInPlane_23);
  pointInPlane_23 = (pointInPlane_23 / pointInPlane_23.w);
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * clipPlane_21.xyz);
  highp float tmpvar_28;
  tmpvar_28 = dot (pointInPlane_23.xyz, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = dot (_glesVertex.xyz, tmpvar_27);
  if ((tmpvar_29 < tmpvar_28)) {
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  alpha_1 = tmpvar_22;
  tmpvar_4.w = alpha_1;
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_14;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
varying highp vec4 xlv_COLOR0;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
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
  alpha_1 = 1.0;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_20.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_23;
  clipPlane_23 = _ClipPlane;
  highp float tmpvar_24;
  highp vec4 pointInPlane_25;
  highp float tmpvar_26;
  tmpvar_26 = abs(clipPlane_23.w);
  if ((tmpvar_26 < 0.001)) {
    pointInPlane_25 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_27;
    tmpvar_27.w = 1.0;
    tmpvar_27.xyz = (clipPlane_23.xyz * clipPlane_23.w);
    pointInPlane_25 = tmpvar_27;
  };
  pointInPlane_25 = (unity_WorldToObject * pointInPlane_25);
  pointInPlane_25 = (pointInPlane_25 / pointInPlane_25.w);
  highp mat3 tmpvar_28;
  tmpvar_28[0] = unity_WorldToObject[0].xyz;
  tmpvar_28[1] = unity_WorldToObject[1].xyz;
  tmpvar_28[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * clipPlane_23.xyz);
  highp float tmpvar_30;
  tmpvar_30 = dot (pointInPlane_25.xyz, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = dot (_glesVertex.xyz, tmpvar_29);
  if ((tmpvar_31 < tmpvar_30)) {
    tmpvar_24 = 0.0;
  } else {
    tmpvar_24 = 1.0;
  };
  alpha_1 = tmpvar_24;
  tmpvar_4.w = alpha_1;
  mediump vec3 tmpvar_32;
  highp vec3 lightColor0_33;
  lightColor0_33 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_34;
  lightColor1_34 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_35;
  lightColor2_35 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_36;
  lightColor3_36 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_37;
  lightAttenSq_37 = unity_4LightAtten0;
  highp vec3 col_38;
  highp vec4 ndotl_39;
  highp vec4 lengthSq_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_43;
  tmpvar_43 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_40 = (tmpvar_41 * tmpvar_41);
  lengthSq_40 = (lengthSq_40 + (tmpvar_42 * tmpvar_42));
  lengthSq_40 = (lengthSq_40 + (tmpvar_43 * tmpvar_43));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (lengthSq_40, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_40 = tmpvar_44;
  ndotl_39 = (tmpvar_41 * tmpvar_12.x);
  ndotl_39 = (ndotl_39 + (tmpvar_42 * tmpvar_12.y));
  ndotl_39 = (ndotl_39 + (tmpvar_43 * tmpvar_12.z));
  highp vec4 tmpvar_45;
  tmpvar_45 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_39 * inversesqrt(tmpvar_44)));
  ndotl_39 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_45 * (1.0/((1.0 + 
    (tmpvar_44 * lightAttenSq_37)
  ))));
  col_38 = (lightColor0_33 * tmpvar_46.x);
  col_38 = (col_38 + (lightColor1_34 * tmpvar_46.y));
  col_38 = (col_38 + (lightColor2_35 * tmpvar_46.z));
  col_38 = (col_38 + (lightColor3_36 * tmpvar_46.w));
  tmpvar_32 = col_38;
  tmpvar_7 = tmpvar_32;
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_6;
  xlv_TEXCOORD8 = tmpvar_7;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
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
  alpha_1 = 1.0;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_20.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_23;
  clipPlane_23 = _ClipPlane;
  highp float tmpvar_24;
  highp vec4 pointInPlane_25;
  highp float tmpvar_26;
  tmpvar_26 = abs(clipPlane_23.w);
  if ((tmpvar_26 < 0.001)) {
    pointInPlane_25 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_27;
    tmpvar_27.w = 1.0;
    tmpvar_27.xyz = (clipPlane_23.xyz * clipPlane_23.w);
    pointInPlane_25 = tmpvar_27;
  };
  pointInPlane_25 = (unity_WorldToObject * pointInPlane_25);
  pointInPlane_25 = (pointInPlane_25 / pointInPlane_25.w);
  highp mat3 tmpvar_28;
  tmpvar_28[0] = unity_WorldToObject[0].xyz;
  tmpvar_28[1] = unity_WorldToObject[1].xyz;
  tmpvar_28[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * clipPlane_23.xyz);
  highp float tmpvar_30;
  tmpvar_30 = dot (pointInPlane_25.xyz, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = dot (_glesVertex.xyz, tmpvar_29);
  if ((tmpvar_31 < tmpvar_30)) {
    tmpvar_24 = 0.0;
  } else {
    tmpvar_24 = 1.0;
  };
  alpha_1 = tmpvar_24;
  tmpvar_4.w = alpha_1;
  mediump vec3 tmpvar_32;
  highp vec3 lightColor0_33;
  lightColor0_33 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_34;
  lightColor1_34 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_35;
  lightColor2_35 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_36;
  lightColor3_36 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_37;
  lightAttenSq_37 = unity_4LightAtten0;
  highp vec3 col_38;
  highp vec4 ndotl_39;
  highp vec4 lengthSq_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_43;
  tmpvar_43 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_40 = (tmpvar_41 * tmpvar_41);
  lengthSq_40 = (lengthSq_40 + (tmpvar_42 * tmpvar_42));
  lengthSq_40 = (lengthSq_40 + (tmpvar_43 * tmpvar_43));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (lengthSq_40, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_40 = tmpvar_44;
  ndotl_39 = (tmpvar_41 * tmpvar_12.x);
  ndotl_39 = (ndotl_39 + (tmpvar_42 * tmpvar_12.y));
  ndotl_39 = (ndotl_39 + (tmpvar_43 * tmpvar_12.z));
  highp vec4 tmpvar_45;
  tmpvar_45 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_39 * inversesqrt(tmpvar_44)));
  ndotl_39 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_45 * (1.0/((1.0 + 
    (tmpvar_44 * lightAttenSq_37)
  ))));
  col_38 = (lightColor0_33 * tmpvar_46.x);
  col_38 = (col_38 + (lightColor1_34 * tmpvar_46.y));
  col_38 = (col_38 + (lightColor2_35 * tmpvar_46.z));
  col_38 = (col_38 + (lightColor3_36 * tmpvar_46.w));
  tmpvar_32 = col_38;
  tmpvar_7 = tmpvar_32;
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_6;
  xlv_TEXCOORD8 = tmpvar_7;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  tmpvar_1 = outColor_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  mediump float alpha_1;
  mediump float s_2;
  mediump float d_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
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
  alpha_1 = 1.0;
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_8.zw;
  tmpvar_6.xyw = o_20.xyw;
  tmpvar_6.z = _DitherAlpha;
  highp vec4 clipPlane_23;
  clipPlane_23 = _ClipPlane;
  highp float tmpvar_24;
  highp vec4 pointInPlane_25;
  highp float tmpvar_26;
  tmpvar_26 = abs(clipPlane_23.w);
  if ((tmpvar_26 < 0.001)) {
    pointInPlane_25 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_27;
    tmpvar_27.w = 1.0;
    tmpvar_27.xyz = (clipPlane_23.xyz * clipPlane_23.w);
    pointInPlane_25 = tmpvar_27;
  };
  pointInPlane_25 = (unity_WorldToObject * pointInPlane_25);
  pointInPlane_25 = (pointInPlane_25 / pointInPlane_25.w);
  highp mat3 tmpvar_28;
  tmpvar_28[0] = unity_WorldToObject[0].xyz;
  tmpvar_28[1] = unity_WorldToObject[1].xyz;
  tmpvar_28[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * clipPlane_23.xyz);
  highp float tmpvar_30;
  tmpvar_30 = dot (pointInPlane_25.xyz, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = dot (_glesVertex.xyz, tmpvar_29);
  if ((tmpvar_31 < tmpvar_30)) {
    tmpvar_24 = 0.0;
  } else {
    tmpvar_24 = 1.0;
  };
  alpha_1 = tmpvar_24;
  tmpvar_4.w = alpha_1;
  mediump vec3 tmpvar_32;
  highp vec3 lightColor0_33;
  lightColor0_33 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_34;
  lightColor1_34 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_35;
  lightColor2_35 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_36;
  lightColor3_36 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_37;
  lightAttenSq_37 = unity_4LightAtten0;
  highp vec3 col_38;
  highp vec4 ndotl_39;
  highp vec4 lengthSq_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_4LightPosX0 - tmpvar_15.x);
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosY0 - tmpvar_15.y);
  highp vec4 tmpvar_43;
  tmpvar_43 = (unity_4LightPosZ0 - tmpvar_15.z);
  lengthSq_40 = (tmpvar_41 * tmpvar_41);
  lengthSq_40 = (lengthSq_40 + (tmpvar_42 * tmpvar_42));
  lengthSq_40 = (lengthSq_40 + (tmpvar_43 * tmpvar_43));
  highp vec4 tmpvar_44;
  tmpvar_44 = max (lengthSq_40, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_40 = tmpvar_44;
  ndotl_39 = (tmpvar_41 * tmpvar_12.x);
  ndotl_39 = (ndotl_39 + (tmpvar_42 * tmpvar_12.y));
  ndotl_39 = (ndotl_39 + (tmpvar_43 * tmpvar_12.z));
  highp vec4 tmpvar_45;
  tmpvar_45 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_39 * inversesqrt(tmpvar_44)));
  ndotl_39 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_45 * (1.0/((1.0 + 
    (tmpvar_44 * lightAttenSq_37)
  ))));
  col_38 = (lightColor0_33 * tmpvar_46.x);
  col_38 = (col_38 + (lightColor1_34 * tmpvar_46.y));
  col_38 = (col_38 + (lightColor2_35 * tmpvar_46.z));
  col_38 = (col_38 + (lightColor3_36 * tmpvar_46.w));
  tmpvar_32 = col_38;
  tmpvar_7 = tmpvar_32;
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD5 = tmpvar_16;
  xlv_TEXCOORD6 = tmpvar_12;
  xlv_TEXCOORD7 = tmpvar_6;
  xlv_TEXCOORD8 = tmpvar_7;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
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
  outColor_5.w = xlv_COLOR0.w;
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
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_12;
  tmpvar_12 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = ((dot (tmpvar_14, tmpvar_12.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = d_5;
  tmpvar_16.y = d_5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_18;
  tmpvar_18 = pow (max (dot (tmpvar_14, 
    normalize((tmpvar_12.xyz + normalize((_WorldSpaceCameraPos - tmpvar_17.xyz))))
  ), 0.0), _Shininess);
  s_4 = tmpvar_18;
  mediump float tmpvar_19;
  if ((d_5 < 0.5)) {
    tmpvar_19 = 0.025;
  } else {
    tmpvar_19 = s_4;
  };
  s_4 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19;
  tmpvar_20.y = tmpvar_19;
  alpha_3 = 1.0;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  tmpvar_9.xyw = o_21.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_24;
  vertex_24 = tmpvar_1;
  highp vec4 clipPlane_25;
  clipPlane_25 = _ClipPlane;
  highp float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (_glesVertex.xyz, clipPlane_25.xyz);
  if ((tmpvar_27 < (clipPlane_25.w - 0.01))) {
    vertex_24.xyz = (_glesVertex.xyz - ((tmpvar_27 - clipPlane_25.w) * clipPlane_25.xyz));
    tmpvar_26 = 0.0;
  } else {
    tmpvar_26 = 1.0;
  };
  alpha_3 = tmpvar_26;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_28;
  uv_28 = tmpvar_2;
  highp vec4 spuvs_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (vertex_24 * 0.5);
  spuvs_29.xy = ((uv_28 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_31;
  tmpvar_31.x = (tmpvar_30.x + (tmpvar_30.z * tmpvar_30.z));
  tmpvar_31.y = ((tmpvar_30.y + (0.5 * tmpvar_30.z)) + ((0.5 * tmpvar_30.x) * tmpvar_30.x));
  spuvs_29.zw = ((tmpvar_31 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_17.xyz / tmpvar_17.w);
  gl_Position = tmpvar_10;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_20;
  xlv_TEXCOORD3 = spuvs_29;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_9;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_12;
  tmpvar_12 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = ((dot (tmpvar_14, tmpvar_12.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = d_5;
  tmpvar_16.y = d_5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_18;
  tmpvar_18 = pow (max (dot (tmpvar_14, 
    normalize((tmpvar_12.xyz + normalize((_WorldSpaceCameraPos - tmpvar_17.xyz))))
  ), 0.0), _Shininess);
  s_4 = tmpvar_18;
  mediump float tmpvar_19;
  if ((d_5 < 0.5)) {
    tmpvar_19 = 0.025;
  } else {
    tmpvar_19 = s_4;
  };
  s_4 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19;
  tmpvar_20.y = tmpvar_19;
  alpha_3 = 1.0;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  tmpvar_9.xyw = o_21.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_24;
  vertex_24 = tmpvar_1;
  highp vec4 clipPlane_25;
  clipPlane_25 = _ClipPlane;
  highp float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (_glesVertex.xyz, clipPlane_25.xyz);
  if ((tmpvar_27 < (clipPlane_25.w - 0.01))) {
    vertex_24.xyz = (_glesVertex.xyz - ((tmpvar_27 - clipPlane_25.w) * clipPlane_25.xyz));
    tmpvar_26 = 0.0;
  } else {
    tmpvar_26 = 1.0;
  };
  alpha_3 = tmpvar_26;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_28;
  uv_28 = tmpvar_2;
  highp vec4 spuvs_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (vertex_24 * 0.5);
  spuvs_29.xy = ((uv_28 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_31;
  tmpvar_31.x = (tmpvar_30.x + (tmpvar_30.z * tmpvar_30.z));
  tmpvar_31.y = ((tmpvar_30.y + (0.5 * tmpvar_30.z)) + ((0.5 * tmpvar_30.x) * tmpvar_30.x));
  spuvs_29.zw = ((tmpvar_31 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_17.xyz / tmpvar_17.w);
  gl_Position = tmpvar_10;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_20;
  xlv_TEXCOORD3 = spuvs_29;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_9;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_12;
  tmpvar_12 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = ((dot (tmpvar_14, tmpvar_12.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = d_5;
  tmpvar_16.y = d_5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_18;
  tmpvar_18 = pow (max (dot (tmpvar_14, 
    normalize((tmpvar_12.xyz + normalize((_WorldSpaceCameraPos - tmpvar_17.xyz))))
  ), 0.0), _Shininess);
  s_4 = tmpvar_18;
  mediump float tmpvar_19;
  if ((d_5 < 0.5)) {
    tmpvar_19 = 0.025;
  } else {
    tmpvar_19 = s_4;
  };
  s_4 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19;
  tmpvar_20.y = tmpvar_19;
  alpha_3 = 1.0;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  tmpvar_9.xyw = o_21.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_24;
  vertex_24 = tmpvar_1;
  highp vec4 clipPlane_25;
  clipPlane_25 = _ClipPlane;
  highp float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (_glesVertex.xyz, clipPlane_25.xyz);
  if ((tmpvar_27 < (clipPlane_25.w - 0.01))) {
    vertex_24.xyz = (_glesVertex.xyz - ((tmpvar_27 - clipPlane_25.w) * clipPlane_25.xyz));
    tmpvar_26 = 0.0;
  } else {
    tmpvar_26 = 1.0;
  };
  alpha_3 = tmpvar_26;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_28;
  uv_28 = tmpvar_2;
  highp vec4 spuvs_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (vertex_24 * 0.5);
  spuvs_29.xy = ((uv_28 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_31;
  tmpvar_31.x = (tmpvar_30.x + (tmpvar_30.z * tmpvar_30.z));
  tmpvar_31.y = ((tmpvar_30.y + (0.5 * tmpvar_30.z)) + ((0.5 * tmpvar_30.x) * tmpvar_30.x));
  spuvs_29.zw = ((tmpvar_31 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_17.xyz / tmpvar_17.w);
  gl_Position = tmpvar_10;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_20;
  xlv_TEXCOORD3 = spuvs_29;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_9;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  highp float tmpvar_16;
  tmpvar_16 = ((dot (tmpvar_15, tmpvar_13.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = d_5;
  tmpvar_17.y = d_5;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_15, 
    normalize((tmpvar_13.xyz + normalize((_WorldSpaceCameraPos - tmpvar_18.xyz))))
  ), 0.0), _Shininess);
  s_4 = tmpvar_19;
  mediump float tmpvar_20;
  if ((d_5 < 0.5)) {
    tmpvar_20 = 0.025;
  } else {
    tmpvar_20 = s_4;
  };
  s_4 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20;
  tmpvar_21.y = tmpvar_20;
  alpha_3 = 1.0;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_11.zw;
  tmpvar_9.xyw = o_22.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_25;
  vertex_25 = tmpvar_1;
  highp vec4 clipPlane_26;
  clipPlane_26 = _ClipPlane;
  highp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (_glesVertex.xyz, clipPlane_26.xyz);
  if ((tmpvar_28 < (clipPlane_26.w - 0.01))) {
    vertex_25.xyz = (_glesVertex.xyz - ((tmpvar_28 - clipPlane_26.w) * clipPlane_26.xyz));
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  alpha_3 = tmpvar_27;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_29;
  uv_29 = tmpvar_2;
  highp vec4 spuvs_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (vertex_25 * 0.5);
  spuvs_30.xy = ((uv_29 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_32;
  tmpvar_32.x = (tmpvar_31.x + (tmpvar_31.z * tmpvar_31.z));
  tmpvar_32.y = ((tmpvar_31.y + (0.5 * tmpvar_31.z)) + ((0.5 * tmpvar_31.x) * tmpvar_31.x));
  spuvs_30.zw = ((tmpvar_32 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_18.xyz / tmpvar_18.w);
  mediump vec3 tmpvar_33;
  highp vec3 lightColor0_34;
  lightColor0_34 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_35;
  lightColor1_35 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_36;
  lightColor2_36 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_37;
  lightColor3_37 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_38;
  lightAttenSq_38 = unity_4LightAtten0;
  highp vec3 col_39;
  highp vec4 ndotl_40;
  highp vec4 lengthSq_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosX0 - tmpvar_18.x);
  highp vec4 tmpvar_43;
  tmpvar_43 = (unity_4LightPosY0 - tmpvar_18.y);
  highp vec4 tmpvar_44;
  tmpvar_44 = (unity_4LightPosZ0 - tmpvar_18.z);
  lengthSq_41 = (tmpvar_42 * tmpvar_42);
  lengthSq_41 = (lengthSq_41 + (tmpvar_43 * tmpvar_43));
  lengthSq_41 = (lengthSq_41 + (tmpvar_44 * tmpvar_44));
  highp vec4 tmpvar_45;
  tmpvar_45 = max (lengthSq_41, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_41 = tmpvar_45;
  ndotl_40 = (tmpvar_42 * tmpvar_15.x);
  ndotl_40 = (ndotl_40 + (tmpvar_43 * tmpvar_15.y));
  ndotl_40 = (ndotl_40 + (tmpvar_44 * tmpvar_15.z));
  highp vec4 tmpvar_46;
  tmpvar_46 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_40 * inversesqrt(tmpvar_45)));
  ndotl_40 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (tmpvar_46 * (1.0/((1.0 + 
    (tmpvar_45 * lightAttenSq_38)
  ))));
  col_39 = (lightColor0_34 * tmpvar_47.x);
  col_39 = (col_39 + (lightColor1_35 * tmpvar_47.y));
  col_39 = (col_39 + (lightColor2_36 * tmpvar_47.z));
  col_39 = (col_39 + (lightColor3_37 * tmpvar_47.w));
  tmpvar_33 = col_39;
  tmpvar_10 = tmpvar_33;
  gl_Position = tmpvar_11;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = spuvs_30;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_15;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  highp float tmpvar_16;
  tmpvar_16 = ((dot (tmpvar_15, tmpvar_13.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = d_5;
  tmpvar_17.y = d_5;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_15, 
    normalize((tmpvar_13.xyz + normalize((_WorldSpaceCameraPos - tmpvar_18.xyz))))
  ), 0.0), _Shininess);
  s_4 = tmpvar_19;
  mediump float tmpvar_20;
  if ((d_5 < 0.5)) {
    tmpvar_20 = 0.025;
  } else {
    tmpvar_20 = s_4;
  };
  s_4 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20;
  tmpvar_21.y = tmpvar_20;
  alpha_3 = 1.0;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_11.zw;
  tmpvar_9.xyw = o_22.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_25;
  vertex_25 = tmpvar_1;
  highp vec4 clipPlane_26;
  clipPlane_26 = _ClipPlane;
  highp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (_glesVertex.xyz, clipPlane_26.xyz);
  if ((tmpvar_28 < (clipPlane_26.w - 0.01))) {
    vertex_25.xyz = (_glesVertex.xyz - ((tmpvar_28 - clipPlane_26.w) * clipPlane_26.xyz));
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  alpha_3 = tmpvar_27;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_29;
  uv_29 = tmpvar_2;
  highp vec4 spuvs_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (vertex_25 * 0.5);
  spuvs_30.xy = ((uv_29 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_32;
  tmpvar_32.x = (tmpvar_31.x + (tmpvar_31.z * tmpvar_31.z));
  tmpvar_32.y = ((tmpvar_31.y + (0.5 * tmpvar_31.z)) + ((0.5 * tmpvar_31.x) * tmpvar_31.x));
  spuvs_30.zw = ((tmpvar_32 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_18.xyz / tmpvar_18.w);
  mediump vec3 tmpvar_33;
  highp vec3 lightColor0_34;
  lightColor0_34 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_35;
  lightColor1_35 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_36;
  lightColor2_36 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_37;
  lightColor3_37 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_38;
  lightAttenSq_38 = unity_4LightAtten0;
  highp vec3 col_39;
  highp vec4 ndotl_40;
  highp vec4 lengthSq_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosX0 - tmpvar_18.x);
  highp vec4 tmpvar_43;
  tmpvar_43 = (unity_4LightPosY0 - tmpvar_18.y);
  highp vec4 tmpvar_44;
  tmpvar_44 = (unity_4LightPosZ0 - tmpvar_18.z);
  lengthSq_41 = (tmpvar_42 * tmpvar_42);
  lengthSq_41 = (lengthSq_41 + (tmpvar_43 * tmpvar_43));
  lengthSq_41 = (lengthSq_41 + (tmpvar_44 * tmpvar_44));
  highp vec4 tmpvar_45;
  tmpvar_45 = max (lengthSq_41, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_41 = tmpvar_45;
  ndotl_40 = (tmpvar_42 * tmpvar_15.x);
  ndotl_40 = (ndotl_40 + (tmpvar_43 * tmpvar_15.y));
  ndotl_40 = (ndotl_40 + (tmpvar_44 * tmpvar_15.z));
  highp vec4 tmpvar_46;
  tmpvar_46 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_40 * inversesqrt(tmpvar_45)));
  ndotl_40 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (tmpvar_46 * (1.0/((1.0 + 
    (tmpvar_45 * lightAttenSq_38)
  ))));
  col_39 = (lightColor0_34 * tmpvar_47.x);
  col_39 = (col_39 + (lightColor1_35 * tmpvar_47.y));
  col_39 = (col_39 + (lightColor2_36 * tmpvar_47.z));
  col_39 = (col_39 + (lightColor3_37 * tmpvar_47.w));
  tmpvar_33 = col_39;
  tmpvar_10 = tmpvar_33;
  gl_Position = tmpvar_11;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = spuvs_30;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_15;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  highp float tmpvar_16;
  tmpvar_16 = ((dot (tmpvar_15, tmpvar_13.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = d_5;
  tmpvar_17.y = d_5;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_15, 
    normalize((tmpvar_13.xyz + normalize((_WorldSpaceCameraPos - tmpvar_18.xyz))))
  ), 0.0), _Shininess);
  s_4 = tmpvar_19;
  mediump float tmpvar_20;
  if ((d_5 < 0.5)) {
    tmpvar_20 = 0.025;
  } else {
    tmpvar_20 = s_4;
  };
  s_4 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20;
  tmpvar_21.y = tmpvar_20;
  alpha_3 = 1.0;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_11.zw;
  tmpvar_9.xyw = o_22.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_25;
  vertex_25 = tmpvar_1;
  highp vec4 clipPlane_26;
  clipPlane_26 = _ClipPlane;
  highp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (_glesVertex.xyz, clipPlane_26.xyz);
  if ((tmpvar_28 < (clipPlane_26.w - 0.01))) {
    vertex_25.xyz = (_glesVertex.xyz - ((tmpvar_28 - clipPlane_26.w) * clipPlane_26.xyz));
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  alpha_3 = tmpvar_27;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_29;
  uv_29 = tmpvar_2;
  highp vec4 spuvs_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (vertex_25 * 0.5);
  spuvs_30.xy = ((uv_29 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_32;
  tmpvar_32.x = (tmpvar_31.x + (tmpvar_31.z * tmpvar_31.z));
  tmpvar_32.y = ((tmpvar_31.y + (0.5 * tmpvar_31.z)) + ((0.5 * tmpvar_31.x) * tmpvar_31.x));
  spuvs_30.zw = ((tmpvar_32 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_18.xyz / tmpvar_18.w);
  mediump vec3 tmpvar_33;
  highp vec3 lightColor0_34;
  lightColor0_34 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_35;
  lightColor1_35 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_36;
  lightColor2_36 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_37;
  lightColor3_37 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_38;
  lightAttenSq_38 = unity_4LightAtten0;
  highp vec3 col_39;
  highp vec4 ndotl_40;
  highp vec4 lengthSq_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_4LightPosX0 - tmpvar_18.x);
  highp vec4 tmpvar_43;
  tmpvar_43 = (unity_4LightPosY0 - tmpvar_18.y);
  highp vec4 tmpvar_44;
  tmpvar_44 = (unity_4LightPosZ0 - tmpvar_18.z);
  lengthSq_41 = (tmpvar_42 * tmpvar_42);
  lengthSq_41 = (lengthSq_41 + (tmpvar_43 * tmpvar_43));
  lengthSq_41 = (lengthSq_41 + (tmpvar_44 * tmpvar_44));
  highp vec4 tmpvar_45;
  tmpvar_45 = max (lengthSq_41, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_41 = tmpvar_45;
  ndotl_40 = (tmpvar_42 * tmpvar_15.x);
  ndotl_40 = (ndotl_40 + (tmpvar_43 * tmpvar_15.y));
  ndotl_40 = (ndotl_40 + (tmpvar_44 * tmpvar_15.z));
  highp vec4 tmpvar_46;
  tmpvar_46 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_40 * inversesqrt(tmpvar_45)));
  ndotl_40 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (tmpvar_46 * (1.0/((1.0 + 
    (tmpvar_45 * lightAttenSq_38)
  ))));
  col_39 = (lightColor0_34 * tmpvar_47.x);
  col_39 = (col_39 + (lightColor1_35 * tmpvar_47.y));
  col_39 = (col_39 + (lightColor2_36 * tmpvar_47.z));
  col_39 = (col_39 + (lightColor3_37 * tmpvar_47.w));
  tmpvar_33 = col_39;
  tmpvar_10 = tmpvar_33;
  gl_Position = tmpvar_11;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = spuvs_30;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_15;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_12;
  tmpvar_12 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = ((dot (tmpvar_14, tmpvar_12.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = d_5;
  tmpvar_16.y = d_5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_18;
  tmpvar_18 = pow (max (dot (tmpvar_14, 
    normalize((tmpvar_12.xyz + normalize((_WorldSpaceCameraPos - tmpvar_17.xyz))))
  ), 0.0), _Shininess);
  s_4 = tmpvar_18;
  mediump float tmpvar_19;
  if ((d_5 < 0.5)) {
    tmpvar_19 = 0.025;
  } else {
    tmpvar_19 = s_4;
  };
  s_4 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19;
  tmpvar_20.y = tmpvar_19;
  alpha_3 = 1.0;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  tmpvar_9.xyw = o_21.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_24;
  vertex_24 = tmpvar_1;
  highp vec4 clipPlane_25;
  clipPlane_25 = _ClipPlane;
  highp float tmpvar_26;
  highp vec4 pointInPlane_27;
  highp float tmpvar_28;
  tmpvar_28 = abs(clipPlane_25.w);
  if ((tmpvar_28 < 0.001)) {
    pointInPlane_27 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_29;
    tmpvar_29.w = 1.0;
    tmpvar_29.xyz = (clipPlane_25.xyz * clipPlane_25.w);
    pointInPlane_27 = tmpvar_29;
  };
  pointInPlane_27 = (unity_WorldToObject * pointInPlane_27);
  pointInPlane_27 = (pointInPlane_27 / pointInPlane_27.w);
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_30 * clipPlane_25.xyz);
  highp float tmpvar_32;
  tmpvar_32 = dot (pointInPlane_27.xyz, tmpvar_31);
  highp float tmpvar_33;
  tmpvar_33 = dot (_glesVertex.xyz, tmpvar_31);
  if ((tmpvar_33 < tmpvar_32)) {
    vertex_24.xyz = (_glesVertex.xyz - ((tmpvar_33 - tmpvar_32) * tmpvar_31));
    tmpvar_26 = 0.0;
  } else {
    tmpvar_26 = 1.0;
  };
  alpha_3 = tmpvar_26;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_34;
  uv_34 = tmpvar_2;
  highp vec4 spuvs_35;
  highp vec4 tmpvar_36;
  tmpvar_36 = (vertex_24 * 0.5);
  spuvs_35.xy = ((uv_34 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_37;
  tmpvar_37.x = (tmpvar_36.x + (tmpvar_36.z * tmpvar_36.z));
  tmpvar_37.y = ((tmpvar_36.y + (0.5 * tmpvar_36.z)) + ((0.5 * tmpvar_36.x) * tmpvar_36.x));
  spuvs_35.zw = ((tmpvar_37 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_17.xyz / tmpvar_17.w);
  gl_Position = tmpvar_10;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_20;
  xlv_TEXCOORD3 = spuvs_35;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_9;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_12;
  tmpvar_12 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = ((dot (tmpvar_14, tmpvar_12.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = d_5;
  tmpvar_16.y = d_5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_18;
  tmpvar_18 = pow (max (dot (tmpvar_14, 
    normalize((tmpvar_12.xyz + normalize((_WorldSpaceCameraPos - tmpvar_17.xyz))))
  ), 0.0), _Shininess);
  s_4 = tmpvar_18;
  mediump float tmpvar_19;
  if ((d_5 < 0.5)) {
    tmpvar_19 = 0.025;
  } else {
    tmpvar_19 = s_4;
  };
  s_4 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19;
  tmpvar_20.y = tmpvar_19;
  alpha_3 = 1.0;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  tmpvar_9.xyw = o_21.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_24;
  vertex_24 = tmpvar_1;
  highp vec4 clipPlane_25;
  clipPlane_25 = _ClipPlane;
  highp float tmpvar_26;
  highp vec4 pointInPlane_27;
  highp float tmpvar_28;
  tmpvar_28 = abs(clipPlane_25.w);
  if ((tmpvar_28 < 0.001)) {
    pointInPlane_27 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_29;
    tmpvar_29.w = 1.0;
    tmpvar_29.xyz = (clipPlane_25.xyz * clipPlane_25.w);
    pointInPlane_27 = tmpvar_29;
  };
  pointInPlane_27 = (unity_WorldToObject * pointInPlane_27);
  pointInPlane_27 = (pointInPlane_27 / pointInPlane_27.w);
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_30 * clipPlane_25.xyz);
  highp float tmpvar_32;
  tmpvar_32 = dot (pointInPlane_27.xyz, tmpvar_31);
  highp float tmpvar_33;
  tmpvar_33 = dot (_glesVertex.xyz, tmpvar_31);
  if ((tmpvar_33 < tmpvar_32)) {
    vertex_24.xyz = (_glesVertex.xyz - ((tmpvar_33 - tmpvar_32) * tmpvar_31));
    tmpvar_26 = 0.0;
  } else {
    tmpvar_26 = 1.0;
  };
  alpha_3 = tmpvar_26;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_34;
  uv_34 = tmpvar_2;
  highp vec4 spuvs_35;
  highp vec4 tmpvar_36;
  tmpvar_36 = (vertex_24 * 0.5);
  spuvs_35.xy = ((uv_34 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_37;
  tmpvar_37.x = (tmpvar_36.x + (tmpvar_36.z * tmpvar_36.z));
  tmpvar_37.y = ((tmpvar_36.y + (0.5 * tmpvar_36.z)) + ((0.5 * tmpvar_36.x) * tmpvar_36.x));
  spuvs_35.zw = ((tmpvar_37 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_17.xyz / tmpvar_17.w);
  gl_Position = tmpvar_10;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_20;
  xlv_TEXCOORD3 = spuvs_35;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_9;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_12;
  tmpvar_12 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = ((dot (tmpvar_14, tmpvar_12.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = d_5;
  tmpvar_16.y = d_5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_18;
  tmpvar_18 = pow (max (dot (tmpvar_14, 
    normalize((tmpvar_12.xyz + normalize((_WorldSpaceCameraPos - tmpvar_17.xyz))))
  ), 0.0), _Shininess);
  s_4 = tmpvar_18;
  mediump float tmpvar_19;
  if ((d_5 < 0.5)) {
    tmpvar_19 = 0.025;
  } else {
    tmpvar_19 = s_4;
  };
  s_4 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19;
  tmpvar_20.y = tmpvar_19;
  alpha_3 = 1.0;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  tmpvar_9.xyw = o_21.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_24;
  vertex_24 = tmpvar_1;
  highp vec4 clipPlane_25;
  clipPlane_25 = _ClipPlane;
  highp float tmpvar_26;
  highp vec4 pointInPlane_27;
  highp float tmpvar_28;
  tmpvar_28 = abs(clipPlane_25.w);
  if ((tmpvar_28 < 0.001)) {
    pointInPlane_27 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_29;
    tmpvar_29.w = 1.0;
    tmpvar_29.xyz = (clipPlane_25.xyz * clipPlane_25.w);
    pointInPlane_27 = tmpvar_29;
  };
  pointInPlane_27 = (unity_WorldToObject * pointInPlane_27);
  pointInPlane_27 = (pointInPlane_27 / pointInPlane_27.w);
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_30 * clipPlane_25.xyz);
  highp float tmpvar_32;
  tmpvar_32 = dot (pointInPlane_27.xyz, tmpvar_31);
  highp float tmpvar_33;
  tmpvar_33 = dot (_glesVertex.xyz, tmpvar_31);
  if ((tmpvar_33 < tmpvar_32)) {
    vertex_24.xyz = (_glesVertex.xyz - ((tmpvar_33 - tmpvar_32) * tmpvar_31));
    tmpvar_26 = 0.0;
  } else {
    tmpvar_26 = 1.0;
  };
  alpha_3 = tmpvar_26;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_34;
  uv_34 = tmpvar_2;
  highp vec4 spuvs_35;
  highp vec4 tmpvar_36;
  tmpvar_36 = (vertex_24 * 0.5);
  spuvs_35.xy = ((uv_34 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_37;
  tmpvar_37.x = (tmpvar_36.x + (tmpvar_36.z * tmpvar_36.z));
  tmpvar_37.y = ((tmpvar_36.y + (0.5 * tmpvar_36.z)) + ((0.5 * tmpvar_36.x) * tmpvar_36.x));
  spuvs_35.zw = ((tmpvar_37 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_17.xyz / tmpvar_17.w);
  gl_Position = tmpvar_10;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_20;
  xlv_TEXCOORD3 = spuvs_35;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_9;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  highp float tmpvar_16;
  tmpvar_16 = ((dot (tmpvar_15, tmpvar_13.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = d_5;
  tmpvar_17.y = d_5;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_15, 
    normalize((tmpvar_13.xyz + normalize((_WorldSpaceCameraPos - tmpvar_18.xyz))))
  ), 0.0), _Shininess);
  s_4 = tmpvar_19;
  mediump float tmpvar_20;
  if ((d_5 < 0.5)) {
    tmpvar_20 = 0.025;
  } else {
    tmpvar_20 = s_4;
  };
  s_4 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20;
  tmpvar_21.y = tmpvar_20;
  alpha_3 = 1.0;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_11.zw;
  tmpvar_9.xyw = o_22.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_25;
  vertex_25 = tmpvar_1;
  highp vec4 clipPlane_26;
  clipPlane_26 = _ClipPlane;
  highp float tmpvar_27;
  highp vec4 pointInPlane_28;
  highp float tmpvar_29;
  tmpvar_29 = abs(clipPlane_26.w);
  if ((tmpvar_29 < 0.001)) {
    pointInPlane_28 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_30;
    tmpvar_30.w = 1.0;
    tmpvar_30.xyz = (clipPlane_26.xyz * clipPlane_26.w);
    pointInPlane_28 = tmpvar_30;
  };
  pointInPlane_28 = (unity_WorldToObject * pointInPlane_28);
  pointInPlane_28 = (pointInPlane_28 / pointInPlane_28.w);
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_WorldToObject[0].xyz;
  tmpvar_31[1] = unity_WorldToObject[1].xyz;
  tmpvar_31[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * clipPlane_26.xyz);
  highp float tmpvar_33;
  tmpvar_33 = dot (pointInPlane_28.xyz, tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = dot (_glesVertex.xyz, tmpvar_32);
  if ((tmpvar_34 < tmpvar_33)) {
    vertex_25.xyz = (_glesVertex.xyz - ((tmpvar_34 - tmpvar_33) * tmpvar_32));
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  alpha_3 = tmpvar_27;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_35;
  uv_35 = tmpvar_2;
  highp vec4 spuvs_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (vertex_25 * 0.5);
  spuvs_36.xy = ((uv_35 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_38;
  tmpvar_38.x = (tmpvar_37.x + (tmpvar_37.z * tmpvar_37.z));
  tmpvar_38.y = ((tmpvar_37.y + (0.5 * tmpvar_37.z)) + ((0.5 * tmpvar_37.x) * tmpvar_37.x));
  spuvs_36.zw = ((tmpvar_38 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_18.xyz / tmpvar_18.w);
  mediump vec3 tmpvar_39;
  highp vec3 lightColor0_40;
  lightColor0_40 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_41;
  lightColor1_41 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_42;
  lightColor2_42 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_43;
  lightColor3_43 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_44;
  lightAttenSq_44 = unity_4LightAtten0;
  highp vec3 col_45;
  highp vec4 ndotl_46;
  highp vec4 lengthSq_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = (unity_4LightPosX0 - tmpvar_18.x);
  highp vec4 tmpvar_49;
  tmpvar_49 = (unity_4LightPosY0 - tmpvar_18.y);
  highp vec4 tmpvar_50;
  tmpvar_50 = (unity_4LightPosZ0 - tmpvar_18.z);
  lengthSq_47 = (tmpvar_48 * tmpvar_48);
  lengthSq_47 = (lengthSq_47 + (tmpvar_49 * tmpvar_49));
  lengthSq_47 = (lengthSq_47 + (tmpvar_50 * tmpvar_50));
  highp vec4 tmpvar_51;
  tmpvar_51 = max (lengthSq_47, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_47 = tmpvar_51;
  ndotl_46 = (tmpvar_48 * tmpvar_15.x);
  ndotl_46 = (ndotl_46 + (tmpvar_49 * tmpvar_15.y));
  ndotl_46 = (ndotl_46 + (tmpvar_50 * tmpvar_15.z));
  highp vec4 tmpvar_52;
  tmpvar_52 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_46 * inversesqrt(tmpvar_51)));
  ndotl_46 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53 = (tmpvar_52 * (1.0/((1.0 + 
    (tmpvar_51 * lightAttenSq_44)
  ))));
  col_45 = (lightColor0_40 * tmpvar_53.x);
  col_45 = (col_45 + (lightColor1_41 * tmpvar_53.y));
  col_45 = (col_45 + (lightColor2_42 * tmpvar_53.z));
  col_45 = (col_45 + (lightColor3_43 * tmpvar_53.w));
  tmpvar_39 = col_45;
  tmpvar_10 = tmpvar_39;
  gl_Position = tmpvar_11;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = spuvs_36;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_15;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  highp float tmpvar_16;
  tmpvar_16 = ((dot (tmpvar_15, tmpvar_13.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = d_5;
  tmpvar_17.y = d_5;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_15, 
    normalize((tmpvar_13.xyz + normalize((_WorldSpaceCameraPos - tmpvar_18.xyz))))
  ), 0.0), _Shininess);
  s_4 = tmpvar_19;
  mediump float tmpvar_20;
  if ((d_5 < 0.5)) {
    tmpvar_20 = 0.025;
  } else {
    tmpvar_20 = s_4;
  };
  s_4 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20;
  tmpvar_21.y = tmpvar_20;
  alpha_3 = 1.0;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_11.zw;
  tmpvar_9.xyw = o_22.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_25;
  vertex_25 = tmpvar_1;
  highp vec4 clipPlane_26;
  clipPlane_26 = _ClipPlane;
  highp float tmpvar_27;
  highp vec4 pointInPlane_28;
  highp float tmpvar_29;
  tmpvar_29 = abs(clipPlane_26.w);
  if ((tmpvar_29 < 0.001)) {
    pointInPlane_28 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_30;
    tmpvar_30.w = 1.0;
    tmpvar_30.xyz = (clipPlane_26.xyz * clipPlane_26.w);
    pointInPlane_28 = tmpvar_30;
  };
  pointInPlane_28 = (unity_WorldToObject * pointInPlane_28);
  pointInPlane_28 = (pointInPlane_28 / pointInPlane_28.w);
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_WorldToObject[0].xyz;
  tmpvar_31[1] = unity_WorldToObject[1].xyz;
  tmpvar_31[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * clipPlane_26.xyz);
  highp float tmpvar_33;
  tmpvar_33 = dot (pointInPlane_28.xyz, tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = dot (_glesVertex.xyz, tmpvar_32);
  if ((tmpvar_34 < tmpvar_33)) {
    vertex_25.xyz = (_glesVertex.xyz - ((tmpvar_34 - tmpvar_33) * tmpvar_32));
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  alpha_3 = tmpvar_27;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_35;
  uv_35 = tmpvar_2;
  highp vec4 spuvs_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (vertex_25 * 0.5);
  spuvs_36.xy = ((uv_35 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_38;
  tmpvar_38.x = (tmpvar_37.x + (tmpvar_37.z * tmpvar_37.z));
  tmpvar_38.y = ((tmpvar_37.y + (0.5 * tmpvar_37.z)) + ((0.5 * tmpvar_37.x) * tmpvar_37.x));
  spuvs_36.zw = ((tmpvar_38 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_18.xyz / tmpvar_18.w);
  mediump vec3 tmpvar_39;
  highp vec3 lightColor0_40;
  lightColor0_40 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_41;
  lightColor1_41 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_42;
  lightColor2_42 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_43;
  lightColor3_43 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_44;
  lightAttenSq_44 = unity_4LightAtten0;
  highp vec3 col_45;
  highp vec4 ndotl_46;
  highp vec4 lengthSq_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = (unity_4LightPosX0 - tmpvar_18.x);
  highp vec4 tmpvar_49;
  tmpvar_49 = (unity_4LightPosY0 - tmpvar_18.y);
  highp vec4 tmpvar_50;
  tmpvar_50 = (unity_4LightPosZ0 - tmpvar_18.z);
  lengthSq_47 = (tmpvar_48 * tmpvar_48);
  lengthSq_47 = (lengthSq_47 + (tmpvar_49 * tmpvar_49));
  lengthSq_47 = (lengthSq_47 + (tmpvar_50 * tmpvar_50));
  highp vec4 tmpvar_51;
  tmpvar_51 = max (lengthSq_47, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_47 = tmpvar_51;
  ndotl_46 = (tmpvar_48 * tmpvar_15.x);
  ndotl_46 = (ndotl_46 + (tmpvar_49 * tmpvar_15.y));
  ndotl_46 = (ndotl_46 + (tmpvar_50 * tmpvar_15.z));
  highp vec4 tmpvar_52;
  tmpvar_52 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_46 * inversesqrt(tmpvar_51)));
  ndotl_46 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53 = (tmpvar_52 * (1.0/((1.0 + 
    (tmpvar_51 * lightAttenSq_44)
  ))));
  col_45 = (lightColor0_40 * tmpvar_53.x);
  col_45 = (col_45 + (lightColor1_41 * tmpvar_53.y));
  col_45 = (col_45 + (lightColor2_42 * tmpvar_53.z));
  col_45 = (col_45 + (lightColor3_43 * tmpvar_53.w));
  tmpvar_39 = col_45;
  tmpvar_10 = tmpvar_39;
  gl_Position = tmpvar_11;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = spuvs_36;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_15;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  highp float tmpvar_16;
  tmpvar_16 = ((dot (tmpvar_15, tmpvar_13.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = d_5;
  tmpvar_17.y = d_5;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_15, 
    normalize((tmpvar_13.xyz + normalize((_WorldSpaceCameraPos - tmpvar_18.xyz))))
  ), 0.0), _Shininess);
  s_4 = tmpvar_19;
  mediump float tmpvar_20;
  if ((d_5 < 0.5)) {
    tmpvar_20 = 0.025;
  } else {
    tmpvar_20 = s_4;
  };
  s_4 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20;
  tmpvar_21.y = tmpvar_20;
  alpha_3 = 1.0;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_11.zw;
  tmpvar_9.xyw = o_22.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_25;
  vertex_25 = tmpvar_1;
  highp vec4 clipPlane_26;
  clipPlane_26 = _ClipPlane;
  highp float tmpvar_27;
  highp vec4 pointInPlane_28;
  highp float tmpvar_29;
  tmpvar_29 = abs(clipPlane_26.w);
  if ((tmpvar_29 < 0.001)) {
    pointInPlane_28 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_30;
    tmpvar_30.w = 1.0;
    tmpvar_30.xyz = (clipPlane_26.xyz * clipPlane_26.w);
    pointInPlane_28 = tmpvar_30;
  };
  pointInPlane_28 = (unity_WorldToObject * pointInPlane_28);
  pointInPlane_28 = (pointInPlane_28 / pointInPlane_28.w);
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_WorldToObject[0].xyz;
  tmpvar_31[1] = unity_WorldToObject[1].xyz;
  tmpvar_31[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * clipPlane_26.xyz);
  highp float tmpvar_33;
  tmpvar_33 = dot (pointInPlane_28.xyz, tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = dot (_glesVertex.xyz, tmpvar_32);
  if ((tmpvar_34 < tmpvar_33)) {
    vertex_25.xyz = (_glesVertex.xyz - ((tmpvar_34 - tmpvar_33) * tmpvar_32));
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  alpha_3 = tmpvar_27;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_35;
  uv_35 = tmpvar_2;
  highp vec4 spuvs_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (vertex_25 * 0.5);
  spuvs_36.xy = ((uv_35 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_38;
  tmpvar_38.x = (tmpvar_37.x + (tmpvar_37.z * tmpvar_37.z));
  tmpvar_38.y = ((tmpvar_37.y + (0.5 * tmpvar_37.z)) + ((0.5 * tmpvar_37.x) * tmpvar_37.x));
  spuvs_36.zw = ((tmpvar_38 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_18.xyz / tmpvar_18.w);
  mediump vec3 tmpvar_39;
  highp vec3 lightColor0_40;
  lightColor0_40 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_41;
  lightColor1_41 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_42;
  lightColor2_42 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_43;
  lightColor3_43 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_44;
  lightAttenSq_44 = unity_4LightAtten0;
  highp vec3 col_45;
  highp vec4 ndotl_46;
  highp vec4 lengthSq_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = (unity_4LightPosX0 - tmpvar_18.x);
  highp vec4 tmpvar_49;
  tmpvar_49 = (unity_4LightPosY0 - tmpvar_18.y);
  highp vec4 tmpvar_50;
  tmpvar_50 = (unity_4LightPosZ0 - tmpvar_18.z);
  lengthSq_47 = (tmpvar_48 * tmpvar_48);
  lengthSq_47 = (lengthSq_47 + (tmpvar_49 * tmpvar_49));
  lengthSq_47 = (lengthSq_47 + (tmpvar_50 * tmpvar_50));
  highp vec4 tmpvar_51;
  tmpvar_51 = max (lengthSq_47, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_47 = tmpvar_51;
  ndotl_46 = (tmpvar_48 * tmpvar_15.x);
  ndotl_46 = (ndotl_46 + (tmpvar_49 * tmpvar_15.y));
  ndotl_46 = (ndotl_46 + (tmpvar_50 * tmpvar_15.z));
  highp vec4 tmpvar_52;
  tmpvar_52 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_46 * inversesqrt(tmpvar_51)));
  ndotl_46 = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53 = (tmpvar_52 * (1.0/((1.0 + 
    (tmpvar_51 * lightAttenSq_44)
  ))));
  col_45 = (lightColor0_40 * tmpvar_53.x);
  col_45 = (col_45 + (lightColor1_41 * tmpvar_53.y));
  col_45 = (col_45 + (lightColor2_42 * tmpvar_53.z));
  col_45 = (col_45 + (lightColor3_43 * tmpvar_53.w));
  tmpvar_39 = col_45;
  tmpvar_10 = tmpvar_39;
  gl_Position = tmpvar_11;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = spuvs_36;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_15;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_12;
  tmpvar_12 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = ((dot (tmpvar_14, tmpvar_12.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = d_5;
  tmpvar_16.y = d_5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - tmpvar_17.xyz));
  highp float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_14, 
    normalize((tmpvar_12.xyz + tmpvar_18))
  ), 0.0), _Shininess);
  s_4 = tmpvar_19;
  mediump float tmpvar_20;
  if ((d_5 < 0.5)) {
    tmpvar_20 = 0.025;
  } else {
    tmpvar_20 = s_4;
  };
  s_4 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20;
  tmpvar_21.y = tmpvar_20;
  alpha_3 = 1.0;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_10.zw;
  tmpvar_9.xyw = o_22.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_25;
  vertex_25 = tmpvar_1;
  highp vec4 clipPlane_26;
  clipPlane_26 = _ClipPlane;
  highp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (_glesVertex.xyz, clipPlane_26.xyz);
  if ((tmpvar_28 < (clipPlane_26.w - 0.01))) {
    vertex_25.xyz = (_glesVertex.xyz - ((tmpvar_28 - clipPlane_26.w) * clipPlane_26.xyz));
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  alpha_3 = tmpvar_27;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_29;
  uv_29 = tmpvar_2;
  highp vec4 spuvs_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (vertex_25 * 0.5);
  spuvs_30.xy = ((uv_29 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_32;
  tmpvar_32.x = (tmpvar_31.x + (tmpvar_31.z * tmpvar_31.z));
  tmpvar_32.y = ((tmpvar_31.y + (0.5 * tmpvar_31.z)) + ((0.5 * tmpvar_31.x) * tmpvar_31.x));
  spuvs_30.zw = ((tmpvar_32 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_17.xyz / tmpvar_17.w);
  gl_Position = tmpvar_10;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = spuvs_30;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_9;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_12;
  tmpvar_12 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = ((dot (tmpvar_14, tmpvar_12.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = d_5;
  tmpvar_16.y = d_5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - tmpvar_17.xyz));
  highp float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_14, 
    normalize((tmpvar_12.xyz + tmpvar_18))
  ), 0.0), _Shininess);
  s_4 = tmpvar_19;
  mediump float tmpvar_20;
  if ((d_5 < 0.5)) {
    tmpvar_20 = 0.025;
  } else {
    tmpvar_20 = s_4;
  };
  s_4 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20;
  tmpvar_21.y = tmpvar_20;
  alpha_3 = 1.0;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_10.zw;
  tmpvar_9.xyw = o_22.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_25;
  vertex_25 = tmpvar_1;
  highp vec4 clipPlane_26;
  clipPlane_26 = _ClipPlane;
  highp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (_glesVertex.xyz, clipPlane_26.xyz);
  if ((tmpvar_28 < (clipPlane_26.w - 0.01))) {
    vertex_25.xyz = (_glesVertex.xyz - ((tmpvar_28 - clipPlane_26.w) * clipPlane_26.xyz));
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  alpha_3 = tmpvar_27;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_29;
  uv_29 = tmpvar_2;
  highp vec4 spuvs_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (vertex_25 * 0.5);
  spuvs_30.xy = ((uv_29 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_32;
  tmpvar_32.x = (tmpvar_31.x + (tmpvar_31.z * tmpvar_31.z));
  tmpvar_32.y = ((tmpvar_31.y + (0.5 * tmpvar_31.z)) + ((0.5 * tmpvar_31.x) * tmpvar_31.x));
  spuvs_30.zw = ((tmpvar_32 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_17.xyz / tmpvar_17.w);
  gl_Position = tmpvar_10;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = spuvs_30;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_9;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_12;
  tmpvar_12 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = ((dot (tmpvar_14, tmpvar_12.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = d_5;
  tmpvar_16.y = d_5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - tmpvar_17.xyz));
  highp float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_14, 
    normalize((tmpvar_12.xyz + tmpvar_18))
  ), 0.0), _Shininess);
  s_4 = tmpvar_19;
  mediump float tmpvar_20;
  if ((d_5 < 0.5)) {
    tmpvar_20 = 0.025;
  } else {
    tmpvar_20 = s_4;
  };
  s_4 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20;
  tmpvar_21.y = tmpvar_20;
  alpha_3 = 1.0;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_10.zw;
  tmpvar_9.xyw = o_22.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_25;
  vertex_25 = tmpvar_1;
  highp vec4 clipPlane_26;
  clipPlane_26 = _ClipPlane;
  highp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (_glesVertex.xyz, clipPlane_26.xyz);
  if ((tmpvar_28 < (clipPlane_26.w - 0.01))) {
    vertex_25.xyz = (_glesVertex.xyz - ((tmpvar_28 - clipPlane_26.w) * clipPlane_26.xyz));
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  alpha_3 = tmpvar_27;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_29;
  uv_29 = tmpvar_2;
  highp vec4 spuvs_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (vertex_25 * 0.5);
  spuvs_30.xy = ((uv_29 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_32;
  tmpvar_32.x = (tmpvar_31.x + (tmpvar_31.z * tmpvar_31.z));
  tmpvar_32.y = ((tmpvar_31.y + (0.5 * tmpvar_31.z)) + ((0.5 * tmpvar_31.x) * tmpvar_31.x));
  spuvs_30.zw = ((tmpvar_32 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_17.xyz / tmpvar_17.w);
  gl_Position = tmpvar_10;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = spuvs_30;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_9;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  highp float tmpvar_16;
  tmpvar_16 = ((dot (tmpvar_15, tmpvar_13.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = d_5;
  tmpvar_17.y = d_5;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - tmpvar_18.xyz));
  highp float tmpvar_20;
  tmpvar_20 = pow (max (dot (tmpvar_15, 
    normalize((tmpvar_13.xyz + tmpvar_19))
  ), 0.0), _Shininess);
  s_4 = tmpvar_20;
  mediump float tmpvar_21;
  if ((d_5 < 0.5)) {
    tmpvar_21 = 0.025;
  } else {
    tmpvar_21 = s_4;
  };
  s_4 = tmpvar_21;
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21;
  tmpvar_22.y = tmpvar_21;
  alpha_3 = 1.0;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_11.zw;
  tmpvar_9.xyw = o_23.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_26;
  vertex_26 = tmpvar_1;
  highp vec4 clipPlane_27;
  clipPlane_27 = _ClipPlane;
  highp float tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = dot (_glesVertex.xyz, clipPlane_27.xyz);
  if ((tmpvar_29 < (clipPlane_27.w - 0.01))) {
    vertex_26.xyz = (_glesVertex.xyz - ((tmpvar_29 - clipPlane_27.w) * clipPlane_27.xyz));
    tmpvar_28 = 0.0;
  } else {
    tmpvar_28 = 1.0;
  };
  alpha_3 = tmpvar_28;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_30;
  uv_30 = tmpvar_2;
  highp vec4 spuvs_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (vertex_26 * 0.5);
  spuvs_31.xy = ((uv_30 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_33;
  tmpvar_33.x = (tmpvar_32.x + (tmpvar_32.z * tmpvar_32.z));
  tmpvar_33.y = ((tmpvar_32.y + (0.5 * tmpvar_32.z)) + ((0.5 * tmpvar_32.x) * tmpvar_32.x));
  spuvs_31.zw = ((tmpvar_33 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_18.xyz / tmpvar_18.w);
  mediump vec3 tmpvar_34;
  highp vec3 lightColor0_35;
  lightColor0_35 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_36;
  lightColor1_36 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_37;
  lightColor2_37 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_38;
  lightColor3_38 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_39;
  lightAttenSq_39 = unity_4LightAtten0;
  highp vec3 col_40;
  highp vec4 ndotl_41;
  highp vec4 lengthSq_42;
  highp vec4 tmpvar_43;
  tmpvar_43 = (unity_4LightPosX0 - tmpvar_18.x);
  highp vec4 tmpvar_44;
  tmpvar_44 = (unity_4LightPosY0 - tmpvar_18.y);
  highp vec4 tmpvar_45;
  tmpvar_45 = (unity_4LightPosZ0 - tmpvar_18.z);
  lengthSq_42 = (tmpvar_43 * tmpvar_43);
  lengthSq_42 = (lengthSq_42 + (tmpvar_44 * tmpvar_44));
  lengthSq_42 = (lengthSq_42 + (tmpvar_45 * tmpvar_45));
  highp vec4 tmpvar_46;
  tmpvar_46 = max (lengthSq_42, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_42 = tmpvar_46;
  ndotl_41 = (tmpvar_43 * tmpvar_15.x);
  ndotl_41 = (ndotl_41 + (tmpvar_44 * tmpvar_15.y));
  ndotl_41 = (ndotl_41 + (tmpvar_45 * tmpvar_15.z));
  highp vec4 tmpvar_47;
  tmpvar_47 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_41 * inversesqrt(tmpvar_46)));
  ndotl_41 = tmpvar_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = (tmpvar_47 * (1.0/((1.0 + 
    (tmpvar_46 * lightAttenSq_39)
  ))));
  col_40 = (lightColor0_35 * tmpvar_48.x);
  col_40 = (col_40 + (lightColor1_36 * tmpvar_48.y));
  col_40 = (col_40 + (lightColor2_37 * tmpvar_48.z));
  col_40 = (col_40 + (lightColor3_38 * tmpvar_48.w));
  tmpvar_34 = col_40;
  tmpvar_10 = tmpvar_34;
  gl_Position = tmpvar_11;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_22;
  xlv_TEXCOORD3 = spuvs_31;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_15;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  highp float tmpvar_16;
  tmpvar_16 = ((dot (tmpvar_15, tmpvar_13.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = d_5;
  tmpvar_17.y = d_5;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - tmpvar_18.xyz));
  highp float tmpvar_20;
  tmpvar_20 = pow (max (dot (tmpvar_15, 
    normalize((tmpvar_13.xyz + tmpvar_19))
  ), 0.0), _Shininess);
  s_4 = tmpvar_20;
  mediump float tmpvar_21;
  if ((d_5 < 0.5)) {
    tmpvar_21 = 0.025;
  } else {
    tmpvar_21 = s_4;
  };
  s_4 = tmpvar_21;
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21;
  tmpvar_22.y = tmpvar_21;
  alpha_3 = 1.0;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_11.zw;
  tmpvar_9.xyw = o_23.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_26;
  vertex_26 = tmpvar_1;
  highp vec4 clipPlane_27;
  clipPlane_27 = _ClipPlane;
  highp float tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = dot (_glesVertex.xyz, clipPlane_27.xyz);
  if ((tmpvar_29 < (clipPlane_27.w - 0.01))) {
    vertex_26.xyz = (_glesVertex.xyz - ((tmpvar_29 - clipPlane_27.w) * clipPlane_27.xyz));
    tmpvar_28 = 0.0;
  } else {
    tmpvar_28 = 1.0;
  };
  alpha_3 = tmpvar_28;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_30;
  uv_30 = tmpvar_2;
  highp vec4 spuvs_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (vertex_26 * 0.5);
  spuvs_31.xy = ((uv_30 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_33;
  tmpvar_33.x = (tmpvar_32.x + (tmpvar_32.z * tmpvar_32.z));
  tmpvar_33.y = ((tmpvar_32.y + (0.5 * tmpvar_32.z)) + ((0.5 * tmpvar_32.x) * tmpvar_32.x));
  spuvs_31.zw = ((tmpvar_33 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_18.xyz / tmpvar_18.w);
  mediump vec3 tmpvar_34;
  highp vec3 lightColor0_35;
  lightColor0_35 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_36;
  lightColor1_36 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_37;
  lightColor2_37 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_38;
  lightColor3_38 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_39;
  lightAttenSq_39 = unity_4LightAtten0;
  highp vec3 col_40;
  highp vec4 ndotl_41;
  highp vec4 lengthSq_42;
  highp vec4 tmpvar_43;
  tmpvar_43 = (unity_4LightPosX0 - tmpvar_18.x);
  highp vec4 tmpvar_44;
  tmpvar_44 = (unity_4LightPosY0 - tmpvar_18.y);
  highp vec4 tmpvar_45;
  tmpvar_45 = (unity_4LightPosZ0 - tmpvar_18.z);
  lengthSq_42 = (tmpvar_43 * tmpvar_43);
  lengthSq_42 = (lengthSq_42 + (tmpvar_44 * tmpvar_44));
  lengthSq_42 = (lengthSq_42 + (tmpvar_45 * tmpvar_45));
  highp vec4 tmpvar_46;
  tmpvar_46 = max (lengthSq_42, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_42 = tmpvar_46;
  ndotl_41 = (tmpvar_43 * tmpvar_15.x);
  ndotl_41 = (ndotl_41 + (tmpvar_44 * tmpvar_15.y));
  ndotl_41 = (ndotl_41 + (tmpvar_45 * tmpvar_15.z));
  highp vec4 tmpvar_47;
  tmpvar_47 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_41 * inversesqrt(tmpvar_46)));
  ndotl_41 = tmpvar_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = (tmpvar_47 * (1.0/((1.0 + 
    (tmpvar_46 * lightAttenSq_39)
  ))));
  col_40 = (lightColor0_35 * tmpvar_48.x);
  col_40 = (col_40 + (lightColor1_36 * tmpvar_48.y));
  col_40 = (col_40 + (lightColor2_37 * tmpvar_48.z));
  col_40 = (col_40 + (lightColor3_38 * tmpvar_48.w));
  tmpvar_34 = col_40;
  tmpvar_10 = tmpvar_34;
  gl_Position = tmpvar_11;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_22;
  xlv_TEXCOORD3 = spuvs_31;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_15;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  highp float tmpvar_16;
  tmpvar_16 = ((dot (tmpvar_15, tmpvar_13.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = d_5;
  tmpvar_17.y = d_5;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - tmpvar_18.xyz));
  highp float tmpvar_20;
  tmpvar_20 = pow (max (dot (tmpvar_15, 
    normalize((tmpvar_13.xyz + tmpvar_19))
  ), 0.0), _Shininess);
  s_4 = tmpvar_20;
  mediump float tmpvar_21;
  if ((d_5 < 0.5)) {
    tmpvar_21 = 0.025;
  } else {
    tmpvar_21 = s_4;
  };
  s_4 = tmpvar_21;
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21;
  tmpvar_22.y = tmpvar_21;
  alpha_3 = 1.0;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_11.zw;
  tmpvar_9.xyw = o_23.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_26;
  vertex_26 = tmpvar_1;
  highp vec4 clipPlane_27;
  clipPlane_27 = _ClipPlane;
  highp float tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = dot (_glesVertex.xyz, clipPlane_27.xyz);
  if ((tmpvar_29 < (clipPlane_27.w - 0.01))) {
    vertex_26.xyz = (_glesVertex.xyz - ((tmpvar_29 - clipPlane_27.w) * clipPlane_27.xyz));
    tmpvar_28 = 0.0;
  } else {
    tmpvar_28 = 1.0;
  };
  alpha_3 = tmpvar_28;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_30;
  uv_30 = tmpvar_2;
  highp vec4 spuvs_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (vertex_26 * 0.5);
  spuvs_31.xy = ((uv_30 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_33;
  tmpvar_33.x = (tmpvar_32.x + (tmpvar_32.z * tmpvar_32.z));
  tmpvar_33.y = ((tmpvar_32.y + (0.5 * tmpvar_32.z)) + ((0.5 * tmpvar_32.x) * tmpvar_32.x));
  spuvs_31.zw = ((tmpvar_33 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_18.xyz / tmpvar_18.w);
  mediump vec3 tmpvar_34;
  highp vec3 lightColor0_35;
  lightColor0_35 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_36;
  lightColor1_36 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_37;
  lightColor2_37 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_38;
  lightColor3_38 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_39;
  lightAttenSq_39 = unity_4LightAtten0;
  highp vec3 col_40;
  highp vec4 ndotl_41;
  highp vec4 lengthSq_42;
  highp vec4 tmpvar_43;
  tmpvar_43 = (unity_4LightPosX0 - tmpvar_18.x);
  highp vec4 tmpvar_44;
  tmpvar_44 = (unity_4LightPosY0 - tmpvar_18.y);
  highp vec4 tmpvar_45;
  tmpvar_45 = (unity_4LightPosZ0 - tmpvar_18.z);
  lengthSq_42 = (tmpvar_43 * tmpvar_43);
  lengthSq_42 = (lengthSq_42 + (tmpvar_44 * tmpvar_44));
  lengthSq_42 = (lengthSq_42 + (tmpvar_45 * tmpvar_45));
  highp vec4 tmpvar_46;
  tmpvar_46 = max (lengthSq_42, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_42 = tmpvar_46;
  ndotl_41 = (tmpvar_43 * tmpvar_15.x);
  ndotl_41 = (ndotl_41 + (tmpvar_44 * tmpvar_15.y));
  ndotl_41 = (ndotl_41 + (tmpvar_45 * tmpvar_15.z));
  highp vec4 tmpvar_47;
  tmpvar_47 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_41 * inversesqrt(tmpvar_46)));
  ndotl_41 = tmpvar_47;
  highp vec4 tmpvar_48;
  tmpvar_48 = (tmpvar_47 * (1.0/((1.0 + 
    (tmpvar_46 * lightAttenSq_39)
  ))));
  col_40 = (lightColor0_35 * tmpvar_48.x);
  col_40 = (col_40 + (lightColor1_36 * tmpvar_48.y));
  col_40 = (col_40 + (lightColor2_37 * tmpvar_48.z));
  col_40 = (col_40 + (lightColor3_38 * tmpvar_48.w));
  tmpvar_34 = col_40;
  tmpvar_10 = tmpvar_34;
  gl_Position = tmpvar_11;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_22;
  xlv_TEXCOORD3 = spuvs_31;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_15;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_12;
  tmpvar_12 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = ((dot (tmpvar_14, tmpvar_12.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = d_5;
  tmpvar_16.y = d_5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - tmpvar_17.xyz));
  highp float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_14, 
    normalize((tmpvar_12.xyz + tmpvar_18))
  ), 0.0), _Shininess);
  s_4 = tmpvar_19;
  mediump float tmpvar_20;
  if ((d_5 < 0.5)) {
    tmpvar_20 = 0.025;
  } else {
    tmpvar_20 = s_4;
  };
  s_4 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20;
  tmpvar_21.y = tmpvar_20;
  alpha_3 = 1.0;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_10.zw;
  tmpvar_9.xyw = o_22.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_25;
  vertex_25 = tmpvar_1;
  highp vec4 clipPlane_26;
  clipPlane_26 = _ClipPlane;
  highp float tmpvar_27;
  highp vec4 pointInPlane_28;
  highp float tmpvar_29;
  tmpvar_29 = abs(clipPlane_26.w);
  if ((tmpvar_29 < 0.001)) {
    pointInPlane_28 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_30;
    tmpvar_30.w = 1.0;
    tmpvar_30.xyz = (clipPlane_26.xyz * clipPlane_26.w);
    pointInPlane_28 = tmpvar_30;
  };
  pointInPlane_28 = (unity_WorldToObject * pointInPlane_28);
  pointInPlane_28 = (pointInPlane_28 / pointInPlane_28.w);
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_WorldToObject[0].xyz;
  tmpvar_31[1] = unity_WorldToObject[1].xyz;
  tmpvar_31[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * clipPlane_26.xyz);
  highp float tmpvar_33;
  tmpvar_33 = dot (pointInPlane_28.xyz, tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = dot (_glesVertex.xyz, tmpvar_32);
  if ((tmpvar_34 < tmpvar_33)) {
    vertex_25.xyz = (_glesVertex.xyz - ((tmpvar_34 - tmpvar_33) * tmpvar_32));
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  alpha_3 = tmpvar_27;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_35;
  uv_35 = tmpvar_2;
  highp vec4 spuvs_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (vertex_25 * 0.5);
  spuvs_36.xy = ((uv_35 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_38;
  tmpvar_38.x = (tmpvar_37.x + (tmpvar_37.z * tmpvar_37.z));
  tmpvar_38.y = ((tmpvar_37.y + (0.5 * tmpvar_37.z)) + ((0.5 * tmpvar_37.x) * tmpvar_37.x));
  spuvs_36.zw = ((tmpvar_38 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_17.xyz / tmpvar_17.w);
  gl_Position = tmpvar_10;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = spuvs_36;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_9;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_12;
  tmpvar_12 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = ((dot (tmpvar_14, tmpvar_12.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = d_5;
  tmpvar_16.y = d_5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - tmpvar_17.xyz));
  highp float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_14, 
    normalize((tmpvar_12.xyz + tmpvar_18))
  ), 0.0), _Shininess);
  s_4 = tmpvar_19;
  mediump float tmpvar_20;
  if ((d_5 < 0.5)) {
    tmpvar_20 = 0.025;
  } else {
    tmpvar_20 = s_4;
  };
  s_4 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20;
  tmpvar_21.y = tmpvar_20;
  alpha_3 = 1.0;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_10.zw;
  tmpvar_9.xyw = o_22.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_25;
  vertex_25 = tmpvar_1;
  highp vec4 clipPlane_26;
  clipPlane_26 = _ClipPlane;
  highp float tmpvar_27;
  highp vec4 pointInPlane_28;
  highp float tmpvar_29;
  tmpvar_29 = abs(clipPlane_26.w);
  if ((tmpvar_29 < 0.001)) {
    pointInPlane_28 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_30;
    tmpvar_30.w = 1.0;
    tmpvar_30.xyz = (clipPlane_26.xyz * clipPlane_26.w);
    pointInPlane_28 = tmpvar_30;
  };
  pointInPlane_28 = (unity_WorldToObject * pointInPlane_28);
  pointInPlane_28 = (pointInPlane_28 / pointInPlane_28.w);
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_WorldToObject[0].xyz;
  tmpvar_31[1] = unity_WorldToObject[1].xyz;
  tmpvar_31[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * clipPlane_26.xyz);
  highp float tmpvar_33;
  tmpvar_33 = dot (pointInPlane_28.xyz, tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = dot (_glesVertex.xyz, tmpvar_32);
  if ((tmpvar_34 < tmpvar_33)) {
    vertex_25.xyz = (_glesVertex.xyz - ((tmpvar_34 - tmpvar_33) * tmpvar_32));
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  alpha_3 = tmpvar_27;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_35;
  uv_35 = tmpvar_2;
  highp vec4 spuvs_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (vertex_25 * 0.5);
  spuvs_36.xy = ((uv_35 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_38;
  tmpvar_38.x = (tmpvar_37.x + (tmpvar_37.z * tmpvar_37.z));
  tmpvar_38.y = ((tmpvar_37.y + (0.5 * tmpvar_37.z)) + ((0.5 * tmpvar_37.x) * tmpvar_37.x));
  spuvs_36.zw = ((tmpvar_38 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_17.xyz / tmpvar_17.w);
  gl_Position = tmpvar_10;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = spuvs_36;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_9;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_12;
  tmpvar_12 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(normalize((_glesNormal * tmpvar_13)));
  highp float tmpvar_15;
  tmpvar_15 = ((dot (tmpvar_14, tmpvar_12.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = d_5;
  tmpvar_16.y = d_5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceCameraPos - tmpvar_17.xyz));
  highp float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_14, 
    normalize((tmpvar_12.xyz + tmpvar_18))
  ), 0.0), _Shininess);
  s_4 = tmpvar_19;
  mediump float tmpvar_20;
  if ((d_5 < 0.5)) {
    tmpvar_20 = 0.025;
  } else {
    tmpvar_20 = s_4;
  };
  s_4 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20;
  tmpvar_21.y = tmpvar_20;
  alpha_3 = 1.0;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_10.zw;
  tmpvar_9.xyw = o_22.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_25;
  vertex_25 = tmpvar_1;
  highp vec4 clipPlane_26;
  clipPlane_26 = _ClipPlane;
  highp float tmpvar_27;
  highp vec4 pointInPlane_28;
  highp float tmpvar_29;
  tmpvar_29 = abs(clipPlane_26.w);
  if ((tmpvar_29 < 0.001)) {
    pointInPlane_28 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_30;
    tmpvar_30.w = 1.0;
    tmpvar_30.xyz = (clipPlane_26.xyz * clipPlane_26.w);
    pointInPlane_28 = tmpvar_30;
  };
  pointInPlane_28 = (unity_WorldToObject * pointInPlane_28);
  pointInPlane_28 = (pointInPlane_28 / pointInPlane_28.w);
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_WorldToObject[0].xyz;
  tmpvar_31[1] = unity_WorldToObject[1].xyz;
  tmpvar_31[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * clipPlane_26.xyz);
  highp float tmpvar_33;
  tmpvar_33 = dot (pointInPlane_28.xyz, tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = dot (_glesVertex.xyz, tmpvar_32);
  if ((tmpvar_34 < tmpvar_33)) {
    vertex_25.xyz = (_glesVertex.xyz - ((tmpvar_34 - tmpvar_33) * tmpvar_32));
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  alpha_3 = tmpvar_27;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_35;
  uv_35 = tmpvar_2;
  highp vec4 spuvs_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (vertex_25 * 0.5);
  spuvs_36.xy = ((uv_35 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_38;
  tmpvar_38.x = (tmpvar_37.x + (tmpvar_37.z * tmpvar_37.z));
  tmpvar_38.y = ((tmpvar_37.y + (0.5 * tmpvar_37.z)) + ((0.5 * tmpvar_37.x) * tmpvar_37.x));
  spuvs_36.zw = ((tmpvar_38 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_17.xyz / tmpvar_17.w);
  gl_Position = tmpvar_10;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = spuvs_36;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_9;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  highp float tmpvar_16;
  tmpvar_16 = ((dot (tmpvar_15, tmpvar_13.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = d_5;
  tmpvar_17.y = d_5;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - tmpvar_18.xyz));
  highp float tmpvar_20;
  tmpvar_20 = pow (max (dot (tmpvar_15, 
    normalize((tmpvar_13.xyz + tmpvar_19))
  ), 0.0), _Shininess);
  s_4 = tmpvar_20;
  mediump float tmpvar_21;
  if ((d_5 < 0.5)) {
    tmpvar_21 = 0.025;
  } else {
    tmpvar_21 = s_4;
  };
  s_4 = tmpvar_21;
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21;
  tmpvar_22.y = tmpvar_21;
  alpha_3 = 1.0;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_11.zw;
  tmpvar_9.xyw = o_23.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_26;
  vertex_26 = tmpvar_1;
  highp vec4 clipPlane_27;
  clipPlane_27 = _ClipPlane;
  highp float tmpvar_28;
  highp vec4 pointInPlane_29;
  highp float tmpvar_30;
  tmpvar_30 = abs(clipPlane_27.w);
  if ((tmpvar_30 < 0.001)) {
    pointInPlane_29 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_31;
    tmpvar_31.w = 1.0;
    tmpvar_31.xyz = (clipPlane_27.xyz * clipPlane_27.w);
    pointInPlane_29 = tmpvar_31;
  };
  pointInPlane_29 = (unity_WorldToObject * pointInPlane_29);
  pointInPlane_29 = (pointInPlane_29 / pointInPlane_29.w);
  highp mat3 tmpvar_32;
  tmpvar_32[0] = unity_WorldToObject[0].xyz;
  tmpvar_32[1] = unity_WorldToObject[1].xyz;
  tmpvar_32[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_32 * clipPlane_27.xyz);
  highp float tmpvar_34;
  tmpvar_34 = dot (pointInPlane_29.xyz, tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = dot (_glesVertex.xyz, tmpvar_33);
  if ((tmpvar_35 < tmpvar_34)) {
    vertex_26.xyz = (_glesVertex.xyz - ((tmpvar_35 - tmpvar_34) * tmpvar_33));
    tmpvar_28 = 0.0;
  } else {
    tmpvar_28 = 1.0;
  };
  alpha_3 = tmpvar_28;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_36;
  uv_36 = tmpvar_2;
  highp vec4 spuvs_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = (vertex_26 * 0.5);
  spuvs_37.xy = ((uv_36 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_39;
  tmpvar_39.x = (tmpvar_38.x + (tmpvar_38.z * tmpvar_38.z));
  tmpvar_39.y = ((tmpvar_38.y + (0.5 * tmpvar_38.z)) + ((0.5 * tmpvar_38.x) * tmpvar_38.x));
  spuvs_37.zw = ((tmpvar_39 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_18.xyz / tmpvar_18.w);
  mediump vec3 tmpvar_40;
  highp vec3 lightColor0_41;
  lightColor0_41 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_42;
  lightColor1_42 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_43;
  lightColor2_43 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_44;
  lightColor3_44 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_45;
  lightAttenSq_45 = unity_4LightAtten0;
  highp vec3 col_46;
  highp vec4 ndotl_47;
  highp vec4 lengthSq_48;
  highp vec4 tmpvar_49;
  tmpvar_49 = (unity_4LightPosX0 - tmpvar_18.x);
  highp vec4 tmpvar_50;
  tmpvar_50 = (unity_4LightPosY0 - tmpvar_18.y);
  highp vec4 tmpvar_51;
  tmpvar_51 = (unity_4LightPosZ0 - tmpvar_18.z);
  lengthSq_48 = (tmpvar_49 * tmpvar_49);
  lengthSq_48 = (lengthSq_48 + (tmpvar_50 * tmpvar_50));
  lengthSq_48 = (lengthSq_48 + (tmpvar_51 * tmpvar_51));
  highp vec4 tmpvar_52;
  tmpvar_52 = max (lengthSq_48, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_48 = tmpvar_52;
  ndotl_47 = (tmpvar_49 * tmpvar_15.x);
  ndotl_47 = (ndotl_47 + (tmpvar_50 * tmpvar_15.y));
  ndotl_47 = (ndotl_47 + (tmpvar_51 * tmpvar_15.z));
  highp vec4 tmpvar_53;
  tmpvar_53 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_47 * inversesqrt(tmpvar_52)));
  ndotl_47 = tmpvar_53;
  highp vec4 tmpvar_54;
  tmpvar_54 = (tmpvar_53 * (1.0/((1.0 + 
    (tmpvar_52 * lightAttenSq_45)
  ))));
  col_46 = (lightColor0_41 * tmpvar_54.x);
  col_46 = (col_46 + (lightColor1_42 * tmpvar_54.y));
  col_46 = (col_46 + (lightColor2_43 * tmpvar_54.z));
  col_46 = (col_46 + (lightColor3_44 * tmpvar_54.w));
  tmpvar_40 = col_46;
  tmpvar_10 = tmpvar_40;
  gl_Position = tmpvar_11;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_22;
  xlv_TEXCOORD3 = spuvs_37;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_15;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  highp float tmpvar_16;
  tmpvar_16 = ((dot (tmpvar_15, tmpvar_13.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = d_5;
  tmpvar_17.y = d_5;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - tmpvar_18.xyz));
  highp float tmpvar_20;
  tmpvar_20 = pow (max (dot (tmpvar_15, 
    normalize((tmpvar_13.xyz + tmpvar_19))
  ), 0.0), _Shininess);
  s_4 = tmpvar_20;
  mediump float tmpvar_21;
  if ((d_5 < 0.5)) {
    tmpvar_21 = 0.025;
  } else {
    tmpvar_21 = s_4;
  };
  s_4 = tmpvar_21;
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21;
  tmpvar_22.y = tmpvar_21;
  alpha_3 = 1.0;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_11.zw;
  tmpvar_9.xyw = o_23.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_26;
  vertex_26 = tmpvar_1;
  highp vec4 clipPlane_27;
  clipPlane_27 = _ClipPlane;
  highp float tmpvar_28;
  highp vec4 pointInPlane_29;
  highp float tmpvar_30;
  tmpvar_30 = abs(clipPlane_27.w);
  if ((tmpvar_30 < 0.001)) {
    pointInPlane_29 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_31;
    tmpvar_31.w = 1.0;
    tmpvar_31.xyz = (clipPlane_27.xyz * clipPlane_27.w);
    pointInPlane_29 = tmpvar_31;
  };
  pointInPlane_29 = (unity_WorldToObject * pointInPlane_29);
  pointInPlane_29 = (pointInPlane_29 / pointInPlane_29.w);
  highp mat3 tmpvar_32;
  tmpvar_32[0] = unity_WorldToObject[0].xyz;
  tmpvar_32[1] = unity_WorldToObject[1].xyz;
  tmpvar_32[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_32 * clipPlane_27.xyz);
  highp float tmpvar_34;
  tmpvar_34 = dot (pointInPlane_29.xyz, tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = dot (_glesVertex.xyz, tmpvar_33);
  if ((tmpvar_35 < tmpvar_34)) {
    vertex_26.xyz = (_glesVertex.xyz - ((tmpvar_35 - tmpvar_34) * tmpvar_33));
    tmpvar_28 = 0.0;
  } else {
    tmpvar_28 = 1.0;
  };
  alpha_3 = tmpvar_28;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_36;
  uv_36 = tmpvar_2;
  highp vec4 spuvs_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = (vertex_26 * 0.5);
  spuvs_37.xy = ((uv_36 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_39;
  tmpvar_39.x = (tmpvar_38.x + (tmpvar_38.z * tmpvar_38.z));
  tmpvar_39.y = ((tmpvar_38.y + (0.5 * tmpvar_38.z)) + ((0.5 * tmpvar_38.x) * tmpvar_38.x));
  spuvs_37.zw = ((tmpvar_39 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_18.xyz / tmpvar_18.w);
  mediump vec3 tmpvar_40;
  highp vec3 lightColor0_41;
  lightColor0_41 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_42;
  lightColor1_42 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_43;
  lightColor2_43 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_44;
  lightColor3_44 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_45;
  lightAttenSq_45 = unity_4LightAtten0;
  highp vec3 col_46;
  highp vec4 ndotl_47;
  highp vec4 lengthSq_48;
  highp vec4 tmpvar_49;
  tmpvar_49 = (unity_4LightPosX0 - tmpvar_18.x);
  highp vec4 tmpvar_50;
  tmpvar_50 = (unity_4LightPosY0 - tmpvar_18.y);
  highp vec4 tmpvar_51;
  tmpvar_51 = (unity_4LightPosZ0 - tmpvar_18.z);
  lengthSq_48 = (tmpvar_49 * tmpvar_49);
  lengthSq_48 = (lengthSq_48 + (tmpvar_50 * tmpvar_50));
  lengthSq_48 = (lengthSq_48 + (tmpvar_51 * tmpvar_51));
  highp vec4 tmpvar_52;
  tmpvar_52 = max (lengthSq_48, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_48 = tmpvar_52;
  ndotl_47 = (tmpvar_49 * tmpvar_15.x);
  ndotl_47 = (ndotl_47 + (tmpvar_50 * tmpvar_15.y));
  ndotl_47 = (ndotl_47 + (tmpvar_51 * tmpvar_15.z));
  highp vec4 tmpvar_53;
  tmpvar_53 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_47 * inversesqrt(tmpvar_52)));
  ndotl_47 = tmpvar_53;
  highp vec4 tmpvar_54;
  tmpvar_54 = (tmpvar_53 * (1.0/((1.0 + 
    (tmpvar_52 * lightAttenSq_45)
  ))));
  col_46 = (lightColor0_41 * tmpvar_54.x);
  col_46 = (col_46 + (lightColor1_42 * tmpvar_54.y));
  col_46 = (col_46 + (lightColor2_43 * tmpvar_54.z));
  col_46 = (col_46 + (lightColor3_44 * tmpvar_54.w));
  tmpvar_40 = col_46;
  tmpvar_10 = tmpvar_40;
  gl_Position = tmpvar_11;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_22;
  xlv_TEXCOORD3 = spuvs_37;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_15;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
  tmpvar_1 = outColor_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
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
uniform mediump vec4 _MainTex_ST;
uniform highp float _Shininess;
uniform mediump vec4 _ClipPlane;
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  mediump float alpha_3;
  mediump float s_4;
  mediump float d_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_13;
  tmpvar_13 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize((_glesNormal * tmpvar_14)));
  highp float tmpvar_16;
  tmpvar_16 = ((dot (tmpvar_15, tmpvar_13.xyz) * 0.4975) + 0.5);
  d_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = d_5;
  tmpvar_17.y = d_5;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_WorldSpaceCameraPos - tmpvar_18.xyz));
  highp float tmpvar_20;
  tmpvar_20 = pow (max (dot (tmpvar_15, 
    normalize((tmpvar_13.xyz + tmpvar_19))
  ), 0.0), _Shininess);
  s_4 = tmpvar_20;
  mediump float tmpvar_21;
  if ((d_5 < 0.5)) {
    tmpvar_21 = 0.025;
  } else {
    tmpvar_21 = s_4;
  };
  s_4 = tmpvar_21;
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21;
  tmpvar_22.y = tmpvar_21;
  alpha_3 = 1.0;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_11.zw;
  tmpvar_9.xyw = o_23.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_26;
  vertex_26 = tmpvar_1;
  highp vec4 clipPlane_27;
  clipPlane_27 = _ClipPlane;
  highp float tmpvar_28;
  highp vec4 pointInPlane_29;
  highp float tmpvar_30;
  tmpvar_30 = abs(clipPlane_27.w);
  if ((tmpvar_30 < 0.001)) {
    pointInPlane_29 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_31;
    tmpvar_31.w = 1.0;
    tmpvar_31.xyz = (clipPlane_27.xyz * clipPlane_27.w);
    pointInPlane_29 = tmpvar_31;
  };
  pointInPlane_29 = (unity_WorldToObject * pointInPlane_29);
  pointInPlane_29 = (pointInPlane_29 / pointInPlane_29.w);
  highp mat3 tmpvar_32;
  tmpvar_32[0] = unity_WorldToObject[0].xyz;
  tmpvar_32[1] = unity_WorldToObject[1].xyz;
  tmpvar_32[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_32 * clipPlane_27.xyz);
  highp float tmpvar_34;
  tmpvar_34 = dot (pointInPlane_29.xyz, tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = dot (_glesVertex.xyz, tmpvar_33);
  if ((tmpvar_35 < tmpvar_34)) {
    vertex_26.xyz = (_glesVertex.xyz - ((tmpvar_35 - tmpvar_34) * tmpvar_33));
    tmpvar_28 = 0.0;
  } else {
    tmpvar_28 = 1.0;
  };
  alpha_3 = tmpvar_28;
  tmpvar_6.w = alpha_3;
  highp vec2 uv_36;
  uv_36 = tmpvar_2;
  highp vec4 spuvs_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = (vertex_26 * 0.5);
  spuvs_37.xy = ((uv_36 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_39;
  tmpvar_39.x = (tmpvar_38.x + (tmpvar_38.z * tmpvar_38.z));
  tmpvar_39.y = ((tmpvar_38.y + (0.5 * tmpvar_38.z)) + ((0.5 * tmpvar_38.x) * tmpvar_38.x));
  spuvs_37.zw = ((tmpvar_39 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  tmpvar_8 = (tmpvar_18.xyz / tmpvar_18.w);
  mediump vec3 tmpvar_40;
  highp vec3 lightColor0_41;
  lightColor0_41 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_42;
  lightColor1_42 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_43;
  lightColor2_43 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_44;
  lightColor3_44 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_45;
  lightAttenSq_45 = unity_4LightAtten0;
  highp vec3 col_46;
  highp vec4 ndotl_47;
  highp vec4 lengthSq_48;
  highp vec4 tmpvar_49;
  tmpvar_49 = (unity_4LightPosX0 - tmpvar_18.x);
  highp vec4 tmpvar_50;
  tmpvar_50 = (unity_4LightPosY0 - tmpvar_18.y);
  highp vec4 tmpvar_51;
  tmpvar_51 = (unity_4LightPosZ0 - tmpvar_18.z);
  lengthSq_48 = (tmpvar_49 * tmpvar_49);
  lengthSq_48 = (lengthSq_48 + (tmpvar_50 * tmpvar_50));
  lengthSq_48 = (lengthSq_48 + (tmpvar_51 * tmpvar_51));
  highp vec4 tmpvar_52;
  tmpvar_52 = max (lengthSq_48, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_48 = tmpvar_52;
  ndotl_47 = (tmpvar_49 * tmpvar_15.x);
  ndotl_47 = (ndotl_47 + (tmpvar_50 * tmpvar_15.y));
  ndotl_47 = (ndotl_47 + (tmpvar_51 * tmpvar_15.z));
  highp vec4 tmpvar_53;
  tmpvar_53 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_47 * inversesqrt(tmpvar_52)));
  ndotl_47 = tmpvar_53;
  highp vec4 tmpvar_54;
  tmpvar_54 = (tmpvar_53 * (1.0/((1.0 + 
    (tmpvar_52 * lightAttenSq_45)
  ))));
  col_46 = (lightColor0_41 * tmpvar_54.x);
  col_46 = (col_46 + (lightColor1_42 * tmpvar_54.y));
  col_46 = (col_46 + (lightColor2_43 * tmpvar_54.z));
  col_46 = (col_46 + (lightColor3_44 * tmpvar_54.w));
  tmpvar_40 = col_46;
  tmpvar_10 = tmpvar_40;
  gl_Position = tmpvar_11;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_17;
  xlv_TEXCOORD2 = tmpvar_22;
  xlv_TEXCOORD3 = spuvs_37;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_19;
  xlv_TEXCOORD6 = tmpvar_15;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_TEXCOORD8 = tmpvar_10;
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
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
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
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
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
  xlat_mutable_SPIntensity = _SPIntensity;
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
  outColor_7.w = xlv_COLOR0.w;
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
  spColor_20 = tmpvar_21;
  spColor_20.w = (spColor_20.w * _SPOpaqueness);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_19 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (((1.99 * tmpvar_22.x) * _SPNoiseScaler) - 1.0);
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
      highp vec3 tmpvar_29;
      tmpvar_29 = mix (spColor_20.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_18) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_20.xyz = tmpvar_29;
    };
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = mix (outColor_7, spColor_20, vec4(xlat_mutable_SPIntensity));
  spColor_20 = tmpvar_30;
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
  outColor_7.w = clamp (spColor_20.w, 0.0, 1.0);
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
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "CLIP_PLANE_WORLD" }
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
Keywords { "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "CLIP_PLANE_WORLD" }
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
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
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
}
}
 Pass {
  Name "OUTLINE"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 83304
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
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
uniform highp vec4 _ClipPlane;
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
  mediump float alpha_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_6.zw = tmpvar_9.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_projection[0].xy;
  tmpvar_12[1] = glstate_matrix_projection[1].xy;
  tmpvar_6.xy = (tmpvar_9.xy + ((tmpvar_12 * 
    normalize((tmpvar_11 * _glesNormal))
  .xy) * _Outline));
  tmpvar_7 = _OutlineColor;
  alpha_5 = 1.0;
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_8.xyw = o_13.xyw;
  tmpvar_8.z = _DitherAlpha;
  highp float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_17 < (_ClipPlane.w - 0.01))) {
    tmpvar_16 = 0.0;
  } else {
    tmpvar_16 = 1.0;
  };
  alpha_5 = tmpvar_16;
  tmpvar_7.w = (_OutlineColor.w * alpha_5);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_7;
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
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
  tmpvar_1 = outColor_2;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp vec4 _ClipPlane;
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
  mediump float alpha_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_6.zw = tmpvar_9.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_projection[0].xy;
  tmpvar_12[1] = glstate_matrix_projection[1].xy;
  tmpvar_6.xy = (tmpvar_9.xy + ((tmpvar_12 * 
    normalize((tmpvar_11 * _glesNormal))
  .xy) * _Outline));
  tmpvar_7 = _OutlineColor;
  alpha_5 = 1.0;
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_8.xyw = o_13.xyw;
  tmpvar_8.z = _DitherAlpha;
  highp float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_17 < (_ClipPlane.w - 0.01))) {
    tmpvar_16 = 0.0;
  } else {
    tmpvar_16 = 1.0;
  };
  alpha_5 = tmpvar_16;
  tmpvar_7.w = (_OutlineColor.w * alpha_5);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_7;
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
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
  tmpvar_1 = outColor_2;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp vec4 _ClipPlane;
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
  mediump float alpha_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_6.zw = tmpvar_9.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_projection[0].xy;
  tmpvar_12[1] = glstate_matrix_projection[1].xy;
  tmpvar_6.xy = (tmpvar_9.xy + ((tmpvar_12 * 
    normalize((tmpvar_11 * _glesNormal))
  .xy) * _Outline));
  tmpvar_7 = _OutlineColor;
  alpha_5 = 1.0;
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_8.xyw = o_13.xyw;
  tmpvar_8.z = _DitherAlpha;
  highp float tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_17 < (_ClipPlane.w - 0.01))) {
    tmpvar_16 = 0.0;
  } else {
    tmpvar_16 = 1.0;
  };
  alpha_5 = tmpvar_16;
  tmpvar_7.w = (_OutlineColor.w * alpha_5);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_7;
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
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
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
uniform highp vec4 _ClipPlane;
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
  mediump float alpha_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_6.zw = tmpvar_9.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_projection[0].xy;
  tmpvar_12[1] = glstate_matrix_projection[1].xy;
  tmpvar_6.xy = (tmpvar_9.xy + ((tmpvar_12 * 
    normalize((tmpvar_11 * _glesNormal))
  .xy) * _Outline));
  tmpvar_7 = _OutlineColor;
  alpha_5 = 1.0;
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_8.xyw = o_13.xyw;
  tmpvar_8.z = _DitherAlpha;
  highp float tmpvar_16;
  highp vec4 pointInPlane_17;
  highp float tmpvar_18;
  tmpvar_18 = abs(_ClipPlane.w);
  if ((tmpvar_18 < 0.001)) {
    pointInPlane_17 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_17 = tmpvar_19;
  };
  pointInPlane_17 = (unity_WorldToObject * pointInPlane_17);
  pointInPlane_17 = (pointInPlane_17 / pointInPlane_17.w);
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _ClipPlane.xyz);
  highp float tmpvar_22;
  tmpvar_22 = dot (pointInPlane_17.xyz, tmpvar_21);
  highp float tmpvar_23;
  tmpvar_23 = dot (_glesVertex.xyz, tmpvar_21);
  if ((tmpvar_23 < tmpvar_22)) {
    tmpvar_16 = 0.0;
  } else {
    tmpvar_16 = 1.0;
  };
  alpha_5 = tmpvar_16;
  tmpvar_7.w = (_OutlineColor.w * alpha_5);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_7;
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
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
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
uniform highp vec4 _ClipPlane;
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
  mediump float alpha_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_6.zw = tmpvar_9.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_projection[0].xy;
  tmpvar_12[1] = glstate_matrix_projection[1].xy;
  tmpvar_6.xy = (tmpvar_9.xy + ((tmpvar_12 * 
    normalize((tmpvar_11 * _glesNormal))
  .xy) * _Outline));
  tmpvar_7 = _OutlineColor;
  alpha_5 = 1.0;
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_8.xyw = o_13.xyw;
  tmpvar_8.z = _DitherAlpha;
  highp float tmpvar_16;
  highp vec4 pointInPlane_17;
  highp float tmpvar_18;
  tmpvar_18 = abs(_ClipPlane.w);
  if ((tmpvar_18 < 0.001)) {
    pointInPlane_17 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_17 = tmpvar_19;
  };
  pointInPlane_17 = (unity_WorldToObject * pointInPlane_17);
  pointInPlane_17 = (pointInPlane_17 / pointInPlane_17.w);
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _ClipPlane.xyz);
  highp float tmpvar_22;
  tmpvar_22 = dot (pointInPlane_17.xyz, tmpvar_21);
  highp float tmpvar_23;
  tmpvar_23 = dot (_glesVertex.xyz, tmpvar_21);
  if ((tmpvar_23 < tmpvar_22)) {
    tmpvar_16 = 0.0;
  } else {
    tmpvar_16 = 1.0;
  };
  alpha_5 = tmpvar_16;
  tmpvar_7.w = (_OutlineColor.w * alpha_5);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_7;
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
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
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
uniform highp vec4 _ClipPlane;
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
  mediump float alpha_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_6.zw = tmpvar_9.zw;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = tmpvar_2.xyz;
  tmpvar_11[1] = tmpvar_3.xyz;
  tmpvar_11[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_projection[0].xy;
  tmpvar_12[1] = glstate_matrix_projection[1].xy;
  tmpvar_6.xy = (tmpvar_9.xy + ((tmpvar_12 * 
    normalize((tmpvar_11 * _glesNormal))
  .xy) * _Outline));
  tmpvar_7 = _OutlineColor;
  alpha_5 = 1.0;
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_8.xyw = o_13.xyw;
  tmpvar_8.z = _DitherAlpha;
  highp float tmpvar_16;
  highp vec4 pointInPlane_17;
  highp float tmpvar_18;
  tmpvar_18 = abs(_ClipPlane.w);
  if ((tmpvar_18 < 0.001)) {
    pointInPlane_17 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_17 = tmpvar_19;
  };
  pointInPlane_17 = (unity_WorldToObject * pointInPlane_17);
  pointInPlane_17 = (pointInPlane_17 / pointInPlane_17.w);
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * _ClipPlane.xyz);
  highp float tmpvar_22;
  tmpvar_22 = dot (pointInPlane_17.xyz, tmpvar_21);
  highp float tmpvar_23;
  tmpvar_23 = dot (_glesVertex.xyz, tmpvar_21);
  if ((tmpvar_23 < tmpvar_22)) {
    tmpvar_16 = 0.0;
  } else {
    tmpvar_16 = 1.0;
  };
  alpha_5 = tmpvar_16;
  tmpvar_7.w = (_OutlineColor.w * alpha_5);
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_7;
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
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
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
uniform highp vec4 _ClipPlane;
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
  highp vec4 tmpvar_5;
  tmpvar_5 = _glesVertex;
  mediump float alpha_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_5.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7.zw = tmpvar_10.zw;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = tmpvar_2.xyz;
  tmpvar_12[1] = tmpvar_3.xyz;
  tmpvar_12[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_10.xy + ((tmpvar_13 * 
    normalize((tmpvar_12 * _glesNormal))
  .xy) * _Outline));
  tmpvar_8 = _OutlineColor;
  alpha_6 = 1.0;
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_9.xyw = o_14.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_5;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = 1.0;
  };
  alpha_6 = tmpvar_18;
  tmpvar_8.w = (_OutlineColor.w * alpha_6);
  highp vec4 tmpvar_20;
  tmpvar_20 = (vertex_17 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = (tmpvar_20.x + (tmpvar_20.z * tmpvar_20.z));
  tmpvar_21.y = ((tmpvar_20.y + (0.5 * tmpvar_20.z)) + ((0.5 * tmpvar_20.x) * tmpvar_20.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = ((tmpvar_21 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
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
  outColor_2.w = clamp (outColor_4.w, 0.0, 1.0);
  tmpvar_1 = outColor_2;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp vec4 _ClipPlane;
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
  highp vec4 tmpvar_5;
  tmpvar_5 = _glesVertex;
  mediump float alpha_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_5.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7.zw = tmpvar_10.zw;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = tmpvar_2.xyz;
  tmpvar_12[1] = tmpvar_3.xyz;
  tmpvar_12[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_10.xy + ((tmpvar_13 * 
    normalize((tmpvar_12 * _glesNormal))
  .xy) * _Outline));
  tmpvar_8 = _OutlineColor;
  alpha_6 = 1.0;
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_9.xyw = o_14.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_5;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = 1.0;
  };
  alpha_6 = tmpvar_18;
  tmpvar_8.w = (_OutlineColor.w * alpha_6);
  highp vec4 tmpvar_20;
  tmpvar_20 = (vertex_17 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = (tmpvar_20.x + (tmpvar_20.z * tmpvar_20.z));
  tmpvar_21.y = ((tmpvar_20.y + (0.5 * tmpvar_20.z)) + ((0.5 * tmpvar_20.x) * tmpvar_20.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = ((tmpvar_21 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
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
  outColor_2.w = clamp (outColor_4.w, 0.0, 1.0);
  tmpvar_1 = outColor_2;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp vec4 _ClipPlane;
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
  highp vec4 tmpvar_5;
  tmpvar_5 = _glesVertex;
  mediump float alpha_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_5.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7.zw = tmpvar_10.zw;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = tmpvar_2.xyz;
  tmpvar_12[1] = tmpvar_3.xyz;
  tmpvar_12[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_10.xy + ((tmpvar_13 * 
    normalize((tmpvar_12 * _glesNormal))
  .xy) * _Outline));
  tmpvar_8 = _OutlineColor;
  alpha_6 = 1.0;
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_9.xyw = o_14.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_5;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = 1.0;
  };
  alpha_6 = tmpvar_18;
  tmpvar_8.w = (_OutlineColor.w * alpha_6);
  highp vec4 tmpvar_20;
  tmpvar_20 = (vertex_17 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = (tmpvar_20.x + (tmpvar_20.z * tmpvar_20.z));
  tmpvar_21.y = ((tmpvar_20.y + (0.5 * tmpvar_20.z)) + ((0.5 * tmpvar_20.x) * tmpvar_20.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = ((tmpvar_21 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
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
  outColor_2.w = clamp (outColor_4.w, 0.0, 1.0);
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
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
uniform highp vec4 _ClipPlane;
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
  highp vec4 tmpvar_5;
  tmpvar_5 = _glesVertex;
  mediump float alpha_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_5.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7.zw = tmpvar_10.zw;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = tmpvar_2.xyz;
  tmpvar_12[1] = tmpvar_3.xyz;
  tmpvar_12[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_10.xy + ((tmpvar_13 * 
    normalize((tmpvar_12 * _glesNormal))
  .xy) * _Outline));
  tmpvar_8 = _OutlineColor;
  alpha_6 = 1.0;
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_9.xyw = o_14.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_5;
  highp float tmpvar_18;
  highp vec4 pointInPlane_19;
  highp float tmpvar_20;
  tmpvar_20 = abs(_ClipPlane.w);
  if ((tmpvar_20 < 0.001)) {
    pointInPlane_19 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_21;
    tmpvar_21.w = 1.0;
    tmpvar_21.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_19 = tmpvar_21;
  };
  pointInPlane_19 = (unity_WorldToObject * pointInPlane_19);
  pointInPlane_19 = (pointInPlane_19 / pointInPlane_19.w);
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_WorldToObject[0].xyz;
  tmpvar_22[1] = unity_WorldToObject[1].xyz;
  tmpvar_22[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _ClipPlane.xyz);
  highp float tmpvar_24;
  tmpvar_24 = dot (pointInPlane_19.xyz, tmpvar_23);
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, tmpvar_23);
  if ((tmpvar_25 < tmpvar_24)) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_25 - tmpvar_24) * tmpvar_23));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = 1.0;
  };
  alpha_6 = tmpvar_18;
  tmpvar_8.w = (_OutlineColor.w * alpha_6);
  highp vec4 tmpvar_26;
  tmpvar_26 = (vertex_17 * 0.5);
  highp vec2 tmpvar_27;
  tmpvar_27.x = (tmpvar_26.x + (tmpvar_26.z * tmpvar_26.z));
  tmpvar_27.y = ((tmpvar_26.y + (0.5 * tmpvar_26.z)) + ((0.5 * tmpvar_26.x) * tmpvar_26.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = ((tmpvar_27 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
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
  outColor_2.w = clamp (outColor_4.w, 0.0, 1.0);
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
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
uniform highp vec4 _ClipPlane;
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
  highp vec4 tmpvar_5;
  tmpvar_5 = _glesVertex;
  mediump float alpha_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_5.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7.zw = tmpvar_10.zw;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = tmpvar_2.xyz;
  tmpvar_12[1] = tmpvar_3.xyz;
  tmpvar_12[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_10.xy + ((tmpvar_13 * 
    normalize((tmpvar_12 * _glesNormal))
  .xy) * _Outline));
  tmpvar_8 = _OutlineColor;
  alpha_6 = 1.0;
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_9.xyw = o_14.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_5;
  highp float tmpvar_18;
  highp vec4 pointInPlane_19;
  highp float tmpvar_20;
  tmpvar_20 = abs(_ClipPlane.w);
  if ((tmpvar_20 < 0.001)) {
    pointInPlane_19 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_21;
    tmpvar_21.w = 1.0;
    tmpvar_21.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_19 = tmpvar_21;
  };
  pointInPlane_19 = (unity_WorldToObject * pointInPlane_19);
  pointInPlane_19 = (pointInPlane_19 / pointInPlane_19.w);
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_WorldToObject[0].xyz;
  tmpvar_22[1] = unity_WorldToObject[1].xyz;
  tmpvar_22[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _ClipPlane.xyz);
  highp float tmpvar_24;
  tmpvar_24 = dot (pointInPlane_19.xyz, tmpvar_23);
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, tmpvar_23);
  if ((tmpvar_25 < tmpvar_24)) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_25 - tmpvar_24) * tmpvar_23));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = 1.0;
  };
  alpha_6 = tmpvar_18;
  tmpvar_8.w = (_OutlineColor.w * alpha_6);
  highp vec4 tmpvar_26;
  tmpvar_26 = (vertex_17 * 0.5);
  highp vec2 tmpvar_27;
  tmpvar_27.x = (tmpvar_26.x + (tmpvar_26.z * tmpvar_26.z));
  tmpvar_27.y = ((tmpvar_26.y + (0.5 * tmpvar_26.z)) + ((0.5 * tmpvar_26.x) * tmpvar_26.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = ((tmpvar_27 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
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
  outColor_2.w = clamp (outColor_4.w, 0.0, 1.0);
  tmpvar_1 = outColor_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
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
uniform highp vec4 _ClipPlane;
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
  highp vec4 tmpvar_5;
  tmpvar_5 = _glesVertex;
  mediump float alpha_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_5.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_7.zw = tmpvar_10.zw;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = tmpvar_2.xyz;
  tmpvar_12[1] = tmpvar_3.xyz;
  tmpvar_12[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  tmpvar_7.xy = (tmpvar_10.xy + ((tmpvar_13 * 
    normalize((tmpvar_12 * _glesNormal))
  .xy) * _Outline));
  tmpvar_8 = _OutlineColor;
  alpha_6 = 1.0;
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_9.xyw = o_14.xyw;
  tmpvar_9.z = _DitherAlpha;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_5;
  highp float tmpvar_18;
  highp vec4 pointInPlane_19;
  highp float tmpvar_20;
  tmpvar_20 = abs(_ClipPlane.w);
  if ((tmpvar_20 < 0.001)) {
    pointInPlane_19 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_21;
    tmpvar_21.w = 1.0;
    tmpvar_21.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_19 = tmpvar_21;
  };
  pointInPlane_19 = (unity_WorldToObject * pointInPlane_19);
  pointInPlane_19 = (pointInPlane_19 / pointInPlane_19.w);
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_WorldToObject[0].xyz;
  tmpvar_22[1] = unity_WorldToObject[1].xyz;
  tmpvar_22[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _ClipPlane.xyz);
  highp float tmpvar_24;
  tmpvar_24 = dot (pointInPlane_19.xyz, tmpvar_23);
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, tmpvar_23);
  if ((tmpvar_25 < tmpvar_24)) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_25 - tmpvar_24) * tmpvar_23));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = 1.0;
  };
  alpha_6 = tmpvar_18;
  tmpvar_8.w = (_OutlineColor.w * alpha_6);
  highp vec4 tmpvar_26;
  tmpvar_26 = (vertex_17 * 0.5);
  highp vec2 tmpvar_27;
  tmpvar_27.x = (tmpvar_26.x + (tmpvar_26.z * tmpvar_26.z));
  tmpvar_27.y = ((tmpvar_26.y + (0.5 * tmpvar_26.z)) + ((0.5 * tmpvar_26.x) * tmpvar_26.x));
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = ((tmpvar_27 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
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
  outColor_2.w = clamp (outColor_4.w, 0.0, 1.0);
  tmpvar_1 = outColor_2;
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
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
}
}
 Pass {
  Name "CONSTANT_REPLACE"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 190285
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
SubProgram "gles hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
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
Keywords { "CLIP_PLANE_WORLD" }
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
Keywords { "CLIP_PLANE_WORLD" }
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
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_5;
  tmpvar_5 = (_glesVertex * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_5.x + (tmpvar_5.z * tmpvar_5.z));
  tmpvar_6.y = ((tmpvar_5.y + (0.5 * tmpvar_5.z)) + ((0.5 * tmpvar_5.x) * tmpvar_5.x));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((tmpvar_6 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tex_color_1;
  mediump vec4 o_2;
  o_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_color_1 = tmpvar_3;
  o_2.w = mix (_BloomFactor, _EmissionBloomFactor, tex_color_1.w);
  mediump float intensity_4;
  mediump float outBloomFactor_5;
  outBloomFactor_5 = o_2.w;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_7;
  tmpvar_7 = (((1.99 * tmpvar_6.x) * _SPNoiseScaler) - 1.0);
  intensity_4 = tmpvar_7;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_4 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_4 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_8;
    tmpvar_8 = mix (o_2.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_4) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_5 = tmpvar_8;
  } else {
    if ((intensity_4 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_5 = (outBloomFactor_5 * _SPOpaqueness);
    };
  };
  o_2.w = outBloomFactor_5;
  gl_FragData[0] = o_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_5;
  tmpvar_5 = (_glesVertex * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_5.x + (tmpvar_5.z * tmpvar_5.z));
  tmpvar_6.y = ((tmpvar_5.y + (0.5 * tmpvar_5.z)) + ((0.5 * tmpvar_5.x) * tmpvar_5.x));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((tmpvar_6 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tex_color_1;
  mediump vec4 o_2;
  o_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_color_1 = tmpvar_3;
  o_2.w = mix (_BloomFactor, _EmissionBloomFactor, tex_color_1.w);
  mediump float intensity_4;
  mediump float outBloomFactor_5;
  outBloomFactor_5 = o_2.w;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_7;
  tmpvar_7 = (((1.99 * tmpvar_6.x) * _SPNoiseScaler) - 1.0);
  intensity_4 = tmpvar_7;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_4 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_4 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_8;
    tmpvar_8 = mix (o_2.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_4) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_5 = tmpvar_8;
  } else {
    if ((intensity_4 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_5 = (outBloomFactor_5 * _SPOpaqueness);
    };
  };
  o_2.w = outBloomFactor_5;
  gl_FragData[0] = o_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_5;
  tmpvar_5 = (_glesVertex * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_5.x + (tmpvar_5.z * tmpvar_5.z));
  tmpvar_6.y = ((tmpvar_5.y + (0.5 * tmpvar_5.z)) + ((0.5 * tmpvar_5.x) * tmpvar_5.x));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((tmpvar_6 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tex_color_1;
  mediump vec4 o_2;
  o_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_color_1 = tmpvar_3;
  o_2.w = mix (_BloomFactor, _EmissionBloomFactor, tex_color_1.w);
  mediump float intensity_4;
  mediump float outBloomFactor_5;
  outBloomFactor_5 = o_2.w;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_7;
  tmpvar_7 = (((1.99 * tmpvar_6.x) * _SPNoiseScaler) - 1.0);
  intensity_4 = tmpvar_7;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_4 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_4 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_8;
    tmpvar_8 = mix (o_2.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_4) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_5 = tmpvar_8;
  } else {
    if ((intensity_4 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_5 = (outBloomFactor_5 * _SPOpaqueness);
    };
  };
  o_2.w = outBloomFactor_5;
  gl_FragData[0] = o_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_5;
  tmpvar_5 = (_glesVertex * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_5.x + (tmpvar_5.z * tmpvar_5.z));
  tmpvar_6.y = ((tmpvar_5.y + (0.5 * tmpvar_5.z)) + ((0.5 * tmpvar_5.x) * tmpvar_5.x));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((tmpvar_6 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tex_color_1;
  mediump vec4 o_2;
  o_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_color_1 = tmpvar_3;
  o_2.w = mix (_BloomFactor, _EmissionBloomFactor, tex_color_1.w);
  mediump float intensity_4;
  mediump float outBloomFactor_5;
  outBloomFactor_5 = o_2.w;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_7;
  tmpvar_7 = (((1.99 * tmpvar_6.x) * _SPNoiseScaler) - 1.0);
  intensity_4 = tmpvar_7;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_4 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_4 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_8;
    tmpvar_8 = mix (o_2.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_4) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_5 = tmpvar_8;
  } else {
    if ((intensity_4 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_5 = (outBloomFactor_5 * _SPOpaqueness);
    };
  };
  o_2.w = outBloomFactor_5;
  gl_FragData[0] = o_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_5;
  tmpvar_5 = (_glesVertex * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_5.x + (tmpvar_5.z * tmpvar_5.z));
  tmpvar_6.y = ((tmpvar_5.y + (0.5 * tmpvar_5.z)) + ((0.5 * tmpvar_5.x) * tmpvar_5.x));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((tmpvar_6 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tex_color_1;
  mediump vec4 o_2;
  o_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_color_1 = tmpvar_3;
  o_2.w = mix (_BloomFactor, _EmissionBloomFactor, tex_color_1.w);
  mediump float intensity_4;
  mediump float outBloomFactor_5;
  outBloomFactor_5 = o_2.w;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_7;
  tmpvar_7 = (((1.99 * tmpvar_6.x) * _SPNoiseScaler) - 1.0);
  intensity_4 = tmpvar_7;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_4 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_4 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_8;
    tmpvar_8 = mix (o_2.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_4) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_5 = tmpvar_8;
  } else {
    if ((intensity_4 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_5 = (outBloomFactor_5 * _SPOpaqueness);
    };
  };
  o_2.w = outBloomFactor_5;
  gl_FragData[0] = o_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
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
  highp vec4 tmpvar_5;
  tmpvar_5 = (_glesVertex * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_5.x + (tmpvar_5.z * tmpvar_5.z));
  tmpvar_6.y = ((tmpvar_5.y + (0.5 * tmpvar_5.z)) + ((0.5 * tmpvar_5.x) * tmpvar_5.x));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((tmpvar_6 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tex_color_1;
  mediump vec4 o_2;
  o_2.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_color_1 = tmpvar_3;
  o_2.w = mix (_BloomFactor, _EmissionBloomFactor, tex_color_1.w);
  mediump float intensity_4;
  mediump float outBloomFactor_5;
  outBloomFactor_5 = o_2.w;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_7;
  tmpvar_7 = (((1.99 * tmpvar_6.x) * _SPNoiseScaler) - 1.0);
  intensity_4 = tmpvar_7;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_4 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_4 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_8;
    tmpvar_8 = mix (o_2.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_4) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_5 = tmpvar_8;
  } else {
    if ((intensity_4 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_5 = (outBloomFactor_5 * _SPOpaqueness);
    };
  };
  o_2.w = outBloomFactor_5;
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
SubProgram "gles hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
}
}
}
CustomEditor "MoleMole.CharacterShaderEditorBase"
}