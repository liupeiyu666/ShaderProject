//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Simple/Simple_Emission_Transparent_HardRim" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_EmissionColor ("Emmisive Color", Color) = (0.5,0.5,0.5,1)
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Outline ("Outline Width", Float) = 0.02
_SpecMulti ("Specular Multiply", Float) = 1
_Shininess ("Shininess", Range(0.1, 100)) = 2
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
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
_RimColor ("HardRim Color(alpha for range)", Color) = (0,0,0,1)
_RimPower ("HardRim Power", Range(1E-06, 3)) = 0.1
_RimEdge ("RimEdge", Range(-1, 1)) = 0
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
  GpuProgramID 34072
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
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
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 rimLighting_2;
  highp vec3 rimLightDir_3;
  highp float rim_4;
  mediump vec3 normalDir_5;
  mediump vec3 viewDir_6;
  mediump vec3 lightDir_7;
  mediump vec3 specRamp_8;
  mediump vec3 ramp_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_15;
  tmpvar_15 = ((tmpvar_14.xyz * _SpecMulti) + 1.0);
  specRamp_8 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_16;
  viewDir_6 = xlv_TEXCOORD7;
  normalDir_5 = xlv_TEXCOORD5;
  mediump float tmpvar_17;
  mediump float edge0_18;
  edge0_18 = (_RimColor.w - 0.5);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((
    (1.0 - max (0.0, dot (viewDir_6, normalDir_5)))
   - edge0_18) / (1.0 - edge0_18)), 0.0, 1.0);
  tmpvar_17 = (tmpvar_19 * (tmpvar_19 * (3.0 - 
    (2.0 * tmpvar_19)
  )));
  rim_4 = tmpvar_17;
  mediump vec3 tmpvar_20;
  tmpvar_20 = vec3((1.0 - dot (normalDir_5, normalize(lightDir_7))));
  rimLightDir_3 = tmpvar_20;
  rim_4 = (rim_4 * rimLightDir_3.x);
  highp int tmpvar_21;
  if ((rim_4 > (1.0 - _RimEdge))) {
    tmpvar_21 = 1;
  } else {
    tmpvar_21 = 0;
  };
  rim_4 = float(tmpvar_21);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_RimColor.xyz * rim_4) * (2.0 * _RimPower));
  rimLighting_2 = tmpvar_22;
  outColor_11.xyz = (((tex_C_Color_10.xyz + rimLighting_2) * specRamp_8) * ramp_9);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_24;
  tmpvar_24 = mix ((_Color * _EnvColor), tmpvar_23, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_24.xyz);
  outColor_11.w = xlv_COLOR0.w;
  highp vec4 scrpos_25;
  scrpos_25 = xlv_TEXCOORD6;
  mediump float a_26;
  a_26 = xlv_TEXCOORD6.z;
  if ((a_26 < 0.95)) {
    scrpos_25.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_26 = (a_26 * 17.0);
    highp float tmpvar_27;
    tmpvar_27 = (scrpos_25.y / 4.0);
    highp float tmpvar_28;
    tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
    highp float tmpvar_29;
    if ((tmpvar_27 >= 0.0)) {
      tmpvar_29 = tmpvar_28;
    } else {
      tmpvar_29 = -(tmpvar_28);
    };
    highp float tmpvar_30;
    tmpvar_30 = (scrpos_25.x / 4.0);
    highp float tmpvar_31;
    tmpvar_31 = (fract(abs(tmpvar_30)) * 4.0);
    highp float tmpvar_32;
    if ((tmpvar_30 >= 0.0)) {
      tmpvar_32 = tmpvar_31;
    } else {
      tmpvar_32 = -(tmpvar_31);
    };
    highp float x_33;
    x_33 = ((a_26 - _DITHERMATRIX[
      int(tmpvar_29)
    ][
      int(tmpvar_32)
    ]) - 0.01);
    if ((x_33 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_11;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
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
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 rimLighting_2;
  highp vec3 rimLightDir_3;
  highp float rim_4;
  mediump vec3 normalDir_5;
  mediump vec3 viewDir_6;
  mediump vec3 lightDir_7;
  mediump vec3 specRamp_8;
  mediump vec3 ramp_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_15;
  tmpvar_15 = ((tmpvar_14.xyz * _SpecMulti) + 1.0);
  specRamp_8 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_16;
  viewDir_6 = xlv_TEXCOORD7;
  normalDir_5 = xlv_TEXCOORD5;
  mediump float tmpvar_17;
  mediump float edge0_18;
  edge0_18 = (_RimColor.w - 0.5);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((
    (1.0 - max (0.0, dot (viewDir_6, normalDir_5)))
   - edge0_18) / (1.0 - edge0_18)), 0.0, 1.0);
  tmpvar_17 = (tmpvar_19 * (tmpvar_19 * (3.0 - 
    (2.0 * tmpvar_19)
  )));
  rim_4 = tmpvar_17;
  mediump vec3 tmpvar_20;
  tmpvar_20 = vec3((1.0 - dot (normalDir_5, normalize(lightDir_7))));
  rimLightDir_3 = tmpvar_20;
  rim_4 = (rim_4 * rimLightDir_3.x);
  highp int tmpvar_21;
  if ((rim_4 > (1.0 - _RimEdge))) {
    tmpvar_21 = 1;
  } else {
    tmpvar_21 = 0;
  };
  rim_4 = float(tmpvar_21);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_RimColor.xyz * rim_4) * (2.0 * _RimPower));
  rimLighting_2 = tmpvar_22;
  outColor_11.xyz = (((tex_C_Color_10.xyz + rimLighting_2) * specRamp_8) * ramp_9);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_24;
  tmpvar_24 = mix ((_Color * _EnvColor), tmpvar_23, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_24.xyz);
  outColor_11.w = xlv_COLOR0.w;
  highp vec4 scrpos_25;
  scrpos_25 = xlv_TEXCOORD6;
  mediump float a_26;
  a_26 = xlv_TEXCOORD6.z;
  if ((a_26 < 0.95)) {
    scrpos_25.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_26 = (a_26 * 17.0);
    highp float tmpvar_27;
    tmpvar_27 = (scrpos_25.y / 4.0);
    highp float tmpvar_28;
    tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
    highp float tmpvar_29;
    if ((tmpvar_27 >= 0.0)) {
      tmpvar_29 = tmpvar_28;
    } else {
      tmpvar_29 = -(tmpvar_28);
    };
    highp float tmpvar_30;
    tmpvar_30 = (scrpos_25.x / 4.0);
    highp float tmpvar_31;
    tmpvar_31 = (fract(abs(tmpvar_30)) * 4.0);
    highp float tmpvar_32;
    if ((tmpvar_30 >= 0.0)) {
      tmpvar_32 = tmpvar_31;
    } else {
      tmpvar_32 = -(tmpvar_31);
    };
    highp float x_33;
    x_33 = ((a_26 - _DITHERMATRIX[
      int(tmpvar_29)
    ][
      int(tmpvar_32)
    ]) - 0.01);
    if ((x_33 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_11;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
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
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 rimLighting_2;
  highp vec3 rimLightDir_3;
  highp float rim_4;
  mediump vec3 normalDir_5;
  mediump vec3 viewDir_6;
  mediump vec3 lightDir_7;
  mediump vec3 specRamp_8;
  mediump vec3 ramp_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_15;
  tmpvar_15 = ((tmpvar_14.xyz * _SpecMulti) + 1.0);
  specRamp_8 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_16;
  viewDir_6 = xlv_TEXCOORD7;
  normalDir_5 = xlv_TEXCOORD5;
  mediump float tmpvar_17;
  mediump float edge0_18;
  edge0_18 = (_RimColor.w - 0.5);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((
    (1.0 - max (0.0, dot (viewDir_6, normalDir_5)))
   - edge0_18) / (1.0 - edge0_18)), 0.0, 1.0);
  tmpvar_17 = (tmpvar_19 * (tmpvar_19 * (3.0 - 
    (2.0 * tmpvar_19)
  )));
  rim_4 = tmpvar_17;
  mediump vec3 tmpvar_20;
  tmpvar_20 = vec3((1.0 - dot (normalDir_5, normalize(lightDir_7))));
  rimLightDir_3 = tmpvar_20;
  rim_4 = (rim_4 * rimLightDir_3.x);
  highp int tmpvar_21;
  if ((rim_4 > (1.0 - _RimEdge))) {
    tmpvar_21 = 1;
  } else {
    tmpvar_21 = 0;
  };
  rim_4 = float(tmpvar_21);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_RimColor.xyz * rim_4) * (2.0 * _RimPower));
  rimLighting_2 = tmpvar_22;
  outColor_11.xyz = (((tex_C_Color_10.xyz + rimLighting_2) * specRamp_8) * ramp_9);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_24;
  tmpvar_24 = mix ((_Color * _EnvColor), tmpvar_23, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_24.xyz);
  outColor_11.w = xlv_COLOR0.w;
  highp vec4 scrpos_25;
  scrpos_25 = xlv_TEXCOORD6;
  mediump float a_26;
  a_26 = xlv_TEXCOORD6.z;
  if ((a_26 < 0.95)) {
    scrpos_25.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_26 = (a_26 * 17.0);
    highp float tmpvar_27;
    tmpvar_27 = (scrpos_25.y / 4.0);
    highp float tmpvar_28;
    tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
    highp float tmpvar_29;
    if ((tmpvar_27 >= 0.0)) {
      tmpvar_29 = tmpvar_28;
    } else {
      tmpvar_29 = -(tmpvar_28);
    };
    highp float tmpvar_30;
    tmpvar_30 = (scrpos_25.x / 4.0);
    highp float tmpvar_31;
    tmpvar_31 = (fract(abs(tmpvar_30)) * 4.0);
    highp float tmpvar_32;
    if ((tmpvar_30 >= 0.0)) {
      tmpvar_32 = tmpvar_31;
    } else {
      tmpvar_32 = -(tmpvar_31);
    };
    highp float x_33;
    x_33 = ((a_26 - _DITHERMATRIX[
      int(tmpvar_29)
    ][
      int(tmpvar_32)
    ]) - 0.01);
    if ((x_33 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_11;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD9;
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
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD9 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 rimLighting_2;
  highp vec3 rimLightDir_3;
  highp float rim_4;
  mediump vec3 normalDir_5;
  mediump vec3 viewDir_6;
  mediump vec3 lightDir_7;
  mediump vec3 specRamp_8;
  mediump vec3 ramp_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_15;
  tmpvar_15 = ((tmpvar_14.xyz * _SpecMulti) + 1.0);
  specRamp_8 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_16;
  viewDir_6 = xlv_TEXCOORD7;
  normalDir_5 = xlv_TEXCOORD5;
  mediump float tmpvar_17;
  mediump float edge0_18;
  edge0_18 = (_RimColor.w - 0.5);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((
    (1.0 - max (0.0, dot (viewDir_6, normalDir_5)))
   - edge0_18) / (1.0 - edge0_18)), 0.0, 1.0);
  tmpvar_17 = (tmpvar_19 * (tmpvar_19 * (3.0 - 
    (2.0 * tmpvar_19)
  )));
  rim_4 = tmpvar_17;
  mediump vec3 tmpvar_20;
  tmpvar_20 = vec3((1.0 - dot (normalDir_5, normalize(lightDir_7))));
  rimLightDir_3 = tmpvar_20;
  rim_4 = (rim_4 * rimLightDir_3.x);
  highp int tmpvar_21;
  if ((rim_4 > (1.0 - _RimEdge))) {
    tmpvar_21 = 1;
  } else {
    tmpvar_21 = 0;
  };
  rim_4 = float(tmpvar_21);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_RimColor.xyz * rim_4) * (2.0 * _RimPower));
  rimLighting_2 = tmpvar_22;
  outColor_11.xyz = (((tex_C_Color_10.xyz + rimLighting_2) * specRamp_8) * ramp_9);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_24;
  tmpvar_24 = mix ((_Color * _EnvColor), tmpvar_23, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_24.xyz);
  outColor_11.w = xlv_COLOR0.w;
  outColor_11.xyz = (outColor_11.xyz + (outColor_11.xyz * xlv_TEXCOORD9));
  highp vec4 scrpos_25;
  scrpos_25 = xlv_TEXCOORD6;
  mediump float a_26;
  a_26 = xlv_TEXCOORD6.z;
  if ((a_26 < 0.95)) {
    scrpos_25.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_26 = (a_26 * 17.0);
    highp float tmpvar_27;
    tmpvar_27 = (scrpos_25.y / 4.0);
    highp float tmpvar_28;
    tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
    highp float tmpvar_29;
    if ((tmpvar_27 >= 0.0)) {
      tmpvar_29 = tmpvar_28;
    } else {
      tmpvar_29 = -(tmpvar_28);
    };
    highp float tmpvar_30;
    tmpvar_30 = (scrpos_25.x / 4.0);
    highp float tmpvar_31;
    tmpvar_31 = (fract(abs(tmpvar_30)) * 4.0);
    highp float tmpvar_32;
    if ((tmpvar_30 >= 0.0)) {
      tmpvar_32 = tmpvar_31;
    } else {
      tmpvar_32 = -(tmpvar_31);
    };
    highp float x_33;
    x_33 = ((a_26 - _DITHERMATRIX[
      int(tmpvar_29)
    ][
      int(tmpvar_32)
    ]) - 0.01);
    if ((x_33 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_11;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD9;
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
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD9 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 rimLighting_2;
  highp vec3 rimLightDir_3;
  highp float rim_4;
  mediump vec3 normalDir_5;
  mediump vec3 viewDir_6;
  mediump vec3 lightDir_7;
  mediump vec3 specRamp_8;
  mediump vec3 ramp_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_15;
  tmpvar_15 = ((tmpvar_14.xyz * _SpecMulti) + 1.0);
  specRamp_8 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_16;
  viewDir_6 = xlv_TEXCOORD7;
  normalDir_5 = xlv_TEXCOORD5;
  mediump float tmpvar_17;
  mediump float edge0_18;
  edge0_18 = (_RimColor.w - 0.5);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((
    (1.0 - max (0.0, dot (viewDir_6, normalDir_5)))
   - edge0_18) / (1.0 - edge0_18)), 0.0, 1.0);
  tmpvar_17 = (tmpvar_19 * (tmpvar_19 * (3.0 - 
    (2.0 * tmpvar_19)
  )));
  rim_4 = tmpvar_17;
  mediump vec3 tmpvar_20;
  tmpvar_20 = vec3((1.0 - dot (normalDir_5, normalize(lightDir_7))));
  rimLightDir_3 = tmpvar_20;
  rim_4 = (rim_4 * rimLightDir_3.x);
  highp int tmpvar_21;
  if ((rim_4 > (1.0 - _RimEdge))) {
    tmpvar_21 = 1;
  } else {
    tmpvar_21 = 0;
  };
  rim_4 = float(tmpvar_21);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_RimColor.xyz * rim_4) * (2.0 * _RimPower));
  rimLighting_2 = tmpvar_22;
  outColor_11.xyz = (((tex_C_Color_10.xyz + rimLighting_2) * specRamp_8) * ramp_9);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_24;
  tmpvar_24 = mix ((_Color * _EnvColor), tmpvar_23, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_24.xyz);
  outColor_11.w = xlv_COLOR0.w;
  outColor_11.xyz = (outColor_11.xyz + (outColor_11.xyz * xlv_TEXCOORD9));
  highp vec4 scrpos_25;
  scrpos_25 = xlv_TEXCOORD6;
  mediump float a_26;
  a_26 = xlv_TEXCOORD6.z;
  if ((a_26 < 0.95)) {
    scrpos_25.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_26 = (a_26 * 17.0);
    highp float tmpvar_27;
    tmpvar_27 = (scrpos_25.y / 4.0);
    highp float tmpvar_28;
    tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
    highp float tmpvar_29;
    if ((tmpvar_27 >= 0.0)) {
      tmpvar_29 = tmpvar_28;
    } else {
      tmpvar_29 = -(tmpvar_28);
    };
    highp float tmpvar_30;
    tmpvar_30 = (scrpos_25.x / 4.0);
    highp float tmpvar_31;
    tmpvar_31 = (fract(abs(tmpvar_30)) * 4.0);
    highp float tmpvar_32;
    if ((tmpvar_30 >= 0.0)) {
      tmpvar_32 = tmpvar_31;
    } else {
      tmpvar_32 = -(tmpvar_31);
    };
    highp float x_33;
    x_33 = ((a_26 - _DITHERMATRIX[
      int(tmpvar_29)
    ][
      int(tmpvar_32)
    ]) - 0.01);
    if ((x_33 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_11;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD9;
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
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD9 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 rimLighting_2;
  highp vec3 rimLightDir_3;
  highp float rim_4;
  mediump vec3 normalDir_5;
  mediump vec3 viewDir_6;
  mediump vec3 lightDir_7;
  mediump vec3 specRamp_8;
  mediump vec3 ramp_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_15;
  tmpvar_15 = ((tmpvar_14.xyz * _SpecMulti) + 1.0);
  specRamp_8 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_16;
  viewDir_6 = xlv_TEXCOORD7;
  normalDir_5 = xlv_TEXCOORD5;
  mediump float tmpvar_17;
  mediump float edge0_18;
  edge0_18 = (_RimColor.w - 0.5);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((
    (1.0 - max (0.0, dot (viewDir_6, normalDir_5)))
   - edge0_18) / (1.0 - edge0_18)), 0.0, 1.0);
  tmpvar_17 = (tmpvar_19 * (tmpvar_19 * (3.0 - 
    (2.0 * tmpvar_19)
  )));
  rim_4 = tmpvar_17;
  mediump vec3 tmpvar_20;
  tmpvar_20 = vec3((1.0 - dot (normalDir_5, normalize(lightDir_7))));
  rimLightDir_3 = tmpvar_20;
  rim_4 = (rim_4 * rimLightDir_3.x);
  highp int tmpvar_21;
  if ((rim_4 > (1.0 - _RimEdge))) {
    tmpvar_21 = 1;
  } else {
    tmpvar_21 = 0;
  };
  rim_4 = float(tmpvar_21);
  highp vec3 tmpvar_22;
  tmpvar_22 = ((_RimColor.xyz * rim_4) * (2.0 * _RimPower));
  rimLighting_2 = tmpvar_22;
  outColor_11.xyz = (((tex_C_Color_10.xyz + rimLighting_2) * specRamp_8) * ramp_9);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 0.0;
  tmpvar_23.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_24;
  tmpvar_24 = mix ((_Color * _EnvColor), tmpvar_23, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_24.xyz);
  outColor_11.w = xlv_COLOR0.w;
  outColor_11.xyz = (outColor_11.xyz + (outColor_11.xyz * xlv_TEXCOORD9));
  highp vec4 scrpos_25;
  scrpos_25 = xlv_TEXCOORD6;
  mediump float a_26;
  a_26 = xlv_TEXCOORD6.z;
  if ((a_26 < 0.95)) {
    scrpos_25.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_26 = (a_26 * 17.0);
    highp float tmpvar_27;
    tmpvar_27 = (scrpos_25.y / 4.0);
    highp float tmpvar_28;
    tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
    highp float tmpvar_29;
    if ((tmpvar_27 >= 0.0)) {
      tmpvar_29 = tmpvar_28;
    } else {
      tmpvar_29 = -(tmpvar_28);
    };
    highp float tmpvar_30;
    tmpvar_30 = (scrpos_25.x / 4.0);
    highp float tmpvar_31;
    tmpvar_31 = (fract(abs(tmpvar_30)) * 4.0);
    highp float tmpvar_32;
    if ((tmpvar_30 >= 0.0)) {
      tmpvar_32 = tmpvar_31;
    } else {
      tmpvar_32 = -(tmpvar_31);
    };
    highp float x_33;
    x_33 = ((a_26 - _DITHERMATRIX[
      int(tmpvar_29)
    ][
      int(tmpvar_32)
    ]) - 0.01);
    if ((x_33 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_11;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
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
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_13;
  xlv_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tex_RimMask_2;
  mediump vec3 rimLighting_3;
  highp vec3 rimLightDir_4;
  highp float rim_5;
  mediump vec3 normalDir_6;
  mediump vec3 viewDir_7;
  mediump vec3 lightDir_8;
  mediump vec3 specRamp_9;
  mediump vec3 ramp_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_16;
  tmpvar_16 = ((tmpvar_15.xyz * _SpecMulti) + 1.0);
  specRamp_9 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_17;
  viewDir_7 = xlv_TEXCOORD7;
  normalDir_6 = xlv_TEXCOORD5;
  mediump float tmpvar_18;
  mediump float edge0_19;
  edge0_19 = (_RimColor.w - 0.5);
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((
    (1.0 - max (0.0, dot (viewDir_7, normalDir_6)))
   - edge0_19) / (1.0 - edge0_19)), 0.0, 1.0);
  tmpvar_18 = (tmpvar_20 * (tmpvar_20 * (3.0 - 
    (2.0 * tmpvar_20)
  )));
  rim_5 = tmpvar_18;
  mediump vec3 tmpvar_21;
  tmpvar_21 = vec3((1.0 - dot (normalDir_6, normalize(lightDir_8))));
  rimLightDir_4 = tmpvar_21;
  rim_5 = (rim_5 * rimLightDir_4.x);
  highp int tmpvar_22;
  if ((rim_5 > (1.0 - _RimEdge))) {
    tmpvar_22 = 1;
  } else {
    tmpvar_22 = 0;
  };
  rim_5 = float(tmpvar_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = ((_RimColor.xyz * rim_5) * (2.0 * _RimPower));
  rimLighting_3 = tmpvar_23;
  outColor_12.xyz = (((tex_C_Color_11.xyz + rimLighting_3) * specRamp_9) * ramp_10);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_25;
  tmpvar_25 = mix ((_Color * _EnvColor), tmpvar_24, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_25.xyz);
  outColor_12.w = xlv_COLOR0.w;
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec3 tmpvar_26;
  highp vec4 rimMask_27;
  rimMask_27 = tex_RimMask_2;
  mediump vec3 rgColorRGBA_28;
  mediump vec3 rgColorA_29;
  mediump vec3 rgColorB_30;
  mediump vec3 rgColorG_31;
  mediump vec3 rgColorR_32;
  mediump vec3 rgColor_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_34 = (_RGBias + (tmpvar_35 * _RGScale));
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_34 * _RGColor).xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * (1.0 - rimMask_27.x));
  rgColorR_32 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36 * (1.0 - rimMask_27.y));
  rgColorG_31 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (tmpvar_36 * (1.0 - rimMask_27.z));
  rgColorB_30 = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_36 * (1.0 - rimMask_27.w));
  rgColorA_29 = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = (((
    (rgColorR_32 * _RGMaskR)
   + 
    (rgColorG_31 * _RGMaskG)
  ) + (rgColorB_30 * _RGMaskB)) + (rgColorA_29 * _RGMaskA));
  rgColorRGBA_28 = tmpvar_41;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_12.xyz, rgColorRGBA_28, vec3(clamp ((
    (rgColorRGBA_28.x + rgColorRGBA_28.y)
   + rgColorRGBA_28.z), 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (tmpvar_36, tmpvar_42, vec3(_RGMaskIntensity));
  rgColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (tmpvar_34, 0.0, 1.0);
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (outColor_12.xyz, rgColor_33, vec3((tmpvar_44 * _RGRatio)));
  tmpvar_26 = tmpvar_45;
  outColor_12.xyz = tmpvar_26;
  highp vec4 scrpos_46;
  scrpos_46 = xlv_TEXCOORD6;
  mediump float a_47;
  a_47 = xlv_TEXCOORD6.z;
  if ((a_47 < 0.95)) {
    scrpos_46.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_47 = (a_47 * 17.0);
    highp float tmpvar_48;
    tmpvar_48 = (scrpos_46.y / 4.0);
    highp float tmpvar_49;
    tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
    highp float tmpvar_50;
    if ((tmpvar_48 >= 0.0)) {
      tmpvar_50 = tmpvar_49;
    } else {
      tmpvar_50 = -(tmpvar_49);
    };
    highp float tmpvar_51;
    tmpvar_51 = (scrpos_46.x / 4.0);
    highp float tmpvar_52;
    tmpvar_52 = (fract(abs(tmpvar_51)) * 4.0);
    highp float tmpvar_53;
    if ((tmpvar_51 >= 0.0)) {
      tmpvar_53 = tmpvar_52;
    } else {
      tmpvar_53 = -(tmpvar_52);
    };
    highp float x_54;
    x_54 = ((a_47 - _DITHERMATRIX[
      int(tmpvar_50)
    ][
      int(tmpvar_53)
    ]) - 0.01);
    if ((x_54 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_12;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
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
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_13;
  xlv_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tex_RimMask_2;
  mediump vec3 rimLighting_3;
  highp vec3 rimLightDir_4;
  highp float rim_5;
  mediump vec3 normalDir_6;
  mediump vec3 viewDir_7;
  mediump vec3 lightDir_8;
  mediump vec3 specRamp_9;
  mediump vec3 ramp_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_16;
  tmpvar_16 = ((tmpvar_15.xyz * _SpecMulti) + 1.0);
  specRamp_9 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_17;
  viewDir_7 = xlv_TEXCOORD7;
  normalDir_6 = xlv_TEXCOORD5;
  mediump float tmpvar_18;
  mediump float edge0_19;
  edge0_19 = (_RimColor.w - 0.5);
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((
    (1.0 - max (0.0, dot (viewDir_7, normalDir_6)))
   - edge0_19) / (1.0 - edge0_19)), 0.0, 1.0);
  tmpvar_18 = (tmpvar_20 * (tmpvar_20 * (3.0 - 
    (2.0 * tmpvar_20)
  )));
  rim_5 = tmpvar_18;
  mediump vec3 tmpvar_21;
  tmpvar_21 = vec3((1.0 - dot (normalDir_6, normalize(lightDir_8))));
  rimLightDir_4 = tmpvar_21;
  rim_5 = (rim_5 * rimLightDir_4.x);
  highp int tmpvar_22;
  if ((rim_5 > (1.0 - _RimEdge))) {
    tmpvar_22 = 1;
  } else {
    tmpvar_22 = 0;
  };
  rim_5 = float(tmpvar_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = ((_RimColor.xyz * rim_5) * (2.0 * _RimPower));
  rimLighting_3 = tmpvar_23;
  outColor_12.xyz = (((tex_C_Color_11.xyz + rimLighting_3) * specRamp_9) * ramp_10);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_25;
  tmpvar_25 = mix ((_Color * _EnvColor), tmpvar_24, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_25.xyz);
  outColor_12.w = xlv_COLOR0.w;
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec3 tmpvar_26;
  highp vec4 rimMask_27;
  rimMask_27 = tex_RimMask_2;
  mediump vec3 rgColorRGBA_28;
  mediump vec3 rgColorA_29;
  mediump vec3 rgColorB_30;
  mediump vec3 rgColorG_31;
  mediump vec3 rgColorR_32;
  mediump vec3 rgColor_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_34 = (_RGBias + (tmpvar_35 * _RGScale));
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_34 * _RGColor).xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * (1.0 - rimMask_27.x));
  rgColorR_32 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36 * (1.0 - rimMask_27.y));
  rgColorG_31 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (tmpvar_36 * (1.0 - rimMask_27.z));
  rgColorB_30 = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_36 * (1.0 - rimMask_27.w));
  rgColorA_29 = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = (((
    (rgColorR_32 * _RGMaskR)
   + 
    (rgColorG_31 * _RGMaskG)
  ) + (rgColorB_30 * _RGMaskB)) + (rgColorA_29 * _RGMaskA));
  rgColorRGBA_28 = tmpvar_41;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_12.xyz, rgColorRGBA_28, vec3(clamp ((
    (rgColorRGBA_28.x + rgColorRGBA_28.y)
   + rgColorRGBA_28.z), 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (tmpvar_36, tmpvar_42, vec3(_RGMaskIntensity));
  rgColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (tmpvar_34, 0.0, 1.0);
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (outColor_12.xyz, rgColor_33, vec3((tmpvar_44 * _RGRatio)));
  tmpvar_26 = tmpvar_45;
  outColor_12.xyz = tmpvar_26;
  highp vec4 scrpos_46;
  scrpos_46 = xlv_TEXCOORD6;
  mediump float a_47;
  a_47 = xlv_TEXCOORD6.z;
  if ((a_47 < 0.95)) {
    scrpos_46.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_47 = (a_47 * 17.0);
    highp float tmpvar_48;
    tmpvar_48 = (scrpos_46.y / 4.0);
    highp float tmpvar_49;
    tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
    highp float tmpvar_50;
    if ((tmpvar_48 >= 0.0)) {
      tmpvar_50 = tmpvar_49;
    } else {
      tmpvar_50 = -(tmpvar_49);
    };
    highp float tmpvar_51;
    tmpvar_51 = (scrpos_46.x / 4.0);
    highp float tmpvar_52;
    tmpvar_52 = (fract(abs(tmpvar_51)) * 4.0);
    highp float tmpvar_53;
    if ((tmpvar_51 >= 0.0)) {
      tmpvar_53 = tmpvar_52;
    } else {
      tmpvar_53 = -(tmpvar_52);
    };
    highp float x_54;
    x_54 = ((a_47 - _DITHERMATRIX[
      int(tmpvar_50)
    ][
      int(tmpvar_53)
    ]) - 0.01);
    if ((x_54 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_12;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
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
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_13;
  xlv_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tex_RimMask_2;
  mediump vec3 rimLighting_3;
  highp vec3 rimLightDir_4;
  highp float rim_5;
  mediump vec3 normalDir_6;
  mediump vec3 viewDir_7;
  mediump vec3 lightDir_8;
  mediump vec3 specRamp_9;
  mediump vec3 ramp_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_16;
  tmpvar_16 = ((tmpvar_15.xyz * _SpecMulti) + 1.0);
  specRamp_9 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_17;
  viewDir_7 = xlv_TEXCOORD7;
  normalDir_6 = xlv_TEXCOORD5;
  mediump float tmpvar_18;
  mediump float edge0_19;
  edge0_19 = (_RimColor.w - 0.5);
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((
    (1.0 - max (0.0, dot (viewDir_7, normalDir_6)))
   - edge0_19) / (1.0 - edge0_19)), 0.0, 1.0);
  tmpvar_18 = (tmpvar_20 * (tmpvar_20 * (3.0 - 
    (2.0 * tmpvar_20)
  )));
  rim_5 = tmpvar_18;
  mediump vec3 tmpvar_21;
  tmpvar_21 = vec3((1.0 - dot (normalDir_6, normalize(lightDir_8))));
  rimLightDir_4 = tmpvar_21;
  rim_5 = (rim_5 * rimLightDir_4.x);
  highp int tmpvar_22;
  if ((rim_5 > (1.0 - _RimEdge))) {
    tmpvar_22 = 1;
  } else {
    tmpvar_22 = 0;
  };
  rim_5 = float(tmpvar_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = ((_RimColor.xyz * rim_5) * (2.0 * _RimPower));
  rimLighting_3 = tmpvar_23;
  outColor_12.xyz = (((tex_C_Color_11.xyz + rimLighting_3) * specRamp_9) * ramp_10);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_25;
  tmpvar_25 = mix ((_Color * _EnvColor), tmpvar_24, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_25.xyz);
  outColor_12.w = xlv_COLOR0.w;
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec3 tmpvar_26;
  highp vec4 rimMask_27;
  rimMask_27 = tex_RimMask_2;
  mediump vec3 rgColorRGBA_28;
  mediump vec3 rgColorA_29;
  mediump vec3 rgColorB_30;
  mediump vec3 rgColorG_31;
  mediump vec3 rgColorR_32;
  mediump vec3 rgColor_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_34 = (_RGBias + (tmpvar_35 * _RGScale));
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_34 * _RGColor).xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * (1.0 - rimMask_27.x));
  rgColorR_32 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36 * (1.0 - rimMask_27.y));
  rgColorG_31 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (tmpvar_36 * (1.0 - rimMask_27.z));
  rgColorB_30 = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_36 * (1.0 - rimMask_27.w));
  rgColorA_29 = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = (((
    (rgColorR_32 * _RGMaskR)
   + 
    (rgColorG_31 * _RGMaskG)
  ) + (rgColorB_30 * _RGMaskB)) + (rgColorA_29 * _RGMaskA));
  rgColorRGBA_28 = tmpvar_41;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_12.xyz, rgColorRGBA_28, vec3(clamp ((
    (rgColorRGBA_28.x + rgColorRGBA_28.y)
   + rgColorRGBA_28.z), 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (tmpvar_36, tmpvar_42, vec3(_RGMaskIntensity));
  rgColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (tmpvar_34, 0.0, 1.0);
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (outColor_12.xyz, rgColor_33, vec3((tmpvar_44 * _RGRatio)));
  tmpvar_26 = tmpvar_45;
  outColor_12.xyz = tmpvar_26;
  highp vec4 scrpos_46;
  scrpos_46 = xlv_TEXCOORD6;
  mediump float a_47;
  a_47 = xlv_TEXCOORD6.z;
  if ((a_47 < 0.95)) {
    scrpos_46.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_47 = (a_47 * 17.0);
    highp float tmpvar_48;
    tmpvar_48 = (scrpos_46.y / 4.0);
    highp float tmpvar_49;
    tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
    highp float tmpvar_50;
    if ((tmpvar_48 >= 0.0)) {
      tmpvar_50 = tmpvar_49;
    } else {
      tmpvar_50 = -(tmpvar_49);
    };
    highp float tmpvar_51;
    tmpvar_51 = (scrpos_46.x / 4.0);
    highp float tmpvar_52;
    tmpvar_52 = (fract(abs(tmpvar_51)) * 4.0);
    highp float tmpvar_53;
    if ((tmpvar_51 >= 0.0)) {
      tmpvar_53 = tmpvar_52;
    } else {
      tmpvar_53 = -(tmpvar_52);
    };
    highp float x_54;
    x_54 = ((a_47 - _DITHERMATRIX[
      int(tmpvar_50)
    ][
      int(tmpvar_53)
    ]) - 0.01);
    if ((x_54 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_12;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD9 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tex_RimMask_2;
  mediump vec3 rimLighting_3;
  highp vec3 rimLightDir_4;
  highp float rim_5;
  mediump vec3 normalDir_6;
  mediump vec3 viewDir_7;
  mediump vec3 lightDir_8;
  mediump vec3 specRamp_9;
  mediump vec3 ramp_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_16;
  tmpvar_16 = ((tmpvar_15.xyz * _SpecMulti) + 1.0);
  specRamp_9 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_17;
  viewDir_7 = xlv_TEXCOORD7;
  normalDir_6 = xlv_TEXCOORD5;
  mediump float tmpvar_18;
  mediump float edge0_19;
  edge0_19 = (_RimColor.w - 0.5);
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((
    (1.0 - max (0.0, dot (viewDir_7, normalDir_6)))
   - edge0_19) / (1.0 - edge0_19)), 0.0, 1.0);
  tmpvar_18 = (tmpvar_20 * (tmpvar_20 * (3.0 - 
    (2.0 * tmpvar_20)
  )));
  rim_5 = tmpvar_18;
  mediump vec3 tmpvar_21;
  tmpvar_21 = vec3((1.0 - dot (normalDir_6, normalize(lightDir_8))));
  rimLightDir_4 = tmpvar_21;
  rim_5 = (rim_5 * rimLightDir_4.x);
  highp int tmpvar_22;
  if ((rim_5 > (1.0 - _RimEdge))) {
    tmpvar_22 = 1;
  } else {
    tmpvar_22 = 0;
  };
  rim_5 = float(tmpvar_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = ((_RimColor.xyz * rim_5) * (2.0 * _RimPower));
  rimLighting_3 = tmpvar_23;
  outColor_12.xyz = (((tex_C_Color_11.xyz + rimLighting_3) * specRamp_9) * ramp_10);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_25;
  tmpvar_25 = mix ((_Color * _EnvColor), tmpvar_24, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_25.xyz);
  outColor_12.w = xlv_COLOR0.w;
  outColor_12.xyz = (outColor_12.xyz + (outColor_12.xyz * xlv_TEXCOORD9));
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec3 tmpvar_26;
  highp vec4 rimMask_27;
  rimMask_27 = tex_RimMask_2;
  mediump vec3 rgColorRGBA_28;
  mediump vec3 rgColorA_29;
  mediump vec3 rgColorB_30;
  mediump vec3 rgColorG_31;
  mediump vec3 rgColorR_32;
  mediump vec3 rgColor_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_34 = (_RGBias + (tmpvar_35 * _RGScale));
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_34 * _RGColor).xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * (1.0 - rimMask_27.x));
  rgColorR_32 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36 * (1.0 - rimMask_27.y));
  rgColorG_31 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (tmpvar_36 * (1.0 - rimMask_27.z));
  rgColorB_30 = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_36 * (1.0 - rimMask_27.w));
  rgColorA_29 = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = (((
    (rgColorR_32 * _RGMaskR)
   + 
    (rgColorG_31 * _RGMaskG)
  ) + (rgColorB_30 * _RGMaskB)) + (rgColorA_29 * _RGMaskA));
  rgColorRGBA_28 = tmpvar_41;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_12.xyz, rgColorRGBA_28, vec3(clamp ((
    (rgColorRGBA_28.x + rgColorRGBA_28.y)
   + rgColorRGBA_28.z), 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (tmpvar_36, tmpvar_42, vec3(_RGMaskIntensity));
  rgColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (tmpvar_34, 0.0, 1.0);
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (outColor_12.xyz, rgColor_33, vec3((tmpvar_44 * _RGRatio)));
  tmpvar_26 = tmpvar_45;
  outColor_12.xyz = tmpvar_26;
  highp vec4 scrpos_46;
  scrpos_46 = xlv_TEXCOORD6;
  mediump float a_47;
  a_47 = xlv_TEXCOORD6.z;
  if ((a_47 < 0.95)) {
    scrpos_46.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_47 = (a_47 * 17.0);
    highp float tmpvar_48;
    tmpvar_48 = (scrpos_46.y / 4.0);
    highp float tmpvar_49;
    tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
    highp float tmpvar_50;
    if ((tmpvar_48 >= 0.0)) {
      tmpvar_50 = tmpvar_49;
    } else {
      tmpvar_50 = -(tmpvar_49);
    };
    highp float tmpvar_51;
    tmpvar_51 = (scrpos_46.x / 4.0);
    highp float tmpvar_52;
    tmpvar_52 = (fract(abs(tmpvar_51)) * 4.0);
    highp float tmpvar_53;
    if ((tmpvar_51 >= 0.0)) {
      tmpvar_53 = tmpvar_52;
    } else {
      tmpvar_53 = -(tmpvar_52);
    };
    highp float x_54;
    x_54 = ((a_47 - _DITHERMATRIX[
      int(tmpvar_50)
    ][
      int(tmpvar_53)
    ]) - 0.01);
    if ((x_54 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_12;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD9 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tex_RimMask_2;
  mediump vec3 rimLighting_3;
  highp vec3 rimLightDir_4;
  highp float rim_5;
  mediump vec3 normalDir_6;
  mediump vec3 viewDir_7;
  mediump vec3 lightDir_8;
  mediump vec3 specRamp_9;
  mediump vec3 ramp_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_16;
  tmpvar_16 = ((tmpvar_15.xyz * _SpecMulti) + 1.0);
  specRamp_9 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_17;
  viewDir_7 = xlv_TEXCOORD7;
  normalDir_6 = xlv_TEXCOORD5;
  mediump float tmpvar_18;
  mediump float edge0_19;
  edge0_19 = (_RimColor.w - 0.5);
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((
    (1.0 - max (0.0, dot (viewDir_7, normalDir_6)))
   - edge0_19) / (1.0 - edge0_19)), 0.0, 1.0);
  tmpvar_18 = (tmpvar_20 * (tmpvar_20 * (3.0 - 
    (2.0 * tmpvar_20)
  )));
  rim_5 = tmpvar_18;
  mediump vec3 tmpvar_21;
  tmpvar_21 = vec3((1.0 - dot (normalDir_6, normalize(lightDir_8))));
  rimLightDir_4 = tmpvar_21;
  rim_5 = (rim_5 * rimLightDir_4.x);
  highp int tmpvar_22;
  if ((rim_5 > (1.0 - _RimEdge))) {
    tmpvar_22 = 1;
  } else {
    tmpvar_22 = 0;
  };
  rim_5 = float(tmpvar_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = ((_RimColor.xyz * rim_5) * (2.0 * _RimPower));
  rimLighting_3 = tmpvar_23;
  outColor_12.xyz = (((tex_C_Color_11.xyz + rimLighting_3) * specRamp_9) * ramp_10);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_25;
  tmpvar_25 = mix ((_Color * _EnvColor), tmpvar_24, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_25.xyz);
  outColor_12.w = xlv_COLOR0.w;
  outColor_12.xyz = (outColor_12.xyz + (outColor_12.xyz * xlv_TEXCOORD9));
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec3 tmpvar_26;
  highp vec4 rimMask_27;
  rimMask_27 = tex_RimMask_2;
  mediump vec3 rgColorRGBA_28;
  mediump vec3 rgColorA_29;
  mediump vec3 rgColorB_30;
  mediump vec3 rgColorG_31;
  mediump vec3 rgColorR_32;
  mediump vec3 rgColor_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_34 = (_RGBias + (tmpvar_35 * _RGScale));
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_34 * _RGColor).xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * (1.0 - rimMask_27.x));
  rgColorR_32 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36 * (1.0 - rimMask_27.y));
  rgColorG_31 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (tmpvar_36 * (1.0 - rimMask_27.z));
  rgColorB_30 = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_36 * (1.0 - rimMask_27.w));
  rgColorA_29 = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = (((
    (rgColorR_32 * _RGMaskR)
   + 
    (rgColorG_31 * _RGMaskG)
  ) + (rgColorB_30 * _RGMaskB)) + (rgColorA_29 * _RGMaskA));
  rgColorRGBA_28 = tmpvar_41;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_12.xyz, rgColorRGBA_28, vec3(clamp ((
    (rgColorRGBA_28.x + rgColorRGBA_28.y)
   + rgColorRGBA_28.z), 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (tmpvar_36, tmpvar_42, vec3(_RGMaskIntensity));
  rgColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (tmpvar_34, 0.0, 1.0);
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (outColor_12.xyz, rgColor_33, vec3((tmpvar_44 * _RGRatio)));
  tmpvar_26 = tmpvar_45;
  outColor_12.xyz = tmpvar_26;
  highp vec4 scrpos_46;
  scrpos_46 = xlv_TEXCOORD6;
  mediump float a_47;
  a_47 = xlv_TEXCOORD6.z;
  if ((a_47 < 0.95)) {
    scrpos_46.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_47 = (a_47 * 17.0);
    highp float tmpvar_48;
    tmpvar_48 = (scrpos_46.y / 4.0);
    highp float tmpvar_49;
    tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
    highp float tmpvar_50;
    if ((tmpvar_48 >= 0.0)) {
      tmpvar_50 = tmpvar_49;
    } else {
      tmpvar_50 = -(tmpvar_49);
    };
    highp float tmpvar_51;
    tmpvar_51 = (scrpos_46.x / 4.0);
    highp float tmpvar_52;
    tmpvar_52 = (fract(abs(tmpvar_51)) * 4.0);
    highp float tmpvar_53;
    if ((tmpvar_51 >= 0.0)) {
      tmpvar_53 = tmpvar_52;
    } else {
      tmpvar_53 = -(tmpvar_52);
    };
    highp float x_54;
    x_54 = ((a_47 - _DITHERMATRIX[
      int(tmpvar_50)
    ][
      int(tmpvar_53)
    ]) - 0.01);
    if ((x_54 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_12;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_11;
  xlv_TEXCOORD6 = tmpvar_5;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD9 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tex_RimMask_2;
  mediump vec3 rimLighting_3;
  highp vec3 rimLightDir_4;
  highp float rim_5;
  mediump vec3 normalDir_6;
  mediump vec3 viewDir_7;
  mediump vec3 lightDir_8;
  mediump vec3 specRamp_9;
  mediump vec3 ramp_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_16;
  tmpvar_16 = ((tmpvar_15.xyz * _SpecMulti) + 1.0);
  specRamp_9 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_17;
  viewDir_7 = xlv_TEXCOORD7;
  normalDir_6 = xlv_TEXCOORD5;
  mediump float tmpvar_18;
  mediump float edge0_19;
  edge0_19 = (_RimColor.w - 0.5);
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((
    (1.0 - max (0.0, dot (viewDir_7, normalDir_6)))
   - edge0_19) / (1.0 - edge0_19)), 0.0, 1.0);
  tmpvar_18 = (tmpvar_20 * (tmpvar_20 * (3.0 - 
    (2.0 * tmpvar_20)
  )));
  rim_5 = tmpvar_18;
  mediump vec3 tmpvar_21;
  tmpvar_21 = vec3((1.0 - dot (normalDir_6, normalize(lightDir_8))));
  rimLightDir_4 = tmpvar_21;
  rim_5 = (rim_5 * rimLightDir_4.x);
  highp int tmpvar_22;
  if ((rim_5 > (1.0 - _RimEdge))) {
    tmpvar_22 = 1;
  } else {
    tmpvar_22 = 0;
  };
  rim_5 = float(tmpvar_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = ((_RimColor.xyz * rim_5) * (2.0 * _RimPower));
  rimLighting_3 = tmpvar_23;
  outColor_12.xyz = (((tex_C_Color_11.xyz + rimLighting_3) * specRamp_9) * ramp_10);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 0.0;
  tmpvar_24.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_25;
  tmpvar_25 = mix ((_Color * _EnvColor), tmpvar_24, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_25.xyz);
  outColor_12.w = xlv_COLOR0.w;
  outColor_12.xyz = (outColor_12.xyz + (outColor_12.xyz * xlv_TEXCOORD9));
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec3 tmpvar_26;
  highp vec4 rimMask_27;
  rimMask_27 = tex_RimMask_2;
  mediump vec3 rgColorRGBA_28;
  mediump vec3 rgColorA_29;
  mediump vec3 rgColorB_30;
  mediump vec3 rgColorG_31;
  mediump vec3 rgColorR_32;
  mediump vec3 rgColor_33;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_34 = (_RGBias + (tmpvar_35 * _RGScale));
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_34 * _RGColor).xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * (1.0 - rimMask_27.x));
  rgColorR_32 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_36 * (1.0 - rimMask_27.y));
  rgColorG_31 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (tmpvar_36 * (1.0 - rimMask_27.z));
  rgColorB_30 = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_36 * (1.0 - rimMask_27.w));
  rgColorA_29 = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = (((
    (rgColorR_32 * _RGMaskR)
   + 
    (rgColorG_31 * _RGMaskG)
  ) + (rgColorB_30 * _RGMaskB)) + (rgColorA_29 * _RGMaskA));
  rgColorRGBA_28 = tmpvar_41;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (outColor_12.xyz, rgColorRGBA_28, vec3(clamp ((
    (rgColorRGBA_28.x + rgColorRGBA_28.y)
   + rgColorRGBA_28.z), 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (tmpvar_36, tmpvar_42, vec3(_RGMaskIntensity));
  rgColor_33 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = clamp (tmpvar_34, 0.0, 1.0);
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (outColor_12.xyz, rgColor_33, vec3((tmpvar_44 * _RGRatio)));
  tmpvar_26 = tmpvar_45;
  outColor_12.xyz = tmpvar_26;
  highp vec4 scrpos_46;
  scrpos_46 = xlv_TEXCOORD6;
  mediump float a_47;
  a_47 = xlv_TEXCOORD6.z;
  if ((a_47 < 0.95)) {
    scrpos_46.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_47 = (a_47 * 17.0);
    highp float tmpvar_48;
    tmpvar_48 = (scrpos_46.y / 4.0);
    highp float tmpvar_49;
    tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
    highp float tmpvar_50;
    if ((tmpvar_48 >= 0.0)) {
      tmpvar_50 = tmpvar_49;
    } else {
      tmpvar_50 = -(tmpvar_49);
    };
    highp float tmpvar_51;
    tmpvar_51 = (scrpos_46.x / 4.0);
    highp float tmpvar_52;
    tmpvar_52 = (fract(abs(tmpvar_51)) * 4.0);
    highp float tmpvar_53;
    if ((tmpvar_51 >= 0.0)) {
      tmpvar_53 = tmpvar_52;
    } else {
      tmpvar_53 = -(tmpvar_52);
    };
    highp float x_54;
    x_54 = ((a_47 - _DITHERMATRIX[
      int(tmpvar_50)
    ][
      int(tmpvar_53)
    ]) - 0.01);
    if ((x_54 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_12;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
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
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 specRamp_10;
  mediump vec3 ramp_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_16.xyz * _SpecMulti) + 1.0);
  specRamp_10 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_18;
  viewDir_8 = xlv_TEXCOORD7;
  normalDir_7 = xlv_TEXCOORD5;
  mediump float tmpvar_19;
  mediump float edge0_20;
  edge0_20 = (_RimColor.w - 0.5);
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((
    (1.0 - max (0.0, dot (viewDir_8, normalDir_7)))
   - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
  tmpvar_19 = (tmpvar_21 * (tmpvar_21 * (3.0 - 
    (2.0 * tmpvar_21)
  )));
  rim_6 = tmpvar_19;
  mediump vec3 tmpvar_22;
  tmpvar_22 = vec3((1.0 - dot (normalDir_7, normalize(lightDir_9))));
  rimLightDir_5 = tmpvar_22;
  rim_6 = (rim_6 * rimLightDir_5.x);
  highp int tmpvar_23;
  if ((rim_6 > (1.0 - _RimEdge))) {
    tmpvar_23 = 1;
  } else {
    tmpvar_23 = 0;
  };
  rim_6 = float(tmpvar_23);
  highp vec3 tmpvar_24;
  tmpvar_24 = ((_RimColor.xyz * rim_6) * (2.0 * _RimPower));
  rimLighting_4 = tmpvar_24;
  outColor_13.xyz = (((tex_C_Color_12.xyz + rimLighting_4) * specRamp_10) * ramp_11);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_26;
  tmpvar_26 = mix ((_Color * _EnvColor), tmpvar_25, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_26.xyz);
  outColor_13.w = xlv_COLOR0.w;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_28;
  mediump vec3 reflection_29;
  mediump vec3 R_30;
  mediump float intensity_31;
  mediump vec4 noiseTex_32;
  mediump vec4 spColor_33;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_33 = tmpvar_34;
  spColor_33.w = (spColor_33.w * _SPOpaqueness);
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_32 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (((1.99 * tmpvar_35.x) * _SPNoiseScaler) - 1.0);
  intensity_31 = tmpvar_36;
  highp vec3 tmpvar_37;
  highp vec3 I_38;
  I_38 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_32 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_37 = (I_38 - (2.0 * (
    dot (N_3, I_38)
   * N_3)));
  R_30 = tmpvar_37;
  lowp vec3 tmpvar_39;
  tmpvar_39 = textureCube (_SPCubeMap, R_30).xyz;
  reflection_29 = tmpvar_39;
  highp vec3 tmpvar_40;
  mediump vec3 x_41;
  x_41 = (spColor_33.xyz * _SPOldColor.xyz);
  tmpvar_40 = mix (x_41, ((reflection_29 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_33.xyz = tmpvar_40;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_31 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_31 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_42;
      tmpvar_42 = mix (spColor_33.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_31) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_33.xyz = tmpvar_42;
    };
  };
  highp vec4 tmpvar_43;
  tmpvar_43 = mix (outColor_13, spColor_33, vec4(xlat_mutable_SPIntensity));
  spColor_33 = tmpvar_43;
  outColor_13 = spColor_33;
  highp vec4 scrpos_44;
  scrpos_44 = xlv_TEXCOORD6;
  mediump float a_45;
  a_45 = xlv_TEXCOORD6.z;
  if ((a_45 < 0.95)) {
    scrpos_44.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_45 = (a_45 * 17.0);
    highp float tmpvar_46;
    tmpvar_46 = (scrpos_44.y / 4.0);
    highp float tmpvar_47;
    tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
    highp float tmpvar_48;
    if ((tmpvar_46 >= 0.0)) {
      tmpvar_48 = tmpvar_47;
    } else {
      tmpvar_48 = -(tmpvar_47);
    };
    highp float tmpvar_49;
    tmpvar_49 = (scrpos_44.x / 4.0);
    highp float tmpvar_50;
    tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
    highp float tmpvar_51;
    if ((tmpvar_49 >= 0.0)) {
      tmpvar_51 = tmpvar_50;
    } else {
      tmpvar_51 = -(tmpvar_50);
    };
    highp float x_52;
    x_52 = ((a_45 - _DITHERMATRIX[
      int(tmpvar_48)
    ][
      int(tmpvar_51)
    ]) - 0.01);
    if ((x_52 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = spColor_33;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
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
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 specRamp_10;
  mediump vec3 ramp_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_16.xyz * _SpecMulti) + 1.0);
  specRamp_10 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_18;
  viewDir_8 = xlv_TEXCOORD7;
  normalDir_7 = xlv_TEXCOORD5;
  mediump float tmpvar_19;
  mediump float edge0_20;
  edge0_20 = (_RimColor.w - 0.5);
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((
    (1.0 - max (0.0, dot (viewDir_8, normalDir_7)))
   - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
  tmpvar_19 = (tmpvar_21 * (tmpvar_21 * (3.0 - 
    (2.0 * tmpvar_21)
  )));
  rim_6 = tmpvar_19;
  mediump vec3 tmpvar_22;
  tmpvar_22 = vec3((1.0 - dot (normalDir_7, normalize(lightDir_9))));
  rimLightDir_5 = tmpvar_22;
  rim_6 = (rim_6 * rimLightDir_5.x);
  highp int tmpvar_23;
  if ((rim_6 > (1.0 - _RimEdge))) {
    tmpvar_23 = 1;
  } else {
    tmpvar_23 = 0;
  };
  rim_6 = float(tmpvar_23);
  highp vec3 tmpvar_24;
  tmpvar_24 = ((_RimColor.xyz * rim_6) * (2.0 * _RimPower));
  rimLighting_4 = tmpvar_24;
  outColor_13.xyz = (((tex_C_Color_12.xyz + rimLighting_4) * specRamp_10) * ramp_11);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_26;
  tmpvar_26 = mix ((_Color * _EnvColor), tmpvar_25, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_26.xyz);
  outColor_13.w = xlv_COLOR0.w;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_28;
  mediump vec3 reflection_29;
  mediump vec3 R_30;
  mediump float intensity_31;
  mediump vec4 noiseTex_32;
  mediump vec4 spColor_33;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_33 = tmpvar_34;
  spColor_33.w = (spColor_33.w * _SPOpaqueness);
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_32 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (((1.99 * tmpvar_35.x) * _SPNoiseScaler) - 1.0);
  intensity_31 = tmpvar_36;
  highp vec3 tmpvar_37;
  highp vec3 I_38;
  I_38 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_32 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_37 = (I_38 - (2.0 * (
    dot (N_3, I_38)
   * N_3)));
  R_30 = tmpvar_37;
  lowp vec3 tmpvar_39;
  tmpvar_39 = textureCube (_SPCubeMap, R_30).xyz;
  reflection_29 = tmpvar_39;
  highp vec3 tmpvar_40;
  mediump vec3 x_41;
  x_41 = (spColor_33.xyz * _SPOldColor.xyz);
  tmpvar_40 = mix (x_41, ((reflection_29 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_33.xyz = tmpvar_40;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_31 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_31 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_42;
      tmpvar_42 = mix (spColor_33.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_31) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_33.xyz = tmpvar_42;
    };
  };
  highp vec4 tmpvar_43;
  tmpvar_43 = mix (outColor_13, spColor_33, vec4(xlat_mutable_SPIntensity));
  spColor_33 = tmpvar_43;
  outColor_13 = spColor_33;
  highp vec4 scrpos_44;
  scrpos_44 = xlv_TEXCOORD6;
  mediump float a_45;
  a_45 = xlv_TEXCOORD6.z;
  if ((a_45 < 0.95)) {
    scrpos_44.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_45 = (a_45 * 17.0);
    highp float tmpvar_46;
    tmpvar_46 = (scrpos_44.y / 4.0);
    highp float tmpvar_47;
    tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
    highp float tmpvar_48;
    if ((tmpvar_46 >= 0.0)) {
      tmpvar_48 = tmpvar_47;
    } else {
      tmpvar_48 = -(tmpvar_47);
    };
    highp float tmpvar_49;
    tmpvar_49 = (scrpos_44.x / 4.0);
    highp float tmpvar_50;
    tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
    highp float tmpvar_51;
    if ((tmpvar_49 >= 0.0)) {
      tmpvar_51 = tmpvar_50;
    } else {
      tmpvar_51 = -(tmpvar_50);
    };
    highp float x_52;
    x_52 = ((a_45 - _DITHERMATRIX[
      int(tmpvar_48)
    ][
      int(tmpvar_51)
    ]) - 0.01);
    if ((x_52 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = spColor_33;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
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
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_16;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 specRamp_10;
  mediump vec3 ramp_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_16.xyz * _SpecMulti) + 1.0);
  specRamp_10 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_18;
  viewDir_8 = xlv_TEXCOORD7;
  normalDir_7 = xlv_TEXCOORD5;
  mediump float tmpvar_19;
  mediump float edge0_20;
  edge0_20 = (_RimColor.w - 0.5);
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((
    (1.0 - max (0.0, dot (viewDir_8, normalDir_7)))
   - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
  tmpvar_19 = (tmpvar_21 * (tmpvar_21 * (3.0 - 
    (2.0 * tmpvar_21)
  )));
  rim_6 = tmpvar_19;
  mediump vec3 tmpvar_22;
  tmpvar_22 = vec3((1.0 - dot (normalDir_7, normalize(lightDir_9))));
  rimLightDir_5 = tmpvar_22;
  rim_6 = (rim_6 * rimLightDir_5.x);
  highp int tmpvar_23;
  if ((rim_6 > (1.0 - _RimEdge))) {
    tmpvar_23 = 1;
  } else {
    tmpvar_23 = 0;
  };
  rim_6 = float(tmpvar_23);
  highp vec3 tmpvar_24;
  tmpvar_24 = ((_RimColor.xyz * rim_6) * (2.0 * _RimPower));
  rimLighting_4 = tmpvar_24;
  outColor_13.xyz = (((tex_C_Color_12.xyz + rimLighting_4) * specRamp_10) * ramp_11);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_26;
  tmpvar_26 = mix ((_Color * _EnvColor), tmpvar_25, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_26.xyz);
  outColor_13.w = xlv_COLOR0.w;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_28;
  mediump vec3 reflection_29;
  mediump vec3 R_30;
  mediump float intensity_31;
  mediump vec4 noiseTex_32;
  mediump vec4 spColor_33;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_33 = tmpvar_34;
  spColor_33.w = (spColor_33.w * _SPOpaqueness);
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_32 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (((1.99 * tmpvar_35.x) * _SPNoiseScaler) - 1.0);
  intensity_31 = tmpvar_36;
  highp vec3 tmpvar_37;
  highp vec3 I_38;
  I_38 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_32 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_37 = (I_38 - (2.0 * (
    dot (N_3, I_38)
   * N_3)));
  R_30 = tmpvar_37;
  lowp vec3 tmpvar_39;
  tmpvar_39 = textureCube (_SPCubeMap, R_30).xyz;
  reflection_29 = tmpvar_39;
  highp vec3 tmpvar_40;
  mediump vec3 x_41;
  x_41 = (spColor_33.xyz * _SPOldColor.xyz);
  tmpvar_40 = mix (x_41, ((reflection_29 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_33.xyz = tmpvar_40;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_31 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_31 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_42;
      tmpvar_42 = mix (spColor_33.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_31) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_33.xyz = tmpvar_42;
    };
  };
  highp vec4 tmpvar_43;
  tmpvar_43 = mix (outColor_13, spColor_33, vec4(xlat_mutable_SPIntensity));
  spColor_33 = tmpvar_43;
  outColor_13 = spColor_33;
  highp vec4 scrpos_44;
  scrpos_44 = xlv_TEXCOORD6;
  mediump float a_45;
  a_45 = xlv_TEXCOORD6.z;
  if ((a_45 < 0.95)) {
    scrpos_44.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_45 = (a_45 * 17.0);
    highp float tmpvar_46;
    tmpvar_46 = (scrpos_44.y / 4.0);
    highp float tmpvar_47;
    tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
    highp float tmpvar_48;
    if ((tmpvar_46 >= 0.0)) {
      tmpvar_48 = tmpvar_47;
    } else {
      tmpvar_48 = -(tmpvar_47);
    };
    highp float tmpvar_49;
    tmpvar_49 = (scrpos_44.x / 4.0);
    highp float tmpvar_50;
    tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
    highp float tmpvar_51;
    if ((tmpvar_49 >= 0.0)) {
      tmpvar_51 = tmpvar_50;
    } else {
      tmpvar_51 = -(tmpvar_50);
    };
    highp float x_52;
    x_52 = ((a_45 - _DITHERMATRIX[
      int(tmpvar_48)
    ][
      int(tmpvar_51)
    ]) - 0.01);
    if ((x_52 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = spColor_33;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD9;
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
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_17;
  xlv_TEXCOORD9 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 specRamp_10;
  mediump vec3 ramp_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_16.xyz * _SpecMulti) + 1.0);
  specRamp_10 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_18;
  viewDir_8 = xlv_TEXCOORD7;
  normalDir_7 = xlv_TEXCOORD5;
  mediump float tmpvar_19;
  mediump float edge0_20;
  edge0_20 = (_RimColor.w - 0.5);
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((
    (1.0 - max (0.0, dot (viewDir_8, normalDir_7)))
   - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
  tmpvar_19 = (tmpvar_21 * (tmpvar_21 * (3.0 - 
    (2.0 * tmpvar_21)
  )));
  rim_6 = tmpvar_19;
  mediump vec3 tmpvar_22;
  tmpvar_22 = vec3((1.0 - dot (normalDir_7, normalize(lightDir_9))));
  rimLightDir_5 = tmpvar_22;
  rim_6 = (rim_6 * rimLightDir_5.x);
  highp int tmpvar_23;
  if ((rim_6 > (1.0 - _RimEdge))) {
    tmpvar_23 = 1;
  } else {
    tmpvar_23 = 0;
  };
  rim_6 = float(tmpvar_23);
  highp vec3 tmpvar_24;
  tmpvar_24 = ((_RimColor.xyz * rim_6) * (2.0 * _RimPower));
  rimLighting_4 = tmpvar_24;
  outColor_13.xyz = (((tex_C_Color_12.xyz + rimLighting_4) * specRamp_10) * ramp_11);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_26;
  tmpvar_26 = mix ((_Color * _EnvColor), tmpvar_25, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_26.xyz);
  outColor_13.w = xlv_COLOR0.w;
  outColor_13.xyz = (outColor_13.xyz + (outColor_13.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_28;
  mediump vec3 reflection_29;
  mediump vec3 R_30;
  mediump float intensity_31;
  mediump vec4 noiseTex_32;
  mediump vec4 spColor_33;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_33 = tmpvar_34;
  spColor_33.w = (spColor_33.w * _SPOpaqueness);
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_32 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (((1.99 * tmpvar_35.x) * _SPNoiseScaler) - 1.0);
  intensity_31 = tmpvar_36;
  highp vec3 tmpvar_37;
  highp vec3 I_38;
  I_38 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_32 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_37 = (I_38 - (2.0 * (
    dot (N_3, I_38)
   * N_3)));
  R_30 = tmpvar_37;
  lowp vec3 tmpvar_39;
  tmpvar_39 = textureCube (_SPCubeMap, R_30).xyz;
  reflection_29 = tmpvar_39;
  highp vec3 tmpvar_40;
  mediump vec3 x_41;
  x_41 = (spColor_33.xyz * _SPOldColor.xyz);
  tmpvar_40 = mix (x_41, ((reflection_29 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_33.xyz = tmpvar_40;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_31 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_31 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_42;
      tmpvar_42 = mix (spColor_33.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_31) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_33.xyz = tmpvar_42;
    };
  };
  highp vec4 tmpvar_43;
  tmpvar_43 = mix (outColor_13, spColor_33, vec4(xlat_mutable_SPIntensity));
  spColor_33 = tmpvar_43;
  outColor_13 = spColor_33;
  highp vec4 scrpos_44;
  scrpos_44 = xlv_TEXCOORD6;
  mediump float a_45;
  a_45 = xlv_TEXCOORD6.z;
  if ((a_45 < 0.95)) {
    scrpos_44.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_45 = (a_45 * 17.0);
    highp float tmpvar_46;
    tmpvar_46 = (scrpos_44.y / 4.0);
    highp float tmpvar_47;
    tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
    highp float tmpvar_48;
    if ((tmpvar_46 >= 0.0)) {
      tmpvar_48 = tmpvar_47;
    } else {
      tmpvar_48 = -(tmpvar_47);
    };
    highp float tmpvar_49;
    tmpvar_49 = (scrpos_44.x / 4.0);
    highp float tmpvar_50;
    tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
    highp float tmpvar_51;
    if ((tmpvar_49 >= 0.0)) {
      tmpvar_51 = tmpvar_50;
    } else {
      tmpvar_51 = -(tmpvar_50);
    };
    highp float x_52;
    x_52 = ((a_45 - _DITHERMATRIX[
      int(tmpvar_48)
    ][
      int(tmpvar_51)
    ]) - 0.01);
    if ((x_52 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = spColor_33;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD9;
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
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_17;
  xlv_TEXCOORD9 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 specRamp_10;
  mediump vec3 ramp_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_16.xyz * _SpecMulti) + 1.0);
  specRamp_10 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_18;
  viewDir_8 = xlv_TEXCOORD7;
  normalDir_7 = xlv_TEXCOORD5;
  mediump float tmpvar_19;
  mediump float edge0_20;
  edge0_20 = (_RimColor.w - 0.5);
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((
    (1.0 - max (0.0, dot (viewDir_8, normalDir_7)))
   - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
  tmpvar_19 = (tmpvar_21 * (tmpvar_21 * (3.0 - 
    (2.0 * tmpvar_21)
  )));
  rim_6 = tmpvar_19;
  mediump vec3 tmpvar_22;
  tmpvar_22 = vec3((1.0 - dot (normalDir_7, normalize(lightDir_9))));
  rimLightDir_5 = tmpvar_22;
  rim_6 = (rim_6 * rimLightDir_5.x);
  highp int tmpvar_23;
  if ((rim_6 > (1.0 - _RimEdge))) {
    tmpvar_23 = 1;
  } else {
    tmpvar_23 = 0;
  };
  rim_6 = float(tmpvar_23);
  highp vec3 tmpvar_24;
  tmpvar_24 = ((_RimColor.xyz * rim_6) * (2.0 * _RimPower));
  rimLighting_4 = tmpvar_24;
  outColor_13.xyz = (((tex_C_Color_12.xyz + rimLighting_4) * specRamp_10) * ramp_11);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_26;
  tmpvar_26 = mix ((_Color * _EnvColor), tmpvar_25, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_26.xyz);
  outColor_13.w = xlv_COLOR0.w;
  outColor_13.xyz = (outColor_13.xyz + (outColor_13.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_28;
  mediump vec3 reflection_29;
  mediump vec3 R_30;
  mediump float intensity_31;
  mediump vec4 noiseTex_32;
  mediump vec4 spColor_33;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_33 = tmpvar_34;
  spColor_33.w = (spColor_33.w * _SPOpaqueness);
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_32 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (((1.99 * tmpvar_35.x) * _SPNoiseScaler) - 1.0);
  intensity_31 = tmpvar_36;
  highp vec3 tmpvar_37;
  highp vec3 I_38;
  I_38 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_32 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_37 = (I_38 - (2.0 * (
    dot (N_3, I_38)
   * N_3)));
  R_30 = tmpvar_37;
  lowp vec3 tmpvar_39;
  tmpvar_39 = textureCube (_SPCubeMap, R_30).xyz;
  reflection_29 = tmpvar_39;
  highp vec3 tmpvar_40;
  mediump vec3 x_41;
  x_41 = (spColor_33.xyz * _SPOldColor.xyz);
  tmpvar_40 = mix (x_41, ((reflection_29 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_33.xyz = tmpvar_40;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_31 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_31 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_42;
      tmpvar_42 = mix (spColor_33.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_31) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_33.xyz = tmpvar_42;
    };
  };
  highp vec4 tmpvar_43;
  tmpvar_43 = mix (outColor_13, spColor_33, vec4(xlat_mutable_SPIntensity));
  spColor_33 = tmpvar_43;
  outColor_13 = spColor_33;
  highp vec4 scrpos_44;
  scrpos_44 = xlv_TEXCOORD6;
  mediump float a_45;
  a_45 = xlv_TEXCOORD6.z;
  if ((a_45 < 0.95)) {
    scrpos_44.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_45 = (a_45 * 17.0);
    highp float tmpvar_46;
    tmpvar_46 = (scrpos_44.y / 4.0);
    highp float tmpvar_47;
    tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
    highp float tmpvar_48;
    if ((tmpvar_46 >= 0.0)) {
      tmpvar_48 = tmpvar_47;
    } else {
      tmpvar_48 = -(tmpvar_47);
    };
    highp float tmpvar_49;
    tmpvar_49 = (scrpos_44.x / 4.0);
    highp float tmpvar_50;
    tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
    highp float tmpvar_51;
    if ((tmpvar_49 >= 0.0)) {
      tmpvar_51 = tmpvar_50;
    } else {
      tmpvar_51 = -(tmpvar_50);
    };
    highp float x_52;
    x_52 = ((a_45 - _DITHERMATRIX[
      int(tmpvar_48)
    ][
      int(tmpvar_51)
    ]) - 0.01);
    if ((x_52 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = spColor_33;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD9;
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
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_17;
  xlv_TEXCOORD9 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 specRamp_10;
  mediump vec3 ramp_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_16.xyz * _SpecMulti) + 1.0);
  specRamp_10 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_18;
  viewDir_8 = xlv_TEXCOORD7;
  normalDir_7 = xlv_TEXCOORD5;
  mediump float tmpvar_19;
  mediump float edge0_20;
  edge0_20 = (_RimColor.w - 0.5);
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((
    (1.0 - max (0.0, dot (viewDir_8, normalDir_7)))
   - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
  tmpvar_19 = (tmpvar_21 * (tmpvar_21 * (3.0 - 
    (2.0 * tmpvar_21)
  )));
  rim_6 = tmpvar_19;
  mediump vec3 tmpvar_22;
  tmpvar_22 = vec3((1.0 - dot (normalDir_7, normalize(lightDir_9))));
  rimLightDir_5 = tmpvar_22;
  rim_6 = (rim_6 * rimLightDir_5.x);
  highp int tmpvar_23;
  if ((rim_6 > (1.0 - _RimEdge))) {
    tmpvar_23 = 1;
  } else {
    tmpvar_23 = 0;
  };
  rim_6 = float(tmpvar_23);
  highp vec3 tmpvar_24;
  tmpvar_24 = ((_RimColor.xyz * rim_6) * (2.0 * _RimPower));
  rimLighting_4 = tmpvar_24;
  outColor_13.xyz = (((tex_C_Color_12.xyz + rimLighting_4) * specRamp_10) * ramp_11);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_26;
  tmpvar_26 = mix ((_Color * _EnvColor), tmpvar_25, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_26.xyz);
  outColor_13.w = xlv_COLOR0.w;
  outColor_13.xyz = (outColor_13.xyz + (outColor_13.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_28;
  mediump vec3 reflection_29;
  mediump vec3 R_30;
  mediump float intensity_31;
  mediump vec4 noiseTex_32;
  mediump vec4 spColor_33;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_33 = tmpvar_34;
  spColor_33.w = (spColor_33.w * _SPOpaqueness);
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_32 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (((1.99 * tmpvar_35.x) * _SPNoiseScaler) - 1.0);
  intensity_31 = tmpvar_36;
  highp vec3 tmpvar_37;
  highp vec3 I_38;
  I_38 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_32 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_37 = (I_38 - (2.0 * (
    dot (N_3, I_38)
   * N_3)));
  R_30 = tmpvar_37;
  lowp vec3 tmpvar_39;
  tmpvar_39 = textureCube (_SPCubeMap, R_30).xyz;
  reflection_29 = tmpvar_39;
  highp vec3 tmpvar_40;
  mediump vec3 x_41;
  x_41 = (spColor_33.xyz * _SPOldColor.xyz);
  tmpvar_40 = mix (x_41, ((reflection_29 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_33.xyz = tmpvar_40;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_31 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_31 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_42;
      tmpvar_42 = mix (spColor_33.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_31) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_33.xyz = tmpvar_42;
    };
  };
  highp vec4 tmpvar_43;
  tmpvar_43 = mix (outColor_13, spColor_33, vec4(xlat_mutable_SPIntensity));
  spColor_33 = tmpvar_43;
  outColor_13 = spColor_33;
  highp vec4 scrpos_44;
  scrpos_44 = xlv_TEXCOORD6;
  mediump float a_45;
  a_45 = xlv_TEXCOORD6.z;
  if ((a_45 < 0.95)) {
    scrpos_44.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_45 = (a_45 * 17.0);
    highp float tmpvar_46;
    tmpvar_46 = (scrpos_44.y / 4.0);
    highp float tmpvar_47;
    tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
    highp float tmpvar_48;
    if ((tmpvar_46 >= 0.0)) {
      tmpvar_48 = tmpvar_47;
    } else {
      tmpvar_48 = -(tmpvar_47);
    };
    highp float tmpvar_49;
    tmpvar_49 = (scrpos_44.x / 4.0);
    highp float tmpvar_50;
    tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
    highp float tmpvar_51;
    if ((tmpvar_49 >= 0.0)) {
      tmpvar_51 = tmpvar_50;
    } else {
      tmpvar_51 = -(tmpvar_50);
    };
    highp float x_52;
    x_52 = ((a_45 - _DITHERMATRIX[
      int(tmpvar_48)
    ][
      int(tmpvar_51)
    ]) - 0.01);
    if ((x_52 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = spColor_33;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
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
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_16;
  xlv_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  highp vec4 tmpvar_1;
  mediump vec4 tex_RimMask_2;
  mediump vec3 V_3;
  mediump vec3 N_4;
  mediump vec3 rimLighting_5;
  highp vec3 rimLightDir_6;
  highp float rim_7;
  mediump vec3 normalDir_8;
  mediump vec3 viewDir_9;
  mediump vec3 lightDir_10;
  mediump vec3 specRamp_11;
  mediump vec3 ramp_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_12 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_17.xyz * _SpecMulti) + 1.0);
  specRamp_11 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_19;
  viewDir_9 = xlv_TEXCOORD7;
  normalDir_8 = xlv_TEXCOORD5;
  mediump float tmpvar_20;
  mediump float edge0_21;
  edge0_21 = (_RimColor.w - 0.5);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - max (0.0, dot (viewDir_9, normalDir_8)))
   - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
  tmpvar_20 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  rim_7 = tmpvar_20;
  mediump vec3 tmpvar_23;
  tmpvar_23 = vec3((1.0 - dot (normalDir_8, normalize(lightDir_10))));
  rimLightDir_6 = tmpvar_23;
  rim_7 = (rim_7 * rimLightDir_6.x);
  highp int tmpvar_24;
  if ((rim_7 > (1.0 - _RimEdge))) {
    tmpvar_24 = 1;
  } else {
    tmpvar_24 = 0;
  };
  rim_7 = float(tmpvar_24);
  highp vec3 tmpvar_25;
  tmpvar_25 = ((_RimColor.xyz * rim_7) * (2.0 * _RimPower));
  rimLighting_5 = tmpvar_25;
  outColor_14.xyz = (((tex_C_Color_13.xyz + rimLighting_5) * specRamp_11) * ramp_12);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_26;
  tmpvar_26.w = 0.0;
  tmpvar_26.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_27;
  tmpvar_27 = mix ((_Color * _EnvColor), tmpvar_26, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_27.xyz);
  outColor_14.w = xlv_COLOR0.w;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_29;
  mediump vec3 reflection_30;
  mediump vec3 R_31;
  mediump float intensity_32;
  mediump vec4 noiseTex_33;
  mediump vec4 spColor_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_34 = tmpvar_35;
  spColor_34.w = (spColor_34.w * _SPOpaqueness);
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_33 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (((1.99 * tmpvar_36.x) * _SPNoiseScaler) - 1.0);
  intensity_32 = tmpvar_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_33 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (N_4, I_39)
   * N_4)));
  R_31 = tmpvar_38;
  lowp vec3 tmpvar_40;
  tmpvar_40 = textureCube (_SPCubeMap, R_31).xyz;
  reflection_30 = tmpvar_40;
  highp vec3 tmpvar_41;
  mediump vec3 x_42;
  x_42 = (spColor_34.xyz * _SPOldColor.xyz);
  tmpvar_41 = mix (x_42, ((reflection_30 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_34.xyz = tmpvar_41;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_32 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_32 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_43;
      tmpvar_43 = mix (spColor_34.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_32) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_34.xyz = tmpvar_43;
    };
  };
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (outColor_14, spColor_34, vec4(xlat_mutable_SPIntensity));
  spColor_34 = tmpvar_44;
  outColor_14.w = spColor_34.w;
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec3 tmpvar_45;
  highp vec4 rimMask_46;
  rimMask_46 = tex_RimMask_2;
  mediump vec3 rgColorRGBA_47;
  mediump vec3 rgColorA_48;
  mediump vec3 rgColorB_49;
  mediump vec3 rgColorG_50;
  mediump vec3 rgColorR_51;
  mediump vec3 rgColor_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_53 = (_RGBias + (tmpvar_54 * _RGScale));
  mediump vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_53 * _RGColor).xyz;
  highp vec3 tmpvar_56;
  tmpvar_56 = (tmpvar_55 * (1.0 - rimMask_46.x));
  rgColorR_51 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = (tmpvar_55 * (1.0 - rimMask_46.y));
  rgColorG_50 = tmpvar_57;
  highp vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_55 * (1.0 - rimMask_46.z));
  rgColorB_49 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = (tmpvar_55 * (1.0 - rimMask_46.w));
  rgColorA_48 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = (((
    (rgColorR_51 * _RGMaskR)
   + 
    (rgColorG_50 * _RGMaskG)
  ) + (rgColorB_49 * _RGMaskB)) + (rgColorA_48 * _RGMaskA));
  rgColorRGBA_47 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = mix (spColor_34.xyz, rgColorRGBA_47, vec3(clamp ((
    (rgColorRGBA_47.x + rgColorRGBA_47.y)
   + rgColorRGBA_47.z), 0.0, 1.0)));
  highp vec3 tmpvar_62;
  tmpvar_62 = mix (tmpvar_55, tmpvar_61, vec3(_RGMaskIntensity));
  rgColor_52 = tmpvar_62;
  mediump float tmpvar_63;
  tmpvar_63 = clamp (tmpvar_53, 0.0, 1.0);
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (spColor_34.xyz, rgColor_52, vec3((tmpvar_63 * _RGRatio)));
  tmpvar_45 = tmpvar_64;
  outColor_14.xyz = tmpvar_45;
  highp vec4 scrpos_65;
  scrpos_65 = xlv_TEXCOORD6;
  mediump float a_66;
  a_66 = xlv_TEXCOORD6.z;
  if ((a_66 < 0.95)) {
    scrpos_65.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_66 = (a_66 * 17.0);
    highp float tmpvar_67;
    tmpvar_67 = (scrpos_65.y / 4.0);
    highp float tmpvar_68;
    tmpvar_68 = (fract(abs(tmpvar_67)) * 4.0);
    highp float tmpvar_69;
    if ((tmpvar_67 >= 0.0)) {
      tmpvar_69 = tmpvar_68;
    } else {
      tmpvar_69 = -(tmpvar_68);
    };
    highp float tmpvar_70;
    tmpvar_70 = (scrpos_65.x / 4.0);
    highp float tmpvar_71;
    tmpvar_71 = (fract(abs(tmpvar_70)) * 4.0);
    highp float tmpvar_72;
    if ((tmpvar_70 >= 0.0)) {
      tmpvar_72 = tmpvar_71;
    } else {
      tmpvar_72 = -(tmpvar_71);
    };
    highp float x_73;
    x_73 = ((a_66 - _DITHERMATRIX[
      int(tmpvar_69)
    ][
      int(tmpvar_72)
    ]) - 0.01);
    if ((x_73 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_14;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
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
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_16;
  xlv_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  highp vec4 tmpvar_1;
  mediump vec4 tex_RimMask_2;
  mediump vec3 V_3;
  mediump vec3 N_4;
  mediump vec3 rimLighting_5;
  highp vec3 rimLightDir_6;
  highp float rim_7;
  mediump vec3 normalDir_8;
  mediump vec3 viewDir_9;
  mediump vec3 lightDir_10;
  mediump vec3 specRamp_11;
  mediump vec3 ramp_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_12 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_17.xyz * _SpecMulti) + 1.0);
  specRamp_11 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_19;
  viewDir_9 = xlv_TEXCOORD7;
  normalDir_8 = xlv_TEXCOORD5;
  mediump float tmpvar_20;
  mediump float edge0_21;
  edge0_21 = (_RimColor.w - 0.5);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - max (0.0, dot (viewDir_9, normalDir_8)))
   - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
  tmpvar_20 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  rim_7 = tmpvar_20;
  mediump vec3 tmpvar_23;
  tmpvar_23 = vec3((1.0 - dot (normalDir_8, normalize(lightDir_10))));
  rimLightDir_6 = tmpvar_23;
  rim_7 = (rim_7 * rimLightDir_6.x);
  highp int tmpvar_24;
  if ((rim_7 > (1.0 - _RimEdge))) {
    tmpvar_24 = 1;
  } else {
    tmpvar_24 = 0;
  };
  rim_7 = float(tmpvar_24);
  highp vec3 tmpvar_25;
  tmpvar_25 = ((_RimColor.xyz * rim_7) * (2.0 * _RimPower));
  rimLighting_5 = tmpvar_25;
  outColor_14.xyz = (((tex_C_Color_13.xyz + rimLighting_5) * specRamp_11) * ramp_12);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_26;
  tmpvar_26.w = 0.0;
  tmpvar_26.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_27;
  tmpvar_27 = mix ((_Color * _EnvColor), tmpvar_26, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_27.xyz);
  outColor_14.w = xlv_COLOR0.w;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_29;
  mediump vec3 reflection_30;
  mediump vec3 R_31;
  mediump float intensity_32;
  mediump vec4 noiseTex_33;
  mediump vec4 spColor_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_34 = tmpvar_35;
  spColor_34.w = (spColor_34.w * _SPOpaqueness);
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_33 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (((1.99 * tmpvar_36.x) * _SPNoiseScaler) - 1.0);
  intensity_32 = tmpvar_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_33 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (N_4, I_39)
   * N_4)));
  R_31 = tmpvar_38;
  lowp vec3 tmpvar_40;
  tmpvar_40 = textureCube (_SPCubeMap, R_31).xyz;
  reflection_30 = tmpvar_40;
  highp vec3 tmpvar_41;
  mediump vec3 x_42;
  x_42 = (spColor_34.xyz * _SPOldColor.xyz);
  tmpvar_41 = mix (x_42, ((reflection_30 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_34.xyz = tmpvar_41;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_32 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_32 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_43;
      tmpvar_43 = mix (spColor_34.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_32) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_34.xyz = tmpvar_43;
    };
  };
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (outColor_14, spColor_34, vec4(xlat_mutable_SPIntensity));
  spColor_34 = tmpvar_44;
  outColor_14.w = spColor_34.w;
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec3 tmpvar_45;
  highp vec4 rimMask_46;
  rimMask_46 = tex_RimMask_2;
  mediump vec3 rgColorRGBA_47;
  mediump vec3 rgColorA_48;
  mediump vec3 rgColorB_49;
  mediump vec3 rgColorG_50;
  mediump vec3 rgColorR_51;
  mediump vec3 rgColor_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_53 = (_RGBias + (tmpvar_54 * _RGScale));
  mediump vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_53 * _RGColor).xyz;
  highp vec3 tmpvar_56;
  tmpvar_56 = (tmpvar_55 * (1.0 - rimMask_46.x));
  rgColorR_51 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = (tmpvar_55 * (1.0 - rimMask_46.y));
  rgColorG_50 = tmpvar_57;
  highp vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_55 * (1.0 - rimMask_46.z));
  rgColorB_49 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = (tmpvar_55 * (1.0 - rimMask_46.w));
  rgColorA_48 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = (((
    (rgColorR_51 * _RGMaskR)
   + 
    (rgColorG_50 * _RGMaskG)
  ) + (rgColorB_49 * _RGMaskB)) + (rgColorA_48 * _RGMaskA));
  rgColorRGBA_47 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = mix (spColor_34.xyz, rgColorRGBA_47, vec3(clamp ((
    (rgColorRGBA_47.x + rgColorRGBA_47.y)
   + rgColorRGBA_47.z), 0.0, 1.0)));
  highp vec3 tmpvar_62;
  tmpvar_62 = mix (tmpvar_55, tmpvar_61, vec3(_RGMaskIntensity));
  rgColor_52 = tmpvar_62;
  mediump float tmpvar_63;
  tmpvar_63 = clamp (tmpvar_53, 0.0, 1.0);
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (spColor_34.xyz, rgColor_52, vec3((tmpvar_63 * _RGRatio)));
  tmpvar_45 = tmpvar_64;
  outColor_14.xyz = tmpvar_45;
  highp vec4 scrpos_65;
  scrpos_65 = xlv_TEXCOORD6;
  mediump float a_66;
  a_66 = xlv_TEXCOORD6.z;
  if ((a_66 < 0.95)) {
    scrpos_65.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_66 = (a_66 * 17.0);
    highp float tmpvar_67;
    tmpvar_67 = (scrpos_65.y / 4.0);
    highp float tmpvar_68;
    tmpvar_68 = (fract(abs(tmpvar_67)) * 4.0);
    highp float tmpvar_69;
    if ((tmpvar_67 >= 0.0)) {
      tmpvar_69 = tmpvar_68;
    } else {
      tmpvar_69 = -(tmpvar_68);
    };
    highp float tmpvar_70;
    tmpvar_70 = (scrpos_65.x / 4.0);
    highp float tmpvar_71;
    tmpvar_71 = (fract(abs(tmpvar_70)) * 4.0);
    highp float tmpvar_72;
    if ((tmpvar_70 >= 0.0)) {
      tmpvar_72 = tmpvar_71;
    } else {
      tmpvar_72 = -(tmpvar_71);
    };
    highp float x_73;
    x_73 = ((a_66 - _DITHERMATRIX[
      int(tmpvar_69)
    ][
      int(tmpvar_72)
    ]) - 0.01);
    if ((x_73 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_14;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
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
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_16;
  xlv_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  highp vec4 tmpvar_1;
  mediump vec4 tex_RimMask_2;
  mediump vec3 V_3;
  mediump vec3 N_4;
  mediump vec3 rimLighting_5;
  highp vec3 rimLightDir_6;
  highp float rim_7;
  mediump vec3 normalDir_8;
  mediump vec3 viewDir_9;
  mediump vec3 lightDir_10;
  mediump vec3 specRamp_11;
  mediump vec3 ramp_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_12 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_17.xyz * _SpecMulti) + 1.0);
  specRamp_11 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_19;
  viewDir_9 = xlv_TEXCOORD7;
  normalDir_8 = xlv_TEXCOORD5;
  mediump float tmpvar_20;
  mediump float edge0_21;
  edge0_21 = (_RimColor.w - 0.5);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - max (0.0, dot (viewDir_9, normalDir_8)))
   - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
  tmpvar_20 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  rim_7 = tmpvar_20;
  mediump vec3 tmpvar_23;
  tmpvar_23 = vec3((1.0 - dot (normalDir_8, normalize(lightDir_10))));
  rimLightDir_6 = tmpvar_23;
  rim_7 = (rim_7 * rimLightDir_6.x);
  highp int tmpvar_24;
  if ((rim_7 > (1.0 - _RimEdge))) {
    tmpvar_24 = 1;
  } else {
    tmpvar_24 = 0;
  };
  rim_7 = float(tmpvar_24);
  highp vec3 tmpvar_25;
  tmpvar_25 = ((_RimColor.xyz * rim_7) * (2.0 * _RimPower));
  rimLighting_5 = tmpvar_25;
  outColor_14.xyz = (((tex_C_Color_13.xyz + rimLighting_5) * specRamp_11) * ramp_12);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_26;
  tmpvar_26.w = 0.0;
  tmpvar_26.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_27;
  tmpvar_27 = mix ((_Color * _EnvColor), tmpvar_26, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_27.xyz);
  outColor_14.w = xlv_COLOR0.w;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_29;
  mediump vec3 reflection_30;
  mediump vec3 R_31;
  mediump float intensity_32;
  mediump vec4 noiseTex_33;
  mediump vec4 spColor_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_34 = tmpvar_35;
  spColor_34.w = (spColor_34.w * _SPOpaqueness);
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_33 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (((1.99 * tmpvar_36.x) * _SPNoiseScaler) - 1.0);
  intensity_32 = tmpvar_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_33 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (N_4, I_39)
   * N_4)));
  R_31 = tmpvar_38;
  lowp vec3 tmpvar_40;
  tmpvar_40 = textureCube (_SPCubeMap, R_31).xyz;
  reflection_30 = tmpvar_40;
  highp vec3 tmpvar_41;
  mediump vec3 x_42;
  x_42 = (spColor_34.xyz * _SPOldColor.xyz);
  tmpvar_41 = mix (x_42, ((reflection_30 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_34.xyz = tmpvar_41;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_32 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_32 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_43;
      tmpvar_43 = mix (spColor_34.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_32) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_34.xyz = tmpvar_43;
    };
  };
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (outColor_14, spColor_34, vec4(xlat_mutable_SPIntensity));
  spColor_34 = tmpvar_44;
  outColor_14.w = spColor_34.w;
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec3 tmpvar_45;
  highp vec4 rimMask_46;
  rimMask_46 = tex_RimMask_2;
  mediump vec3 rgColorRGBA_47;
  mediump vec3 rgColorA_48;
  mediump vec3 rgColorB_49;
  mediump vec3 rgColorG_50;
  mediump vec3 rgColorR_51;
  mediump vec3 rgColor_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_53 = (_RGBias + (tmpvar_54 * _RGScale));
  mediump vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_53 * _RGColor).xyz;
  highp vec3 tmpvar_56;
  tmpvar_56 = (tmpvar_55 * (1.0 - rimMask_46.x));
  rgColorR_51 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = (tmpvar_55 * (1.0 - rimMask_46.y));
  rgColorG_50 = tmpvar_57;
  highp vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_55 * (1.0 - rimMask_46.z));
  rgColorB_49 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = (tmpvar_55 * (1.0 - rimMask_46.w));
  rgColorA_48 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = (((
    (rgColorR_51 * _RGMaskR)
   + 
    (rgColorG_50 * _RGMaskG)
  ) + (rgColorB_49 * _RGMaskB)) + (rgColorA_48 * _RGMaskA));
  rgColorRGBA_47 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = mix (spColor_34.xyz, rgColorRGBA_47, vec3(clamp ((
    (rgColorRGBA_47.x + rgColorRGBA_47.y)
   + rgColorRGBA_47.z), 0.0, 1.0)));
  highp vec3 tmpvar_62;
  tmpvar_62 = mix (tmpvar_55, tmpvar_61, vec3(_RGMaskIntensity));
  rgColor_52 = tmpvar_62;
  mediump float tmpvar_63;
  tmpvar_63 = clamp (tmpvar_53, 0.0, 1.0);
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (spColor_34.xyz, rgColor_52, vec3((tmpvar_63 * _RGRatio)));
  tmpvar_45 = tmpvar_64;
  outColor_14.xyz = tmpvar_45;
  highp vec4 scrpos_65;
  scrpos_65 = xlv_TEXCOORD6;
  mediump float a_66;
  a_66 = xlv_TEXCOORD6.z;
  if ((a_66 < 0.95)) {
    scrpos_65.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_66 = (a_66 * 17.0);
    highp float tmpvar_67;
    tmpvar_67 = (scrpos_65.y / 4.0);
    highp float tmpvar_68;
    tmpvar_68 = (fract(abs(tmpvar_67)) * 4.0);
    highp float tmpvar_69;
    if ((tmpvar_67 >= 0.0)) {
      tmpvar_69 = tmpvar_68;
    } else {
      tmpvar_69 = -(tmpvar_68);
    };
    highp float tmpvar_70;
    tmpvar_70 = (scrpos_65.x / 4.0);
    highp float tmpvar_71;
    tmpvar_71 = (fract(abs(tmpvar_70)) * 4.0);
    highp float tmpvar_72;
    if ((tmpvar_70 >= 0.0)) {
      tmpvar_72 = tmpvar_71;
    } else {
      tmpvar_72 = -(tmpvar_71);
    };
    highp float x_73;
    x_73 = ((a_66 - _DITHERMATRIX[
      int(tmpvar_69)
    ][
      int(tmpvar_72)
    ]) - 0.01);
    if ((x_73 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_14;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_17;
  xlv_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD9 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  highp vec4 tmpvar_1;
  mediump vec4 tex_RimMask_2;
  mediump vec3 V_3;
  mediump vec3 N_4;
  mediump vec3 rimLighting_5;
  highp vec3 rimLightDir_6;
  highp float rim_7;
  mediump vec3 normalDir_8;
  mediump vec3 viewDir_9;
  mediump vec3 lightDir_10;
  mediump vec3 specRamp_11;
  mediump vec3 ramp_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_12 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_17.xyz * _SpecMulti) + 1.0);
  specRamp_11 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_19;
  viewDir_9 = xlv_TEXCOORD7;
  normalDir_8 = xlv_TEXCOORD5;
  mediump float tmpvar_20;
  mediump float edge0_21;
  edge0_21 = (_RimColor.w - 0.5);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - max (0.0, dot (viewDir_9, normalDir_8)))
   - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
  tmpvar_20 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  rim_7 = tmpvar_20;
  mediump vec3 tmpvar_23;
  tmpvar_23 = vec3((1.0 - dot (normalDir_8, normalize(lightDir_10))));
  rimLightDir_6 = tmpvar_23;
  rim_7 = (rim_7 * rimLightDir_6.x);
  highp int tmpvar_24;
  if ((rim_7 > (1.0 - _RimEdge))) {
    tmpvar_24 = 1;
  } else {
    tmpvar_24 = 0;
  };
  rim_7 = float(tmpvar_24);
  highp vec3 tmpvar_25;
  tmpvar_25 = ((_RimColor.xyz * rim_7) * (2.0 * _RimPower));
  rimLighting_5 = tmpvar_25;
  outColor_14.xyz = (((tex_C_Color_13.xyz + rimLighting_5) * specRamp_11) * ramp_12);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_26;
  tmpvar_26.w = 0.0;
  tmpvar_26.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_27;
  tmpvar_27 = mix ((_Color * _EnvColor), tmpvar_26, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_27.xyz);
  outColor_14.w = xlv_COLOR0.w;
  outColor_14.xyz = (outColor_14.xyz + (outColor_14.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_29;
  mediump vec3 reflection_30;
  mediump vec3 R_31;
  mediump float intensity_32;
  mediump vec4 noiseTex_33;
  mediump vec4 spColor_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_34 = tmpvar_35;
  spColor_34.w = (spColor_34.w * _SPOpaqueness);
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_33 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (((1.99 * tmpvar_36.x) * _SPNoiseScaler) - 1.0);
  intensity_32 = tmpvar_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_33 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (N_4, I_39)
   * N_4)));
  R_31 = tmpvar_38;
  lowp vec3 tmpvar_40;
  tmpvar_40 = textureCube (_SPCubeMap, R_31).xyz;
  reflection_30 = tmpvar_40;
  highp vec3 tmpvar_41;
  mediump vec3 x_42;
  x_42 = (spColor_34.xyz * _SPOldColor.xyz);
  tmpvar_41 = mix (x_42, ((reflection_30 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_34.xyz = tmpvar_41;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_32 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_32 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_43;
      tmpvar_43 = mix (spColor_34.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_32) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_34.xyz = tmpvar_43;
    };
  };
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (outColor_14, spColor_34, vec4(xlat_mutable_SPIntensity));
  spColor_34 = tmpvar_44;
  outColor_14.w = spColor_34.w;
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec3 tmpvar_45;
  highp vec4 rimMask_46;
  rimMask_46 = tex_RimMask_2;
  mediump vec3 rgColorRGBA_47;
  mediump vec3 rgColorA_48;
  mediump vec3 rgColorB_49;
  mediump vec3 rgColorG_50;
  mediump vec3 rgColorR_51;
  mediump vec3 rgColor_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_53 = (_RGBias + (tmpvar_54 * _RGScale));
  mediump vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_53 * _RGColor).xyz;
  highp vec3 tmpvar_56;
  tmpvar_56 = (tmpvar_55 * (1.0 - rimMask_46.x));
  rgColorR_51 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = (tmpvar_55 * (1.0 - rimMask_46.y));
  rgColorG_50 = tmpvar_57;
  highp vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_55 * (1.0 - rimMask_46.z));
  rgColorB_49 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = (tmpvar_55 * (1.0 - rimMask_46.w));
  rgColorA_48 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = (((
    (rgColorR_51 * _RGMaskR)
   + 
    (rgColorG_50 * _RGMaskG)
  ) + (rgColorB_49 * _RGMaskB)) + (rgColorA_48 * _RGMaskA));
  rgColorRGBA_47 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = mix (spColor_34.xyz, rgColorRGBA_47, vec3(clamp ((
    (rgColorRGBA_47.x + rgColorRGBA_47.y)
   + rgColorRGBA_47.z), 0.0, 1.0)));
  highp vec3 tmpvar_62;
  tmpvar_62 = mix (tmpvar_55, tmpvar_61, vec3(_RGMaskIntensity));
  rgColor_52 = tmpvar_62;
  mediump float tmpvar_63;
  tmpvar_63 = clamp (tmpvar_53, 0.0, 1.0);
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (spColor_34.xyz, rgColor_52, vec3((tmpvar_63 * _RGRatio)));
  tmpvar_45 = tmpvar_64;
  outColor_14.xyz = tmpvar_45;
  highp vec4 scrpos_65;
  scrpos_65 = xlv_TEXCOORD6;
  mediump float a_66;
  a_66 = xlv_TEXCOORD6.z;
  if ((a_66 < 0.95)) {
    scrpos_65.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_66 = (a_66 * 17.0);
    highp float tmpvar_67;
    tmpvar_67 = (scrpos_65.y / 4.0);
    highp float tmpvar_68;
    tmpvar_68 = (fract(abs(tmpvar_67)) * 4.0);
    highp float tmpvar_69;
    if ((tmpvar_67 >= 0.0)) {
      tmpvar_69 = tmpvar_68;
    } else {
      tmpvar_69 = -(tmpvar_68);
    };
    highp float tmpvar_70;
    tmpvar_70 = (scrpos_65.x / 4.0);
    highp float tmpvar_71;
    tmpvar_71 = (fract(abs(tmpvar_70)) * 4.0);
    highp float tmpvar_72;
    if ((tmpvar_70 >= 0.0)) {
      tmpvar_72 = tmpvar_71;
    } else {
      tmpvar_72 = -(tmpvar_71);
    };
    highp float x_73;
    x_73 = ((a_66 - _DITHERMATRIX[
      int(tmpvar_69)
    ][
      int(tmpvar_72)
    ]) - 0.01);
    if ((x_73 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_14;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_17;
  xlv_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD9 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  highp vec4 tmpvar_1;
  mediump vec4 tex_RimMask_2;
  mediump vec3 V_3;
  mediump vec3 N_4;
  mediump vec3 rimLighting_5;
  highp vec3 rimLightDir_6;
  highp float rim_7;
  mediump vec3 normalDir_8;
  mediump vec3 viewDir_9;
  mediump vec3 lightDir_10;
  mediump vec3 specRamp_11;
  mediump vec3 ramp_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_12 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_17.xyz * _SpecMulti) + 1.0);
  specRamp_11 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_19;
  viewDir_9 = xlv_TEXCOORD7;
  normalDir_8 = xlv_TEXCOORD5;
  mediump float tmpvar_20;
  mediump float edge0_21;
  edge0_21 = (_RimColor.w - 0.5);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - max (0.0, dot (viewDir_9, normalDir_8)))
   - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
  tmpvar_20 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  rim_7 = tmpvar_20;
  mediump vec3 tmpvar_23;
  tmpvar_23 = vec3((1.0 - dot (normalDir_8, normalize(lightDir_10))));
  rimLightDir_6 = tmpvar_23;
  rim_7 = (rim_7 * rimLightDir_6.x);
  highp int tmpvar_24;
  if ((rim_7 > (1.0 - _RimEdge))) {
    tmpvar_24 = 1;
  } else {
    tmpvar_24 = 0;
  };
  rim_7 = float(tmpvar_24);
  highp vec3 tmpvar_25;
  tmpvar_25 = ((_RimColor.xyz * rim_7) * (2.0 * _RimPower));
  rimLighting_5 = tmpvar_25;
  outColor_14.xyz = (((tex_C_Color_13.xyz + rimLighting_5) * specRamp_11) * ramp_12);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_26;
  tmpvar_26.w = 0.0;
  tmpvar_26.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_27;
  tmpvar_27 = mix ((_Color * _EnvColor), tmpvar_26, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_27.xyz);
  outColor_14.w = xlv_COLOR0.w;
  outColor_14.xyz = (outColor_14.xyz + (outColor_14.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_29;
  mediump vec3 reflection_30;
  mediump vec3 R_31;
  mediump float intensity_32;
  mediump vec4 noiseTex_33;
  mediump vec4 spColor_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_34 = tmpvar_35;
  spColor_34.w = (spColor_34.w * _SPOpaqueness);
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_33 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (((1.99 * tmpvar_36.x) * _SPNoiseScaler) - 1.0);
  intensity_32 = tmpvar_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_33 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (N_4, I_39)
   * N_4)));
  R_31 = tmpvar_38;
  lowp vec3 tmpvar_40;
  tmpvar_40 = textureCube (_SPCubeMap, R_31).xyz;
  reflection_30 = tmpvar_40;
  highp vec3 tmpvar_41;
  mediump vec3 x_42;
  x_42 = (spColor_34.xyz * _SPOldColor.xyz);
  tmpvar_41 = mix (x_42, ((reflection_30 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_34.xyz = tmpvar_41;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_32 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_32 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_43;
      tmpvar_43 = mix (spColor_34.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_32) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_34.xyz = tmpvar_43;
    };
  };
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (outColor_14, spColor_34, vec4(xlat_mutable_SPIntensity));
  spColor_34 = tmpvar_44;
  outColor_14.w = spColor_34.w;
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec3 tmpvar_45;
  highp vec4 rimMask_46;
  rimMask_46 = tex_RimMask_2;
  mediump vec3 rgColorRGBA_47;
  mediump vec3 rgColorA_48;
  mediump vec3 rgColorB_49;
  mediump vec3 rgColorG_50;
  mediump vec3 rgColorR_51;
  mediump vec3 rgColor_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_53 = (_RGBias + (tmpvar_54 * _RGScale));
  mediump vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_53 * _RGColor).xyz;
  highp vec3 tmpvar_56;
  tmpvar_56 = (tmpvar_55 * (1.0 - rimMask_46.x));
  rgColorR_51 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = (tmpvar_55 * (1.0 - rimMask_46.y));
  rgColorG_50 = tmpvar_57;
  highp vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_55 * (1.0 - rimMask_46.z));
  rgColorB_49 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = (tmpvar_55 * (1.0 - rimMask_46.w));
  rgColorA_48 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = (((
    (rgColorR_51 * _RGMaskR)
   + 
    (rgColorG_50 * _RGMaskG)
  ) + (rgColorB_49 * _RGMaskB)) + (rgColorA_48 * _RGMaskA));
  rgColorRGBA_47 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = mix (spColor_34.xyz, rgColorRGBA_47, vec3(clamp ((
    (rgColorRGBA_47.x + rgColorRGBA_47.y)
   + rgColorRGBA_47.z), 0.0, 1.0)));
  highp vec3 tmpvar_62;
  tmpvar_62 = mix (tmpvar_55, tmpvar_61, vec3(_RGMaskIntensity));
  rgColor_52 = tmpvar_62;
  mediump float tmpvar_63;
  tmpvar_63 = clamp (tmpvar_53, 0.0, 1.0);
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (spColor_34.xyz, rgColor_52, vec3((tmpvar_63 * _RGRatio)));
  tmpvar_45 = tmpvar_64;
  outColor_14.xyz = tmpvar_45;
  highp vec4 scrpos_65;
  scrpos_65 = xlv_TEXCOORD6;
  mediump float a_66;
  a_66 = xlv_TEXCOORD6.z;
  if ((a_66 < 0.95)) {
    scrpos_65.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_66 = (a_66 * 17.0);
    highp float tmpvar_67;
    tmpvar_67 = (scrpos_65.y / 4.0);
    highp float tmpvar_68;
    tmpvar_68 = (fract(abs(tmpvar_67)) * 4.0);
    highp float tmpvar_69;
    if ((tmpvar_67 >= 0.0)) {
      tmpvar_69 = tmpvar_68;
    } else {
      tmpvar_69 = -(tmpvar_68);
    };
    highp float tmpvar_70;
    tmpvar_70 = (scrpos_65.x / 4.0);
    highp float tmpvar_71;
    tmpvar_71 = (fract(abs(tmpvar_70)) * 4.0);
    highp float tmpvar_72;
    if ((tmpvar_70 >= 0.0)) {
      tmpvar_72 = tmpvar_71;
    } else {
      tmpvar_72 = -(tmpvar_71);
    };
    highp float x_73;
    x_73 = ((a_66 - _DITHERMATRIX[
      int(tmpvar_69)
    ][
      int(tmpvar_72)
    ]) - 0.01);
    if ((x_73 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_14;
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
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * _glesNormal));
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
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD7 = tmpvar_17;
  xlv_TEXCOORD8 = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD9 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  highp vec4 tmpvar_1;
  mediump vec4 tex_RimMask_2;
  mediump vec3 V_3;
  mediump vec3 N_4;
  mediump vec3 rimLighting_5;
  highp vec3 rimLightDir_6;
  highp float rim_7;
  mediump vec3 normalDir_8;
  mediump vec3 viewDir_9;
  mediump vec3 lightDir_10;
  mediump vec3 specRamp_11;
  mediump vec3 ramp_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_12 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  highp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_17.xyz * _SpecMulti) + 1.0);
  specRamp_11 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_19;
  viewDir_9 = xlv_TEXCOORD7;
  normalDir_8 = xlv_TEXCOORD5;
  mediump float tmpvar_20;
  mediump float edge0_21;
  edge0_21 = (_RimColor.w - 0.5);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - max (0.0, dot (viewDir_9, normalDir_8)))
   - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
  tmpvar_20 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  rim_7 = tmpvar_20;
  mediump vec3 tmpvar_23;
  tmpvar_23 = vec3((1.0 - dot (normalDir_8, normalize(lightDir_10))));
  rimLightDir_6 = tmpvar_23;
  rim_7 = (rim_7 * rimLightDir_6.x);
  highp int tmpvar_24;
  if ((rim_7 > (1.0 - _RimEdge))) {
    tmpvar_24 = 1;
  } else {
    tmpvar_24 = 0;
  };
  rim_7 = float(tmpvar_24);
  highp vec3 tmpvar_25;
  tmpvar_25 = ((_RimColor.xyz * rim_7) * (2.0 * _RimPower));
  rimLighting_5 = tmpvar_25;
  outColor_14.xyz = (((tex_C_Color_13.xyz + rimLighting_5) * specRamp_11) * ramp_12);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_26;
  tmpvar_26.w = 0.0;
  tmpvar_26.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_27;
  tmpvar_27 = mix ((_Color * _EnvColor), tmpvar_26, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_27.xyz);
  outColor_14.w = xlv_COLOR0.w;
  outColor_14.xyz = (outColor_14.xyz + (outColor_14.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_29;
  mediump vec3 reflection_30;
  mediump vec3 R_31;
  mediump float intensity_32;
  mediump vec4 noiseTex_33;
  mediump vec4 spColor_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_34 = tmpvar_35;
  spColor_34.w = (spColor_34.w * _SPOpaqueness);
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_33 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (((1.99 * tmpvar_36.x) * _SPNoiseScaler) - 1.0);
  intensity_32 = tmpvar_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_33 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (N_4, I_39)
   * N_4)));
  R_31 = tmpvar_38;
  lowp vec3 tmpvar_40;
  tmpvar_40 = textureCube (_SPCubeMap, R_31).xyz;
  reflection_30 = tmpvar_40;
  highp vec3 tmpvar_41;
  mediump vec3 x_42;
  x_42 = (spColor_34.xyz * _SPOldColor.xyz);
  tmpvar_41 = mix (x_42, ((reflection_30 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_34.xyz = tmpvar_41;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_32 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_32 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_43;
      tmpvar_43 = mix (spColor_34.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_32) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_34.xyz = tmpvar_43;
    };
  };
  highp vec4 tmpvar_44;
  tmpvar_44 = mix (outColor_14, spColor_34, vec4(xlat_mutable_SPIntensity));
  spColor_34 = tmpvar_44;
  outColor_14.w = spColor_34.w;
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec3 tmpvar_45;
  highp vec4 rimMask_46;
  rimMask_46 = tex_RimMask_2;
  mediump vec3 rgColorRGBA_47;
  mediump vec3 rgColorA_48;
  mediump vec3 rgColorB_49;
  mediump vec3 rgColorG_50;
  mediump vec3 rgColorR_51;
  mediump vec3 rgColor_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_53 = (_RGBias + (tmpvar_54 * _RGScale));
  mediump vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_53 * _RGColor).xyz;
  highp vec3 tmpvar_56;
  tmpvar_56 = (tmpvar_55 * (1.0 - rimMask_46.x));
  rgColorR_51 = tmpvar_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = (tmpvar_55 * (1.0 - rimMask_46.y));
  rgColorG_50 = tmpvar_57;
  highp vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_55 * (1.0 - rimMask_46.z));
  rgColorB_49 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = (tmpvar_55 * (1.0 - rimMask_46.w));
  rgColorA_48 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = (((
    (rgColorR_51 * _RGMaskR)
   + 
    (rgColorG_50 * _RGMaskG)
  ) + (rgColorB_49 * _RGMaskB)) + (rgColorA_48 * _RGMaskA));
  rgColorRGBA_47 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = mix (spColor_34.xyz, rgColorRGBA_47, vec3(clamp ((
    (rgColorRGBA_47.x + rgColorRGBA_47.y)
   + rgColorRGBA_47.z), 0.0, 1.0)));
  highp vec3 tmpvar_62;
  tmpvar_62 = mix (tmpvar_55, tmpvar_61, vec3(_RGMaskIntensity));
  rgColor_52 = tmpvar_62;
  mediump float tmpvar_63;
  tmpvar_63 = clamp (tmpvar_53, 0.0, 1.0);
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (spColor_34.xyz, rgColor_52, vec3((tmpvar_63 * _RGRatio)));
  tmpvar_45 = tmpvar_64;
  outColor_14.xyz = tmpvar_45;
  highp vec4 scrpos_65;
  scrpos_65 = xlv_TEXCOORD6;
  mediump float a_66;
  a_66 = xlv_TEXCOORD6.z;
  if ((a_66 < 0.95)) {
    scrpos_65.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_66 = (a_66 * 17.0);
    highp float tmpvar_67;
    tmpvar_67 = (scrpos_65.y / 4.0);
    highp float tmpvar_68;
    tmpvar_68 = (fract(abs(tmpvar_67)) * 4.0);
    highp float tmpvar_69;
    if ((tmpvar_67 >= 0.0)) {
      tmpvar_69 = tmpvar_68;
    } else {
      tmpvar_69 = -(tmpvar_68);
    };
    highp float tmpvar_70;
    tmpvar_70 = (scrpos_65.x / 4.0);
    highp float tmpvar_71;
    tmpvar_71 = (fract(abs(tmpvar_70)) * 4.0);
    highp float tmpvar_72;
    if ((tmpvar_70 >= 0.0)) {
      tmpvar_72 = tmpvar_71;
    } else {
      tmpvar_72 = -(tmpvar_71);
    };
    highp float x_73;
    x_73 = ((a_66 - _DITHERMATRIX[
      int(tmpvar_69)
    ][
      int(tmpvar_72)
    ]) - 0.01);
    if ((x_73 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_14;
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
  Name "OUTLINE"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 67557
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
uniform highp float _Opaqueness;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
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
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    normalize((tmpvar_10 * _glesNormal))
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_7.xyw = o_12.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_6.w = (_OutlineColor.w * _Opaqueness);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
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
uniform highp float _Opaqueness;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
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
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    normalize((tmpvar_10 * _glesNormal))
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_7.xyw = o_12.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_6.w = (_OutlineColor.w * _Opaqueness);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
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
uniform highp float _Opaqueness;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
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
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    normalize((tmpvar_10 * _glesNormal))
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_7.xyw = o_12.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_6.w = (_OutlineColor.w * _Opaqueness);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
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
uniform highp float _Opaqueness;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    normalize((tmpvar_10 * _glesNormal))
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_7.xyw = o_12.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_6.w = (_OutlineColor.w * _Opaqueness);
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
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
uniform highp float _Opaqueness;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    normalize((tmpvar_10 * _glesNormal))
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_7.xyw = o_12.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_6.w = (_OutlineColor.w * _Opaqueness);
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
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
uniform highp float _Opaqueness;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
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
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_5.zw = tmpvar_8.zw;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = tmpvar_2.xyz;
  tmpvar_10[1] = tmpvar_3.xyz;
  tmpvar_10[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_8.xy + ((tmpvar_11 * 
    normalize((tmpvar_10 * _glesNormal))
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_7.xyw = o_12.xyw;
  tmpvar_7.z = _DitherAlpha;
  tmpvar_6.w = (_OutlineColor.w * _Opaqueness);
  highp vec4 tmpvar_15;
  tmpvar_15 = (_glesVertex * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (tmpvar_15.z * tmpvar_15.z));
  tmpvar_16.y = ((tmpvar_15.y + (0.5 * tmpvar_15.z)) + ((0.5 * tmpvar_15.x) * tmpvar_15.x));
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = ((tmpvar_16 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
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
  Name "CONSTANT_REPLACE"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 135031
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
CustomEditor "MoleMole.CharacterShaderEditorBase"
}