//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Simple/Simple_Emission_Opaque_Spec" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_EmissionColor ("Emmisive Color", Color) = (0.5,0.5,0.5,1)
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Outline ("Outline Width", Float) = 0.02
[Toggle] _OutlineUseTangent ("Use Tangent For Outline", Float) = 0
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_LightMap ("Light Map", 2D) = "black" { }
_Ramp ("Toon Ramp (RGB)", 2D) = "white" { }
_DiffuseRanges ("Diffuse Ranges", Vector) = (0.4,0.6,0,0)
_ShadowThreshold ("Shadow Threshold", Range(0, 1)) = 0.5
_SpecularColor ("Specular Color", Color) = (1,1,1,1)
_SpecularIntensity ("Specular Intensity", Range(0, 50)) = 1
_Shininess ("Specular Shininess", Range(0.1, 500)) = 2
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
[Toggle(RIM_GLOW)] _RimGlow ("Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
_RGMaskR ("Rim Mask R", Range(0, 1)) = 0
_RGMaskG ("Rim Mask G", Range(0, 1)) = 0
_RGMaskB ("Rim Mask B", Range(0, 1)) = 0
_RGMaskA ("Rim Mask A", Range(0, 1)) = 0
_RGMaskIntensity ("Rim Mask Intensity", Range(0, 1)) = 1
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
 LOD 600
 Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 600
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Simple" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
  GpuProgramID 22963
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  highp float tmpvar_8;
  tmpvar_8 = ((dot (tmpvar_7, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = d_1;
  tmpvar_9.y = d_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_4.zw;
  tmpvar_3.xyw = o_10.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_8;
  mediump vec4 lightmap_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_8 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_15;
  viewDir_6 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize((lightDir_7 + viewDir_6));
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
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (dot (normalDir_5, tmpvar_16), 0.0);
  highp float tmpvar_25;
  tmpvar_25 = pow (tmpvar_24, _Shininess);
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_9.y) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_9.y) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  outColor_11.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_28 * 
      (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
    ))) * lightmap_9.x) * _SpecularIntensity)
   * tex_C_Color_10.xyz) + tex_C_Color_10.xyz) + rimLighting_2);
  outColor_11.xyz = (outColor_11.xyz * ramp_8);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix ((_Color * _EnvColor), tmpvar_29, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_30.xyz);
  outColor_11.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_10.w);
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  highp float tmpvar_8;
  tmpvar_8 = ((dot (tmpvar_7, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = d_1;
  tmpvar_9.y = d_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_4.zw;
  tmpvar_3.xyw = o_10.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_8;
  mediump vec4 lightmap_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_8 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_15;
  viewDir_6 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize((lightDir_7 + viewDir_6));
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
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (dot (normalDir_5, tmpvar_16), 0.0);
  highp float tmpvar_25;
  tmpvar_25 = pow (tmpvar_24, _Shininess);
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_9.y) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_9.y) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  outColor_11.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_28 * 
      (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
    ))) * lightmap_9.x) * _SpecularIntensity)
   * tex_C_Color_10.xyz) + tex_C_Color_10.xyz) + rimLighting_2);
  outColor_11.xyz = (outColor_11.xyz * ramp_8);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix ((_Color * _EnvColor), tmpvar_29, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_30.xyz);
  outColor_11.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_10.w);
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  highp float tmpvar_8;
  tmpvar_8 = ((dot (tmpvar_7, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = d_1;
  tmpvar_9.y = d_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_4.zw;
  tmpvar_3.xyw = o_10.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_8;
  mediump vec4 lightmap_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_8 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_15;
  viewDir_6 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize((lightDir_7 + viewDir_6));
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
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (dot (normalDir_5, tmpvar_16), 0.0);
  highp float tmpvar_25;
  tmpvar_25 = pow (tmpvar_24, _Shininess);
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_9.y) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_9.y) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  outColor_11.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_28 * 
      (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
    ))) * lightmap_9.x) * _SpecularIntensity)
   * tex_C_Color_10.xyz) + tex_C_Color_10.xyz) + rimLighting_2);
  outColor_11.xyz = (outColor_11.xyz * ramp_8);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix ((_Color * _EnvColor), tmpvar_29, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_30.xyz);
  outColor_11.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_10.w);
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_1;
  tmpvar_10.y = d_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_3.xyw = o_12.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  mediump vec3 tmpvar_15;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_15 = col_21;
  tmpvar_4 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD9 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_8;
  mediump vec4 lightmap_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_8 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_15;
  viewDir_6 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize((lightDir_7 + viewDir_6));
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
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (dot (normalDir_5, tmpvar_16), 0.0);
  highp float tmpvar_25;
  tmpvar_25 = pow (tmpvar_24, _Shininess);
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_9.y) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_9.y) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  outColor_11.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_28 * 
      (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
    ))) * lightmap_9.x) * _SpecularIntensity)
   * tex_C_Color_10.xyz) + tex_C_Color_10.xyz) + rimLighting_2);
  outColor_11.xyz = (outColor_11.xyz * ramp_8);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix ((_Color * _EnvColor), tmpvar_29, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_30.xyz);
  outColor_11.w = _BloomFactor;
  outColor_11.xyz = (outColor_11.xyz + (outColor_11.xyz * xlv_TEXCOORD9));
  outColor_11.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_10.w);
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_1;
  tmpvar_10.y = d_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_3.xyw = o_12.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  mediump vec3 tmpvar_15;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_15 = col_21;
  tmpvar_4 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD9 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_8;
  mediump vec4 lightmap_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_8 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_15;
  viewDir_6 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize((lightDir_7 + viewDir_6));
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
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (dot (normalDir_5, tmpvar_16), 0.0);
  highp float tmpvar_25;
  tmpvar_25 = pow (tmpvar_24, _Shininess);
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_9.y) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_9.y) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  outColor_11.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_28 * 
      (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
    ))) * lightmap_9.x) * _SpecularIntensity)
   * tex_C_Color_10.xyz) + tex_C_Color_10.xyz) + rimLighting_2);
  outColor_11.xyz = (outColor_11.xyz * ramp_8);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix ((_Color * _EnvColor), tmpvar_29, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_30.xyz);
  outColor_11.w = _BloomFactor;
  outColor_11.xyz = (outColor_11.xyz + (outColor_11.xyz * xlv_TEXCOORD9));
  outColor_11.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_10.w);
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_1;
  tmpvar_10.y = d_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_3.xyw = o_12.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  mediump vec3 tmpvar_15;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_15 = col_21;
  tmpvar_4 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD9 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_8;
  mediump vec4 lightmap_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_8 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_15;
  viewDir_6 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize((lightDir_7 + viewDir_6));
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
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (dot (normalDir_5, tmpvar_16), 0.0);
  highp float tmpvar_25;
  tmpvar_25 = pow (tmpvar_24, _Shininess);
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_9.y) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_9.y) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  outColor_11.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_28 * 
      (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
    ))) * lightmap_9.x) * _SpecularIntensity)
   * tex_C_Color_10.xyz) + tex_C_Color_10.xyz) + rimLighting_2);
  outColor_11.xyz = (outColor_11.xyz * ramp_8);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix ((_Color * _EnvColor), tmpvar_29, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_30.xyz);
  outColor_11.w = _BloomFactor;
  outColor_11.xyz = (outColor_11.xyz + (outColor_11.xyz * xlv_TEXCOORD9));
  outColor_11.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_10.w);
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
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
attribute vec4 _glesColor;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  highp float tmpvar_8;
  tmpvar_8 = ((dot (tmpvar_7, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = d_1;
  tmpvar_9.y = d_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_4.zw;
  tmpvar_3.xyw = o_10.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  xlv_TEXCOORD8 = _glesColor;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_9;
  mediump vec4 lightmap_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_16;
  viewDir_7 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize((lightDir_8 + viewDir_7));
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
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (dot (normalDir_6, tmpvar_17), 0.0);
  highp float tmpvar_26;
  tmpvar_26 = pow (tmpvar_25, _Shininess);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_10.y) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_10.y) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  outColor_12.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_29 * 
      (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
    ))) * lightmap_10.x) * _SpecularIntensity)
   * tex_C_Color_11.xyz) + tex_C_Color_11.xyz) + rimLighting_3);
  outColor_12.xyz = (outColor_12.xyz * ramp_9);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix ((_Color * _EnvColor), tmpvar_30, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_31.xyz);
  outColor_12.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_11.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_32;
  highp vec4 rimMask_33;
  rimMask_33 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_34;
  mediump vec4 rgColorA_35;
  mediump vec4 rgColorB_36;
  mediump vec4 rgColorG_37;
  mediump vec4 rgColorR_38;
  mediump vec4 rgColor_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_40 = (_RGBias + (tmpvar_41 * _RGScale));
  mediump vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_40 * _RGColor);
  highp vec4 tmpvar_43;
  tmpvar_43 = (tmpvar_42 * (1.0 - rimMask_33.x));
  rgColorR_38 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = (tmpvar_42 * (1.0 - rimMask_33.y));
  rgColorG_37 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_42 * (1.0 - rimMask_33.z));
  rgColorB_36 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_42 * (1.0 - rimMask_33.w));
  rgColorA_35 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (((
    (rgColorR_38 * _RGMaskR)
   + 
    (rgColorG_37 * _RGMaskG)
  ) + (rgColorB_36 * _RGMaskB)) + (rgColorA_35 * _RGMaskA));
  rgColorRGBA_34.xyz = tmpvar_47.xyz;
  rgColorRGBA_34.w = _RGBloomFactor;
  mediump vec4 tmpvar_48;
  tmpvar_48 = mix (outColor_12, rgColorRGBA_34, vec4(clamp ((
    (rgColorRGBA_34.x + rgColorRGBA_34.y)
   + rgColorRGBA_34.z), 0.0, 1.0)));
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_42, tmpvar_48, vec4(_RGMaskIntensity));
  rgColor_39 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (tmpvar_40, 0.0, 1.0);
  highp vec4 tmpvar_51;
  tmpvar_51 = mix (outColor_12, rgColor_39, vec4((tmpvar_50 * _RGRatio)));
  tmpvar_32 = tmpvar_51;
  outColor_12 = tmpvar_32;
  highp vec4 scrpos_52;
  scrpos_52 = xlv_TEXCOORD6;
  mediump float a_53;
  a_53 = xlv_TEXCOORD6.z;
  if ((a_53 < 0.95)) {
    scrpos_52.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_53 = (a_53 * 17.0);
    highp float tmpvar_54;
    tmpvar_54 = (scrpos_52.y / 4.0);
    highp float tmpvar_55;
    tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
    highp float tmpvar_56;
    if ((tmpvar_54 >= 0.0)) {
      tmpvar_56 = tmpvar_55;
    } else {
      tmpvar_56 = -(tmpvar_55);
    };
    highp float tmpvar_57;
    tmpvar_57 = (scrpos_52.x / 4.0);
    highp float tmpvar_58;
    tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
    highp float tmpvar_59;
    if ((tmpvar_57 >= 0.0)) {
      tmpvar_59 = tmpvar_58;
    } else {
      tmpvar_59 = -(tmpvar_58);
    };
    highp float x_60;
    x_60 = ((a_53 - _DITHERMATRIX[
      int(tmpvar_56)
    ][
      int(tmpvar_59)
    ]) - 0.01);
    if ((x_60 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_32;
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
attribute vec4 _glesColor;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  highp float tmpvar_8;
  tmpvar_8 = ((dot (tmpvar_7, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = d_1;
  tmpvar_9.y = d_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_4.zw;
  tmpvar_3.xyw = o_10.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  xlv_TEXCOORD8 = _glesColor;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_9;
  mediump vec4 lightmap_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_16;
  viewDir_7 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize((lightDir_8 + viewDir_7));
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
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (dot (normalDir_6, tmpvar_17), 0.0);
  highp float tmpvar_26;
  tmpvar_26 = pow (tmpvar_25, _Shininess);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_10.y) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_10.y) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  outColor_12.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_29 * 
      (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
    ))) * lightmap_10.x) * _SpecularIntensity)
   * tex_C_Color_11.xyz) + tex_C_Color_11.xyz) + rimLighting_3);
  outColor_12.xyz = (outColor_12.xyz * ramp_9);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix ((_Color * _EnvColor), tmpvar_30, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_31.xyz);
  outColor_12.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_11.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_32;
  highp vec4 rimMask_33;
  rimMask_33 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_34;
  mediump vec4 rgColorA_35;
  mediump vec4 rgColorB_36;
  mediump vec4 rgColorG_37;
  mediump vec4 rgColorR_38;
  mediump vec4 rgColor_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_40 = (_RGBias + (tmpvar_41 * _RGScale));
  mediump vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_40 * _RGColor);
  highp vec4 tmpvar_43;
  tmpvar_43 = (tmpvar_42 * (1.0 - rimMask_33.x));
  rgColorR_38 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = (tmpvar_42 * (1.0 - rimMask_33.y));
  rgColorG_37 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_42 * (1.0 - rimMask_33.z));
  rgColorB_36 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_42 * (1.0 - rimMask_33.w));
  rgColorA_35 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (((
    (rgColorR_38 * _RGMaskR)
   + 
    (rgColorG_37 * _RGMaskG)
  ) + (rgColorB_36 * _RGMaskB)) + (rgColorA_35 * _RGMaskA));
  rgColorRGBA_34.xyz = tmpvar_47.xyz;
  rgColorRGBA_34.w = _RGBloomFactor;
  mediump vec4 tmpvar_48;
  tmpvar_48 = mix (outColor_12, rgColorRGBA_34, vec4(clamp ((
    (rgColorRGBA_34.x + rgColorRGBA_34.y)
   + rgColorRGBA_34.z), 0.0, 1.0)));
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_42, tmpvar_48, vec4(_RGMaskIntensity));
  rgColor_39 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (tmpvar_40, 0.0, 1.0);
  highp vec4 tmpvar_51;
  tmpvar_51 = mix (outColor_12, rgColor_39, vec4((tmpvar_50 * _RGRatio)));
  tmpvar_32 = tmpvar_51;
  outColor_12 = tmpvar_32;
  highp vec4 scrpos_52;
  scrpos_52 = xlv_TEXCOORD6;
  mediump float a_53;
  a_53 = xlv_TEXCOORD6.z;
  if ((a_53 < 0.95)) {
    scrpos_52.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_53 = (a_53 * 17.0);
    highp float tmpvar_54;
    tmpvar_54 = (scrpos_52.y / 4.0);
    highp float tmpvar_55;
    tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
    highp float tmpvar_56;
    if ((tmpvar_54 >= 0.0)) {
      tmpvar_56 = tmpvar_55;
    } else {
      tmpvar_56 = -(tmpvar_55);
    };
    highp float tmpvar_57;
    tmpvar_57 = (scrpos_52.x / 4.0);
    highp float tmpvar_58;
    tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
    highp float tmpvar_59;
    if ((tmpvar_57 >= 0.0)) {
      tmpvar_59 = tmpvar_58;
    } else {
      tmpvar_59 = -(tmpvar_58);
    };
    highp float x_60;
    x_60 = ((a_53 - _DITHERMATRIX[
      int(tmpvar_56)
    ][
      int(tmpvar_59)
    ]) - 0.01);
    if ((x_60 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_32;
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
attribute vec4 _glesColor;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  highp float tmpvar_8;
  tmpvar_8 = ((dot (tmpvar_7, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = d_1;
  tmpvar_9.y = d_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_4.zw;
  tmpvar_3.xyw = o_10.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  xlv_TEXCOORD8 = _glesColor;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_9;
  mediump vec4 lightmap_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_16;
  viewDir_7 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize((lightDir_8 + viewDir_7));
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
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (dot (normalDir_6, tmpvar_17), 0.0);
  highp float tmpvar_26;
  tmpvar_26 = pow (tmpvar_25, _Shininess);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_10.y) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_10.y) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  outColor_12.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_29 * 
      (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
    ))) * lightmap_10.x) * _SpecularIntensity)
   * tex_C_Color_11.xyz) + tex_C_Color_11.xyz) + rimLighting_3);
  outColor_12.xyz = (outColor_12.xyz * ramp_9);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix ((_Color * _EnvColor), tmpvar_30, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_31.xyz);
  outColor_12.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_11.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_32;
  highp vec4 rimMask_33;
  rimMask_33 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_34;
  mediump vec4 rgColorA_35;
  mediump vec4 rgColorB_36;
  mediump vec4 rgColorG_37;
  mediump vec4 rgColorR_38;
  mediump vec4 rgColor_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_40 = (_RGBias + (tmpvar_41 * _RGScale));
  mediump vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_40 * _RGColor);
  highp vec4 tmpvar_43;
  tmpvar_43 = (tmpvar_42 * (1.0 - rimMask_33.x));
  rgColorR_38 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = (tmpvar_42 * (1.0 - rimMask_33.y));
  rgColorG_37 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_42 * (1.0 - rimMask_33.z));
  rgColorB_36 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_42 * (1.0 - rimMask_33.w));
  rgColorA_35 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (((
    (rgColorR_38 * _RGMaskR)
   + 
    (rgColorG_37 * _RGMaskG)
  ) + (rgColorB_36 * _RGMaskB)) + (rgColorA_35 * _RGMaskA));
  rgColorRGBA_34.xyz = tmpvar_47.xyz;
  rgColorRGBA_34.w = _RGBloomFactor;
  mediump vec4 tmpvar_48;
  tmpvar_48 = mix (outColor_12, rgColorRGBA_34, vec4(clamp ((
    (rgColorRGBA_34.x + rgColorRGBA_34.y)
   + rgColorRGBA_34.z), 0.0, 1.0)));
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_42, tmpvar_48, vec4(_RGMaskIntensity));
  rgColor_39 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (tmpvar_40, 0.0, 1.0);
  highp vec4 tmpvar_51;
  tmpvar_51 = mix (outColor_12, rgColor_39, vec4((tmpvar_50 * _RGRatio)));
  tmpvar_32 = tmpvar_51;
  outColor_12 = tmpvar_32;
  highp vec4 scrpos_52;
  scrpos_52 = xlv_TEXCOORD6;
  mediump float a_53;
  a_53 = xlv_TEXCOORD6.z;
  if ((a_53 < 0.95)) {
    scrpos_52.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_53 = (a_53 * 17.0);
    highp float tmpvar_54;
    tmpvar_54 = (scrpos_52.y / 4.0);
    highp float tmpvar_55;
    tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
    highp float tmpvar_56;
    if ((tmpvar_54 >= 0.0)) {
      tmpvar_56 = tmpvar_55;
    } else {
      tmpvar_56 = -(tmpvar_55);
    };
    highp float tmpvar_57;
    tmpvar_57 = (scrpos_52.x / 4.0);
    highp float tmpvar_58;
    tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
    highp float tmpvar_59;
    if ((tmpvar_57 >= 0.0)) {
      tmpvar_59 = tmpvar_58;
    } else {
      tmpvar_59 = -(tmpvar_58);
    };
    highp float x_60;
    x_60 = ((a_53 - _DITHERMATRIX[
      int(tmpvar_56)
    ][
      int(tmpvar_59)
    ]) - 0.01);
    if ((x_60 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_32;
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
attribute vec4 _glesColor;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_1;
  tmpvar_10.y = d_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_3.xyw = o_12.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  mediump vec3 tmpvar_15;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_15 = col_21;
  tmpvar_4 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD8 = _glesColor;
  xlv_TEXCOORD9 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_9;
  mediump vec4 lightmap_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_16;
  viewDir_7 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize((lightDir_8 + viewDir_7));
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
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (dot (normalDir_6, tmpvar_17), 0.0);
  highp float tmpvar_26;
  tmpvar_26 = pow (tmpvar_25, _Shininess);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_10.y) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_10.y) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  outColor_12.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_29 * 
      (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
    ))) * lightmap_10.x) * _SpecularIntensity)
   * tex_C_Color_11.xyz) + tex_C_Color_11.xyz) + rimLighting_3);
  outColor_12.xyz = (outColor_12.xyz * ramp_9);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix ((_Color * _EnvColor), tmpvar_30, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_31.xyz);
  outColor_12.w = _BloomFactor;
  outColor_12.xyz = (outColor_12.xyz + (outColor_12.xyz * xlv_TEXCOORD9));
  outColor_12.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_11.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_32;
  highp vec4 rimMask_33;
  rimMask_33 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_34;
  mediump vec4 rgColorA_35;
  mediump vec4 rgColorB_36;
  mediump vec4 rgColorG_37;
  mediump vec4 rgColorR_38;
  mediump vec4 rgColor_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_40 = (_RGBias + (tmpvar_41 * _RGScale));
  mediump vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_40 * _RGColor);
  highp vec4 tmpvar_43;
  tmpvar_43 = (tmpvar_42 * (1.0 - rimMask_33.x));
  rgColorR_38 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = (tmpvar_42 * (1.0 - rimMask_33.y));
  rgColorG_37 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_42 * (1.0 - rimMask_33.z));
  rgColorB_36 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_42 * (1.0 - rimMask_33.w));
  rgColorA_35 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (((
    (rgColorR_38 * _RGMaskR)
   + 
    (rgColorG_37 * _RGMaskG)
  ) + (rgColorB_36 * _RGMaskB)) + (rgColorA_35 * _RGMaskA));
  rgColorRGBA_34.xyz = tmpvar_47.xyz;
  rgColorRGBA_34.w = _RGBloomFactor;
  mediump vec4 tmpvar_48;
  tmpvar_48 = mix (outColor_12, rgColorRGBA_34, vec4(clamp ((
    (rgColorRGBA_34.x + rgColorRGBA_34.y)
   + rgColorRGBA_34.z), 0.0, 1.0)));
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_42, tmpvar_48, vec4(_RGMaskIntensity));
  rgColor_39 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (tmpvar_40, 0.0, 1.0);
  highp vec4 tmpvar_51;
  tmpvar_51 = mix (outColor_12, rgColor_39, vec4((tmpvar_50 * _RGRatio)));
  tmpvar_32 = tmpvar_51;
  outColor_12 = tmpvar_32;
  highp vec4 scrpos_52;
  scrpos_52 = xlv_TEXCOORD6;
  mediump float a_53;
  a_53 = xlv_TEXCOORD6.z;
  if ((a_53 < 0.95)) {
    scrpos_52.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_53 = (a_53 * 17.0);
    highp float tmpvar_54;
    tmpvar_54 = (scrpos_52.y / 4.0);
    highp float tmpvar_55;
    tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
    highp float tmpvar_56;
    if ((tmpvar_54 >= 0.0)) {
      tmpvar_56 = tmpvar_55;
    } else {
      tmpvar_56 = -(tmpvar_55);
    };
    highp float tmpvar_57;
    tmpvar_57 = (scrpos_52.x / 4.0);
    highp float tmpvar_58;
    tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
    highp float tmpvar_59;
    if ((tmpvar_57 >= 0.0)) {
      tmpvar_59 = tmpvar_58;
    } else {
      tmpvar_59 = -(tmpvar_58);
    };
    highp float x_60;
    x_60 = ((a_53 - _DITHERMATRIX[
      int(tmpvar_56)
    ][
      int(tmpvar_59)
    ]) - 0.01);
    if ((x_60 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_32;
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
attribute vec4 _glesColor;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_1;
  tmpvar_10.y = d_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_3.xyw = o_12.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  mediump vec3 tmpvar_15;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_15 = col_21;
  tmpvar_4 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD8 = _glesColor;
  xlv_TEXCOORD9 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_9;
  mediump vec4 lightmap_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_16;
  viewDir_7 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize((lightDir_8 + viewDir_7));
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
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (dot (normalDir_6, tmpvar_17), 0.0);
  highp float tmpvar_26;
  tmpvar_26 = pow (tmpvar_25, _Shininess);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_10.y) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_10.y) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  outColor_12.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_29 * 
      (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
    ))) * lightmap_10.x) * _SpecularIntensity)
   * tex_C_Color_11.xyz) + tex_C_Color_11.xyz) + rimLighting_3);
  outColor_12.xyz = (outColor_12.xyz * ramp_9);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix ((_Color * _EnvColor), tmpvar_30, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_31.xyz);
  outColor_12.w = _BloomFactor;
  outColor_12.xyz = (outColor_12.xyz + (outColor_12.xyz * xlv_TEXCOORD9));
  outColor_12.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_11.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_32;
  highp vec4 rimMask_33;
  rimMask_33 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_34;
  mediump vec4 rgColorA_35;
  mediump vec4 rgColorB_36;
  mediump vec4 rgColorG_37;
  mediump vec4 rgColorR_38;
  mediump vec4 rgColor_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_40 = (_RGBias + (tmpvar_41 * _RGScale));
  mediump vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_40 * _RGColor);
  highp vec4 tmpvar_43;
  tmpvar_43 = (tmpvar_42 * (1.0 - rimMask_33.x));
  rgColorR_38 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = (tmpvar_42 * (1.0 - rimMask_33.y));
  rgColorG_37 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_42 * (1.0 - rimMask_33.z));
  rgColorB_36 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_42 * (1.0 - rimMask_33.w));
  rgColorA_35 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (((
    (rgColorR_38 * _RGMaskR)
   + 
    (rgColorG_37 * _RGMaskG)
  ) + (rgColorB_36 * _RGMaskB)) + (rgColorA_35 * _RGMaskA));
  rgColorRGBA_34.xyz = tmpvar_47.xyz;
  rgColorRGBA_34.w = _RGBloomFactor;
  mediump vec4 tmpvar_48;
  tmpvar_48 = mix (outColor_12, rgColorRGBA_34, vec4(clamp ((
    (rgColorRGBA_34.x + rgColorRGBA_34.y)
   + rgColorRGBA_34.z), 0.0, 1.0)));
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_42, tmpvar_48, vec4(_RGMaskIntensity));
  rgColor_39 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (tmpvar_40, 0.0, 1.0);
  highp vec4 tmpvar_51;
  tmpvar_51 = mix (outColor_12, rgColor_39, vec4((tmpvar_50 * _RGRatio)));
  tmpvar_32 = tmpvar_51;
  outColor_12 = tmpvar_32;
  highp vec4 scrpos_52;
  scrpos_52 = xlv_TEXCOORD6;
  mediump float a_53;
  a_53 = xlv_TEXCOORD6.z;
  if ((a_53 < 0.95)) {
    scrpos_52.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_53 = (a_53 * 17.0);
    highp float tmpvar_54;
    tmpvar_54 = (scrpos_52.y / 4.0);
    highp float tmpvar_55;
    tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
    highp float tmpvar_56;
    if ((tmpvar_54 >= 0.0)) {
      tmpvar_56 = tmpvar_55;
    } else {
      tmpvar_56 = -(tmpvar_55);
    };
    highp float tmpvar_57;
    tmpvar_57 = (scrpos_52.x / 4.0);
    highp float tmpvar_58;
    tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
    highp float tmpvar_59;
    if ((tmpvar_57 >= 0.0)) {
      tmpvar_59 = tmpvar_58;
    } else {
      tmpvar_59 = -(tmpvar_58);
    };
    highp float x_60;
    x_60 = ((a_53 - _DITHERMATRIX[
      int(tmpvar_56)
    ][
      int(tmpvar_59)
    ]) - 0.01);
    if ((x_60 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_32;
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
attribute vec4 _glesColor;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_1;
  tmpvar_10.y = d_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_3.xyw = o_12.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  mediump vec3 tmpvar_15;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_15 = col_21;
  tmpvar_4 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD8 = _glesColor;
  xlv_TEXCOORD9 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_9;
  mediump vec4 lightmap_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_16;
  viewDir_7 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize((lightDir_8 + viewDir_7));
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
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (dot (normalDir_6, tmpvar_17), 0.0);
  highp float tmpvar_26;
  tmpvar_26 = pow (tmpvar_25, _Shininess);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_10.y) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_10.y) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  outColor_12.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_29 * 
      (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
    ))) * lightmap_10.x) * _SpecularIntensity)
   * tex_C_Color_11.xyz) + tex_C_Color_11.xyz) + rimLighting_3);
  outColor_12.xyz = (outColor_12.xyz * ramp_9);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix ((_Color * _EnvColor), tmpvar_30, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_31.xyz);
  outColor_12.w = _BloomFactor;
  outColor_12.xyz = (outColor_12.xyz + (outColor_12.xyz * xlv_TEXCOORD9));
  outColor_12.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_11.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_32;
  highp vec4 rimMask_33;
  rimMask_33 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_34;
  mediump vec4 rgColorA_35;
  mediump vec4 rgColorB_36;
  mediump vec4 rgColorG_37;
  mediump vec4 rgColorR_38;
  mediump vec4 rgColor_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_40 = (_RGBias + (tmpvar_41 * _RGScale));
  mediump vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_40 * _RGColor);
  highp vec4 tmpvar_43;
  tmpvar_43 = (tmpvar_42 * (1.0 - rimMask_33.x));
  rgColorR_38 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = (tmpvar_42 * (1.0 - rimMask_33.y));
  rgColorG_37 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_42 * (1.0 - rimMask_33.z));
  rgColorB_36 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_42 * (1.0 - rimMask_33.w));
  rgColorA_35 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (((
    (rgColorR_38 * _RGMaskR)
   + 
    (rgColorG_37 * _RGMaskG)
  ) + (rgColorB_36 * _RGMaskB)) + (rgColorA_35 * _RGMaskA));
  rgColorRGBA_34.xyz = tmpvar_47.xyz;
  rgColorRGBA_34.w = _RGBloomFactor;
  mediump vec4 tmpvar_48;
  tmpvar_48 = mix (outColor_12, rgColorRGBA_34, vec4(clamp ((
    (rgColorRGBA_34.x + rgColorRGBA_34.y)
   + rgColorRGBA_34.z), 0.0, 1.0)));
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_42, tmpvar_48, vec4(_RGMaskIntensity));
  rgColor_39 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (tmpvar_40, 0.0, 1.0);
  highp vec4 tmpvar_51;
  tmpvar_51 = mix (outColor_12, rgColor_39, vec4((tmpvar_50 * _RGRatio)));
  tmpvar_32 = tmpvar_51;
  outColor_12 = tmpvar_32;
  highp vec4 scrpos_52;
  scrpos_52 = xlv_TEXCOORD6;
  mediump float a_53;
  a_53 = xlv_TEXCOORD6.z;
  if ((a_53 < 0.95)) {
    scrpos_52.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_53 = (a_53 * 17.0);
    highp float tmpvar_54;
    tmpvar_54 = (scrpos_52.y / 4.0);
    highp float tmpvar_55;
    tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
    highp float tmpvar_56;
    if ((tmpvar_54 >= 0.0)) {
      tmpvar_56 = tmpvar_55;
    } else {
      tmpvar_56 = -(tmpvar_55);
    };
    highp float tmpvar_57;
    tmpvar_57 = (scrpos_52.x / 4.0);
    highp float tmpvar_58;
    tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
    highp float tmpvar_59;
    if ((tmpvar_57 >= 0.0)) {
      tmpvar_59 = tmpvar_58;
    } else {
      tmpvar_59 = -(tmpvar_58);
    };
    highp float x_60;
    x_60 = ((a_53 - _DITHERMATRIX[
      int(tmpvar_56)
    ][
      int(tmpvar_59)
    ]) - 0.01);
    if ((x_60 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_32;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_2;
  tmpvar_10.y = d_2;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_4.xyw = o_12.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_15;
  uv_15 = tmpvar_1;
  highp vec4 spuvs_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  spuvs_16.xy = ((uv_15 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  spuvs_16.zw = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_16;
  xlv_TEXCOORD4 = (tmpvar_11.xyz / tmpvar_11.w);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 ramp_10;
  mediump vec4 lightmap_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_11 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_17;
  viewDir_8 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_9 + viewDir_8));
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
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (dot (normalDir_7, tmpvar_18), 0.0);
  highp float tmpvar_27;
  tmpvar_27 = pow (tmpvar_26, _Shininess);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_11.y) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_11.y) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  outColor_13.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    ))) * lightmap_11.x) * _SpecularIntensity)
   * tex_C_Color_12.xyz) + tex_C_Color_12.xyz) + rimLighting_4);
  outColor_13.xyz = (outColor_13.xyz * ramp_10);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_32;
  tmpvar_32 = mix ((_Color * _EnvColor), tmpvar_31, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_32.xyz);
  outColor_13.w = _BloomFactor;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_34;
  mediump vec3 reflection_35;
  mediump vec3 R_36;
  mediump float intensity_37;
  mediump vec4 noiseTex_38;
  mediump vec4 spColor_39;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_39.xyz = tmpvar_40.xyz;
  spColor_39.w = outColor_13.w;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_38 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (((1.99 * noiseTex_38.x) * _SPNoiseScaler) - 1.0);
  intensity_37 = tmpvar_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_38 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (N_3, I_44)
   * N_3)));
  R_36 = tmpvar_43;
  lowp vec3 tmpvar_45;
  tmpvar_45 = textureCube (_SPCubeMap, R_36).xyz;
  reflection_35 = tmpvar_45;
  highp vec3 tmpvar_46;
  mediump vec3 x_47;
  x_47 = (spColor_39.xyz * _SPOldColor.xyz);
  tmpvar_46 = mix (x_47, ((reflection_35 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_39.xyz = tmpvar_46;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_37 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_37 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_48;
      tmpvar_48 = mix (spColor_39, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_37) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_39 = tmpvar_48;
    };
  };
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (outColor_13.xyz, spColor_39.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_39.xyz = tmpvar_49;
  outColor_13.xyz = spColor_39.xyz;
  outColor_13.w = mix (spColor_39.w, _EmissionBloomFactor, tex_C_Color_12.w);
  highp vec4 scrpos_50;
  scrpos_50 = xlv_TEXCOORD6;
  mediump float a_51;
  a_51 = xlv_TEXCOORD6.z;
  if ((a_51 < 0.95)) {
    scrpos_50.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_51 = (a_51 * 17.0);
    highp float tmpvar_52;
    tmpvar_52 = (scrpos_50.y / 4.0);
    highp float tmpvar_53;
    tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
    highp float tmpvar_54;
    if ((tmpvar_52 >= 0.0)) {
      tmpvar_54 = tmpvar_53;
    } else {
      tmpvar_54 = -(tmpvar_53);
    };
    highp float tmpvar_55;
    tmpvar_55 = (scrpos_50.x / 4.0);
    highp float tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
    highp float tmpvar_57;
    if ((tmpvar_55 >= 0.0)) {
      tmpvar_57 = tmpvar_56;
    } else {
      tmpvar_57 = -(tmpvar_56);
    };
    highp float x_58;
    x_58 = ((a_51 - _DITHERMATRIX[
      int(tmpvar_54)
    ][
      int(tmpvar_57)
    ]) - 0.01);
    if ((x_58 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_13;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_2;
  tmpvar_10.y = d_2;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_4.xyw = o_12.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_15;
  uv_15 = tmpvar_1;
  highp vec4 spuvs_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  spuvs_16.xy = ((uv_15 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  spuvs_16.zw = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_16;
  xlv_TEXCOORD4 = (tmpvar_11.xyz / tmpvar_11.w);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 ramp_10;
  mediump vec4 lightmap_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_11 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_17;
  viewDir_8 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_9 + viewDir_8));
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
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (dot (normalDir_7, tmpvar_18), 0.0);
  highp float tmpvar_27;
  tmpvar_27 = pow (tmpvar_26, _Shininess);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_11.y) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_11.y) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  outColor_13.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    ))) * lightmap_11.x) * _SpecularIntensity)
   * tex_C_Color_12.xyz) + tex_C_Color_12.xyz) + rimLighting_4);
  outColor_13.xyz = (outColor_13.xyz * ramp_10);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_32;
  tmpvar_32 = mix ((_Color * _EnvColor), tmpvar_31, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_32.xyz);
  outColor_13.w = _BloomFactor;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_34;
  mediump vec3 reflection_35;
  mediump vec3 R_36;
  mediump float intensity_37;
  mediump vec4 noiseTex_38;
  mediump vec4 spColor_39;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_39.xyz = tmpvar_40.xyz;
  spColor_39.w = outColor_13.w;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_38 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (((1.99 * noiseTex_38.x) * _SPNoiseScaler) - 1.0);
  intensity_37 = tmpvar_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_38 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (N_3, I_44)
   * N_3)));
  R_36 = tmpvar_43;
  lowp vec3 tmpvar_45;
  tmpvar_45 = textureCube (_SPCubeMap, R_36).xyz;
  reflection_35 = tmpvar_45;
  highp vec3 tmpvar_46;
  mediump vec3 x_47;
  x_47 = (spColor_39.xyz * _SPOldColor.xyz);
  tmpvar_46 = mix (x_47, ((reflection_35 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_39.xyz = tmpvar_46;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_37 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_37 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_48;
      tmpvar_48 = mix (spColor_39, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_37) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_39 = tmpvar_48;
    };
  };
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (outColor_13.xyz, spColor_39.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_39.xyz = tmpvar_49;
  outColor_13.xyz = spColor_39.xyz;
  outColor_13.w = mix (spColor_39.w, _EmissionBloomFactor, tex_C_Color_12.w);
  highp vec4 scrpos_50;
  scrpos_50 = xlv_TEXCOORD6;
  mediump float a_51;
  a_51 = xlv_TEXCOORD6.z;
  if ((a_51 < 0.95)) {
    scrpos_50.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_51 = (a_51 * 17.0);
    highp float tmpvar_52;
    tmpvar_52 = (scrpos_50.y / 4.0);
    highp float tmpvar_53;
    tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
    highp float tmpvar_54;
    if ((tmpvar_52 >= 0.0)) {
      tmpvar_54 = tmpvar_53;
    } else {
      tmpvar_54 = -(tmpvar_53);
    };
    highp float tmpvar_55;
    tmpvar_55 = (scrpos_50.x / 4.0);
    highp float tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
    highp float tmpvar_57;
    if ((tmpvar_55 >= 0.0)) {
      tmpvar_57 = tmpvar_56;
    } else {
      tmpvar_57 = -(tmpvar_56);
    };
    highp float x_58;
    x_58 = ((a_51 - _DITHERMATRIX[
      int(tmpvar_54)
    ][
      int(tmpvar_57)
    ]) - 0.01);
    if ((x_58 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_13;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_2;
  tmpvar_10.y = d_2;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_4.xyw = o_12.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_15;
  uv_15 = tmpvar_1;
  highp vec4 spuvs_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  spuvs_16.xy = ((uv_15 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  spuvs_16.zw = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_16;
  xlv_TEXCOORD4 = (tmpvar_11.xyz / tmpvar_11.w);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 ramp_10;
  mediump vec4 lightmap_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_11 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_17;
  viewDir_8 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_9 + viewDir_8));
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
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (dot (normalDir_7, tmpvar_18), 0.0);
  highp float tmpvar_27;
  tmpvar_27 = pow (tmpvar_26, _Shininess);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_11.y) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_11.y) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  outColor_13.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    ))) * lightmap_11.x) * _SpecularIntensity)
   * tex_C_Color_12.xyz) + tex_C_Color_12.xyz) + rimLighting_4);
  outColor_13.xyz = (outColor_13.xyz * ramp_10);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_32;
  tmpvar_32 = mix ((_Color * _EnvColor), tmpvar_31, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_32.xyz);
  outColor_13.w = _BloomFactor;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_34;
  mediump vec3 reflection_35;
  mediump vec3 R_36;
  mediump float intensity_37;
  mediump vec4 noiseTex_38;
  mediump vec4 spColor_39;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_39.xyz = tmpvar_40.xyz;
  spColor_39.w = outColor_13.w;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_38 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (((1.99 * noiseTex_38.x) * _SPNoiseScaler) - 1.0);
  intensity_37 = tmpvar_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_38 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (N_3, I_44)
   * N_3)));
  R_36 = tmpvar_43;
  lowp vec3 tmpvar_45;
  tmpvar_45 = textureCube (_SPCubeMap, R_36).xyz;
  reflection_35 = tmpvar_45;
  highp vec3 tmpvar_46;
  mediump vec3 x_47;
  x_47 = (spColor_39.xyz * _SPOldColor.xyz);
  tmpvar_46 = mix (x_47, ((reflection_35 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_39.xyz = tmpvar_46;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_37 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_37 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_48;
      tmpvar_48 = mix (spColor_39, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_37) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_39 = tmpvar_48;
    };
  };
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (outColor_13.xyz, spColor_39.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_39.xyz = tmpvar_49;
  outColor_13.xyz = spColor_39.xyz;
  outColor_13.w = mix (spColor_39.w, _EmissionBloomFactor, tex_C_Color_12.w);
  highp vec4 scrpos_50;
  scrpos_50 = xlv_TEXCOORD6;
  mediump float a_51;
  a_51 = xlv_TEXCOORD6.z;
  if ((a_51 < 0.95)) {
    scrpos_50.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_51 = (a_51 * 17.0);
    highp float tmpvar_52;
    tmpvar_52 = (scrpos_50.y / 4.0);
    highp float tmpvar_53;
    tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
    highp float tmpvar_54;
    if ((tmpvar_52 >= 0.0)) {
      tmpvar_54 = tmpvar_53;
    } else {
      tmpvar_54 = -(tmpvar_53);
    };
    highp float tmpvar_55;
    tmpvar_55 = (scrpos_50.x / 4.0);
    highp float tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
    highp float tmpvar_57;
    if ((tmpvar_55 >= 0.0)) {
      tmpvar_57 = tmpvar_56;
    } else {
      tmpvar_57 = -(tmpvar_56);
    };
    highp float x_58;
    x_58 = ((a_51 - _DITHERMATRIX[
      int(tmpvar_54)
    ][
      int(tmpvar_57)
    ]) - 0.01);
    if ((x_58 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_13;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_4.xyw = o_13.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_16;
  uv_16 = tmpvar_1;
  highp vec4 spuvs_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (_glesVertex * 0.5);
  spuvs_17.xy = ((uv_16 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (tmpvar_18.z * tmpvar_18.z));
  tmpvar_19.y = ((tmpvar_18.y + (0.5 * tmpvar_18.z)) + ((0.5 * tmpvar_18.x) * tmpvar_18.x));
  spuvs_17.zw = ((tmpvar_19 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  mediump vec3 tmpvar_20;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 col_26;
  highp vec4 ndotl_27;
  highp vec4 lengthSq_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosX0 - tmpvar_12.x);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosY0 - tmpvar_12.y);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosZ0 - tmpvar_12.z);
  lengthSq_28 = (tmpvar_29 * tmpvar_29);
  lengthSq_28 = (lengthSq_28 + (tmpvar_30 * tmpvar_30));
  lengthSq_28 = (lengthSq_28 + (tmpvar_31 * tmpvar_31));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (lengthSq_28, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_28 = tmpvar_32;
  ndotl_27 = (tmpvar_29 * tmpvar_9.x);
  ndotl_27 = (ndotl_27 + (tmpvar_30 * tmpvar_9.y));
  ndotl_27 = (ndotl_27 + (tmpvar_31 * tmpvar_9.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_27 * inversesqrt(tmpvar_32)));
  ndotl_27 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (tmpvar_32 * lightAttenSq_25)
  ))));
  col_26 = (lightColor0_21 * tmpvar_34.x);
  col_26 = (col_26 + (lightColor1_22 * tmpvar_34.y));
  col_26 = (col_26 + (lightColor2_23 * tmpvar_34.z));
  col_26 = (col_26 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_20 = col_26;
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_17;
  xlv_TEXCOORD4 = (tmpvar_12.xyz / tmpvar_12.w);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_12.xyz));
  xlv_TEXCOORD9 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 ramp_10;
  mediump vec4 lightmap_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_11 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_17;
  viewDir_8 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_9 + viewDir_8));
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
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (dot (normalDir_7, tmpvar_18), 0.0);
  highp float tmpvar_27;
  tmpvar_27 = pow (tmpvar_26, _Shininess);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_11.y) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_11.y) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  outColor_13.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    ))) * lightmap_11.x) * _SpecularIntensity)
   * tex_C_Color_12.xyz) + tex_C_Color_12.xyz) + rimLighting_4);
  outColor_13.xyz = (outColor_13.xyz * ramp_10);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_32;
  tmpvar_32 = mix ((_Color * _EnvColor), tmpvar_31, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_32.xyz);
  outColor_13.w = _BloomFactor;
  outColor_13.xyz = (outColor_13.xyz + (outColor_13.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_34;
  mediump vec3 reflection_35;
  mediump vec3 R_36;
  mediump float intensity_37;
  mediump vec4 noiseTex_38;
  mediump vec4 spColor_39;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_39.xyz = tmpvar_40.xyz;
  spColor_39.w = outColor_13.w;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_38 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (((1.99 * noiseTex_38.x) * _SPNoiseScaler) - 1.0);
  intensity_37 = tmpvar_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_38 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (N_3, I_44)
   * N_3)));
  R_36 = tmpvar_43;
  lowp vec3 tmpvar_45;
  tmpvar_45 = textureCube (_SPCubeMap, R_36).xyz;
  reflection_35 = tmpvar_45;
  highp vec3 tmpvar_46;
  mediump vec3 x_47;
  x_47 = (spColor_39.xyz * _SPOldColor.xyz);
  tmpvar_46 = mix (x_47, ((reflection_35 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_39.xyz = tmpvar_46;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_37 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_37 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_48;
      tmpvar_48 = mix (spColor_39, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_37) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_39 = tmpvar_48;
    };
  };
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (outColor_13.xyz, spColor_39.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_39.xyz = tmpvar_49;
  outColor_13.xyz = spColor_39.xyz;
  outColor_13.w = mix (spColor_39.w, _EmissionBloomFactor, tex_C_Color_12.w);
  highp vec4 scrpos_50;
  scrpos_50 = xlv_TEXCOORD6;
  mediump float a_51;
  a_51 = xlv_TEXCOORD6.z;
  if ((a_51 < 0.95)) {
    scrpos_50.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_51 = (a_51 * 17.0);
    highp float tmpvar_52;
    tmpvar_52 = (scrpos_50.y / 4.0);
    highp float tmpvar_53;
    tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
    highp float tmpvar_54;
    if ((tmpvar_52 >= 0.0)) {
      tmpvar_54 = tmpvar_53;
    } else {
      tmpvar_54 = -(tmpvar_53);
    };
    highp float tmpvar_55;
    tmpvar_55 = (scrpos_50.x / 4.0);
    highp float tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
    highp float tmpvar_57;
    if ((tmpvar_55 >= 0.0)) {
      tmpvar_57 = tmpvar_56;
    } else {
      tmpvar_57 = -(tmpvar_56);
    };
    highp float x_58;
    x_58 = ((a_51 - _DITHERMATRIX[
      int(tmpvar_54)
    ][
      int(tmpvar_57)
    ]) - 0.01);
    if ((x_58 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_13;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_4.xyw = o_13.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_16;
  uv_16 = tmpvar_1;
  highp vec4 spuvs_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (_glesVertex * 0.5);
  spuvs_17.xy = ((uv_16 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (tmpvar_18.z * tmpvar_18.z));
  tmpvar_19.y = ((tmpvar_18.y + (0.5 * tmpvar_18.z)) + ((0.5 * tmpvar_18.x) * tmpvar_18.x));
  spuvs_17.zw = ((tmpvar_19 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  mediump vec3 tmpvar_20;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 col_26;
  highp vec4 ndotl_27;
  highp vec4 lengthSq_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosX0 - tmpvar_12.x);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosY0 - tmpvar_12.y);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosZ0 - tmpvar_12.z);
  lengthSq_28 = (tmpvar_29 * tmpvar_29);
  lengthSq_28 = (lengthSq_28 + (tmpvar_30 * tmpvar_30));
  lengthSq_28 = (lengthSq_28 + (tmpvar_31 * tmpvar_31));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (lengthSq_28, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_28 = tmpvar_32;
  ndotl_27 = (tmpvar_29 * tmpvar_9.x);
  ndotl_27 = (ndotl_27 + (tmpvar_30 * tmpvar_9.y));
  ndotl_27 = (ndotl_27 + (tmpvar_31 * tmpvar_9.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_27 * inversesqrt(tmpvar_32)));
  ndotl_27 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (tmpvar_32 * lightAttenSq_25)
  ))));
  col_26 = (lightColor0_21 * tmpvar_34.x);
  col_26 = (col_26 + (lightColor1_22 * tmpvar_34.y));
  col_26 = (col_26 + (lightColor2_23 * tmpvar_34.z));
  col_26 = (col_26 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_20 = col_26;
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_17;
  xlv_TEXCOORD4 = (tmpvar_12.xyz / tmpvar_12.w);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_12.xyz));
  xlv_TEXCOORD9 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 ramp_10;
  mediump vec4 lightmap_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_11 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_17;
  viewDir_8 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_9 + viewDir_8));
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
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (dot (normalDir_7, tmpvar_18), 0.0);
  highp float tmpvar_27;
  tmpvar_27 = pow (tmpvar_26, _Shininess);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_11.y) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_11.y) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  outColor_13.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    ))) * lightmap_11.x) * _SpecularIntensity)
   * tex_C_Color_12.xyz) + tex_C_Color_12.xyz) + rimLighting_4);
  outColor_13.xyz = (outColor_13.xyz * ramp_10);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_32;
  tmpvar_32 = mix ((_Color * _EnvColor), tmpvar_31, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_32.xyz);
  outColor_13.w = _BloomFactor;
  outColor_13.xyz = (outColor_13.xyz + (outColor_13.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_34;
  mediump vec3 reflection_35;
  mediump vec3 R_36;
  mediump float intensity_37;
  mediump vec4 noiseTex_38;
  mediump vec4 spColor_39;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_39.xyz = tmpvar_40.xyz;
  spColor_39.w = outColor_13.w;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_38 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (((1.99 * noiseTex_38.x) * _SPNoiseScaler) - 1.0);
  intensity_37 = tmpvar_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_38 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (N_3, I_44)
   * N_3)));
  R_36 = tmpvar_43;
  lowp vec3 tmpvar_45;
  tmpvar_45 = textureCube (_SPCubeMap, R_36).xyz;
  reflection_35 = tmpvar_45;
  highp vec3 tmpvar_46;
  mediump vec3 x_47;
  x_47 = (spColor_39.xyz * _SPOldColor.xyz);
  tmpvar_46 = mix (x_47, ((reflection_35 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_39.xyz = tmpvar_46;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_37 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_37 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_48;
      tmpvar_48 = mix (spColor_39, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_37) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_39 = tmpvar_48;
    };
  };
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (outColor_13.xyz, spColor_39.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_39.xyz = tmpvar_49;
  outColor_13.xyz = spColor_39.xyz;
  outColor_13.w = mix (spColor_39.w, _EmissionBloomFactor, tex_C_Color_12.w);
  highp vec4 scrpos_50;
  scrpos_50 = xlv_TEXCOORD6;
  mediump float a_51;
  a_51 = xlv_TEXCOORD6.z;
  if ((a_51 < 0.95)) {
    scrpos_50.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_51 = (a_51 * 17.0);
    highp float tmpvar_52;
    tmpvar_52 = (scrpos_50.y / 4.0);
    highp float tmpvar_53;
    tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
    highp float tmpvar_54;
    if ((tmpvar_52 >= 0.0)) {
      tmpvar_54 = tmpvar_53;
    } else {
      tmpvar_54 = -(tmpvar_53);
    };
    highp float tmpvar_55;
    tmpvar_55 = (scrpos_50.x / 4.0);
    highp float tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
    highp float tmpvar_57;
    if ((tmpvar_55 >= 0.0)) {
      tmpvar_57 = tmpvar_56;
    } else {
      tmpvar_57 = -(tmpvar_56);
    };
    highp float x_58;
    x_58 = ((a_51 - _DITHERMATRIX[
      int(tmpvar_54)
    ][
      int(tmpvar_57)
    ]) - 0.01);
    if ((x_58 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_13;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_4.xyw = o_13.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_16;
  uv_16 = tmpvar_1;
  highp vec4 spuvs_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (_glesVertex * 0.5);
  spuvs_17.xy = ((uv_16 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (tmpvar_18.z * tmpvar_18.z));
  tmpvar_19.y = ((tmpvar_18.y + (0.5 * tmpvar_18.z)) + ((0.5 * tmpvar_18.x) * tmpvar_18.x));
  spuvs_17.zw = ((tmpvar_19 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  mediump vec3 tmpvar_20;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 col_26;
  highp vec4 ndotl_27;
  highp vec4 lengthSq_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosX0 - tmpvar_12.x);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosY0 - tmpvar_12.y);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosZ0 - tmpvar_12.z);
  lengthSq_28 = (tmpvar_29 * tmpvar_29);
  lengthSq_28 = (lengthSq_28 + (tmpvar_30 * tmpvar_30));
  lengthSq_28 = (lengthSq_28 + (tmpvar_31 * tmpvar_31));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (lengthSq_28, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_28 = tmpvar_32;
  ndotl_27 = (tmpvar_29 * tmpvar_9.x);
  ndotl_27 = (ndotl_27 + (tmpvar_30 * tmpvar_9.y));
  ndotl_27 = (ndotl_27 + (tmpvar_31 * tmpvar_9.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_27 * inversesqrt(tmpvar_32)));
  ndotl_27 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (tmpvar_32 * lightAttenSq_25)
  ))));
  col_26 = (lightColor0_21 * tmpvar_34.x);
  col_26 = (col_26 + (lightColor1_22 * tmpvar_34.y));
  col_26 = (col_26 + (lightColor2_23 * tmpvar_34.z));
  col_26 = (col_26 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_20 = col_26;
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_17;
  xlv_TEXCOORD4 = (tmpvar_12.xyz / tmpvar_12.w);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_12.xyz));
  xlv_TEXCOORD9 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 ramp_10;
  mediump vec4 lightmap_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_11 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_17;
  viewDir_8 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_9 + viewDir_8));
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
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (dot (normalDir_7, tmpvar_18), 0.0);
  highp float tmpvar_27;
  tmpvar_27 = pow (tmpvar_26, _Shininess);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_11.y) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_11.y) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  outColor_13.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    ))) * lightmap_11.x) * _SpecularIntensity)
   * tex_C_Color_12.xyz) + tex_C_Color_12.xyz) + rimLighting_4);
  outColor_13.xyz = (outColor_13.xyz * ramp_10);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_32;
  tmpvar_32 = mix ((_Color * _EnvColor), tmpvar_31, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_32.xyz);
  outColor_13.w = _BloomFactor;
  outColor_13.xyz = (outColor_13.xyz + (outColor_13.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_34;
  mediump vec3 reflection_35;
  mediump vec3 R_36;
  mediump float intensity_37;
  mediump vec4 noiseTex_38;
  mediump vec4 spColor_39;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_39.xyz = tmpvar_40.xyz;
  spColor_39.w = outColor_13.w;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_38 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (((1.99 * noiseTex_38.x) * _SPNoiseScaler) - 1.0);
  intensity_37 = tmpvar_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_38 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (N_3, I_44)
   * N_3)));
  R_36 = tmpvar_43;
  lowp vec3 tmpvar_45;
  tmpvar_45 = textureCube (_SPCubeMap, R_36).xyz;
  reflection_35 = tmpvar_45;
  highp vec3 tmpvar_46;
  mediump vec3 x_47;
  x_47 = (spColor_39.xyz * _SPOldColor.xyz);
  tmpvar_46 = mix (x_47, ((reflection_35 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_39.xyz = tmpvar_46;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_37 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_37 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_48;
      tmpvar_48 = mix (spColor_39, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_37) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_39 = tmpvar_48;
    };
  };
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (outColor_13.xyz, spColor_39.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_39.xyz = tmpvar_49;
  outColor_13.xyz = spColor_39.xyz;
  outColor_13.w = mix (spColor_39.w, _EmissionBloomFactor, tex_C_Color_12.w);
  highp vec4 scrpos_50;
  scrpos_50 = xlv_TEXCOORD6;
  mediump float a_51;
  a_51 = xlv_TEXCOORD6.z;
  if ((a_51 < 0.95)) {
    scrpos_50.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_51 = (a_51 * 17.0);
    highp float tmpvar_52;
    tmpvar_52 = (scrpos_50.y / 4.0);
    highp float tmpvar_53;
    tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
    highp float tmpvar_54;
    if ((tmpvar_52 >= 0.0)) {
      tmpvar_54 = tmpvar_53;
    } else {
      tmpvar_54 = -(tmpvar_53);
    };
    highp float tmpvar_55;
    tmpvar_55 = (scrpos_50.x / 4.0);
    highp float tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
    highp float tmpvar_57;
    if ((tmpvar_55 >= 0.0)) {
      tmpvar_57 = tmpvar_56;
    } else {
      tmpvar_57 = -(tmpvar_56);
    };
    highp float x_58;
    x_58 = ((a_51 - _DITHERMATRIX[
      int(tmpvar_54)
    ][
      int(tmpvar_57)
    ]) - 0.01);
    if ((x_58 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_13;
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
attribute vec4 _glesColor;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_2;
  tmpvar_10.y = d_2;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_4.xyw = o_12.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_15;
  uv_15 = tmpvar_1;
  highp vec4 spuvs_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  spuvs_16.xy = ((uv_15 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  spuvs_16.zw = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_16;
  xlv_TEXCOORD4 = (tmpvar_11.xyz / tmpvar_11.w);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD8 = _glesColor;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  mediump vec3 ramp_11;
  mediump vec4 lightmap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_12 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_18;
  viewDir_9 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize((lightDir_10 + viewDir_9));
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
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (dot (normalDir_8, tmpvar_19), 0.0);
  highp float tmpvar_28;
  tmpvar_28 = pow (tmpvar_27, _Shininess);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_12.y) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_12.y) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  outColor_14.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_31 * 
      (tmpvar_31 * (3.0 - (2.0 * tmpvar_31)))
    ))) * lightmap_12.x) * _SpecularIntensity)
   * tex_C_Color_13.xyz) + tex_C_Color_13.xyz) + rimLighting_5);
  outColor_14.xyz = (outColor_14.xyz * ramp_11);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 0.0;
  tmpvar_32.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix ((_Color * _EnvColor), tmpvar_32, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_33.xyz);
  outColor_14.w = _BloomFactor;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_35;
  mediump vec3 reflection_36;
  mediump vec3 R_37;
  mediump float intensity_38;
  mediump vec4 noiseTex_39;
  mediump vec4 spColor_40;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_40.xyz = tmpvar_41.xyz;
  spColor_40.w = outColor_14.w;
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_39 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (((1.99 * noiseTex_39.x) * _SPNoiseScaler) - 1.0);
  intensity_38 = tmpvar_43;
  highp vec3 tmpvar_44;
  highp vec3 I_45;
  I_45 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_39 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_44 = (I_45 - (2.0 * (
    dot (N_4, I_45)
   * N_4)));
  R_37 = tmpvar_44;
  lowp vec3 tmpvar_46;
  tmpvar_46 = textureCube (_SPCubeMap, R_37).xyz;
  reflection_36 = tmpvar_46;
  highp vec3 tmpvar_47;
  mediump vec3 x_48;
  x_48 = (spColor_40.xyz * _SPOldColor.xyz);
  tmpvar_47 = mix (x_48, ((reflection_36 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_40.xyz = tmpvar_47;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_38 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_38 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_49;
      tmpvar_49 = mix (spColor_40, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_38) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_40 = tmpvar_49;
    };
  };
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_14.xyz, spColor_40.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_40.xyz = tmpvar_50;
  outColor_14.xyz = spColor_40.xyz;
  outColor_14.w = mix (spColor_40.w, _EmissionBloomFactor, tex_C_Color_13.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_51;
  highp vec4 rimMask_52;
  rimMask_52 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_53;
  mediump vec4 rgColorA_54;
  mediump vec4 rgColorB_55;
  mediump vec4 rgColorG_56;
  mediump vec4 rgColorR_57;
  mediump vec4 rgColor_58;
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_59 = (_RGBias + (tmpvar_60 * _RGScale));
  mediump vec4 tmpvar_61;
  tmpvar_61 = (tmpvar_59 * _RGColor);
  highp vec4 tmpvar_62;
  tmpvar_62 = (tmpvar_61 * (1.0 - rimMask_52.x));
  rgColorR_57 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 * (1.0 - rimMask_52.y));
  rgColorG_56 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_61 * (1.0 - rimMask_52.z));
  rgColorB_55 = tmpvar_64;
  highp vec4 tmpvar_65;
  tmpvar_65 = (tmpvar_61 * (1.0 - rimMask_52.w));
  rgColorA_54 = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66 = (((
    (rgColorR_57 * _RGMaskR)
   + 
    (rgColorG_56 * _RGMaskG)
  ) + (rgColorB_55 * _RGMaskB)) + (rgColorA_54 * _RGMaskA));
  rgColorRGBA_53.xyz = tmpvar_66.xyz;
  rgColorRGBA_53.w = _RGBloomFactor;
  mediump vec4 tmpvar_67;
  tmpvar_67 = mix (outColor_14, rgColorRGBA_53, vec4(clamp ((
    (rgColorRGBA_53.x + rgColorRGBA_53.y)
   + rgColorRGBA_53.z), 0.0, 1.0)));
  highp vec4 tmpvar_68;
  tmpvar_68 = mix (tmpvar_61, tmpvar_67, vec4(_RGMaskIntensity));
  rgColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = clamp (tmpvar_59, 0.0, 1.0);
  highp vec4 tmpvar_70;
  tmpvar_70 = mix (outColor_14, rgColor_58, vec4((tmpvar_69 * _RGRatio)));
  tmpvar_51 = tmpvar_70;
  outColor_14 = tmpvar_51;
  highp vec4 scrpos_71;
  scrpos_71 = xlv_TEXCOORD6;
  mediump float a_72;
  a_72 = xlv_TEXCOORD6.z;
  if ((a_72 < 0.95)) {
    scrpos_71.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_72 = (a_72 * 17.0);
    highp float tmpvar_73;
    tmpvar_73 = (scrpos_71.y / 4.0);
    highp float tmpvar_74;
    tmpvar_74 = (fract(abs(tmpvar_73)) * 4.0);
    highp float tmpvar_75;
    if ((tmpvar_73 >= 0.0)) {
      tmpvar_75 = tmpvar_74;
    } else {
      tmpvar_75 = -(tmpvar_74);
    };
    highp float tmpvar_76;
    tmpvar_76 = (scrpos_71.x / 4.0);
    highp float tmpvar_77;
    tmpvar_77 = (fract(abs(tmpvar_76)) * 4.0);
    highp float tmpvar_78;
    if ((tmpvar_76 >= 0.0)) {
      tmpvar_78 = tmpvar_77;
    } else {
      tmpvar_78 = -(tmpvar_77);
    };
    highp float x_79;
    x_79 = ((a_72 - _DITHERMATRIX[
      int(tmpvar_75)
    ][
      int(tmpvar_78)
    ]) - 0.01);
    if ((x_79 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_51;
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
attribute vec4 _glesColor;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_2;
  tmpvar_10.y = d_2;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_4.xyw = o_12.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_15;
  uv_15 = tmpvar_1;
  highp vec4 spuvs_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  spuvs_16.xy = ((uv_15 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  spuvs_16.zw = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_16;
  xlv_TEXCOORD4 = (tmpvar_11.xyz / tmpvar_11.w);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD8 = _glesColor;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  mediump vec3 ramp_11;
  mediump vec4 lightmap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_12 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_18;
  viewDir_9 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize((lightDir_10 + viewDir_9));
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
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (dot (normalDir_8, tmpvar_19), 0.0);
  highp float tmpvar_28;
  tmpvar_28 = pow (tmpvar_27, _Shininess);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_12.y) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_12.y) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  outColor_14.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_31 * 
      (tmpvar_31 * (3.0 - (2.0 * tmpvar_31)))
    ))) * lightmap_12.x) * _SpecularIntensity)
   * tex_C_Color_13.xyz) + tex_C_Color_13.xyz) + rimLighting_5);
  outColor_14.xyz = (outColor_14.xyz * ramp_11);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 0.0;
  tmpvar_32.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix ((_Color * _EnvColor), tmpvar_32, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_33.xyz);
  outColor_14.w = _BloomFactor;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_35;
  mediump vec3 reflection_36;
  mediump vec3 R_37;
  mediump float intensity_38;
  mediump vec4 noiseTex_39;
  mediump vec4 spColor_40;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_40.xyz = tmpvar_41.xyz;
  spColor_40.w = outColor_14.w;
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_39 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (((1.99 * noiseTex_39.x) * _SPNoiseScaler) - 1.0);
  intensity_38 = tmpvar_43;
  highp vec3 tmpvar_44;
  highp vec3 I_45;
  I_45 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_39 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_44 = (I_45 - (2.0 * (
    dot (N_4, I_45)
   * N_4)));
  R_37 = tmpvar_44;
  lowp vec3 tmpvar_46;
  tmpvar_46 = textureCube (_SPCubeMap, R_37).xyz;
  reflection_36 = tmpvar_46;
  highp vec3 tmpvar_47;
  mediump vec3 x_48;
  x_48 = (spColor_40.xyz * _SPOldColor.xyz);
  tmpvar_47 = mix (x_48, ((reflection_36 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_40.xyz = tmpvar_47;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_38 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_38 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_49;
      tmpvar_49 = mix (spColor_40, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_38) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_40 = tmpvar_49;
    };
  };
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_14.xyz, spColor_40.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_40.xyz = tmpvar_50;
  outColor_14.xyz = spColor_40.xyz;
  outColor_14.w = mix (spColor_40.w, _EmissionBloomFactor, tex_C_Color_13.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_51;
  highp vec4 rimMask_52;
  rimMask_52 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_53;
  mediump vec4 rgColorA_54;
  mediump vec4 rgColorB_55;
  mediump vec4 rgColorG_56;
  mediump vec4 rgColorR_57;
  mediump vec4 rgColor_58;
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_59 = (_RGBias + (tmpvar_60 * _RGScale));
  mediump vec4 tmpvar_61;
  tmpvar_61 = (tmpvar_59 * _RGColor);
  highp vec4 tmpvar_62;
  tmpvar_62 = (tmpvar_61 * (1.0 - rimMask_52.x));
  rgColorR_57 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 * (1.0 - rimMask_52.y));
  rgColorG_56 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_61 * (1.0 - rimMask_52.z));
  rgColorB_55 = tmpvar_64;
  highp vec4 tmpvar_65;
  tmpvar_65 = (tmpvar_61 * (1.0 - rimMask_52.w));
  rgColorA_54 = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66 = (((
    (rgColorR_57 * _RGMaskR)
   + 
    (rgColorG_56 * _RGMaskG)
  ) + (rgColorB_55 * _RGMaskB)) + (rgColorA_54 * _RGMaskA));
  rgColorRGBA_53.xyz = tmpvar_66.xyz;
  rgColorRGBA_53.w = _RGBloomFactor;
  mediump vec4 tmpvar_67;
  tmpvar_67 = mix (outColor_14, rgColorRGBA_53, vec4(clamp ((
    (rgColorRGBA_53.x + rgColorRGBA_53.y)
   + rgColorRGBA_53.z), 0.0, 1.0)));
  highp vec4 tmpvar_68;
  tmpvar_68 = mix (tmpvar_61, tmpvar_67, vec4(_RGMaskIntensity));
  rgColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = clamp (tmpvar_59, 0.0, 1.0);
  highp vec4 tmpvar_70;
  tmpvar_70 = mix (outColor_14, rgColor_58, vec4((tmpvar_69 * _RGRatio)));
  tmpvar_51 = tmpvar_70;
  outColor_14 = tmpvar_51;
  highp vec4 scrpos_71;
  scrpos_71 = xlv_TEXCOORD6;
  mediump float a_72;
  a_72 = xlv_TEXCOORD6.z;
  if ((a_72 < 0.95)) {
    scrpos_71.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_72 = (a_72 * 17.0);
    highp float tmpvar_73;
    tmpvar_73 = (scrpos_71.y / 4.0);
    highp float tmpvar_74;
    tmpvar_74 = (fract(abs(tmpvar_73)) * 4.0);
    highp float tmpvar_75;
    if ((tmpvar_73 >= 0.0)) {
      tmpvar_75 = tmpvar_74;
    } else {
      tmpvar_75 = -(tmpvar_74);
    };
    highp float tmpvar_76;
    tmpvar_76 = (scrpos_71.x / 4.0);
    highp float tmpvar_77;
    tmpvar_77 = (fract(abs(tmpvar_76)) * 4.0);
    highp float tmpvar_78;
    if ((tmpvar_76 >= 0.0)) {
      tmpvar_78 = tmpvar_77;
    } else {
      tmpvar_78 = -(tmpvar_77);
    };
    highp float x_79;
    x_79 = ((a_72 - _DITHERMATRIX[
      int(tmpvar_75)
    ][
      int(tmpvar_78)
    ]) - 0.01);
    if ((x_79 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_51;
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
attribute vec4 _glesColor;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_2;
  tmpvar_10.y = d_2;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_4.xyw = o_12.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_15;
  uv_15 = tmpvar_1;
  highp vec4 spuvs_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  spuvs_16.xy = ((uv_15 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  spuvs_16.zw = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_16;
  xlv_TEXCOORD4 = (tmpvar_11.xyz / tmpvar_11.w);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD8 = _glesColor;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  mediump vec3 ramp_11;
  mediump vec4 lightmap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_12 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_18;
  viewDir_9 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize((lightDir_10 + viewDir_9));
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
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (dot (normalDir_8, tmpvar_19), 0.0);
  highp float tmpvar_28;
  tmpvar_28 = pow (tmpvar_27, _Shininess);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_12.y) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_12.y) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  outColor_14.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_31 * 
      (tmpvar_31 * (3.0 - (2.0 * tmpvar_31)))
    ))) * lightmap_12.x) * _SpecularIntensity)
   * tex_C_Color_13.xyz) + tex_C_Color_13.xyz) + rimLighting_5);
  outColor_14.xyz = (outColor_14.xyz * ramp_11);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 0.0;
  tmpvar_32.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix ((_Color * _EnvColor), tmpvar_32, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_33.xyz);
  outColor_14.w = _BloomFactor;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_35;
  mediump vec3 reflection_36;
  mediump vec3 R_37;
  mediump float intensity_38;
  mediump vec4 noiseTex_39;
  mediump vec4 spColor_40;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_40.xyz = tmpvar_41.xyz;
  spColor_40.w = outColor_14.w;
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_39 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (((1.99 * noiseTex_39.x) * _SPNoiseScaler) - 1.0);
  intensity_38 = tmpvar_43;
  highp vec3 tmpvar_44;
  highp vec3 I_45;
  I_45 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_39 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_44 = (I_45 - (2.0 * (
    dot (N_4, I_45)
   * N_4)));
  R_37 = tmpvar_44;
  lowp vec3 tmpvar_46;
  tmpvar_46 = textureCube (_SPCubeMap, R_37).xyz;
  reflection_36 = tmpvar_46;
  highp vec3 tmpvar_47;
  mediump vec3 x_48;
  x_48 = (spColor_40.xyz * _SPOldColor.xyz);
  tmpvar_47 = mix (x_48, ((reflection_36 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_40.xyz = tmpvar_47;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_38 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_38 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_49;
      tmpvar_49 = mix (spColor_40, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_38) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_40 = tmpvar_49;
    };
  };
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_14.xyz, spColor_40.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_40.xyz = tmpvar_50;
  outColor_14.xyz = spColor_40.xyz;
  outColor_14.w = mix (spColor_40.w, _EmissionBloomFactor, tex_C_Color_13.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_51;
  highp vec4 rimMask_52;
  rimMask_52 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_53;
  mediump vec4 rgColorA_54;
  mediump vec4 rgColorB_55;
  mediump vec4 rgColorG_56;
  mediump vec4 rgColorR_57;
  mediump vec4 rgColor_58;
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_59 = (_RGBias + (tmpvar_60 * _RGScale));
  mediump vec4 tmpvar_61;
  tmpvar_61 = (tmpvar_59 * _RGColor);
  highp vec4 tmpvar_62;
  tmpvar_62 = (tmpvar_61 * (1.0 - rimMask_52.x));
  rgColorR_57 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 * (1.0 - rimMask_52.y));
  rgColorG_56 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_61 * (1.0 - rimMask_52.z));
  rgColorB_55 = tmpvar_64;
  highp vec4 tmpvar_65;
  tmpvar_65 = (tmpvar_61 * (1.0 - rimMask_52.w));
  rgColorA_54 = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66 = (((
    (rgColorR_57 * _RGMaskR)
   + 
    (rgColorG_56 * _RGMaskG)
  ) + (rgColorB_55 * _RGMaskB)) + (rgColorA_54 * _RGMaskA));
  rgColorRGBA_53.xyz = tmpvar_66.xyz;
  rgColorRGBA_53.w = _RGBloomFactor;
  mediump vec4 tmpvar_67;
  tmpvar_67 = mix (outColor_14, rgColorRGBA_53, vec4(clamp ((
    (rgColorRGBA_53.x + rgColorRGBA_53.y)
   + rgColorRGBA_53.z), 0.0, 1.0)));
  highp vec4 tmpvar_68;
  tmpvar_68 = mix (tmpvar_61, tmpvar_67, vec4(_RGMaskIntensity));
  rgColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = clamp (tmpvar_59, 0.0, 1.0);
  highp vec4 tmpvar_70;
  tmpvar_70 = mix (outColor_14, rgColor_58, vec4((tmpvar_69 * _RGRatio)));
  tmpvar_51 = tmpvar_70;
  outColor_14 = tmpvar_51;
  highp vec4 scrpos_71;
  scrpos_71 = xlv_TEXCOORD6;
  mediump float a_72;
  a_72 = xlv_TEXCOORD6.z;
  if ((a_72 < 0.95)) {
    scrpos_71.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_72 = (a_72 * 17.0);
    highp float tmpvar_73;
    tmpvar_73 = (scrpos_71.y / 4.0);
    highp float tmpvar_74;
    tmpvar_74 = (fract(abs(tmpvar_73)) * 4.0);
    highp float tmpvar_75;
    if ((tmpvar_73 >= 0.0)) {
      tmpvar_75 = tmpvar_74;
    } else {
      tmpvar_75 = -(tmpvar_74);
    };
    highp float tmpvar_76;
    tmpvar_76 = (scrpos_71.x / 4.0);
    highp float tmpvar_77;
    tmpvar_77 = (fract(abs(tmpvar_76)) * 4.0);
    highp float tmpvar_78;
    if ((tmpvar_76 >= 0.0)) {
      tmpvar_78 = tmpvar_77;
    } else {
      tmpvar_78 = -(tmpvar_77);
    };
    highp float x_79;
    x_79 = ((a_72 - _DITHERMATRIX[
      int(tmpvar_75)
    ][
      int(tmpvar_78)
    ]) - 0.01);
    if ((x_79 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_51;
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
attribute vec4 _glesColor;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_4.xyw = o_13.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_16;
  uv_16 = tmpvar_1;
  highp vec4 spuvs_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (_glesVertex * 0.5);
  spuvs_17.xy = ((uv_16 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (tmpvar_18.z * tmpvar_18.z));
  tmpvar_19.y = ((tmpvar_18.y + (0.5 * tmpvar_18.z)) + ((0.5 * tmpvar_18.x) * tmpvar_18.x));
  spuvs_17.zw = ((tmpvar_19 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  mediump vec3 tmpvar_20;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 col_26;
  highp vec4 ndotl_27;
  highp vec4 lengthSq_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosX0 - tmpvar_12.x);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosY0 - tmpvar_12.y);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosZ0 - tmpvar_12.z);
  lengthSq_28 = (tmpvar_29 * tmpvar_29);
  lengthSq_28 = (lengthSq_28 + (tmpvar_30 * tmpvar_30));
  lengthSq_28 = (lengthSq_28 + (tmpvar_31 * tmpvar_31));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (lengthSq_28, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_28 = tmpvar_32;
  ndotl_27 = (tmpvar_29 * tmpvar_9.x);
  ndotl_27 = (ndotl_27 + (tmpvar_30 * tmpvar_9.y));
  ndotl_27 = (ndotl_27 + (tmpvar_31 * tmpvar_9.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_27 * inversesqrt(tmpvar_32)));
  ndotl_27 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (tmpvar_32 * lightAttenSq_25)
  ))));
  col_26 = (lightColor0_21 * tmpvar_34.x);
  col_26 = (col_26 + (lightColor1_22 * tmpvar_34.y));
  col_26 = (col_26 + (lightColor2_23 * tmpvar_34.z));
  col_26 = (col_26 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_20 = col_26;
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_17;
  xlv_TEXCOORD4 = (tmpvar_12.xyz / tmpvar_12.w);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_12.xyz));
  xlv_TEXCOORD8 = _glesColor;
  xlv_TEXCOORD9 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  mediump vec3 ramp_11;
  mediump vec4 lightmap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_12 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_18;
  viewDir_9 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize((lightDir_10 + viewDir_9));
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
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (dot (normalDir_8, tmpvar_19), 0.0);
  highp float tmpvar_28;
  tmpvar_28 = pow (tmpvar_27, _Shininess);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_12.y) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_12.y) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  outColor_14.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_31 * 
      (tmpvar_31 * (3.0 - (2.0 * tmpvar_31)))
    ))) * lightmap_12.x) * _SpecularIntensity)
   * tex_C_Color_13.xyz) + tex_C_Color_13.xyz) + rimLighting_5);
  outColor_14.xyz = (outColor_14.xyz * ramp_11);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 0.0;
  tmpvar_32.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix ((_Color * _EnvColor), tmpvar_32, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_33.xyz);
  outColor_14.w = _BloomFactor;
  outColor_14.xyz = (outColor_14.xyz + (outColor_14.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_35;
  mediump vec3 reflection_36;
  mediump vec3 R_37;
  mediump float intensity_38;
  mediump vec4 noiseTex_39;
  mediump vec4 spColor_40;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_40.xyz = tmpvar_41.xyz;
  spColor_40.w = outColor_14.w;
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_39 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (((1.99 * noiseTex_39.x) * _SPNoiseScaler) - 1.0);
  intensity_38 = tmpvar_43;
  highp vec3 tmpvar_44;
  highp vec3 I_45;
  I_45 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_39 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_44 = (I_45 - (2.0 * (
    dot (N_4, I_45)
   * N_4)));
  R_37 = tmpvar_44;
  lowp vec3 tmpvar_46;
  tmpvar_46 = textureCube (_SPCubeMap, R_37).xyz;
  reflection_36 = tmpvar_46;
  highp vec3 tmpvar_47;
  mediump vec3 x_48;
  x_48 = (spColor_40.xyz * _SPOldColor.xyz);
  tmpvar_47 = mix (x_48, ((reflection_36 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_40.xyz = tmpvar_47;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_38 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_38 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_49;
      tmpvar_49 = mix (spColor_40, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_38) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_40 = tmpvar_49;
    };
  };
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_14.xyz, spColor_40.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_40.xyz = tmpvar_50;
  outColor_14.xyz = spColor_40.xyz;
  outColor_14.w = mix (spColor_40.w, _EmissionBloomFactor, tex_C_Color_13.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_51;
  highp vec4 rimMask_52;
  rimMask_52 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_53;
  mediump vec4 rgColorA_54;
  mediump vec4 rgColorB_55;
  mediump vec4 rgColorG_56;
  mediump vec4 rgColorR_57;
  mediump vec4 rgColor_58;
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_59 = (_RGBias + (tmpvar_60 * _RGScale));
  mediump vec4 tmpvar_61;
  tmpvar_61 = (tmpvar_59 * _RGColor);
  highp vec4 tmpvar_62;
  tmpvar_62 = (tmpvar_61 * (1.0 - rimMask_52.x));
  rgColorR_57 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 * (1.0 - rimMask_52.y));
  rgColorG_56 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_61 * (1.0 - rimMask_52.z));
  rgColorB_55 = tmpvar_64;
  highp vec4 tmpvar_65;
  tmpvar_65 = (tmpvar_61 * (1.0 - rimMask_52.w));
  rgColorA_54 = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66 = (((
    (rgColorR_57 * _RGMaskR)
   + 
    (rgColorG_56 * _RGMaskG)
  ) + (rgColorB_55 * _RGMaskB)) + (rgColorA_54 * _RGMaskA));
  rgColorRGBA_53.xyz = tmpvar_66.xyz;
  rgColorRGBA_53.w = _RGBloomFactor;
  mediump vec4 tmpvar_67;
  tmpvar_67 = mix (outColor_14, rgColorRGBA_53, vec4(clamp ((
    (rgColorRGBA_53.x + rgColorRGBA_53.y)
   + rgColorRGBA_53.z), 0.0, 1.0)));
  highp vec4 tmpvar_68;
  tmpvar_68 = mix (tmpvar_61, tmpvar_67, vec4(_RGMaskIntensity));
  rgColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = clamp (tmpvar_59, 0.0, 1.0);
  highp vec4 tmpvar_70;
  tmpvar_70 = mix (outColor_14, rgColor_58, vec4((tmpvar_69 * _RGRatio)));
  tmpvar_51 = tmpvar_70;
  outColor_14 = tmpvar_51;
  highp vec4 scrpos_71;
  scrpos_71 = xlv_TEXCOORD6;
  mediump float a_72;
  a_72 = xlv_TEXCOORD6.z;
  if ((a_72 < 0.95)) {
    scrpos_71.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_72 = (a_72 * 17.0);
    highp float tmpvar_73;
    tmpvar_73 = (scrpos_71.y / 4.0);
    highp float tmpvar_74;
    tmpvar_74 = (fract(abs(tmpvar_73)) * 4.0);
    highp float tmpvar_75;
    if ((tmpvar_73 >= 0.0)) {
      tmpvar_75 = tmpvar_74;
    } else {
      tmpvar_75 = -(tmpvar_74);
    };
    highp float tmpvar_76;
    tmpvar_76 = (scrpos_71.x / 4.0);
    highp float tmpvar_77;
    tmpvar_77 = (fract(abs(tmpvar_76)) * 4.0);
    highp float tmpvar_78;
    if ((tmpvar_76 >= 0.0)) {
      tmpvar_78 = tmpvar_77;
    } else {
      tmpvar_78 = -(tmpvar_77);
    };
    highp float x_79;
    x_79 = ((a_72 - _DITHERMATRIX[
      int(tmpvar_75)
    ][
      int(tmpvar_78)
    ]) - 0.01);
    if ((x_79 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_51;
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
attribute vec4 _glesColor;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_4.xyw = o_13.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_16;
  uv_16 = tmpvar_1;
  highp vec4 spuvs_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (_glesVertex * 0.5);
  spuvs_17.xy = ((uv_16 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (tmpvar_18.z * tmpvar_18.z));
  tmpvar_19.y = ((tmpvar_18.y + (0.5 * tmpvar_18.z)) + ((0.5 * tmpvar_18.x) * tmpvar_18.x));
  spuvs_17.zw = ((tmpvar_19 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  mediump vec3 tmpvar_20;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 col_26;
  highp vec4 ndotl_27;
  highp vec4 lengthSq_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosX0 - tmpvar_12.x);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosY0 - tmpvar_12.y);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosZ0 - tmpvar_12.z);
  lengthSq_28 = (tmpvar_29 * tmpvar_29);
  lengthSq_28 = (lengthSq_28 + (tmpvar_30 * tmpvar_30));
  lengthSq_28 = (lengthSq_28 + (tmpvar_31 * tmpvar_31));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (lengthSq_28, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_28 = tmpvar_32;
  ndotl_27 = (tmpvar_29 * tmpvar_9.x);
  ndotl_27 = (ndotl_27 + (tmpvar_30 * tmpvar_9.y));
  ndotl_27 = (ndotl_27 + (tmpvar_31 * tmpvar_9.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_27 * inversesqrt(tmpvar_32)));
  ndotl_27 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (tmpvar_32 * lightAttenSq_25)
  ))));
  col_26 = (lightColor0_21 * tmpvar_34.x);
  col_26 = (col_26 + (lightColor1_22 * tmpvar_34.y));
  col_26 = (col_26 + (lightColor2_23 * tmpvar_34.z));
  col_26 = (col_26 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_20 = col_26;
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_17;
  xlv_TEXCOORD4 = (tmpvar_12.xyz / tmpvar_12.w);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_12.xyz));
  xlv_TEXCOORD8 = _glesColor;
  xlv_TEXCOORD9 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  mediump vec3 ramp_11;
  mediump vec4 lightmap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_12 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_18;
  viewDir_9 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize((lightDir_10 + viewDir_9));
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
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (dot (normalDir_8, tmpvar_19), 0.0);
  highp float tmpvar_28;
  tmpvar_28 = pow (tmpvar_27, _Shininess);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_12.y) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_12.y) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  outColor_14.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_31 * 
      (tmpvar_31 * (3.0 - (2.0 * tmpvar_31)))
    ))) * lightmap_12.x) * _SpecularIntensity)
   * tex_C_Color_13.xyz) + tex_C_Color_13.xyz) + rimLighting_5);
  outColor_14.xyz = (outColor_14.xyz * ramp_11);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 0.0;
  tmpvar_32.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix ((_Color * _EnvColor), tmpvar_32, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_33.xyz);
  outColor_14.w = _BloomFactor;
  outColor_14.xyz = (outColor_14.xyz + (outColor_14.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_35;
  mediump vec3 reflection_36;
  mediump vec3 R_37;
  mediump float intensity_38;
  mediump vec4 noiseTex_39;
  mediump vec4 spColor_40;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_40.xyz = tmpvar_41.xyz;
  spColor_40.w = outColor_14.w;
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_39 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (((1.99 * noiseTex_39.x) * _SPNoiseScaler) - 1.0);
  intensity_38 = tmpvar_43;
  highp vec3 tmpvar_44;
  highp vec3 I_45;
  I_45 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_39 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_44 = (I_45 - (2.0 * (
    dot (N_4, I_45)
   * N_4)));
  R_37 = tmpvar_44;
  lowp vec3 tmpvar_46;
  tmpvar_46 = textureCube (_SPCubeMap, R_37).xyz;
  reflection_36 = tmpvar_46;
  highp vec3 tmpvar_47;
  mediump vec3 x_48;
  x_48 = (spColor_40.xyz * _SPOldColor.xyz);
  tmpvar_47 = mix (x_48, ((reflection_36 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_40.xyz = tmpvar_47;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_38 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_38 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_49;
      tmpvar_49 = mix (spColor_40, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_38) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_40 = tmpvar_49;
    };
  };
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_14.xyz, spColor_40.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_40.xyz = tmpvar_50;
  outColor_14.xyz = spColor_40.xyz;
  outColor_14.w = mix (spColor_40.w, _EmissionBloomFactor, tex_C_Color_13.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_51;
  highp vec4 rimMask_52;
  rimMask_52 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_53;
  mediump vec4 rgColorA_54;
  mediump vec4 rgColorB_55;
  mediump vec4 rgColorG_56;
  mediump vec4 rgColorR_57;
  mediump vec4 rgColor_58;
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_59 = (_RGBias + (tmpvar_60 * _RGScale));
  mediump vec4 tmpvar_61;
  tmpvar_61 = (tmpvar_59 * _RGColor);
  highp vec4 tmpvar_62;
  tmpvar_62 = (tmpvar_61 * (1.0 - rimMask_52.x));
  rgColorR_57 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 * (1.0 - rimMask_52.y));
  rgColorG_56 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_61 * (1.0 - rimMask_52.z));
  rgColorB_55 = tmpvar_64;
  highp vec4 tmpvar_65;
  tmpvar_65 = (tmpvar_61 * (1.0 - rimMask_52.w));
  rgColorA_54 = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66 = (((
    (rgColorR_57 * _RGMaskR)
   + 
    (rgColorG_56 * _RGMaskG)
  ) + (rgColorB_55 * _RGMaskB)) + (rgColorA_54 * _RGMaskA));
  rgColorRGBA_53.xyz = tmpvar_66.xyz;
  rgColorRGBA_53.w = _RGBloomFactor;
  mediump vec4 tmpvar_67;
  tmpvar_67 = mix (outColor_14, rgColorRGBA_53, vec4(clamp ((
    (rgColorRGBA_53.x + rgColorRGBA_53.y)
   + rgColorRGBA_53.z), 0.0, 1.0)));
  highp vec4 tmpvar_68;
  tmpvar_68 = mix (tmpvar_61, tmpvar_67, vec4(_RGMaskIntensity));
  rgColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = clamp (tmpvar_59, 0.0, 1.0);
  highp vec4 tmpvar_70;
  tmpvar_70 = mix (outColor_14, rgColor_58, vec4((tmpvar_69 * _RGRatio)));
  tmpvar_51 = tmpvar_70;
  outColor_14 = tmpvar_51;
  highp vec4 scrpos_71;
  scrpos_71 = xlv_TEXCOORD6;
  mediump float a_72;
  a_72 = xlv_TEXCOORD6.z;
  if ((a_72 < 0.95)) {
    scrpos_71.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_72 = (a_72 * 17.0);
    highp float tmpvar_73;
    tmpvar_73 = (scrpos_71.y / 4.0);
    highp float tmpvar_74;
    tmpvar_74 = (fract(abs(tmpvar_73)) * 4.0);
    highp float tmpvar_75;
    if ((tmpvar_73 >= 0.0)) {
      tmpvar_75 = tmpvar_74;
    } else {
      tmpvar_75 = -(tmpvar_74);
    };
    highp float tmpvar_76;
    tmpvar_76 = (scrpos_71.x / 4.0);
    highp float tmpvar_77;
    tmpvar_77 = (fract(abs(tmpvar_76)) * 4.0);
    highp float tmpvar_78;
    if ((tmpvar_76 >= 0.0)) {
      tmpvar_78 = tmpvar_77;
    } else {
      tmpvar_78 = -(tmpvar_77);
    };
    highp float x_79;
    x_79 = ((a_72 - _DITHERMATRIX[
      int(tmpvar_75)
    ][
      int(tmpvar_78)
    ]) - 0.01);
    if ((x_79 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_51;
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
attribute vec4 _glesColor;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_4.xyw = o_13.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_16;
  uv_16 = tmpvar_1;
  highp vec4 spuvs_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (_glesVertex * 0.5);
  spuvs_17.xy = ((uv_16 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (tmpvar_18.z * tmpvar_18.z));
  tmpvar_19.y = ((tmpvar_18.y + (0.5 * tmpvar_18.z)) + ((0.5 * tmpvar_18.x) * tmpvar_18.x));
  spuvs_17.zw = ((tmpvar_19 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  mediump vec3 tmpvar_20;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 col_26;
  highp vec4 ndotl_27;
  highp vec4 lengthSq_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosX0 - tmpvar_12.x);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosY0 - tmpvar_12.y);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosZ0 - tmpvar_12.z);
  lengthSq_28 = (tmpvar_29 * tmpvar_29);
  lengthSq_28 = (lengthSq_28 + (tmpvar_30 * tmpvar_30));
  lengthSq_28 = (lengthSq_28 + (tmpvar_31 * tmpvar_31));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (lengthSq_28, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_28 = tmpvar_32;
  ndotl_27 = (tmpvar_29 * tmpvar_9.x);
  ndotl_27 = (ndotl_27 + (tmpvar_30 * tmpvar_9.y));
  ndotl_27 = (ndotl_27 + (tmpvar_31 * tmpvar_9.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_27 * inversesqrt(tmpvar_32)));
  ndotl_27 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (tmpvar_32 * lightAttenSq_25)
  ))));
  col_26 = (lightColor0_21 * tmpvar_34.x);
  col_26 = (col_26 + (lightColor1_22 * tmpvar_34.y));
  col_26 = (col_26 + (lightColor2_23 * tmpvar_34.z));
  col_26 = (col_26 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_20 = col_26;
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_17;
  xlv_TEXCOORD4 = (tmpvar_12.xyz / tmpvar_12.w);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_12.xyz));
  xlv_TEXCOORD8 = _glesColor;
  xlv_TEXCOORD9 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  mediump vec3 ramp_11;
  mediump vec4 lightmap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_12 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_18;
  viewDir_9 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize((lightDir_10 + viewDir_9));
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
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (dot (normalDir_8, tmpvar_19), 0.0);
  highp float tmpvar_28;
  tmpvar_28 = pow (tmpvar_27, _Shininess);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_12.y) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_12.y) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  outColor_14.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_31 * 
      (tmpvar_31 * (3.0 - (2.0 * tmpvar_31)))
    ))) * lightmap_12.x) * _SpecularIntensity)
   * tex_C_Color_13.xyz) + tex_C_Color_13.xyz) + rimLighting_5);
  outColor_14.xyz = (outColor_14.xyz * ramp_11);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 0.0;
  tmpvar_32.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix ((_Color * _EnvColor), tmpvar_32, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_33.xyz);
  outColor_14.w = _BloomFactor;
  outColor_14.xyz = (outColor_14.xyz + (outColor_14.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_35;
  mediump vec3 reflection_36;
  mediump vec3 R_37;
  mediump float intensity_38;
  mediump vec4 noiseTex_39;
  mediump vec4 spColor_40;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_40.xyz = tmpvar_41.xyz;
  spColor_40.w = outColor_14.w;
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_39 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (((1.99 * noiseTex_39.x) * _SPNoiseScaler) - 1.0);
  intensity_38 = tmpvar_43;
  highp vec3 tmpvar_44;
  highp vec3 I_45;
  I_45 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_39 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_44 = (I_45 - (2.0 * (
    dot (N_4, I_45)
   * N_4)));
  R_37 = tmpvar_44;
  lowp vec3 tmpvar_46;
  tmpvar_46 = textureCube (_SPCubeMap, R_37).xyz;
  reflection_36 = tmpvar_46;
  highp vec3 tmpvar_47;
  mediump vec3 x_48;
  x_48 = (spColor_40.xyz * _SPOldColor.xyz);
  tmpvar_47 = mix (x_48, ((reflection_36 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_40.xyz = tmpvar_47;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_38 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_38 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_49;
      tmpvar_49 = mix (spColor_40, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_38) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_40 = tmpvar_49;
    };
  };
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_14.xyz, spColor_40.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_40.xyz = tmpvar_50;
  outColor_14.xyz = spColor_40.xyz;
  outColor_14.w = mix (spColor_40.w, _EmissionBloomFactor, tex_C_Color_13.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_51;
  highp vec4 rimMask_52;
  rimMask_52 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_53;
  mediump vec4 rgColorA_54;
  mediump vec4 rgColorB_55;
  mediump vec4 rgColorG_56;
  mediump vec4 rgColorR_57;
  mediump vec4 rgColor_58;
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_59 = (_RGBias + (tmpvar_60 * _RGScale));
  mediump vec4 tmpvar_61;
  tmpvar_61 = (tmpvar_59 * _RGColor);
  highp vec4 tmpvar_62;
  tmpvar_62 = (tmpvar_61 * (1.0 - rimMask_52.x));
  rgColorR_57 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 * (1.0 - rimMask_52.y));
  rgColorG_56 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_61 * (1.0 - rimMask_52.z));
  rgColorB_55 = tmpvar_64;
  highp vec4 tmpvar_65;
  tmpvar_65 = (tmpvar_61 * (1.0 - rimMask_52.w));
  rgColorA_54 = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66 = (((
    (rgColorR_57 * _RGMaskR)
   + 
    (rgColorG_56 * _RGMaskG)
  ) + (rgColorB_55 * _RGMaskB)) + (rgColorA_54 * _RGMaskA));
  rgColorRGBA_53.xyz = tmpvar_66.xyz;
  rgColorRGBA_53.w = _RGBloomFactor;
  mediump vec4 tmpvar_67;
  tmpvar_67 = mix (outColor_14, rgColorRGBA_53, vec4(clamp ((
    (rgColorRGBA_53.x + rgColorRGBA_53.y)
   + rgColorRGBA_53.z), 0.0, 1.0)));
  highp vec4 tmpvar_68;
  tmpvar_68 = mix (tmpvar_61, tmpvar_67, vec4(_RGMaskIntensity));
  rgColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = clamp (tmpvar_59, 0.0, 1.0);
  highp vec4 tmpvar_70;
  tmpvar_70 = mix (outColor_14, rgColor_58, vec4((tmpvar_69 * _RGRatio)));
  tmpvar_51 = tmpvar_70;
  outColor_14 = tmpvar_51;
  highp vec4 scrpos_71;
  scrpos_71 = xlv_TEXCOORD6;
  mediump float a_72;
  a_72 = xlv_TEXCOORD6.z;
  if ((a_72 < 0.95)) {
    scrpos_71.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_72 = (a_72 * 17.0);
    highp float tmpvar_73;
    tmpvar_73 = (scrpos_71.y / 4.0);
    highp float tmpvar_74;
    tmpvar_74 = (fract(abs(tmpvar_73)) * 4.0);
    highp float tmpvar_75;
    if ((tmpvar_73 >= 0.0)) {
      tmpvar_75 = tmpvar_74;
    } else {
      tmpvar_75 = -(tmpvar_74);
    };
    highp float tmpvar_76;
    tmpvar_76 = (scrpos_71.x / 4.0);
    highp float tmpvar_77;
    tmpvar_77 = (fract(abs(tmpvar_76)) * 4.0);
    highp float tmpvar_78;
    if ((tmpvar_76 >= 0.0)) {
      tmpvar_78 = tmpvar_77;
    } else {
      tmpvar_78 = -(tmpvar_77);
    };
    highp float x_79;
    x_79 = ((a_72 - _DITHERMATRIX[
      int(tmpvar_75)
    ][
      int(tmpvar_78)
    ]) - 0.01);
    if ((x_79 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_51;
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
  LOD 600
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 124186
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
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Simple" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
  GpuProgramID 142916
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  highp float tmpvar_8;
  tmpvar_8 = ((dot (tmpvar_7, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = d_1;
  tmpvar_9.y = d_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_4.zw;
  tmpvar_3.xyw = o_10.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_8;
  mediump vec4 lightmap_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_8 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_15;
  viewDir_6 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize((lightDir_7 + viewDir_6));
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
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (dot (normalDir_5, tmpvar_16), 0.0);
  highp float tmpvar_25;
  tmpvar_25 = pow (tmpvar_24, _Shininess);
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_9.y) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_9.y) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  outColor_11.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_28 * 
      (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
    ))) * lightmap_9.x) * _SpecularIntensity)
   * tex_C_Color_10.xyz) + tex_C_Color_10.xyz) + rimLighting_2);
  outColor_11.xyz = (outColor_11.xyz * ramp_8);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix ((_Color * _EnvColor), tmpvar_29, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_30.xyz);
  outColor_11.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_10.w);
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  highp float tmpvar_8;
  tmpvar_8 = ((dot (tmpvar_7, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = d_1;
  tmpvar_9.y = d_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_4.zw;
  tmpvar_3.xyw = o_10.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_8;
  mediump vec4 lightmap_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_8 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_15;
  viewDir_6 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize((lightDir_7 + viewDir_6));
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
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (dot (normalDir_5, tmpvar_16), 0.0);
  highp float tmpvar_25;
  tmpvar_25 = pow (tmpvar_24, _Shininess);
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_9.y) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_9.y) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  outColor_11.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_28 * 
      (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
    ))) * lightmap_9.x) * _SpecularIntensity)
   * tex_C_Color_10.xyz) + tex_C_Color_10.xyz) + rimLighting_2);
  outColor_11.xyz = (outColor_11.xyz * ramp_8);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix ((_Color * _EnvColor), tmpvar_29, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_30.xyz);
  outColor_11.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_10.w);
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  highp float tmpvar_8;
  tmpvar_8 = ((dot (tmpvar_7, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = d_1;
  tmpvar_9.y = d_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_4.zw;
  tmpvar_3.xyw = o_10.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_8;
  mediump vec4 lightmap_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_8 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_15;
  viewDir_6 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize((lightDir_7 + viewDir_6));
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
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (dot (normalDir_5, tmpvar_16), 0.0);
  highp float tmpvar_25;
  tmpvar_25 = pow (tmpvar_24, _Shininess);
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_9.y) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_9.y) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  outColor_11.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_28 * 
      (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
    ))) * lightmap_9.x) * _SpecularIntensity)
   * tex_C_Color_10.xyz) + tex_C_Color_10.xyz) + rimLighting_2);
  outColor_11.xyz = (outColor_11.xyz * ramp_8);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix ((_Color * _EnvColor), tmpvar_29, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_30.xyz);
  outColor_11.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_10.w);
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_1;
  tmpvar_10.y = d_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_3.xyw = o_12.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  mediump vec3 tmpvar_15;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_15 = col_21;
  tmpvar_4 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD9 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_8;
  mediump vec4 lightmap_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_8 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_15;
  viewDir_6 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize((lightDir_7 + viewDir_6));
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
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (dot (normalDir_5, tmpvar_16), 0.0);
  highp float tmpvar_25;
  tmpvar_25 = pow (tmpvar_24, _Shininess);
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_9.y) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_9.y) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  outColor_11.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_28 * 
      (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
    ))) * lightmap_9.x) * _SpecularIntensity)
   * tex_C_Color_10.xyz) + tex_C_Color_10.xyz) + rimLighting_2);
  outColor_11.xyz = (outColor_11.xyz * ramp_8);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix ((_Color * _EnvColor), tmpvar_29, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_30.xyz);
  outColor_11.w = _BloomFactor;
  outColor_11.xyz = (outColor_11.xyz + (outColor_11.xyz * xlv_TEXCOORD9));
  outColor_11.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_10.w);
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_1;
  tmpvar_10.y = d_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_3.xyw = o_12.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  mediump vec3 tmpvar_15;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_15 = col_21;
  tmpvar_4 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD9 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_8;
  mediump vec4 lightmap_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_8 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_15;
  viewDir_6 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize((lightDir_7 + viewDir_6));
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
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (dot (normalDir_5, tmpvar_16), 0.0);
  highp float tmpvar_25;
  tmpvar_25 = pow (tmpvar_24, _Shininess);
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_9.y) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_9.y) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  outColor_11.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_28 * 
      (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
    ))) * lightmap_9.x) * _SpecularIntensity)
   * tex_C_Color_10.xyz) + tex_C_Color_10.xyz) + rimLighting_2);
  outColor_11.xyz = (outColor_11.xyz * ramp_8);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix ((_Color * _EnvColor), tmpvar_29, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_30.xyz);
  outColor_11.w = _BloomFactor;
  outColor_11.xyz = (outColor_11.xyz + (outColor_11.xyz * xlv_TEXCOORD9));
  outColor_11.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_10.w);
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Opaqueness;
uniform mediump vec4 _MainTex_ST;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_1;
  tmpvar_10.y = d_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_3.xyw = o_12.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  mediump vec3 tmpvar_15;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_15 = col_21;
  tmpvar_4 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD9 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_8;
  mediump vec4 lightmap_9;
  mediump vec4 tex_C_Color_10;
  mediump vec4 outColor_11;
  outColor_11 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_9 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_8 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_15;
  viewDir_6 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize((lightDir_7 + viewDir_6));
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
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = max (dot (normalDir_5, tmpvar_16), 0.0);
  highp float tmpvar_25;
  tmpvar_25 = pow (tmpvar_24, _Shininess);
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_9.y) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_9.y) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  outColor_11.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_28 * 
      (tmpvar_28 * (3.0 - (2.0 * tmpvar_28)))
    ))) * lightmap_9.x) * _SpecularIntensity)
   * tex_C_Color_10.xyz) + tex_C_Color_10.xyz) + rimLighting_2);
  outColor_11.xyz = (outColor_11.xyz * ramp_8);
  outColor_11.xyz = (outColor_11.xyz * _LightColor0);
  mediump vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_30;
  tmpvar_30 = mix ((_Color * _EnvColor), tmpvar_29, tex_C_Color_10.wwww);
  outColor_11.xyz = (outColor_11.xyz * tmpvar_30.xyz);
  outColor_11.w = _BloomFactor;
  outColor_11.xyz = (outColor_11.xyz + (outColor_11.xyz * xlv_TEXCOORD9));
  outColor_11.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_10.w);
  highp vec4 scrpos_31;
  scrpos_31 = xlv_TEXCOORD6;
  mediump float a_32;
  a_32 = xlv_TEXCOORD6.z;
  if ((a_32 < 0.95)) {
    scrpos_31.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
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
attribute vec4 _glesColor;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  highp float tmpvar_8;
  tmpvar_8 = ((dot (tmpvar_7, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = d_1;
  tmpvar_9.y = d_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_4.zw;
  tmpvar_3.xyw = o_10.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  xlv_TEXCOORD8 = _glesColor;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_9;
  mediump vec4 lightmap_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_16;
  viewDir_7 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize((lightDir_8 + viewDir_7));
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
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (dot (normalDir_6, tmpvar_17), 0.0);
  highp float tmpvar_26;
  tmpvar_26 = pow (tmpvar_25, _Shininess);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_10.y) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_10.y) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  outColor_12.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_29 * 
      (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
    ))) * lightmap_10.x) * _SpecularIntensity)
   * tex_C_Color_11.xyz) + tex_C_Color_11.xyz) + rimLighting_3);
  outColor_12.xyz = (outColor_12.xyz * ramp_9);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix ((_Color * _EnvColor), tmpvar_30, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_31.xyz);
  outColor_12.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_11.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_32;
  highp vec4 rimMask_33;
  rimMask_33 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_34;
  mediump vec4 rgColorA_35;
  mediump vec4 rgColorB_36;
  mediump vec4 rgColorG_37;
  mediump vec4 rgColorR_38;
  mediump vec4 rgColor_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_40 = (_RGBias + (tmpvar_41 * _RGScale));
  mediump vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_40 * _RGColor);
  highp vec4 tmpvar_43;
  tmpvar_43 = (tmpvar_42 * (1.0 - rimMask_33.x));
  rgColorR_38 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = (tmpvar_42 * (1.0 - rimMask_33.y));
  rgColorG_37 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_42 * (1.0 - rimMask_33.z));
  rgColorB_36 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_42 * (1.0 - rimMask_33.w));
  rgColorA_35 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (((
    (rgColorR_38 * _RGMaskR)
   + 
    (rgColorG_37 * _RGMaskG)
  ) + (rgColorB_36 * _RGMaskB)) + (rgColorA_35 * _RGMaskA));
  rgColorRGBA_34.xyz = tmpvar_47.xyz;
  rgColorRGBA_34.w = _RGBloomFactor;
  mediump vec4 tmpvar_48;
  tmpvar_48 = mix (outColor_12, rgColorRGBA_34, vec4(clamp ((
    (rgColorRGBA_34.x + rgColorRGBA_34.y)
   + rgColorRGBA_34.z), 0.0, 1.0)));
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_42, tmpvar_48, vec4(_RGMaskIntensity));
  rgColor_39 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (tmpvar_40, 0.0, 1.0);
  highp vec4 tmpvar_51;
  tmpvar_51 = mix (outColor_12, rgColor_39, vec4((tmpvar_50 * _RGRatio)));
  tmpvar_32 = tmpvar_51;
  outColor_12 = tmpvar_32;
  highp vec4 scrpos_52;
  scrpos_52 = xlv_TEXCOORD6;
  mediump float a_53;
  a_53 = xlv_TEXCOORD6.z;
  if ((a_53 < 0.95)) {
    scrpos_52.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_53 = (a_53 * 17.0);
    highp float tmpvar_54;
    tmpvar_54 = (scrpos_52.y / 4.0);
    highp float tmpvar_55;
    tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
    highp float tmpvar_56;
    if ((tmpvar_54 >= 0.0)) {
      tmpvar_56 = tmpvar_55;
    } else {
      tmpvar_56 = -(tmpvar_55);
    };
    highp float tmpvar_57;
    tmpvar_57 = (scrpos_52.x / 4.0);
    highp float tmpvar_58;
    tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
    highp float tmpvar_59;
    if ((tmpvar_57 >= 0.0)) {
      tmpvar_59 = tmpvar_58;
    } else {
      tmpvar_59 = -(tmpvar_58);
    };
    highp float x_60;
    x_60 = ((a_53 - _DITHERMATRIX[
      int(tmpvar_56)
    ][
      int(tmpvar_59)
    ]) - 0.01);
    if ((x_60 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_32;
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
attribute vec4 _glesColor;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  highp float tmpvar_8;
  tmpvar_8 = ((dot (tmpvar_7, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = d_1;
  tmpvar_9.y = d_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_4.zw;
  tmpvar_3.xyw = o_10.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  xlv_TEXCOORD8 = _glesColor;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_9;
  mediump vec4 lightmap_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_16;
  viewDir_7 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize((lightDir_8 + viewDir_7));
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
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (dot (normalDir_6, tmpvar_17), 0.0);
  highp float tmpvar_26;
  tmpvar_26 = pow (tmpvar_25, _Shininess);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_10.y) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_10.y) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  outColor_12.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_29 * 
      (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
    ))) * lightmap_10.x) * _SpecularIntensity)
   * tex_C_Color_11.xyz) + tex_C_Color_11.xyz) + rimLighting_3);
  outColor_12.xyz = (outColor_12.xyz * ramp_9);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix ((_Color * _EnvColor), tmpvar_30, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_31.xyz);
  outColor_12.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_11.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_32;
  highp vec4 rimMask_33;
  rimMask_33 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_34;
  mediump vec4 rgColorA_35;
  mediump vec4 rgColorB_36;
  mediump vec4 rgColorG_37;
  mediump vec4 rgColorR_38;
  mediump vec4 rgColor_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_40 = (_RGBias + (tmpvar_41 * _RGScale));
  mediump vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_40 * _RGColor);
  highp vec4 tmpvar_43;
  tmpvar_43 = (tmpvar_42 * (1.0 - rimMask_33.x));
  rgColorR_38 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = (tmpvar_42 * (1.0 - rimMask_33.y));
  rgColorG_37 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_42 * (1.0 - rimMask_33.z));
  rgColorB_36 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_42 * (1.0 - rimMask_33.w));
  rgColorA_35 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (((
    (rgColorR_38 * _RGMaskR)
   + 
    (rgColorG_37 * _RGMaskG)
  ) + (rgColorB_36 * _RGMaskB)) + (rgColorA_35 * _RGMaskA));
  rgColorRGBA_34.xyz = tmpvar_47.xyz;
  rgColorRGBA_34.w = _RGBloomFactor;
  mediump vec4 tmpvar_48;
  tmpvar_48 = mix (outColor_12, rgColorRGBA_34, vec4(clamp ((
    (rgColorRGBA_34.x + rgColorRGBA_34.y)
   + rgColorRGBA_34.z), 0.0, 1.0)));
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_42, tmpvar_48, vec4(_RGMaskIntensity));
  rgColor_39 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (tmpvar_40, 0.0, 1.0);
  highp vec4 tmpvar_51;
  tmpvar_51 = mix (outColor_12, rgColor_39, vec4((tmpvar_50 * _RGRatio)));
  tmpvar_32 = tmpvar_51;
  outColor_12 = tmpvar_32;
  highp vec4 scrpos_52;
  scrpos_52 = xlv_TEXCOORD6;
  mediump float a_53;
  a_53 = xlv_TEXCOORD6.z;
  if ((a_53 < 0.95)) {
    scrpos_52.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_53 = (a_53 * 17.0);
    highp float tmpvar_54;
    tmpvar_54 = (scrpos_52.y / 4.0);
    highp float tmpvar_55;
    tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
    highp float tmpvar_56;
    if ((tmpvar_54 >= 0.0)) {
      tmpvar_56 = tmpvar_55;
    } else {
      tmpvar_56 = -(tmpvar_55);
    };
    highp float tmpvar_57;
    tmpvar_57 = (scrpos_52.x / 4.0);
    highp float tmpvar_58;
    tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
    highp float tmpvar_59;
    if ((tmpvar_57 >= 0.0)) {
      tmpvar_59 = tmpvar_58;
    } else {
      tmpvar_59 = -(tmpvar_58);
    };
    highp float x_60;
    x_60 = ((a_53 - _DITHERMATRIX[
      int(tmpvar_56)
    ][
      int(tmpvar_59)
    ]) - 0.01);
    if ((x_60 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_32;
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
attribute vec4 _glesColor;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(normalize((_glesNormal * tmpvar_6)));
  highp float tmpvar_8;
  tmpvar_8 = ((dot (tmpvar_7, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_8;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = d_1;
  tmpvar_9.y = d_1;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_4.zw;
  tmpvar_3.xyw = o_10.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  xlv_TEXCOORD8 = _glesColor;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_9;
  mediump vec4 lightmap_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_16;
  viewDir_7 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize((lightDir_8 + viewDir_7));
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
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (dot (normalDir_6, tmpvar_17), 0.0);
  highp float tmpvar_26;
  tmpvar_26 = pow (tmpvar_25, _Shininess);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_10.y) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_10.y) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  outColor_12.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_29 * 
      (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
    ))) * lightmap_10.x) * _SpecularIntensity)
   * tex_C_Color_11.xyz) + tex_C_Color_11.xyz) + rimLighting_3);
  outColor_12.xyz = (outColor_12.xyz * ramp_9);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix ((_Color * _EnvColor), tmpvar_30, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_31.xyz);
  outColor_12.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_11.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_32;
  highp vec4 rimMask_33;
  rimMask_33 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_34;
  mediump vec4 rgColorA_35;
  mediump vec4 rgColorB_36;
  mediump vec4 rgColorG_37;
  mediump vec4 rgColorR_38;
  mediump vec4 rgColor_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_40 = (_RGBias + (tmpvar_41 * _RGScale));
  mediump vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_40 * _RGColor);
  highp vec4 tmpvar_43;
  tmpvar_43 = (tmpvar_42 * (1.0 - rimMask_33.x));
  rgColorR_38 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = (tmpvar_42 * (1.0 - rimMask_33.y));
  rgColorG_37 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_42 * (1.0 - rimMask_33.z));
  rgColorB_36 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_42 * (1.0 - rimMask_33.w));
  rgColorA_35 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (((
    (rgColorR_38 * _RGMaskR)
   + 
    (rgColorG_37 * _RGMaskG)
  ) + (rgColorB_36 * _RGMaskB)) + (rgColorA_35 * _RGMaskA));
  rgColorRGBA_34.xyz = tmpvar_47.xyz;
  rgColorRGBA_34.w = _RGBloomFactor;
  mediump vec4 tmpvar_48;
  tmpvar_48 = mix (outColor_12, rgColorRGBA_34, vec4(clamp ((
    (rgColorRGBA_34.x + rgColorRGBA_34.y)
   + rgColorRGBA_34.z), 0.0, 1.0)));
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_42, tmpvar_48, vec4(_RGMaskIntensity));
  rgColor_39 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (tmpvar_40, 0.0, 1.0);
  highp vec4 tmpvar_51;
  tmpvar_51 = mix (outColor_12, rgColor_39, vec4((tmpvar_50 * _RGRatio)));
  tmpvar_32 = tmpvar_51;
  outColor_12 = tmpvar_32;
  highp vec4 scrpos_52;
  scrpos_52 = xlv_TEXCOORD6;
  mediump float a_53;
  a_53 = xlv_TEXCOORD6.z;
  if ((a_53 < 0.95)) {
    scrpos_52.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_53 = (a_53 * 17.0);
    highp float tmpvar_54;
    tmpvar_54 = (scrpos_52.y / 4.0);
    highp float tmpvar_55;
    tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
    highp float tmpvar_56;
    if ((tmpvar_54 >= 0.0)) {
      tmpvar_56 = tmpvar_55;
    } else {
      tmpvar_56 = -(tmpvar_55);
    };
    highp float tmpvar_57;
    tmpvar_57 = (scrpos_52.x / 4.0);
    highp float tmpvar_58;
    tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
    highp float tmpvar_59;
    if ((tmpvar_57 >= 0.0)) {
      tmpvar_59 = tmpvar_58;
    } else {
      tmpvar_59 = -(tmpvar_58);
    };
    highp float x_60;
    x_60 = ((a_53 - _DITHERMATRIX[
      int(tmpvar_56)
    ][
      int(tmpvar_59)
    ]) - 0.01);
    if ((x_60 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_32;
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
attribute vec4 _glesColor;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_1;
  tmpvar_10.y = d_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_3.xyw = o_12.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  mediump vec3 tmpvar_15;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_15 = col_21;
  tmpvar_4 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD8 = _glesColor;
  xlv_TEXCOORD9 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_9;
  mediump vec4 lightmap_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_16;
  viewDir_7 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize((lightDir_8 + viewDir_7));
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
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (dot (normalDir_6, tmpvar_17), 0.0);
  highp float tmpvar_26;
  tmpvar_26 = pow (tmpvar_25, _Shininess);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_10.y) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_10.y) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  outColor_12.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_29 * 
      (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
    ))) * lightmap_10.x) * _SpecularIntensity)
   * tex_C_Color_11.xyz) + tex_C_Color_11.xyz) + rimLighting_3);
  outColor_12.xyz = (outColor_12.xyz * ramp_9);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix ((_Color * _EnvColor), tmpvar_30, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_31.xyz);
  outColor_12.w = _BloomFactor;
  outColor_12.xyz = (outColor_12.xyz + (outColor_12.xyz * xlv_TEXCOORD9));
  outColor_12.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_11.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_32;
  highp vec4 rimMask_33;
  rimMask_33 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_34;
  mediump vec4 rgColorA_35;
  mediump vec4 rgColorB_36;
  mediump vec4 rgColorG_37;
  mediump vec4 rgColorR_38;
  mediump vec4 rgColor_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_40 = (_RGBias + (tmpvar_41 * _RGScale));
  mediump vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_40 * _RGColor);
  highp vec4 tmpvar_43;
  tmpvar_43 = (tmpvar_42 * (1.0 - rimMask_33.x));
  rgColorR_38 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = (tmpvar_42 * (1.0 - rimMask_33.y));
  rgColorG_37 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_42 * (1.0 - rimMask_33.z));
  rgColorB_36 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_42 * (1.0 - rimMask_33.w));
  rgColorA_35 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (((
    (rgColorR_38 * _RGMaskR)
   + 
    (rgColorG_37 * _RGMaskG)
  ) + (rgColorB_36 * _RGMaskB)) + (rgColorA_35 * _RGMaskA));
  rgColorRGBA_34.xyz = tmpvar_47.xyz;
  rgColorRGBA_34.w = _RGBloomFactor;
  mediump vec4 tmpvar_48;
  tmpvar_48 = mix (outColor_12, rgColorRGBA_34, vec4(clamp ((
    (rgColorRGBA_34.x + rgColorRGBA_34.y)
   + rgColorRGBA_34.z), 0.0, 1.0)));
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_42, tmpvar_48, vec4(_RGMaskIntensity));
  rgColor_39 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (tmpvar_40, 0.0, 1.0);
  highp vec4 tmpvar_51;
  tmpvar_51 = mix (outColor_12, rgColor_39, vec4((tmpvar_50 * _RGRatio)));
  tmpvar_32 = tmpvar_51;
  outColor_12 = tmpvar_32;
  highp vec4 scrpos_52;
  scrpos_52 = xlv_TEXCOORD6;
  mediump float a_53;
  a_53 = xlv_TEXCOORD6.z;
  if ((a_53 < 0.95)) {
    scrpos_52.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_53 = (a_53 * 17.0);
    highp float tmpvar_54;
    tmpvar_54 = (scrpos_52.y / 4.0);
    highp float tmpvar_55;
    tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
    highp float tmpvar_56;
    if ((tmpvar_54 >= 0.0)) {
      tmpvar_56 = tmpvar_55;
    } else {
      tmpvar_56 = -(tmpvar_55);
    };
    highp float tmpvar_57;
    tmpvar_57 = (scrpos_52.x / 4.0);
    highp float tmpvar_58;
    tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
    highp float tmpvar_59;
    if ((tmpvar_57 >= 0.0)) {
      tmpvar_59 = tmpvar_58;
    } else {
      tmpvar_59 = -(tmpvar_58);
    };
    highp float x_60;
    x_60 = ((a_53 - _DITHERMATRIX[
      int(tmpvar_56)
    ][
      int(tmpvar_59)
    ]) - 0.01);
    if ((x_60 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_32;
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
attribute vec4 _glesColor;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_1;
  tmpvar_10.y = d_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_3.xyw = o_12.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  mediump vec3 tmpvar_15;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_15 = col_21;
  tmpvar_4 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD8 = _glesColor;
  xlv_TEXCOORD9 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_9;
  mediump vec4 lightmap_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_16;
  viewDir_7 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize((lightDir_8 + viewDir_7));
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
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (dot (normalDir_6, tmpvar_17), 0.0);
  highp float tmpvar_26;
  tmpvar_26 = pow (tmpvar_25, _Shininess);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_10.y) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_10.y) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  outColor_12.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_29 * 
      (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
    ))) * lightmap_10.x) * _SpecularIntensity)
   * tex_C_Color_11.xyz) + tex_C_Color_11.xyz) + rimLighting_3);
  outColor_12.xyz = (outColor_12.xyz * ramp_9);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix ((_Color * _EnvColor), tmpvar_30, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_31.xyz);
  outColor_12.w = _BloomFactor;
  outColor_12.xyz = (outColor_12.xyz + (outColor_12.xyz * xlv_TEXCOORD9));
  outColor_12.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_11.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_32;
  highp vec4 rimMask_33;
  rimMask_33 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_34;
  mediump vec4 rgColorA_35;
  mediump vec4 rgColorB_36;
  mediump vec4 rgColorG_37;
  mediump vec4 rgColorR_38;
  mediump vec4 rgColor_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_40 = (_RGBias + (tmpvar_41 * _RGScale));
  mediump vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_40 * _RGColor);
  highp vec4 tmpvar_43;
  tmpvar_43 = (tmpvar_42 * (1.0 - rimMask_33.x));
  rgColorR_38 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = (tmpvar_42 * (1.0 - rimMask_33.y));
  rgColorG_37 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_42 * (1.0 - rimMask_33.z));
  rgColorB_36 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_42 * (1.0 - rimMask_33.w));
  rgColorA_35 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (((
    (rgColorR_38 * _RGMaskR)
   + 
    (rgColorG_37 * _RGMaskG)
  ) + (rgColorB_36 * _RGMaskB)) + (rgColorA_35 * _RGMaskA));
  rgColorRGBA_34.xyz = tmpvar_47.xyz;
  rgColorRGBA_34.w = _RGBloomFactor;
  mediump vec4 tmpvar_48;
  tmpvar_48 = mix (outColor_12, rgColorRGBA_34, vec4(clamp ((
    (rgColorRGBA_34.x + rgColorRGBA_34.y)
   + rgColorRGBA_34.z), 0.0, 1.0)));
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_42, tmpvar_48, vec4(_RGMaskIntensity));
  rgColor_39 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (tmpvar_40, 0.0, 1.0);
  highp vec4 tmpvar_51;
  tmpvar_51 = mix (outColor_12, rgColor_39, vec4((tmpvar_50 * _RGRatio)));
  tmpvar_32 = tmpvar_51;
  outColor_12 = tmpvar_32;
  highp vec4 scrpos_52;
  scrpos_52 = xlv_TEXCOORD6;
  mediump float a_53;
  a_53 = xlv_TEXCOORD6.z;
  if ((a_53 < 0.95)) {
    scrpos_52.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_53 = (a_53 * 17.0);
    highp float tmpvar_54;
    tmpvar_54 = (scrpos_52.y / 4.0);
    highp float tmpvar_55;
    tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
    highp float tmpvar_56;
    if ((tmpvar_54 >= 0.0)) {
      tmpvar_56 = tmpvar_55;
    } else {
      tmpvar_56 = -(tmpvar_55);
    };
    highp float tmpvar_57;
    tmpvar_57 = (scrpos_52.x / 4.0);
    highp float tmpvar_58;
    tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
    highp float tmpvar_59;
    if ((tmpvar_57 >= 0.0)) {
      tmpvar_59 = tmpvar_58;
    } else {
      tmpvar_59 = -(tmpvar_58);
    };
    highp float x_60;
    x_60 = ((a_53 - _DITHERMATRIX[
      int(tmpvar_56)
    ][
      int(tmpvar_59)
    ]) - 0.01);
    if ((x_60 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_32;
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
attribute vec4 _glesColor;
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
  mediump float d_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_2.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_1 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_1;
  tmpvar_10.y = d_1;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_3.xyw = o_12.xyw;
  tmpvar_3.z = _DitherAlpha;
  tmpvar_2.w = _Opaqueness;
  mediump vec3 tmpvar_15;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 col_21;
  highp vec4 ndotl_22;
  highp vec4 lengthSq_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_23 = (tmpvar_24 * tmpvar_24);
  lengthSq_23 = (lengthSq_23 + (tmpvar_25 * tmpvar_25));
  lengthSq_23 = (lengthSq_23 + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (lengthSq_23, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_23 = tmpvar_27;
  ndotl_22 = (tmpvar_24 * tmpvar_8.x);
  ndotl_22 = (ndotl_22 + (tmpvar_25 * tmpvar_8.y));
  ndotl_22 = (ndotl_22 + (tmpvar_26 * tmpvar_8.z));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_22 * inversesqrt(tmpvar_27)));
  ndotl_22 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (1.0/((1.0 + 
    (tmpvar_27 * lightAttenSq_20)
  ))));
  col_21 = (lightColor0_16 * tmpvar_29.x);
  col_21 = (col_21 + (lightColor1_17 * tmpvar_29.y));
  col_21 = (col_21 + (lightColor2_18 * tmpvar_29.z));
  col_21 = (col_21 + (lightColor3_19 * tmpvar_29.w));
  tmpvar_15 = col_21;
  tmpvar_4 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_3;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD8 = _glesColor;
  xlv_TEXCOORD9 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _RGColor;
uniform highp float _RGShininess;
uniform highp float _RGScale;
uniform highp float _RGBias;
uniform highp float _RGRatio;
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  mediump vec3 ramp_9;
  mediump vec4 lightmap_10;
  mediump vec4 tex_C_Color_11;
  mediump vec4 outColor_12;
  outColor_12 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_11 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_10 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_9 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_16;
  viewDir_7 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize((lightDir_8 + viewDir_7));
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
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (dot (normalDir_6, tmpvar_17), 0.0);
  highp float tmpvar_26;
  tmpvar_26 = pow (tmpvar_25, _Shininess);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_10.y) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_10.y) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  outColor_12.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_29 * 
      (tmpvar_29 * (3.0 - (2.0 * tmpvar_29)))
    ))) * lightmap_10.x) * _SpecularIntensity)
   * tex_C_Color_11.xyz) + tex_C_Color_11.xyz) + rimLighting_3);
  outColor_12.xyz = (outColor_12.xyz * ramp_9);
  outColor_12.xyz = (outColor_12.xyz * _LightColor0);
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix ((_Color * _EnvColor), tmpvar_30, tex_C_Color_11.wwww);
  outColor_12.xyz = (outColor_12.xyz * tmpvar_31.xyz);
  outColor_12.w = _BloomFactor;
  outColor_12.xyz = (outColor_12.xyz + (outColor_12.xyz * xlv_TEXCOORD9));
  outColor_12.w = mix (_BloomFactor, _EmissionBloomFactor, tex_C_Color_11.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_32;
  highp vec4 rimMask_33;
  rimMask_33 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_34;
  mediump vec4 rgColorA_35;
  mediump vec4 rgColorB_36;
  mediump vec4 rgColorG_37;
  mediump vec4 rgColorR_38;
  mediump vec4 rgColor_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_40 = (_RGBias + (tmpvar_41 * _RGScale));
  mediump vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_40 * _RGColor);
  highp vec4 tmpvar_43;
  tmpvar_43 = (tmpvar_42 * (1.0 - rimMask_33.x));
  rgColorR_38 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44 = (tmpvar_42 * (1.0 - rimMask_33.y));
  rgColorG_37 = tmpvar_44;
  highp vec4 tmpvar_45;
  tmpvar_45 = (tmpvar_42 * (1.0 - rimMask_33.z));
  rgColorB_36 = tmpvar_45;
  highp vec4 tmpvar_46;
  tmpvar_46 = (tmpvar_42 * (1.0 - rimMask_33.w));
  rgColorA_35 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (((
    (rgColorR_38 * _RGMaskR)
   + 
    (rgColorG_37 * _RGMaskG)
  ) + (rgColorB_36 * _RGMaskB)) + (rgColorA_35 * _RGMaskA));
  rgColorRGBA_34.xyz = tmpvar_47.xyz;
  rgColorRGBA_34.w = _RGBloomFactor;
  mediump vec4 tmpvar_48;
  tmpvar_48 = mix (outColor_12, rgColorRGBA_34, vec4(clamp ((
    (rgColorRGBA_34.x + rgColorRGBA_34.y)
   + rgColorRGBA_34.z), 0.0, 1.0)));
  highp vec4 tmpvar_49;
  tmpvar_49 = mix (tmpvar_42, tmpvar_48, vec4(_RGMaskIntensity));
  rgColor_39 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = clamp (tmpvar_40, 0.0, 1.0);
  highp vec4 tmpvar_51;
  tmpvar_51 = mix (outColor_12, rgColor_39, vec4((tmpvar_50 * _RGRatio)));
  tmpvar_32 = tmpvar_51;
  outColor_12 = tmpvar_32;
  highp vec4 scrpos_52;
  scrpos_52 = xlv_TEXCOORD6;
  mediump float a_53;
  a_53 = xlv_TEXCOORD6.z;
  if ((a_53 < 0.95)) {
    scrpos_52.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_53 = (a_53 * 17.0);
    highp float tmpvar_54;
    tmpvar_54 = (scrpos_52.y / 4.0);
    highp float tmpvar_55;
    tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
    highp float tmpvar_56;
    if ((tmpvar_54 >= 0.0)) {
      tmpvar_56 = tmpvar_55;
    } else {
      tmpvar_56 = -(tmpvar_55);
    };
    highp float tmpvar_57;
    tmpvar_57 = (scrpos_52.x / 4.0);
    highp float tmpvar_58;
    tmpvar_58 = (fract(abs(tmpvar_57)) * 4.0);
    highp float tmpvar_59;
    if ((tmpvar_57 >= 0.0)) {
      tmpvar_59 = tmpvar_58;
    } else {
      tmpvar_59 = -(tmpvar_58);
    };
    highp float x_60;
    x_60 = ((a_53 - _DITHERMATRIX[
      int(tmpvar_56)
    ][
      int(tmpvar_59)
    ]) - 0.01);
    if ((x_60 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_32;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_2;
  tmpvar_10.y = d_2;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_4.xyw = o_12.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_15;
  uv_15 = tmpvar_1;
  highp vec4 spuvs_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  spuvs_16.xy = ((uv_15 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  spuvs_16.zw = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_16;
  xlv_TEXCOORD4 = (tmpvar_11.xyz / tmpvar_11.w);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 ramp_10;
  mediump vec4 lightmap_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_11 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_17;
  viewDir_8 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_9 + viewDir_8));
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
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (dot (normalDir_7, tmpvar_18), 0.0);
  highp float tmpvar_27;
  tmpvar_27 = pow (tmpvar_26, _Shininess);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_11.y) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_11.y) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  outColor_13.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    ))) * lightmap_11.x) * _SpecularIntensity)
   * tex_C_Color_12.xyz) + tex_C_Color_12.xyz) + rimLighting_4);
  outColor_13.xyz = (outColor_13.xyz * ramp_10);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_32;
  tmpvar_32 = mix ((_Color * _EnvColor), tmpvar_31, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_32.xyz);
  outColor_13.w = _BloomFactor;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_34;
  mediump vec3 reflection_35;
  mediump vec3 R_36;
  mediump float intensity_37;
  mediump vec4 noiseTex_38;
  mediump vec4 spColor_39;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_39.xyz = tmpvar_40.xyz;
  spColor_39.w = outColor_13.w;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_38 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (((1.99 * noiseTex_38.x) * _SPNoiseScaler) - 1.0);
  intensity_37 = tmpvar_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_38 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (N_3, I_44)
   * N_3)));
  R_36 = tmpvar_43;
  lowp vec3 tmpvar_45;
  tmpvar_45 = textureCube (_SPCubeMap, R_36).xyz;
  reflection_35 = tmpvar_45;
  highp vec3 tmpvar_46;
  mediump vec3 x_47;
  x_47 = (spColor_39.xyz * _SPOldColor.xyz);
  tmpvar_46 = mix (x_47, ((reflection_35 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_39.xyz = tmpvar_46;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_37 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_37 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_48;
      tmpvar_48 = mix (spColor_39, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_37) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_39 = tmpvar_48;
    };
  };
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (outColor_13.xyz, spColor_39.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_39.xyz = tmpvar_49;
  outColor_13.xyz = spColor_39.xyz;
  outColor_13.w = mix (spColor_39.w, _EmissionBloomFactor, tex_C_Color_12.w);
  highp vec4 scrpos_50;
  scrpos_50 = xlv_TEXCOORD6;
  mediump float a_51;
  a_51 = xlv_TEXCOORD6.z;
  if ((a_51 < 0.95)) {
    scrpos_50.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_51 = (a_51 * 17.0);
    highp float tmpvar_52;
    tmpvar_52 = (scrpos_50.y / 4.0);
    highp float tmpvar_53;
    tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
    highp float tmpvar_54;
    if ((tmpvar_52 >= 0.0)) {
      tmpvar_54 = tmpvar_53;
    } else {
      tmpvar_54 = -(tmpvar_53);
    };
    highp float tmpvar_55;
    tmpvar_55 = (scrpos_50.x / 4.0);
    highp float tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
    highp float tmpvar_57;
    if ((tmpvar_55 >= 0.0)) {
      tmpvar_57 = tmpvar_56;
    } else {
      tmpvar_57 = -(tmpvar_56);
    };
    highp float x_58;
    x_58 = ((a_51 - _DITHERMATRIX[
      int(tmpvar_54)
    ][
      int(tmpvar_57)
    ]) - 0.01);
    if ((x_58 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_13;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_2;
  tmpvar_10.y = d_2;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_4.xyw = o_12.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_15;
  uv_15 = tmpvar_1;
  highp vec4 spuvs_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  spuvs_16.xy = ((uv_15 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  spuvs_16.zw = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_16;
  xlv_TEXCOORD4 = (tmpvar_11.xyz / tmpvar_11.w);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 ramp_10;
  mediump vec4 lightmap_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_11 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_17;
  viewDir_8 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_9 + viewDir_8));
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
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (dot (normalDir_7, tmpvar_18), 0.0);
  highp float tmpvar_27;
  tmpvar_27 = pow (tmpvar_26, _Shininess);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_11.y) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_11.y) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  outColor_13.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    ))) * lightmap_11.x) * _SpecularIntensity)
   * tex_C_Color_12.xyz) + tex_C_Color_12.xyz) + rimLighting_4);
  outColor_13.xyz = (outColor_13.xyz * ramp_10);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_32;
  tmpvar_32 = mix ((_Color * _EnvColor), tmpvar_31, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_32.xyz);
  outColor_13.w = _BloomFactor;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_34;
  mediump vec3 reflection_35;
  mediump vec3 R_36;
  mediump float intensity_37;
  mediump vec4 noiseTex_38;
  mediump vec4 spColor_39;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_39.xyz = tmpvar_40.xyz;
  spColor_39.w = outColor_13.w;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_38 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (((1.99 * noiseTex_38.x) * _SPNoiseScaler) - 1.0);
  intensity_37 = tmpvar_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_38 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (N_3, I_44)
   * N_3)));
  R_36 = tmpvar_43;
  lowp vec3 tmpvar_45;
  tmpvar_45 = textureCube (_SPCubeMap, R_36).xyz;
  reflection_35 = tmpvar_45;
  highp vec3 tmpvar_46;
  mediump vec3 x_47;
  x_47 = (spColor_39.xyz * _SPOldColor.xyz);
  tmpvar_46 = mix (x_47, ((reflection_35 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_39.xyz = tmpvar_46;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_37 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_37 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_48;
      tmpvar_48 = mix (spColor_39, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_37) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_39 = tmpvar_48;
    };
  };
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (outColor_13.xyz, spColor_39.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_39.xyz = tmpvar_49;
  outColor_13.xyz = spColor_39.xyz;
  outColor_13.w = mix (spColor_39.w, _EmissionBloomFactor, tex_C_Color_12.w);
  highp vec4 scrpos_50;
  scrpos_50 = xlv_TEXCOORD6;
  mediump float a_51;
  a_51 = xlv_TEXCOORD6.z;
  if ((a_51 < 0.95)) {
    scrpos_50.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_51 = (a_51 * 17.0);
    highp float tmpvar_52;
    tmpvar_52 = (scrpos_50.y / 4.0);
    highp float tmpvar_53;
    tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
    highp float tmpvar_54;
    if ((tmpvar_52 >= 0.0)) {
      tmpvar_54 = tmpvar_53;
    } else {
      tmpvar_54 = -(tmpvar_53);
    };
    highp float tmpvar_55;
    tmpvar_55 = (scrpos_50.x / 4.0);
    highp float tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
    highp float tmpvar_57;
    if ((tmpvar_55 >= 0.0)) {
      tmpvar_57 = tmpvar_56;
    } else {
      tmpvar_57 = -(tmpvar_56);
    };
    highp float x_58;
    x_58 = ((a_51 - _DITHERMATRIX[
      int(tmpvar_54)
    ][
      int(tmpvar_57)
    ]) - 0.01);
    if ((x_58 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_13;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_2;
  tmpvar_10.y = d_2;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_4.xyw = o_12.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_15;
  uv_15 = tmpvar_1;
  highp vec4 spuvs_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  spuvs_16.xy = ((uv_15 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  spuvs_16.zw = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_16;
  xlv_TEXCOORD4 = (tmpvar_11.xyz / tmpvar_11.w);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 ramp_10;
  mediump vec4 lightmap_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_11 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_17;
  viewDir_8 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_9 + viewDir_8));
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
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (dot (normalDir_7, tmpvar_18), 0.0);
  highp float tmpvar_27;
  tmpvar_27 = pow (tmpvar_26, _Shininess);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_11.y) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_11.y) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  outColor_13.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    ))) * lightmap_11.x) * _SpecularIntensity)
   * tex_C_Color_12.xyz) + tex_C_Color_12.xyz) + rimLighting_4);
  outColor_13.xyz = (outColor_13.xyz * ramp_10);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_32;
  tmpvar_32 = mix ((_Color * _EnvColor), tmpvar_31, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_32.xyz);
  outColor_13.w = _BloomFactor;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_34;
  mediump vec3 reflection_35;
  mediump vec3 R_36;
  mediump float intensity_37;
  mediump vec4 noiseTex_38;
  mediump vec4 spColor_39;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_39.xyz = tmpvar_40.xyz;
  spColor_39.w = outColor_13.w;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_38 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (((1.99 * noiseTex_38.x) * _SPNoiseScaler) - 1.0);
  intensity_37 = tmpvar_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_38 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (N_3, I_44)
   * N_3)));
  R_36 = tmpvar_43;
  lowp vec3 tmpvar_45;
  tmpvar_45 = textureCube (_SPCubeMap, R_36).xyz;
  reflection_35 = tmpvar_45;
  highp vec3 tmpvar_46;
  mediump vec3 x_47;
  x_47 = (spColor_39.xyz * _SPOldColor.xyz);
  tmpvar_46 = mix (x_47, ((reflection_35 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_39.xyz = tmpvar_46;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_37 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_37 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_48;
      tmpvar_48 = mix (spColor_39, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_37) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_39 = tmpvar_48;
    };
  };
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (outColor_13.xyz, spColor_39.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_39.xyz = tmpvar_49;
  outColor_13.xyz = spColor_39.xyz;
  outColor_13.w = mix (spColor_39.w, _EmissionBloomFactor, tex_C_Color_12.w);
  highp vec4 scrpos_50;
  scrpos_50 = xlv_TEXCOORD6;
  mediump float a_51;
  a_51 = xlv_TEXCOORD6.z;
  if ((a_51 < 0.95)) {
    scrpos_50.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_51 = (a_51 * 17.0);
    highp float tmpvar_52;
    tmpvar_52 = (scrpos_50.y / 4.0);
    highp float tmpvar_53;
    tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
    highp float tmpvar_54;
    if ((tmpvar_52 >= 0.0)) {
      tmpvar_54 = tmpvar_53;
    } else {
      tmpvar_54 = -(tmpvar_53);
    };
    highp float tmpvar_55;
    tmpvar_55 = (scrpos_50.x / 4.0);
    highp float tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
    highp float tmpvar_57;
    if ((tmpvar_55 >= 0.0)) {
      tmpvar_57 = tmpvar_56;
    } else {
      tmpvar_57 = -(tmpvar_56);
    };
    highp float x_58;
    x_58 = ((a_51 - _DITHERMATRIX[
      int(tmpvar_54)
    ][
      int(tmpvar_57)
    ]) - 0.01);
    if ((x_58 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_13;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_4.xyw = o_13.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_16;
  uv_16 = tmpvar_1;
  highp vec4 spuvs_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (_glesVertex * 0.5);
  spuvs_17.xy = ((uv_16 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (tmpvar_18.z * tmpvar_18.z));
  tmpvar_19.y = ((tmpvar_18.y + (0.5 * tmpvar_18.z)) + ((0.5 * tmpvar_18.x) * tmpvar_18.x));
  spuvs_17.zw = ((tmpvar_19 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  mediump vec3 tmpvar_20;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 col_26;
  highp vec4 ndotl_27;
  highp vec4 lengthSq_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosX0 - tmpvar_12.x);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosY0 - tmpvar_12.y);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosZ0 - tmpvar_12.z);
  lengthSq_28 = (tmpvar_29 * tmpvar_29);
  lengthSq_28 = (lengthSq_28 + (tmpvar_30 * tmpvar_30));
  lengthSq_28 = (lengthSq_28 + (tmpvar_31 * tmpvar_31));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (lengthSq_28, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_28 = tmpvar_32;
  ndotl_27 = (tmpvar_29 * tmpvar_9.x);
  ndotl_27 = (ndotl_27 + (tmpvar_30 * tmpvar_9.y));
  ndotl_27 = (ndotl_27 + (tmpvar_31 * tmpvar_9.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_27 * inversesqrt(tmpvar_32)));
  ndotl_27 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (tmpvar_32 * lightAttenSq_25)
  ))));
  col_26 = (lightColor0_21 * tmpvar_34.x);
  col_26 = (col_26 + (lightColor1_22 * tmpvar_34.y));
  col_26 = (col_26 + (lightColor2_23 * tmpvar_34.z));
  col_26 = (col_26 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_20 = col_26;
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_17;
  xlv_TEXCOORD4 = (tmpvar_12.xyz / tmpvar_12.w);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_12.xyz));
  xlv_TEXCOORD9 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 ramp_10;
  mediump vec4 lightmap_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_11 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_17;
  viewDir_8 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_9 + viewDir_8));
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
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (dot (normalDir_7, tmpvar_18), 0.0);
  highp float tmpvar_27;
  tmpvar_27 = pow (tmpvar_26, _Shininess);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_11.y) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_11.y) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  outColor_13.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    ))) * lightmap_11.x) * _SpecularIntensity)
   * tex_C_Color_12.xyz) + tex_C_Color_12.xyz) + rimLighting_4);
  outColor_13.xyz = (outColor_13.xyz * ramp_10);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_32;
  tmpvar_32 = mix ((_Color * _EnvColor), tmpvar_31, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_32.xyz);
  outColor_13.w = _BloomFactor;
  outColor_13.xyz = (outColor_13.xyz + (outColor_13.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_34;
  mediump vec3 reflection_35;
  mediump vec3 R_36;
  mediump float intensity_37;
  mediump vec4 noiseTex_38;
  mediump vec4 spColor_39;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_39.xyz = tmpvar_40.xyz;
  spColor_39.w = outColor_13.w;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_38 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (((1.99 * noiseTex_38.x) * _SPNoiseScaler) - 1.0);
  intensity_37 = tmpvar_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_38 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (N_3, I_44)
   * N_3)));
  R_36 = tmpvar_43;
  lowp vec3 tmpvar_45;
  tmpvar_45 = textureCube (_SPCubeMap, R_36).xyz;
  reflection_35 = tmpvar_45;
  highp vec3 tmpvar_46;
  mediump vec3 x_47;
  x_47 = (spColor_39.xyz * _SPOldColor.xyz);
  tmpvar_46 = mix (x_47, ((reflection_35 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_39.xyz = tmpvar_46;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_37 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_37 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_48;
      tmpvar_48 = mix (spColor_39, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_37) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_39 = tmpvar_48;
    };
  };
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (outColor_13.xyz, spColor_39.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_39.xyz = tmpvar_49;
  outColor_13.xyz = spColor_39.xyz;
  outColor_13.w = mix (spColor_39.w, _EmissionBloomFactor, tex_C_Color_12.w);
  highp vec4 scrpos_50;
  scrpos_50 = xlv_TEXCOORD6;
  mediump float a_51;
  a_51 = xlv_TEXCOORD6.z;
  if ((a_51 < 0.95)) {
    scrpos_50.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_51 = (a_51 * 17.0);
    highp float tmpvar_52;
    tmpvar_52 = (scrpos_50.y / 4.0);
    highp float tmpvar_53;
    tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
    highp float tmpvar_54;
    if ((tmpvar_52 >= 0.0)) {
      tmpvar_54 = tmpvar_53;
    } else {
      tmpvar_54 = -(tmpvar_53);
    };
    highp float tmpvar_55;
    tmpvar_55 = (scrpos_50.x / 4.0);
    highp float tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
    highp float tmpvar_57;
    if ((tmpvar_55 >= 0.0)) {
      tmpvar_57 = tmpvar_56;
    } else {
      tmpvar_57 = -(tmpvar_56);
    };
    highp float x_58;
    x_58 = ((a_51 - _DITHERMATRIX[
      int(tmpvar_54)
    ][
      int(tmpvar_57)
    ]) - 0.01);
    if ((x_58 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_13;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_4.xyw = o_13.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_16;
  uv_16 = tmpvar_1;
  highp vec4 spuvs_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (_glesVertex * 0.5);
  spuvs_17.xy = ((uv_16 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (tmpvar_18.z * tmpvar_18.z));
  tmpvar_19.y = ((tmpvar_18.y + (0.5 * tmpvar_18.z)) + ((0.5 * tmpvar_18.x) * tmpvar_18.x));
  spuvs_17.zw = ((tmpvar_19 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  mediump vec3 tmpvar_20;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 col_26;
  highp vec4 ndotl_27;
  highp vec4 lengthSq_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosX0 - tmpvar_12.x);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosY0 - tmpvar_12.y);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosZ0 - tmpvar_12.z);
  lengthSq_28 = (tmpvar_29 * tmpvar_29);
  lengthSq_28 = (lengthSq_28 + (tmpvar_30 * tmpvar_30));
  lengthSq_28 = (lengthSq_28 + (tmpvar_31 * tmpvar_31));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (lengthSq_28, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_28 = tmpvar_32;
  ndotl_27 = (tmpvar_29 * tmpvar_9.x);
  ndotl_27 = (ndotl_27 + (tmpvar_30 * tmpvar_9.y));
  ndotl_27 = (ndotl_27 + (tmpvar_31 * tmpvar_9.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_27 * inversesqrt(tmpvar_32)));
  ndotl_27 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (tmpvar_32 * lightAttenSq_25)
  ))));
  col_26 = (lightColor0_21 * tmpvar_34.x);
  col_26 = (col_26 + (lightColor1_22 * tmpvar_34.y));
  col_26 = (col_26 + (lightColor2_23 * tmpvar_34.z));
  col_26 = (col_26 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_20 = col_26;
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_17;
  xlv_TEXCOORD4 = (tmpvar_12.xyz / tmpvar_12.w);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_12.xyz));
  xlv_TEXCOORD9 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 ramp_10;
  mediump vec4 lightmap_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_11 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_17;
  viewDir_8 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_9 + viewDir_8));
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
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (dot (normalDir_7, tmpvar_18), 0.0);
  highp float tmpvar_27;
  tmpvar_27 = pow (tmpvar_26, _Shininess);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_11.y) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_11.y) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  outColor_13.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    ))) * lightmap_11.x) * _SpecularIntensity)
   * tex_C_Color_12.xyz) + tex_C_Color_12.xyz) + rimLighting_4);
  outColor_13.xyz = (outColor_13.xyz * ramp_10);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_32;
  tmpvar_32 = mix ((_Color * _EnvColor), tmpvar_31, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_32.xyz);
  outColor_13.w = _BloomFactor;
  outColor_13.xyz = (outColor_13.xyz + (outColor_13.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_34;
  mediump vec3 reflection_35;
  mediump vec3 R_36;
  mediump float intensity_37;
  mediump vec4 noiseTex_38;
  mediump vec4 spColor_39;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_39.xyz = tmpvar_40.xyz;
  spColor_39.w = outColor_13.w;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_38 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (((1.99 * noiseTex_38.x) * _SPNoiseScaler) - 1.0);
  intensity_37 = tmpvar_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_38 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (N_3, I_44)
   * N_3)));
  R_36 = tmpvar_43;
  lowp vec3 tmpvar_45;
  tmpvar_45 = textureCube (_SPCubeMap, R_36).xyz;
  reflection_35 = tmpvar_45;
  highp vec3 tmpvar_46;
  mediump vec3 x_47;
  x_47 = (spColor_39.xyz * _SPOldColor.xyz);
  tmpvar_46 = mix (x_47, ((reflection_35 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_39.xyz = tmpvar_46;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_37 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_37 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_48;
      tmpvar_48 = mix (spColor_39, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_37) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_39 = tmpvar_48;
    };
  };
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (outColor_13.xyz, spColor_39.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_39.xyz = tmpvar_49;
  outColor_13.xyz = spColor_39.xyz;
  outColor_13.w = mix (spColor_39.w, _EmissionBloomFactor, tex_C_Color_12.w);
  highp vec4 scrpos_50;
  scrpos_50 = xlv_TEXCOORD6;
  mediump float a_51;
  a_51 = xlv_TEXCOORD6.z;
  if ((a_51 < 0.95)) {
    scrpos_50.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_51 = (a_51 * 17.0);
    highp float tmpvar_52;
    tmpvar_52 = (scrpos_50.y / 4.0);
    highp float tmpvar_53;
    tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
    highp float tmpvar_54;
    if ((tmpvar_52 >= 0.0)) {
      tmpvar_54 = tmpvar_53;
    } else {
      tmpvar_54 = -(tmpvar_53);
    };
    highp float tmpvar_55;
    tmpvar_55 = (scrpos_50.x / 4.0);
    highp float tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
    highp float tmpvar_57;
    if ((tmpvar_55 >= 0.0)) {
      tmpvar_57 = tmpvar_56;
    } else {
      tmpvar_57 = -(tmpvar_56);
    };
    highp float x_58;
    x_58 = ((a_51 - _DITHERMATRIX[
      int(tmpvar_54)
    ][
      int(tmpvar_57)
    ]) - 0.01);
    if ((x_58 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_13;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_4.xyw = o_13.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_16;
  uv_16 = tmpvar_1;
  highp vec4 spuvs_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (_glesVertex * 0.5);
  spuvs_17.xy = ((uv_16 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (tmpvar_18.z * tmpvar_18.z));
  tmpvar_19.y = ((tmpvar_18.y + (0.5 * tmpvar_18.z)) + ((0.5 * tmpvar_18.x) * tmpvar_18.x));
  spuvs_17.zw = ((tmpvar_19 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  mediump vec3 tmpvar_20;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 col_26;
  highp vec4 ndotl_27;
  highp vec4 lengthSq_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosX0 - tmpvar_12.x);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosY0 - tmpvar_12.y);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosZ0 - tmpvar_12.z);
  lengthSq_28 = (tmpvar_29 * tmpvar_29);
  lengthSq_28 = (lengthSq_28 + (tmpvar_30 * tmpvar_30));
  lengthSq_28 = (lengthSq_28 + (tmpvar_31 * tmpvar_31));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (lengthSq_28, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_28 = tmpvar_32;
  ndotl_27 = (tmpvar_29 * tmpvar_9.x);
  ndotl_27 = (ndotl_27 + (tmpvar_30 * tmpvar_9.y));
  ndotl_27 = (ndotl_27 + (tmpvar_31 * tmpvar_9.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_27 * inversesqrt(tmpvar_32)));
  ndotl_27 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (tmpvar_32 * lightAttenSq_25)
  ))));
  col_26 = (lightColor0_21 * tmpvar_34.x);
  col_26 = (col_26 + (lightColor1_22 * tmpvar_34.y));
  col_26 = (col_26 + (lightColor2_23 * tmpvar_34.z));
  col_26 = (col_26 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_20 = col_26;
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_17;
  xlv_TEXCOORD4 = (tmpvar_12.xyz / tmpvar_12.w);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_12.xyz));
  xlv_TEXCOORD9 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
  highp vec4 tmpvar_1;
  mediump vec3 V_2;
  mediump vec3 N_3;
  mediump vec3 rimLighting_4;
  highp vec3 rimLightDir_5;
  highp float rim_6;
  mediump vec3 normalDir_7;
  mediump vec3 viewDir_8;
  mediump vec3 lightDir_9;
  mediump vec3 ramp_10;
  mediump vec4 lightmap_11;
  mediump vec4 tex_C_Color_12;
  mediump vec4 outColor_13;
  outColor_13 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_11 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_10 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_17;
  viewDir_8 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_9 + viewDir_8));
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
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (dot (normalDir_7, tmpvar_18), 0.0);
  highp float tmpvar_27;
  tmpvar_27 = pow (tmpvar_26, _Shininess);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_11.y) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_11.y) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  outColor_13.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_30 * 
      (tmpvar_30 * (3.0 - (2.0 * tmpvar_30)))
    ))) * lightmap_11.x) * _SpecularIntensity)
   * tex_C_Color_12.xyz) + tex_C_Color_12.xyz) + rimLighting_4);
  outColor_13.xyz = (outColor_13.xyz * ramp_10);
  outColor_13.xyz = (outColor_13.xyz * _LightColor0);
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_32;
  tmpvar_32 = mix ((_Color * _EnvColor), tmpvar_31, tex_C_Color_12.wwww);
  outColor_13.xyz = (outColor_13.xyz * tmpvar_32.xyz);
  outColor_13.w = _BloomFactor;
  outColor_13.xyz = (outColor_13.xyz + (outColor_13.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD5);
  N_3 = tmpvar_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_2 = tmpvar_34;
  mediump vec3 reflection_35;
  mediump vec3 R_36;
  mediump float intensity_37;
  mediump vec4 noiseTex_38;
  mediump vec4 spColor_39;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_39.xyz = tmpvar_40.xyz;
  spColor_39.w = outColor_13.w;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_38 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (((1.99 * noiseTex_38.x) * _SPNoiseScaler) - 1.0);
  intensity_37 = tmpvar_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = ((normalize(
    (V_2 - _WorldSpaceCameraPos)
  ) + (noiseTex_38 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (N_3, I_44)
   * N_3)));
  R_36 = tmpvar_43;
  lowp vec3 tmpvar_45;
  tmpvar_45 = textureCube (_SPCubeMap, R_36).xyz;
  reflection_35 = tmpvar_45;
  highp vec3 tmpvar_46;
  mediump vec3 x_47;
  x_47 = (spColor_39.xyz * _SPOldColor.xyz);
  tmpvar_46 = mix (x_47, ((reflection_35 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_39.xyz = tmpvar_46;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_37 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_37 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_48;
      tmpvar_48 = mix (spColor_39, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_37) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_39 = tmpvar_48;
    };
  };
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (outColor_13.xyz, spColor_39.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_39.xyz = tmpvar_49;
  outColor_13.xyz = spColor_39.xyz;
  outColor_13.w = mix (spColor_39.w, _EmissionBloomFactor, tex_C_Color_12.w);
  highp vec4 scrpos_50;
  scrpos_50 = xlv_TEXCOORD6;
  mediump float a_51;
  a_51 = xlv_TEXCOORD6.z;
  if ((a_51 < 0.95)) {
    scrpos_50.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_51 = (a_51 * 17.0);
    highp float tmpvar_52;
    tmpvar_52 = (scrpos_50.y / 4.0);
    highp float tmpvar_53;
    tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
    highp float tmpvar_54;
    if ((tmpvar_52 >= 0.0)) {
      tmpvar_54 = tmpvar_53;
    } else {
      tmpvar_54 = -(tmpvar_53);
    };
    highp float tmpvar_55;
    tmpvar_55 = (scrpos_50.x / 4.0);
    highp float tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * 4.0);
    highp float tmpvar_57;
    if ((tmpvar_55 >= 0.0)) {
      tmpvar_57 = tmpvar_56;
    } else {
      tmpvar_57 = -(tmpvar_56);
    };
    highp float x_58;
    x_58 = ((a_51 - _DITHERMATRIX[
      int(tmpvar_54)
    ][
      int(tmpvar_57)
    ]) - 0.01);
    if ((x_58 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = outColor_13;
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
attribute vec4 _glesColor;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_2;
  tmpvar_10.y = d_2;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_4.xyw = o_12.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_15;
  uv_15 = tmpvar_1;
  highp vec4 spuvs_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  spuvs_16.xy = ((uv_15 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  spuvs_16.zw = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_16;
  xlv_TEXCOORD4 = (tmpvar_11.xyz / tmpvar_11.w);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD8 = _glesColor;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  mediump vec3 ramp_11;
  mediump vec4 lightmap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_12 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_18;
  viewDir_9 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize((lightDir_10 + viewDir_9));
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
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (dot (normalDir_8, tmpvar_19), 0.0);
  highp float tmpvar_28;
  tmpvar_28 = pow (tmpvar_27, _Shininess);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_12.y) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_12.y) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  outColor_14.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_31 * 
      (tmpvar_31 * (3.0 - (2.0 * tmpvar_31)))
    ))) * lightmap_12.x) * _SpecularIntensity)
   * tex_C_Color_13.xyz) + tex_C_Color_13.xyz) + rimLighting_5);
  outColor_14.xyz = (outColor_14.xyz * ramp_11);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 0.0;
  tmpvar_32.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix ((_Color * _EnvColor), tmpvar_32, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_33.xyz);
  outColor_14.w = _BloomFactor;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_35;
  mediump vec3 reflection_36;
  mediump vec3 R_37;
  mediump float intensity_38;
  mediump vec4 noiseTex_39;
  mediump vec4 spColor_40;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_40.xyz = tmpvar_41.xyz;
  spColor_40.w = outColor_14.w;
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_39 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (((1.99 * noiseTex_39.x) * _SPNoiseScaler) - 1.0);
  intensity_38 = tmpvar_43;
  highp vec3 tmpvar_44;
  highp vec3 I_45;
  I_45 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_39 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_44 = (I_45 - (2.0 * (
    dot (N_4, I_45)
   * N_4)));
  R_37 = tmpvar_44;
  lowp vec3 tmpvar_46;
  tmpvar_46 = textureCube (_SPCubeMap, R_37).xyz;
  reflection_36 = tmpvar_46;
  highp vec3 tmpvar_47;
  mediump vec3 x_48;
  x_48 = (spColor_40.xyz * _SPOldColor.xyz);
  tmpvar_47 = mix (x_48, ((reflection_36 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_40.xyz = tmpvar_47;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_38 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_38 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_49;
      tmpvar_49 = mix (spColor_40, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_38) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_40 = tmpvar_49;
    };
  };
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_14.xyz, spColor_40.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_40.xyz = tmpvar_50;
  outColor_14.xyz = spColor_40.xyz;
  outColor_14.w = mix (spColor_40.w, _EmissionBloomFactor, tex_C_Color_13.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_51;
  highp vec4 rimMask_52;
  rimMask_52 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_53;
  mediump vec4 rgColorA_54;
  mediump vec4 rgColorB_55;
  mediump vec4 rgColorG_56;
  mediump vec4 rgColorR_57;
  mediump vec4 rgColor_58;
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_59 = (_RGBias + (tmpvar_60 * _RGScale));
  mediump vec4 tmpvar_61;
  tmpvar_61 = (tmpvar_59 * _RGColor);
  highp vec4 tmpvar_62;
  tmpvar_62 = (tmpvar_61 * (1.0 - rimMask_52.x));
  rgColorR_57 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 * (1.0 - rimMask_52.y));
  rgColorG_56 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_61 * (1.0 - rimMask_52.z));
  rgColorB_55 = tmpvar_64;
  highp vec4 tmpvar_65;
  tmpvar_65 = (tmpvar_61 * (1.0 - rimMask_52.w));
  rgColorA_54 = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66 = (((
    (rgColorR_57 * _RGMaskR)
   + 
    (rgColorG_56 * _RGMaskG)
  ) + (rgColorB_55 * _RGMaskB)) + (rgColorA_54 * _RGMaskA));
  rgColorRGBA_53.xyz = tmpvar_66.xyz;
  rgColorRGBA_53.w = _RGBloomFactor;
  mediump vec4 tmpvar_67;
  tmpvar_67 = mix (outColor_14, rgColorRGBA_53, vec4(clamp ((
    (rgColorRGBA_53.x + rgColorRGBA_53.y)
   + rgColorRGBA_53.z), 0.0, 1.0)));
  highp vec4 tmpvar_68;
  tmpvar_68 = mix (tmpvar_61, tmpvar_67, vec4(_RGMaskIntensity));
  rgColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = clamp (tmpvar_59, 0.0, 1.0);
  highp vec4 tmpvar_70;
  tmpvar_70 = mix (outColor_14, rgColor_58, vec4((tmpvar_69 * _RGRatio)));
  tmpvar_51 = tmpvar_70;
  outColor_14 = tmpvar_51;
  highp vec4 scrpos_71;
  scrpos_71 = xlv_TEXCOORD6;
  mediump float a_72;
  a_72 = xlv_TEXCOORD6.z;
  if ((a_72 < 0.95)) {
    scrpos_71.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_72 = (a_72 * 17.0);
    highp float tmpvar_73;
    tmpvar_73 = (scrpos_71.y / 4.0);
    highp float tmpvar_74;
    tmpvar_74 = (fract(abs(tmpvar_73)) * 4.0);
    highp float tmpvar_75;
    if ((tmpvar_73 >= 0.0)) {
      tmpvar_75 = tmpvar_74;
    } else {
      tmpvar_75 = -(tmpvar_74);
    };
    highp float tmpvar_76;
    tmpvar_76 = (scrpos_71.x / 4.0);
    highp float tmpvar_77;
    tmpvar_77 = (fract(abs(tmpvar_76)) * 4.0);
    highp float tmpvar_78;
    if ((tmpvar_76 >= 0.0)) {
      tmpvar_78 = tmpvar_77;
    } else {
      tmpvar_78 = -(tmpvar_77);
    };
    highp float x_79;
    x_79 = ((a_72 - _DITHERMATRIX[
      int(tmpvar_75)
    ][
      int(tmpvar_78)
    ]) - 0.01);
    if ((x_79 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_51;
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
attribute vec4 _glesColor;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_2;
  tmpvar_10.y = d_2;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_4.xyw = o_12.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_15;
  uv_15 = tmpvar_1;
  highp vec4 spuvs_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  spuvs_16.xy = ((uv_15 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  spuvs_16.zw = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_16;
  xlv_TEXCOORD4 = (tmpvar_11.xyz / tmpvar_11.w);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD8 = _glesColor;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  mediump vec3 ramp_11;
  mediump vec4 lightmap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_12 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_18;
  viewDir_9 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize((lightDir_10 + viewDir_9));
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
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (dot (normalDir_8, tmpvar_19), 0.0);
  highp float tmpvar_28;
  tmpvar_28 = pow (tmpvar_27, _Shininess);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_12.y) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_12.y) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  outColor_14.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_31 * 
      (tmpvar_31 * (3.0 - (2.0 * tmpvar_31)))
    ))) * lightmap_12.x) * _SpecularIntensity)
   * tex_C_Color_13.xyz) + tex_C_Color_13.xyz) + rimLighting_5);
  outColor_14.xyz = (outColor_14.xyz * ramp_11);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 0.0;
  tmpvar_32.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix ((_Color * _EnvColor), tmpvar_32, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_33.xyz);
  outColor_14.w = _BloomFactor;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_35;
  mediump vec3 reflection_36;
  mediump vec3 R_37;
  mediump float intensity_38;
  mediump vec4 noiseTex_39;
  mediump vec4 spColor_40;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_40.xyz = tmpvar_41.xyz;
  spColor_40.w = outColor_14.w;
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_39 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (((1.99 * noiseTex_39.x) * _SPNoiseScaler) - 1.0);
  intensity_38 = tmpvar_43;
  highp vec3 tmpvar_44;
  highp vec3 I_45;
  I_45 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_39 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_44 = (I_45 - (2.0 * (
    dot (N_4, I_45)
   * N_4)));
  R_37 = tmpvar_44;
  lowp vec3 tmpvar_46;
  tmpvar_46 = textureCube (_SPCubeMap, R_37).xyz;
  reflection_36 = tmpvar_46;
  highp vec3 tmpvar_47;
  mediump vec3 x_48;
  x_48 = (spColor_40.xyz * _SPOldColor.xyz);
  tmpvar_47 = mix (x_48, ((reflection_36 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_40.xyz = tmpvar_47;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_38 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_38 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_49;
      tmpvar_49 = mix (spColor_40, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_38) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_40 = tmpvar_49;
    };
  };
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_14.xyz, spColor_40.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_40.xyz = tmpvar_50;
  outColor_14.xyz = spColor_40.xyz;
  outColor_14.w = mix (spColor_40.w, _EmissionBloomFactor, tex_C_Color_13.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_51;
  highp vec4 rimMask_52;
  rimMask_52 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_53;
  mediump vec4 rgColorA_54;
  mediump vec4 rgColorB_55;
  mediump vec4 rgColorG_56;
  mediump vec4 rgColorR_57;
  mediump vec4 rgColor_58;
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_59 = (_RGBias + (tmpvar_60 * _RGScale));
  mediump vec4 tmpvar_61;
  tmpvar_61 = (tmpvar_59 * _RGColor);
  highp vec4 tmpvar_62;
  tmpvar_62 = (tmpvar_61 * (1.0 - rimMask_52.x));
  rgColorR_57 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 * (1.0 - rimMask_52.y));
  rgColorG_56 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_61 * (1.0 - rimMask_52.z));
  rgColorB_55 = tmpvar_64;
  highp vec4 tmpvar_65;
  tmpvar_65 = (tmpvar_61 * (1.0 - rimMask_52.w));
  rgColorA_54 = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66 = (((
    (rgColorR_57 * _RGMaskR)
   + 
    (rgColorG_56 * _RGMaskG)
  ) + (rgColorB_55 * _RGMaskB)) + (rgColorA_54 * _RGMaskA));
  rgColorRGBA_53.xyz = tmpvar_66.xyz;
  rgColorRGBA_53.w = _RGBloomFactor;
  mediump vec4 tmpvar_67;
  tmpvar_67 = mix (outColor_14, rgColorRGBA_53, vec4(clamp ((
    (rgColorRGBA_53.x + rgColorRGBA_53.y)
   + rgColorRGBA_53.z), 0.0, 1.0)));
  highp vec4 tmpvar_68;
  tmpvar_68 = mix (tmpvar_61, tmpvar_67, vec4(_RGMaskIntensity));
  rgColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = clamp (tmpvar_59, 0.0, 1.0);
  highp vec4 tmpvar_70;
  tmpvar_70 = mix (outColor_14, rgColor_58, vec4((tmpvar_69 * _RGRatio)));
  tmpvar_51 = tmpvar_70;
  outColor_14 = tmpvar_51;
  highp vec4 scrpos_71;
  scrpos_71 = xlv_TEXCOORD6;
  mediump float a_72;
  a_72 = xlv_TEXCOORD6.z;
  if ((a_72 < 0.95)) {
    scrpos_71.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_72 = (a_72 * 17.0);
    highp float tmpvar_73;
    tmpvar_73 = (scrpos_71.y / 4.0);
    highp float tmpvar_74;
    tmpvar_74 = (fract(abs(tmpvar_73)) * 4.0);
    highp float tmpvar_75;
    if ((tmpvar_73 >= 0.0)) {
      tmpvar_75 = tmpvar_74;
    } else {
      tmpvar_75 = -(tmpvar_74);
    };
    highp float tmpvar_76;
    tmpvar_76 = (scrpos_71.x / 4.0);
    highp float tmpvar_77;
    tmpvar_77 = (fract(abs(tmpvar_76)) * 4.0);
    highp float tmpvar_78;
    if ((tmpvar_76 >= 0.0)) {
      tmpvar_78 = tmpvar_77;
    } else {
      tmpvar_78 = -(tmpvar_77);
    };
    highp float x_79;
    x_79 = ((a_72 - _DITHERMATRIX[
      int(tmpvar_75)
    ][
      int(tmpvar_78)
    ]) - 0.01);
    if ((x_79 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_51;
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
attribute vec4 _glesColor;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(normalize((_glesNormal * tmpvar_7)));
  highp float tmpvar_9;
  tmpvar_9 = ((dot (tmpvar_8, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_9;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = d_2;
  tmpvar_10.y = d_2;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_5.zw;
  tmpvar_4.xyw = o_12.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_15;
  uv_15 = tmpvar_1;
  highp vec4 spuvs_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (_glesVertex * 0.5);
  spuvs_16.xy = ((uv_15 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.x + (tmpvar_17.z * tmpvar_17.z));
  tmpvar_18.y = ((tmpvar_17.y + (0.5 * tmpvar_17.z)) + ((0.5 * tmpvar_17.x) * tmpvar_17.x));
  spuvs_16.zw = ((tmpvar_18 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_16;
  xlv_TEXCOORD4 = (tmpvar_11.xyz / tmpvar_11.w);
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  xlv_TEXCOORD8 = _glesColor;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  mediump vec3 ramp_11;
  mediump vec4 lightmap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_12 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_18;
  viewDir_9 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize((lightDir_10 + viewDir_9));
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
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (dot (normalDir_8, tmpvar_19), 0.0);
  highp float tmpvar_28;
  tmpvar_28 = pow (tmpvar_27, _Shininess);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_12.y) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_12.y) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  outColor_14.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_31 * 
      (tmpvar_31 * (3.0 - (2.0 * tmpvar_31)))
    ))) * lightmap_12.x) * _SpecularIntensity)
   * tex_C_Color_13.xyz) + tex_C_Color_13.xyz) + rimLighting_5);
  outColor_14.xyz = (outColor_14.xyz * ramp_11);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 0.0;
  tmpvar_32.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix ((_Color * _EnvColor), tmpvar_32, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_33.xyz);
  outColor_14.w = _BloomFactor;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_35;
  mediump vec3 reflection_36;
  mediump vec3 R_37;
  mediump float intensity_38;
  mediump vec4 noiseTex_39;
  mediump vec4 spColor_40;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_40.xyz = tmpvar_41.xyz;
  spColor_40.w = outColor_14.w;
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_39 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (((1.99 * noiseTex_39.x) * _SPNoiseScaler) - 1.0);
  intensity_38 = tmpvar_43;
  highp vec3 tmpvar_44;
  highp vec3 I_45;
  I_45 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_39 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_44 = (I_45 - (2.0 * (
    dot (N_4, I_45)
   * N_4)));
  R_37 = tmpvar_44;
  lowp vec3 tmpvar_46;
  tmpvar_46 = textureCube (_SPCubeMap, R_37).xyz;
  reflection_36 = tmpvar_46;
  highp vec3 tmpvar_47;
  mediump vec3 x_48;
  x_48 = (spColor_40.xyz * _SPOldColor.xyz);
  tmpvar_47 = mix (x_48, ((reflection_36 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_40.xyz = tmpvar_47;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_38 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_38 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_49;
      tmpvar_49 = mix (spColor_40, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_38) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_40 = tmpvar_49;
    };
  };
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_14.xyz, spColor_40.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_40.xyz = tmpvar_50;
  outColor_14.xyz = spColor_40.xyz;
  outColor_14.w = mix (spColor_40.w, _EmissionBloomFactor, tex_C_Color_13.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_51;
  highp vec4 rimMask_52;
  rimMask_52 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_53;
  mediump vec4 rgColorA_54;
  mediump vec4 rgColorB_55;
  mediump vec4 rgColorG_56;
  mediump vec4 rgColorR_57;
  mediump vec4 rgColor_58;
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_59 = (_RGBias + (tmpvar_60 * _RGScale));
  mediump vec4 tmpvar_61;
  tmpvar_61 = (tmpvar_59 * _RGColor);
  highp vec4 tmpvar_62;
  tmpvar_62 = (tmpvar_61 * (1.0 - rimMask_52.x));
  rgColorR_57 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 * (1.0 - rimMask_52.y));
  rgColorG_56 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_61 * (1.0 - rimMask_52.z));
  rgColorB_55 = tmpvar_64;
  highp vec4 tmpvar_65;
  tmpvar_65 = (tmpvar_61 * (1.0 - rimMask_52.w));
  rgColorA_54 = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66 = (((
    (rgColorR_57 * _RGMaskR)
   + 
    (rgColorG_56 * _RGMaskG)
  ) + (rgColorB_55 * _RGMaskB)) + (rgColorA_54 * _RGMaskA));
  rgColorRGBA_53.xyz = tmpvar_66.xyz;
  rgColorRGBA_53.w = _RGBloomFactor;
  mediump vec4 tmpvar_67;
  tmpvar_67 = mix (outColor_14, rgColorRGBA_53, vec4(clamp ((
    (rgColorRGBA_53.x + rgColorRGBA_53.y)
   + rgColorRGBA_53.z), 0.0, 1.0)));
  highp vec4 tmpvar_68;
  tmpvar_68 = mix (tmpvar_61, tmpvar_67, vec4(_RGMaskIntensity));
  rgColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = clamp (tmpvar_59, 0.0, 1.0);
  highp vec4 tmpvar_70;
  tmpvar_70 = mix (outColor_14, rgColor_58, vec4((tmpvar_69 * _RGRatio)));
  tmpvar_51 = tmpvar_70;
  outColor_14 = tmpvar_51;
  highp vec4 scrpos_71;
  scrpos_71 = xlv_TEXCOORD6;
  mediump float a_72;
  a_72 = xlv_TEXCOORD6.z;
  if ((a_72 < 0.95)) {
    scrpos_71.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_72 = (a_72 * 17.0);
    highp float tmpvar_73;
    tmpvar_73 = (scrpos_71.y / 4.0);
    highp float tmpvar_74;
    tmpvar_74 = (fract(abs(tmpvar_73)) * 4.0);
    highp float tmpvar_75;
    if ((tmpvar_73 >= 0.0)) {
      tmpvar_75 = tmpvar_74;
    } else {
      tmpvar_75 = -(tmpvar_74);
    };
    highp float tmpvar_76;
    tmpvar_76 = (scrpos_71.x / 4.0);
    highp float tmpvar_77;
    tmpvar_77 = (fract(abs(tmpvar_76)) * 4.0);
    highp float tmpvar_78;
    if ((tmpvar_76 >= 0.0)) {
      tmpvar_78 = tmpvar_77;
    } else {
      tmpvar_78 = -(tmpvar_77);
    };
    highp float x_79;
    x_79 = ((a_72 - _DITHERMATRIX[
      int(tmpvar_75)
    ][
      int(tmpvar_78)
    ]) - 0.01);
    if ((x_79 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_51;
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
attribute vec4 _glesColor;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_4.xyw = o_13.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_16;
  uv_16 = tmpvar_1;
  highp vec4 spuvs_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (_glesVertex * 0.5);
  spuvs_17.xy = ((uv_16 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (tmpvar_18.z * tmpvar_18.z));
  tmpvar_19.y = ((tmpvar_18.y + (0.5 * tmpvar_18.z)) + ((0.5 * tmpvar_18.x) * tmpvar_18.x));
  spuvs_17.zw = ((tmpvar_19 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  mediump vec3 tmpvar_20;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 col_26;
  highp vec4 ndotl_27;
  highp vec4 lengthSq_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosX0 - tmpvar_12.x);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosY0 - tmpvar_12.y);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosZ0 - tmpvar_12.z);
  lengthSq_28 = (tmpvar_29 * tmpvar_29);
  lengthSq_28 = (lengthSq_28 + (tmpvar_30 * tmpvar_30));
  lengthSq_28 = (lengthSq_28 + (tmpvar_31 * tmpvar_31));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (lengthSq_28, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_28 = tmpvar_32;
  ndotl_27 = (tmpvar_29 * tmpvar_9.x);
  ndotl_27 = (ndotl_27 + (tmpvar_30 * tmpvar_9.y));
  ndotl_27 = (ndotl_27 + (tmpvar_31 * tmpvar_9.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_27 * inversesqrt(tmpvar_32)));
  ndotl_27 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (tmpvar_32 * lightAttenSq_25)
  ))));
  col_26 = (lightColor0_21 * tmpvar_34.x);
  col_26 = (col_26 + (lightColor1_22 * tmpvar_34.y));
  col_26 = (col_26 + (lightColor2_23 * tmpvar_34.z));
  col_26 = (col_26 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_20 = col_26;
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_17;
  xlv_TEXCOORD4 = (tmpvar_12.xyz / tmpvar_12.w);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_12.xyz));
  xlv_TEXCOORD8 = _glesColor;
  xlv_TEXCOORD9 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  mediump vec3 ramp_11;
  mediump vec4 lightmap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_12 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_18;
  viewDir_9 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize((lightDir_10 + viewDir_9));
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
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (dot (normalDir_8, tmpvar_19), 0.0);
  highp float tmpvar_28;
  tmpvar_28 = pow (tmpvar_27, _Shininess);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_12.y) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_12.y) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  outColor_14.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_31 * 
      (tmpvar_31 * (3.0 - (2.0 * tmpvar_31)))
    ))) * lightmap_12.x) * _SpecularIntensity)
   * tex_C_Color_13.xyz) + tex_C_Color_13.xyz) + rimLighting_5);
  outColor_14.xyz = (outColor_14.xyz * ramp_11);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 0.0;
  tmpvar_32.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix ((_Color * _EnvColor), tmpvar_32, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_33.xyz);
  outColor_14.w = _BloomFactor;
  outColor_14.xyz = (outColor_14.xyz + (outColor_14.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_35;
  mediump vec3 reflection_36;
  mediump vec3 R_37;
  mediump float intensity_38;
  mediump vec4 noiseTex_39;
  mediump vec4 spColor_40;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_40.xyz = tmpvar_41.xyz;
  spColor_40.w = outColor_14.w;
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_39 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (((1.99 * noiseTex_39.x) * _SPNoiseScaler) - 1.0);
  intensity_38 = tmpvar_43;
  highp vec3 tmpvar_44;
  highp vec3 I_45;
  I_45 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_39 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_44 = (I_45 - (2.0 * (
    dot (N_4, I_45)
   * N_4)));
  R_37 = tmpvar_44;
  lowp vec3 tmpvar_46;
  tmpvar_46 = textureCube (_SPCubeMap, R_37).xyz;
  reflection_36 = tmpvar_46;
  highp vec3 tmpvar_47;
  mediump vec3 x_48;
  x_48 = (spColor_40.xyz * _SPOldColor.xyz);
  tmpvar_47 = mix (x_48, ((reflection_36 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_40.xyz = tmpvar_47;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_38 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_38 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_49;
      tmpvar_49 = mix (spColor_40, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_38) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_40 = tmpvar_49;
    };
  };
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_14.xyz, spColor_40.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_40.xyz = tmpvar_50;
  outColor_14.xyz = spColor_40.xyz;
  outColor_14.w = mix (spColor_40.w, _EmissionBloomFactor, tex_C_Color_13.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_51;
  highp vec4 rimMask_52;
  rimMask_52 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_53;
  mediump vec4 rgColorA_54;
  mediump vec4 rgColorB_55;
  mediump vec4 rgColorG_56;
  mediump vec4 rgColorR_57;
  mediump vec4 rgColor_58;
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_59 = (_RGBias + (tmpvar_60 * _RGScale));
  mediump vec4 tmpvar_61;
  tmpvar_61 = (tmpvar_59 * _RGColor);
  highp vec4 tmpvar_62;
  tmpvar_62 = (tmpvar_61 * (1.0 - rimMask_52.x));
  rgColorR_57 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 * (1.0 - rimMask_52.y));
  rgColorG_56 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_61 * (1.0 - rimMask_52.z));
  rgColorB_55 = tmpvar_64;
  highp vec4 tmpvar_65;
  tmpvar_65 = (tmpvar_61 * (1.0 - rimMask_52.w));
  rgColorA_54 = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66 = (((
    (rgColorR_57 * _RGMaskR)
   + 
    (rgColorG_56 * _RGMaskG)
  ) + (rgColorB_55 * _RGMaskB)) + (rgColorA_54 * _RGMaskA));
  rgColorRGBA_53.xyz = tmpvar_66.xyz;
  rgColorRGBA_53.w = _RGBloomFactor;
  mediump vec4 tmpvar_67;
  tmpvar_67 = mix (outColor_14, rgColorRGBA_53, vec4(clamp ((
    (rgColorRGBA_53.x + rgColorRGBA_53.y)
   + rgColorRGBA_53.z), 0.0, 1.0)));
  highp vec4 tmpvar_68;
  tmpvar_68 = mix (tmpvar_61, tmpvar_67, vec4(_RGMaskIntensity));
  rgColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = clamp (tmpvar_59, 0.0, 1.0);
  highp vec4 tmpvar_70;
  tmpvar_70 = mix (outColor_14, rgColor_58, vec4((tmpvar_69 * _RGRatio)));
  tmpvar_51 = tmpvar_70;
  outColor_14 = tmpvar_51;
  highp vec4 scrpos_71;
  scrpos_71 = xlv_TEXCOORD6;
  mediump float a_72;
  a_72 = xlv_TEXCOORD6.z;
  if ((a_72 < 0.95)) {
    scrpos_71.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_72 = (a_72 * 17.0);
    highp float tmpvar_73;
    tmpvar_73 = (scrpos_71.y / 4.0);
    highp float tmpvar_74;
    tmpvar_74 = (fract(abs(tmpvar_73)) * 4.0);
    highp float tmpvar_75;
    if ((tmpvar_73 >= 0.0)) {
      tmpvar_75 = tmpvar_74;
    } else {
      tmpvar_75 = -(tmpvar_74);
    };
    highp float tmpvar_76;
    tmpvar_76 = (scrpos_71.x / 4.0);
    highp float tmpvar_77;
    tmpvar_77 = (fract(abs(tmpvar_76)) * 4.0);
    highp float tmpvar_78;
    if ((tmpvar_76 >= 0.0)) {
      tmpvar_78 = tmpvar_77;
    } else {
      tmpvar_78 = -(tmpvar_77);
    };
    highp float x_79;
    x_79 = ((a_72 - _DITHERMATRIX[
      int(tmpvar_75)
    ][
      int(tmpvar_78)
    ]) - 0.01);
    if ((x_79 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_51;
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
attribute vec4 _glesColor;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_4.xyw = o_13.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_16;
  uv_16 = tmpvar_1;
  highp vec4 spuvs_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (_glesVertex * 0.5);
  spuvs_17.xy = ((uv_16 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (tmpvar_18.z * tmpvar_18.z));
  tmpvar_19.y = ((tmpvar_18.y + (0.5 * tmpvar_18.z)) + ((0.5 * tmpvar_18.x) * tmpvar_18.x));
  spuvs_17.zw = ((tmpvar_19 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  mediump vec3 tmpvar_20;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 col_26;
  highp vec4 ndotl_27;
  highp vec4 lengthSq_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosX0 - tmpvar_12.x);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosY0 - tmpvar_12.y);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosZ0 - tmpvar_12.z);
  lengthSq_28 = (tmpvar_29 * tmpvar_29);
  lengthSq_28 = (lengthSq_28 + (tmpvar_30 * tmpvar_30));
  lengthSq_28 = (lengthSq_28 + (tmpvar_31 * tmpvar_31));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (lengthSq_28, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_28 = tmpvar_32;
  ndotl_27 = (tmpvar_29 * tmpvar_9.x);
  ndotl_27 = (ndotl_27 + (tmpvar_30 * tmpvar_9.y));
  ndotl_27 = (ndotl_27 + (tmpvar_31 * tmpvar_9.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_27 * inversesqrt(tmpvar_32)));
  ndotl_27 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (tmpvar_32 * lightAttenSq_25)
  ))));
  col_26 = (lightColor0_21 * tmpvar_34.x);
  col_26 = (col_26 + (lightColor1_22 * tmpvar_34.y));
  col_26 = (col_26 + (lightColor2_23 * tmpvar_34.z));
  col_26 = (col_26 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_20 = col_26;
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_17;
  xlv_TEXCOORD4 = (tmpvar_12.xyz / tmpvar_12.w);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_12.xyz));
  xlv_TEXCOORD8 = _glesColor;
  xlv_TEXCOORD9 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  mediump vec3 ramp_11;
  mediump vec4 lightmap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_12 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_18;
  viewDir_9 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize((lightDir_10 + viewDir_9));
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
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (dot (normalDir_8, tmpvar_19), 0.0);
  highp float tmpvar_28;
  tmpvar_28 = pow (tmpvar_27, _Shininess);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_12.y) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_12.y) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  outColor_14.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_31 * 
      (tmpvar_31 * (3.0 - (2.0 * tmpvar_31)))
    ))) * lightmap_12.x) * _SpecularIntensity)
   * tex_C_Color_13.xyz) + tex_C_Color_13.xyz) + rimLighting_5);
  outColor_14.xyz = (outColor_14.xyz * ramp_11);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 0.0;
  tmpvar_32.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix ((_Color * _EnvColor), tmpvar_32, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_33.xyz);
  outColor_14.w = _BloomFactor;
  outColor_14.xyz = (outColor_14.xyz + (outColor_14.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_35;
  mediump vec3 reflection_36;
  mediump vec3 R_37;
  mediump float intensity_38;
  mediump vec4 noiseTex_39;
  mediump vec4 spColor_40;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_40.xyz = tmpvar_41.xyz;
  spColor_40.w = outColor_14.w;
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_39 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (((1.99 * noiseTex_39.x) * _SPNoiseScaler) - 1.0);
  intensity_38 = tmpvar_43;
  highp vec3 tmpvar_44;
  highp vec3 I_45;
  I_45 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_39 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_44 = (I_45 - (2.0 * (
    dot (N_4, I_45)
   * N_4)));
  R_37 = tmpvar_44;
  lowp vec3 tmpvar_46;
  tmpvar_46 = textureCube (_SPCubeMap, R_37).xyz;
  reflection_36 = tmpvar_46;
  highp vec3 tmpvar_47;
  mediump vec3 x_48;
  x_48 = (spColor_40.xyz * _SPOldColor.xyz);
  tmpvar_47 = mix (x_48, ((reflection_36 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_40.xyz = tmpvar_47;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_38 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_38 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_49;
      tmpvar_49 = mix (spColor_40, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_38) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_40 = tmpvar_49;
    };
  };
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_14.xyz, spColor_40.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_40.xyz = tmpvar_50;
  outColor_14.xyz = spColor_40.xyz;
  outColor_14.w = mix (spColor_40.w, _EmissionBloomFactor, tex_C_Color_13.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_51;
  highp vec4 rimMask_52;
  rimMask_52 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_53;
  mediump vec4 rgColorA_54;
  mediump vec4 rgColorB_55;
  mediump vec4 rgColorG_56;
  mediump vec4 rgColorR_57;
  mediump vec4 rgColor_58;
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_59 = (_RGBias + (tmpvar_60 * _RGScale));
  mediump vec4 tmpvar_61;
  tmpvar_61 = (tmpvar_59 * _RGColor);
  highp vec4 tmpvar_62;
  tmpvar_62 = (tmpvar_61 * (1.0 - rimMask_52.x));
  rgColorR_57 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 * (1.0 - rimMask_52.y));
  rgColorG_56 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_61 * (1.0 - rimMask_52.z));
  rgColorB_55 = tmpvar_64;
  highp vec4 tmpvar_65;
  tmpvar_65 = (tmpvar_61 * (1.0 - rimMask_52.w));
  rgColorA_54 = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66 = (((
    (rgColorR_57 * _RGMaskR)
   + 
    (rgColorG_56 * _RGMaskG)
  ) + (rgColorB_55 * _RGMaskB)) + (rgColorA_54 * _RGMaskA));
  rgColorRGBA_53.xyz = tmpvar_66.xyz;
  rgColorRGBA_53.w = _RGBloomFactor;
  mediump vec4 tmpvar_67;
  tmpvar_67 = mix (outColor_14, rgColorRGBA_53, vec4(clamp ((
    (rgColorRGBA_53.x + rgColorRGBA_53.y)
   + rgColorRGBA_53.z), 0.0, 1.0)));
  highp vec4 tmpvar_68;
  tmpvar_68 = mix (tmpvar_61, tmpvar_67, vec4(_RGMaskIntensity));
  rgColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = clamp (tmpvar_59, 0.0, 1.0);
  highp vec4 tmpvar_70;
  tmpvar_70 = mix (outColor_14, rgColor_58, vec4((tmpvar_69 * _RGRatio)));
  tmpvar_51 = tmpvar_70;
  outColor_14 = tmpvar_51;
  highp vec4 scrpos_71;
  scrpos_71 = xlv_TEXCOORD6;
  mediump float a_72;
  a_72 = xlv_TEXCOORD6.z;
  if ((a_72 < 0.95)) {
    scrpos_71.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_72 = (a_72 * 17.0);
    highp float tmpvar_73;
    tmpvar_73 = (scrpos_71.y / 4.0);
    highp float tmpvar_74;
    tmpvar_74 = (fract(abs(tmpvar_73)) * 4.0);
    highp float tmpvar_75;
    if ((tmpvar_73 >= 0.0)) {
      tmpvar_75 = tmpvar_74;
    } else {
      tmpvar_75 = -(tmpvar_74);
    };
    highp float tmpvar_76;
    tmpvar_76 = (scrpos_71.x / 4.0);
    highp float tmpvar_77;
    tmpvar_77 = (fract(abs(tmpvar_76)) * 4.0);
    highp float tmpvar_78;
    if ((tmpvar_76 >= 0.0)) {
      tmpvar_78 = tmpvar_77;
    } else {
      tmpvar_78 = -(tmpvar_77);
    };
    highp float x_79;
    x_79 = ((a_72 - _DITHERMATRIX[
      int(tmpvar_75)
    ][
      int(tmpvar_78)
    ]) - 0.01);
    if ((x_79 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_51;
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
attribute vec4 _glesColor;
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
  mediump float d_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_3.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize((_glesNormal * tmpvar_8)));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, 
    normalize(_WorldSpaceLightPos0)
  .xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_6.zw;
  tmpvar_4.xyw = o_13.xyw;
  tmpvar_4.z = _DitherAlpha;
  tmpvar_3.w = _Opaqueness;
  highp vec2 uv_16;
  uv_16 = tmpvar_1;
  highp vec4 spuvs_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (_glesVertex * 0.5);
  spuvs_17.xy = ((uv_16 * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (tmpvar_18.z * tmpvar_18.z));
  tmpvar_19.y = ((tmpvar_18.y + (0.5 * tmpvar_18.z)) + ((0.5 * tmpvar_18.x) * tmpvar_18.x));
  spuvs_17.zw = ((tmpvar_19 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  mediump vec3 tmpvar_20;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 col_26;
  highp vec4 ndotl_27;
  highp vec4 lengthSq_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosX0 - tmpvar_12.x);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosY0 - tmpvar_12.y);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosZ0 - tmpvar_12.z);
  lengthSq_28 = (tmpvar_29 * tmpvar_29);
  lengthSq_28 = (lengthSq_28 + (tmpvar_30 * tmpvar_30));
  lengthSq_28 = (lengthSq_28 + (tmpvar_31 * tmpvar_31));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (lengthSq_28, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_28 = tmpvar_32;
  ndotl_27 = (tmpvar_29 * tmpvar_9.x);
  ndotl_27 = (ndotl_27 + (tmpvar_30 * tmpvar_9.y));
  ndotl_27 = (ndotl_27 + (tmpvar_31 * tmpvar_9.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_27 * inversesqrt(tmpvar_32)));
  ndotl_27 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (tmpvar_32 * lightAttenSq_25)
  ))));
  col_26 = (lightColor0_21 * tmpvar_34.x);
  col_26 = (col_26 + (lightColor1_22 * tmpvar_34.y));
  col_26 = (col_26 + (lightColor2_23 * tmpvar_34.z));
  col_26 = (col_26 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_20 = col_26;
  tmpvar_5 = tmpvar_20;
  gl_Position = tmpvar_6;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
  xlv_TEXCOORD3 = spuvs_17;
  xlv_TEXCOORD4 = (tmpvar_12.xyz / tmpvar_12.w);
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_4;
  xlv_TEXCOORD7 = normalize((_WorldSpaceCameraPos - tmpvar_12.xyz));
  xlv_TEXCOORD8 = _glesColor;
  xlv_TEXCOORD9 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
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
uniform highp float _RGBloomFactor;
uniform highp float _RGMaskR;
uniform highp float _RGMaskG;
uniform highp float _RGMaskB;
uniform highp float _RGMaskA;
uniform highp float _RGMaskIntensity;
uniform highp vec4 _Color;
uniform highp vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform highp float _Shininess;
uniform mediump float _SpecularIntensity;
uniform mediump float _BloomFactor;
uniform mediump vec3 _LightColor0;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _EmissionBloomFactor;
uniform sampler2D _LightMap;
uniform mediump vec4 _SpecularColor;
uniform mediump vec4 _RimColor;
uniform mediump float _RimPower;
uniform mediump float _RimEdge;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
mediump vec4 xlat_mutable_SPTransitionColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
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
  xlat_mutable_SPTransitionColor = _SPTransitionColor;
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
  mediump vec3 ramp_11;
  mediump vec4 lightmap_12;
  mediump vec4 tex_C_Color_13;
  mediump vec4 outColor_14;
  outColor_14 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_13 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_12 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_18;
  viewDir_9 = xlv_TEXCOORD7;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize((lightDir_10 + viewDir_9));
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
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = max (dot (normalDir_8, tmpvar_19), 0.0);
  highp float tmpvar_28;
  tmpvar_28 = pow (tmpvar_27, _Shininess);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_12.y) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_12.y) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  outColor_14.xyz = (((
    (((_SpecularColor.xyz * vec3((tmpvar_31 * 
      (tmpvar_31 * (3.0 - (2.0 * tmpvar_31)))
    ))) * lightmap_12.x) * _SpecularIntensity)
   * tex_C_Color_13.xyz) + tex_C_Color_13.xyz) + rimLighting_5);
  outColor_14.xyz = (outColor_14.xyz * ramp_11);
  outColor_14.xyz = (outColor_14.xyz * _LightColor0);
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 0.0;
  tmpvar_32.xyz = (_Emission * _EmissionColor.xyz);
  highp vec4 tmpvar_33;
  tmpvar_33 = mix ((_Color * _EnvColor), tmpvar_32, tex_C_Color_13.wwww);
  outColor_14.xyz = (outColor_14.xyz * tmpvar_33.xyz);
  outColor_14.w = _BloomFactor;
  outColor_14.xyz = (outColor_14.xyz + (outColor_14.xyz * xlv_TEXCOORD9));
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD5);
  N_4 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  V_3 = tmpvar_35;
  mediump vec3 reflection_36;
  mediump vec3 R_37;
  mediump float intensity_38;
  mediump vec4 noiseTex_39;
  mediump vec4 spColor_40;
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_SPTex, xlv_TEXCOORD3.xy);
  spColor_40.xyz = tmpvar_41.xyz;
  spColor_40.w = outColor_14.w;
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_SPNoiseTex, xlv_TEXCOORD3.zw);
  noiseTex_39 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (((1.99 * noiseTex_39.x) * _SPNoiseScaler) - 1.0);
  intensity_38 = tmpvar_43;
  highp vec3 tmpvar_44;
  highp vec3 I_45;
  I_45 = ((normalize(
    (V_3 - _WorldSpaceCameraPos)
  ) + (noiseTex_39 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_44 = (I_45 - (2.0 * (
    dot (N_4, I_45)
   * N_4)));
  R_37 = tmpvar_44;
  lowp vec3 tmpvar_46;
  tmpvar_46 = textureCube (_SPCubeMap, R_37).xyz;
  reflection_36 = tmpvar_46;
  highp vec3 tmpvar_47;
  mediump vec3 x_48;
  x_48 = (spColor_40.xyz * _SPOldColor.xyz);
  tmpvar_47 = mix (x_48, ((reflection_36 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_40.xyz = tmpvar_47;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_38 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_38 >= (1.5 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPTransitionColor.xyz = (_SPTransitionColor * _SPTransitionEmissionScaler).xyz;
      xlat_mutable_SPTransitionColor.w = _SPTransitionBloomFactor;
      highp vec4 tmpvar_49;
      tmpvar_49 = mix (spColor_40, xlat_mutable_SPTransitionColor, vec4(clamp ((10.0 * 
        (-(intensity_38) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_40 = tmpvar_49;
    };
  };
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (outColor_14.xyz, spColor_40.xyz, vec3(xlat_mutable_SPIntensity));
  spColor_40.xyz = tmpvar_50;
  outColor_14.xyz = spColor_40.xyz;
  outColor_14.w = mix (spColor_40.w, _EmissionBloomFactor, tex_C_Color_13.w);
  tex_RimMask_2 = xlv_TEXCOORD8;
  mediump vec4 tmpvar_51;
  highp vec4 rimMask_52;
  rimMask_52 = tex_RimMask_2;
  mediump vec4 rgColorRGBA_53;
  mediump vec4 rgColorA_54;
  mediump vec4 rgColorB_55;
  mediump vec4 rgColorG_56;
  mediump vec4 rgColorR_57;
  mediump vec4 rgColor_58;
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = pow (clamp ((1.001 - 
    dot (normalize(xlv_TEXCOORD7), normalize(xlv_TEXCOORD5))
  ), 0.001, 1.0), _RGShininess);
  tmpvar_59 = (_RGBias + (tmpvar_60 * _RGScale));
  mediump vec4 tmpvar_61;
  tmpvar_61 = (tmpvar_59 * _RGColor);
  highp vec4 tmpvar_62;
  tmpvar_62 = (tmpvar_61 * (1.0 - rimMask_52.x));
  rgColorR_57 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 * (1.0 - rimMask_52.y));
  rgColorG_56 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_61 * (1.0 - rimMask_52.z));
  rgColorB_55 = tmpvar_64;
  highp vec4 tmpvar_65;
  tmpvar_65 = (tmpvar_61 * (1.0 - rimMask_52.w));
  rgColorA_54 = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66 = (((
    (rgColorR_57 * _RGMaskR)
   + 
    (rgColorG_56 * _RGMaskG)
  ) + (rgColorB_55 * _RGMaskB)) + (rgColorA_54 * _RGMaskA));
  rgColorRGBA_53.xyz = tmpvar_66.xyz;
  rgColorRGBA_53.w = _RGBloomFactor;
  mediump vec4 tmpvar_67;
  tmpvar_67 = mix (outColor_14, rgColorRGBA_53, vec4(clamp ((
    (rgColorRGBA_53.x + rgColorRGBA_53.y)
   + rgColorRGBA_53.z), 0.0, 1.0)));
  highp vec4 tmpvar_68;
  tmpvar_68 = mix (tmpvar_61, tmpvar_67, vec4(_RGMaskIntensity));
  rgColor_58 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = clamp (tmpvar_59, 0.0, 1.0);
  highp vec4 tmpvar_70;
  tmpvar_70 = mix (outColor_14, rgColor_58, vec4((tmpvar_69 * _RGRatio)));
  tmpvar_51 = tmpvar_70;
  outColor_14 = tmpvar_51;
  highp vec4 scrpos_71;
  scrpos_71 = xlv_TEXCOORD6;
  mediump float a_72;
  a_72 = xlv_TEXCOORD6.z;
  if ((a_72 < 0.95)) {
    scrpos_71.xy = ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) * _ScreenParams.xy);
    a_72 = (a_72 * 17.0);
    highp float tmpvar_73;
    tmpvar_73 = (scrpos_71.y / 4.0);
    highp float tmpvar_74;
    tmpvar_74 = (fract(abs(tmpvar_73)) * 4.0);
    highp float tmpvar_75;
    if ((tmpvar_73 >= 0.0)) {
      tmpvar_75 = tmpvar_74;
    } else {
      tmpvar_75 = -(tmpvar_74);
    };
    highp float tmpvar_76;
    tmpvar_76 = (scrpos_71.x / 4.0);
    highp float tmpvar_77;
    tmpvar_77 = (fract(abs(tmpvar_76)) * 4.0);
    highp float tmpvar_78;
    if ((tmpvar_76 >= 0.0)) {
      tmpvar_78 = tmpvar_77;
    } else {
      tmpvar_78 = -(tmpvar_77);
    };
    highp float x_79;
    x_79 = ((a_72 - _DITHERMATRIX[
      int(tmpvar_75)
    ][
      int(tmpvar_78)
    ]) - 0.01);
    if ((x_79 < 0.0)) {
      discard;
    };
  };
  tmpvar_1 = tmpvar_51;
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
}
Fallback "Diffuse"
CustomEditor "MoleMole.CharacterShaderEditorBase"
}