//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/LightMapUnity_Matcap_Emission_Fx" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "gray" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (0,0,0,0)
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
_ShadowIntegration ("Shadow Integration", Range(0, 1)) = 0.2
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
_LightMapIntensity ("Light Map Intensity", Range(0, 5)) = 1.5
_FogTune ("Fog Tune", Range(0, 1)) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
[MHYHeaderBox(MATCAP)] [Toggle(MATCAP_ON)] _EnableMatcap ("Enable Matcap", Float) = 0
_MatcapMaskMap ("MatcapMask Map", 2D) = "white" { }
[Toggle(BUMPMAP_ON)] _EnableBumpMap ("Enable Bump Map", Float) = 0
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
_EmissionMask ("Emission Mask", 2D) = "black" { }
[Enum(R,0,G,1,B,2)] _UseChannel ("Use Channel", Float) = 1
[Enum(UV1st,0,UV2nd,1)] _UseSet ("UV Set", Float) = 1
_Emission ("Emission Mask Color", Color) = (0,0,0,0.5)
_EmissionMaskIntensity ("Emission Mask Intensity", Float) = 1
_EmissionGIIntensity ("Emission GI Intensity", Range(0, 10)) = 2
[MHYHeaderBox(ADDLIGHT)] _AdditiveLightPower ("Additive Light Power", Range(0.1, 5)) = 1
_AdditiveLightIntensity ("Additive Light Intensity", Range(0, 1)) = 1
[MHYHeaderBox(EMISSIONMASKTEX)] _EmissionMaskTex ("Emission MaskTex", 2D) = "white" { }
_EmissionMaskTexSpeed ("Emission MaskTex Speed", Vector) = (0,0,0,0)
_EmissionMaskTexIntensity ("EmissionMask Tex Intensity", Float) = 1
_Transparent ("_Trans", Range(0, 1)) = 1
}
SubShader {
 Tags { "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 24431
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_EmissionMask, tmpvar_21).xyz;
  emissionTex_4 = tmpvar_22;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_23;
    tmpvar_23 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_23;
  };
  highp vec3 tmpvar_24;
  tmpvar_24 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMaskTex, tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((tmpvar_26.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(tmpvar_27);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_28));
  mediump vec3 tmpvar_29;
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_5;
  tmpvar_29 = (xlv_COLOR1.xyz + (srcColor_30 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_29;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = colorBlendLightMap_5;
  tmpvar_31.w = _BloomIntensity;
  tmpvar_1 = tmpvar_31;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_EmissionMask, tmpvar_21).xyz;
  emissionTex_4 = tmpvar_22;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_23;
    tmpvar_23 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_23;
  };
  highp vec3 tmpvar_24;
  tmpvar_24 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMaskTex, tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((tmpvar_26.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(tmpvar_27);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_28));
  mediump vec3 tmpvar_29;
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_5;
  tmpvar_29 = (xlv_COLOR1.xyz + (srcColor_30 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_29;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = colorBlendLightMap_5;
  tmpvar_31.w = _BloomIntensity;
  tmpvar_1 = tmpvar_31;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_EmissionMask, tmpvar_21).xyz;
  emissionTex_4 = tmpvar_22;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_23;
    tmpvar_23 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_23;
  };
  highp vec3 tmpvar_24;
  tmpvar_24 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMaskTex, tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((tmpvar_26.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(tmpvar_27);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_28));
  mediump vec3 tmpvar_29;
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_5;
  tmpvar_29 = (xlv_COLOR1.xyz + (srcColor_30 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_29;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = colorBlendLightMap_5;
  tmpvar_31.w = _BloomIntensity;
  tmpvar_1 = tmpvar_31;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_EmissionMask, tmpvar_21).xyz;
  emissionTex_4 = tmpvar_22;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_23;
    tmpvar_23 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_23;
  };
  highp vec3 tmpvar_24;
  tmpvar_24 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMaskTex, tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((tmpvar_26.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(tmpvar_27);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_28));
  mediump vec3 tmpvar_29;
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_5;
  tmpvar_29 = (xlv_COLOR1.xyz + (srcColor_30 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_29;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = colorBlendLightMap_5;
  tmpvar_31.w = _BloomIntensity;
  tmpvar_1 = tmpvar_31;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_EmissionMask, tmpvar_21).xyz;
  emissionTex_4 = tmpvar_22;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_23;
    tmpvar_23 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_23;
  };
  highp vec3 tmpvar_24;
  tmpvar_24 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMaskTex, tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((tmpvar_26.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(tmpvar_27);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_28));
  mediump vec3 tmpvar_29;
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_5;
  tmpvar_29 = (xlv_COLOR1.xyz + (srcColor_30 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_29;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = colorBlendLightMap_5;
  tmpvar_31.w = _BloomIntensity;
  tmpvar_1 = tmpvar_31;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_EmissionMask, tmpvar_21).xyz;
  emissionTex_4 = tmpvar_22;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_23;
    tmpvar_23 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_23;
  };
  highp vec3 tmpvar_24;
  tmpvar_24 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMaskTex, tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = clamp ((tmpvar_26.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_28;
  tmpvar_28 = vec3(tmpvar_27);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_28));
  mediump vec3 tmpvar_29;
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_5;
  tmpvar_29 = (xlv_COLOR1.xyz + (srcColor_30 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_29;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = colorBlendLightMap_5;
  tmpvar_31.w = _BloomIntensity;
  tmpvar_1 = tmpvar_31;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_EmissionMask, tmpvar_20).xyz;
  emissionTex_4 = tmpvar_21;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_22;
    tmpvar_22 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_22;
  };
  highp vec3 tmpvar_23;
  tmpvar_23 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMaskTex, tmpvar_24);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((tmpvar_25.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_27;
  tmpvar_27 = vec3(tmpvar_26);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_27));
  mediump vec3 tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_5;
  tmpvar_28 = (xlv_COLOR1.xyz + (srcColor_29 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_28;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = colorBlendLightMap_5;
  tmpvar_30.w = _BloomIntensity;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_EmissionMask, tmpvar_20).xyz;
  emissionTex_4 = tmpvar_21;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_22;
    tmpvar_22 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_22;
  };
  highp vec3 tmpvar_23;
  tmpvar_23 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMaskTex, tmpvar_24);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((tmpvar_25.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_27;
  tmpvar_27 = vec3(tmpvar_26);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_27));
  mediump vec3 tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_5;
  tmpvar_28 = (xlv_COLOR1.xyz + (srcColor_29 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_28;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = colorBlendLightMap_5;
  tmpvar_30.w = _BloomIntensity;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_EmissionMask, tmpvar_20).xyz;
  emissionTex_4 = tmpvar_21;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_22;
    tmpvar_22 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_22;
  };
  highp vec3 tmpvar_23;
  tmpvar_23 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMaskTex, tmpvar_24);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((tmpvar_25.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_27;
  tmpvar_27 = vec3(tmpvar_26);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_27));
  mediump vec3 tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_5;
  tmpvar_28 = (xlv_COLOR1.xyz + (srcColor_29 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_28;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = colorBlendLightMap_5;
  tmpvar_30.w = _BloomIntensity;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_EmissionMask, tmpvar_20).xyz;
  emissionTex_4 = tmpvar_21;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_22;
    tmpvar_22 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_22;
  };
  highp vec3 tmpvar_23;
  tmpvar_23 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMaskTex, tmpvar_24);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((tmpvar_25.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_27;
  tmpvar_27 = vec3(tmpvar_26);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_27));
  mediump vec3 tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_5;
  tmpvar_28 = (xlv_COLOR1.xyz + (srcColor_29 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_28;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = colorBlendLightMap_5;
  tmpvar_30.w = _BloomIntensity;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_EmissionMask, tmpvar_20).xyz;
  emissionTex_4 = tmpvar_21;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_22;
    tmpvar_22 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_22;
  };
  highp vec3 tmpvar_23;
  tmpvar_23 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMaskTex, tmpvar_24);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((tmpvar_25.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_27;
  tmpvar_27 = vec3(tmpvar_26);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_27));
  mediump vec3 tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_5;
  tmpvar_28 = (xlv_COLOR1.xyz + (srcColor_29 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_28;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = colorBlendLightMap_5;
  tmpvar_30.w = _BloomIntensity;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_EmissionMask, tmpvar_20).xyz;
  emissionTex_4 = tmpvar_21;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_22;
    tmpvar_22 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_22;
  };
  highp vec3 tmpvar_23;
  tmpvar_23 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMaskTex, tmpvar_24);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((tmpvar_25.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_27;
  tmpvar_27 = vec3(tmpvar_26);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_27));
  mediump vec3 tmpvar_28;
  mediump vec3 srcColor_29;
  srcColor_29 = colorBlendLightMap_5;
  tmpvar_28 = (xlv_COLOR1.xyz + (srcColor_29 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_28;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = colorBlendLightMap_5;
  tmpvar_30.w = _BloomIntensity;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23).xyz;
  emissionTex_4 = tmpvar_24;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_25;
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_EmissionMaskTex, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = clamp ((tmpvar_28.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_30;
  tmpvar_30 = vec3(tmpvar_29);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_30));
  mediump vec3 tmpvar_31;
  mediump vec3 srcColor_32;
  srcColor_32 = colorBlendLightMap_5;
  tmpvar_31 = (xlv_COLOR1.xyz + (srcColor_32 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_31;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = colorBlendLightMap_5;
  tmpvar_33.w = _BloomIntensity;
  tmpvar_1 = tmpvar_33;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23).xyz;
  emissionTex_4 = tmpvar_24;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_25;
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_EmissionMaskTex, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = clamp ((tmpvar_28.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_30;
  tmpvar_30 = vec3(tmpvar_29);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_30));
  mediump vec3 tmpvar_31;
  mediump vec3 srcColor_32;
  srcColor_32 = colorBlendLightMap_5;
  tmpvar_31 = (xlv_COLOR1.xyz + (srcColor_32 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_31;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = colorBlendLightMap_5;
  tmpvar_33.w = _BloomIntensity;
  tmpvar_1 = tmpvar_33;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23).xyz;
  emissionTex_4 = tmpvar_24;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_25;
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_EmissionMaskTex, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = clamp ((tmpvar_28.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_30;
  tmpvar_30 = vec3(tmpvar_29);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_30));
  mediump vec3 tmpvar_31;
  mediump vec3 srcColor_32;
  srcColor_32 = colorBlendLightMap_5;
  tmpvar_31 = (xlv_COLOR1.xyz + (srcColor_32 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_31;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = colorBlendLightMap_5;
  tmpvar_33.w = _BloomIntensity;
  tmpvar_1 = tmpvar_33;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23).xyz;
  emissionTex_4 = tmpvar_24;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_25;
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_EmissionMaskTex, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = clamp ((tmpvar_28.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_30;
  tmpvar_30 = vec3(tmpvar_29);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_30));
  mediump vec3 tmpvar_31;
  mediump vec3 srcColor_32;
  srcColor_32 = colorBlendLightMap_5;
  tmpvar_31 = (xlv_COLOR1.xyz + (srcColor_32 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_31;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = colorBlendLightMap_5;
  tmpvar_33.w = _BloomIntensity;
  tmpvar_1 = tmpvar_33;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23).xyz;
  emissionTex_4 = tmpvar_24;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_25;
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_EmissionMaskTex, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = clamp ((tmpvar_28.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_30;
  tmpvar_30 = vec3(tmpvar_29);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_30));
  mediump vec3 tmpvar_31;
  mediump vec3 srcColor_32;
  srcColor_32 = colorBlendLightMap_5;
  tmpvar_31 = (xlv_COLOR1.xyz + (srcColor_32 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_31;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = colorBlendLightMap_5;
  tmpvar_33.w = _BloomIntensity;
  tmpvar_1 = tmpvar_33;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23).xyz;
  emissionTex_4 = tmpvar_24;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_25;
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_EmissionMaskTex, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = clamp ((tmpvar_28.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_30;
  tmpvar_30 = vec3(tmpvar_29);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_30));
  mediump vec3 tmpvar_31;
  mediump vec3 srcColor_32;
  srcColor_32 = colorBlendLightMap_5;
  tmpvar_31 = (xlv_COLOR1.xyz + (srcColor_32 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_31;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = colorBlendLightMap_5;
  tmpvar_33.w = _BloomIntensity;
  tmpvar_1 = tmpvar_33;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_EmissionMask, tmpvar_22).xyz;
  emissionTex_4 = tmpvar_23;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_24;
    tmpvar_24 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_24;
  };
  highp vec3 tmpvar_25;
  tmpvar_25 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMaskTex, tmpvar_26);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((tmpvar_27.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_29;
  tmpvar_29 = vec3(tmpvar_28);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_29));
  mediump vec3 tmpvar_30;
  mediump vec3 srcColor_31;
  srcColor_31 = colorBlendLightMap_5;
  tmpvar_30 = (xlv_COLOR1.xyz + (srcColor_31 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_30;
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = colorBlendLightMap_5;
  tmpvar_32.w = _BloomIntensity;
  tmpvar_1 = tmpvar_32;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_EmissionMask, tmpvar_22).xyz;
  emissionTex_4 = tmpvar_23;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_24;
    tmpvar_24 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_24;
  };
  highp vec3 tmpvar_25;
  tmpvar_25 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMaskTex, tmpvar_26);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((tmpvar_27.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_29;
  tmpvar_29 = vec3(tmpvar_28);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_29));
  mediump vec3 tmpvar_30;
  mediump vec3 srcColor_31;
  srcColor_31 = colorBlendLightMap_5;
  tmpvar_30 = (xlv_COLOR1.xyz + (srcColor_31 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_30;
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = colorBlendLightMap_5;
  tmpvar_32.w = _BloomIntensity;
  tmpvar_1 = tmpvar_32;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_EmissionMask, tmpvar_22).xyz;
  emissionTex_4 = tmpvar_23;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_24;
    tmpvar_24 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_24;
  };
  highp vec3 tmpvar_25;
  tmpvar_25 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMaskTex, tmpvar_26);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((tmpvar_27.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_29;
  tmpvar_29 = vec3(tmpvar_28);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_29));
  mediump vec3 tmpvar_30;
  mediump vec3 srcColor_31;
  srcColor_31 = colorBlendLightMap_5;
  tmpvar_30 = (xlv_COLOR1.xyz + (srcColor_31 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_30;
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = colorBlendLightMap_5;
  tmpvar_32.w = _BloomIntensity;
  tmpvar_1 = tmpvar_32;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_EmissionMask, tmpvar_22).xyz;
  emissionTex_4 = tmpvar_23;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_24;
    tmpvar_24 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_24;
  };
  highp vec3 tmpvar_25;
  tmpvar_25 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMaskTex, tmpvar_26);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((tmpvar_27.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_29;
  tmpvar_29 = vec3(tmpvar_28);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_29));
  mediump vec3 tmpvar_30;
  mediump vec3 srcColor_31;
  srcColor_31 = colorBlendLightMap_5;
  tmpvar_30 = (xlv_COLOR1.xyz + (srcColor_31 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_30;
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = colorBlendLightMap_5;
  tmpvar_32.w = _BloomIntensity;
  tmpvar_1 = tmpvar_32;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_EmissionMask, tmpvar_22).xyz;
  emissionTex_4 = tmpvar_23;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_24;
    tmpvar_24 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_24;
  };
  highp vec3 tmpvar_25;
  tmpvar_25 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMaskTex, tmpvar_26);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((tmpvar_27.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_29;
  tmpvar_29 = vec3(tmpvar_28);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_29));
  mediump vec3 tmpvar_30;
  mediump vec3 srcColor_31;
  srcColor_31 = colorBlendLightMap_5;
  tmpvar_30 = (xlv_COLOR1.xyz + (srcColor_31 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_30;
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = colorBlendLightMap_5;
  tmpvar_32.w = _BloomIntensity;
  tmpvar_1 = tmpvar_32;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    (lmtex_7.xyz * _ShadowColor)
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_EmissionMask, tmpvar_22).xyz;
  emissionTex_4 = tmpvar_23;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_24;
    tmpvar_24 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_24;
  };
  highp vec3 tmpvar_25;
  tmpvar_25 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMaskTex, tmpvar_26);
  highp float tmpvar_28;
  tmpvar_28 = clamp ((tmpvar_27.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_29;
  tmpvar_29 = vec3(tmpvar_28);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_29));
  mediump vec3 tmpvar_30;
  mediump vec3 srcColor_31;
  srcColor_31 = colorBlendLightMap_5;
  tmpvar_30 = (xlv_COLOR1.xyz + (srcColor_31 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_30;
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = colorBlendLightMap_5;
  tmpvar_32.w = _BloomIntensity;
  tmpvar_1 = tmpvar_32;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMask, tmpvar_24).xyz;
  emissionTex_4 = tmpvar_25;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_26;
    tmpvar_26 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_26;
  };
  highp vec3 tmpvar_27;
  tmpvar_27 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_EmissionMaskTex, tmpvar_28);
  highp float tmpvar_30;
  tmpvar_30 = clamp ((tmpvar_29.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_31;
  tmpvar_31 = vec3(tmpvar_30);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_31));
  mediump vec3 tmpvar_32;
  mediump vec3 srcColor_33;
  srcColor_33 = colorBlendLightMap_5;
  tmpvar_32 = (xlv_COLOR1.xyz + (srcColor_33 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_32;
  highp vec4 tmpvar_34;
  tmpvar_34.xyz = colorBlendLightMap_5;
  tmpvar_34.w = _BloomIntensity;
  tmpvar_1 = tmpvar_34;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMask, tmpvar_24).xyz;
  emissionTex_4 = tmpvar_25;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_26;
    tmpvar_26 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_26;
  };
  highp vec3 tmpvar_27;
  tmpvar_27 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_EmissionMaskTex, tmpvar_28);
  highp float tmpvar_30;
  tmpvar_30 = clamp ((tmpvar_29.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_31;
  tmpvar_31 = vec3(tmpvar_30);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_31));
  mediump vec3 tmpvar_32;
  mediump vec3 srcColor_33;
  srcColor_33 = colorBlendLightMap_5;
  tmpvar_32 = (xlv_COLOR1.xyz + (srcColor_33 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_32;
  highp vec4 tmpvar_34;
  tmpvar_34.xyz = colorBlendLightMap_5;
  tmpvar_34.w = _BloomIntensity;
  tmpvar_1 = tmpvar_34;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMask, tmpvar_24).xyz;
  emissionTex_4 = tmpvar_25;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_26;
    tmpvar_26 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_26;
  };
  highp vec3 tmpvar_27;
  tmpvar_27 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_EmissionMaskTex, tmpvar_28);
  highp float tmpvar_30;
  tmpvar_30 = clamp ((tmpvar_29.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_31;
  tmpvar_31 = vec3(tmpvar_30);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_31));
  mediump vec3 tmpvar_32;
  mediump vec3 srcColor_33;
  srcColor_33 = colorBlendLightMap_5;
  tmpvar_32 = (xlv_COLOR1.xyz + (srcColor_33 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_32;
  highp vec4 tmpvar_34;
  tmpvar_34.xyz = colorBlendLightMap_5;
  tmpvar_34.w = _BloomIntensity;
  tmpvar_1 = tmpvar_34;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMask, tmpvar_24).xyz;
  emissionTex_4 = tmpvar_25;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_26;
    tmpvar_26 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_26;
  };
  highp vec3 tmpvar_27;
  tmpvar_27 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_EmissionMaskTex, tmpvar_28);
  highp float tmpvar_30;
  tmpvar_30 = clamp ((tmpvar_29.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_31;
  tmpvar_31 = vec3(tmpvar_30);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_31));
  mediump vec3 tmpvar_32;
  mediump vec3 srcColor_33;
  srcColor_33 = colorBlendLightMap_5;
  tmpvar_32 = (xlv_COLOR1.xyz + (srcColor_33 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_32;
  highp vec4 tmpvar_34;
  tmpvar_34.xyz = colorBlendLightMap_5;
  tmpvar_34.w = _BloomIntensity;
  tmpvar_1 = tmpvar_34;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMask, tmpvar_24).xyz;
  emissionTex_4 = tmpvar_25;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_26;
    tmpvar_26 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_26;
  };
  highp vec3 tmpvar_27;
  tmpvar_27 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_EmissionMaskTex, tmpvar_28);
  highp float tmpvar_30;
  tmpvar_30 = clamp ((tmpvar_29.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_31;
  tmpvar_31 = vec3(tmpvar_30);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_31));
  mediump vec3 tmpvar_32;
  mediump vec3 srcColor_33;
  srcColor_33 = colorBlendLightMap_5;
  tmpvar_32 = (xlv_COLOR1.xyz + (srcColor_33 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_32;
  highp vec4 tmpvar_34;
  tmpvar_34.xyz = colorBlendLightMap_5;
  tmpvar_34.w = _BloomIntensity;
  tmpvar_1 = tmpvar_34;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_17.w;
  lowp vec4 color_18;
  color_18 = tmpvar_17;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_18.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_19;
  highp vec2 screenCoord_20;
  screenCoord_20 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_21;
  shadow_21 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_20);
    shadow_21 = tmpvar_22.x;
  };
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_21))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMask, tmpvar_24).xyz;
  emissionTex_4 = tmpvar_25;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_26;
    tmpvar_26 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_26;
  };
  highp vec3 tmpvar_27;
  tmpvar_27 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_EmissionMaskTex, tmpvar_28);
  highp float tmpvar_30;
  tmpvar_30 = clamp ((tmpvar_29.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_31;
  tmpvar_31 = vec3(tmpvar_30);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_31));
  mediump vec3 tmpvar_32;
  mediump vec3 srcColor_33;
  srcColor_33 = colorBlendLightMap_5;
  tmpvar_32 = (xlv_COLOR1.xyz + (srcColor_33 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_32;
  highp vec4 tmpvar_34;
  tmpvar_34.xyz = colorBlendLightMap_5;
  tmpvar_34.w = _BloomIntensity;
  tmpvar_1 = tmpvar_34;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23).xyz;
  emissionTex_4 = tmpvar_24;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_25;
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_EmissionMaskTex, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = clamp ((tmpvar_28.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_30;
  tmpvar_30 = vec3(tmpvar_29);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_30));
  mediump vec3 tmpvar_31;
  mediump vec3 srcColor_32;
  srcColor_32 = colorBlendLightMap_5;
  tmpvar_31 = (xlv_COLOR1.xyz + (srcColor_32 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_31;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = colorBlendLightMap_5;
  tmpvar_33.w = _BloomIntensity;
  tmpvar_1 = tmpvar_33;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23).xyz;
  emissionTex_4 = tmpvar_24;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_25;
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_EmissionMaskTex, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = clamp ((tmpvar_28.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_30;
  tmpvar_30 = vec3(tmpvar_29);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_30));
  mediump vec3 tmpvar_31;
  mediump vec3 srcColor_32;
  srcColor_32 = colorBlendLightMap_5;
  tmpvar_31 = (xlv_COLOR1.xyz + (srcColor_32 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_31;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = colorBlendLightMap_5;
  tmpvar_33.w = _BloomIntensity;
  tmpvar_1 = tmpvar_33;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23).xyz;
  emissionTex_4 = tmpvar_24;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_25;
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_EmissionMaskTex, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = clamp ((tmpvar_28.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_30;
  tmpvar_30 = vec3(tmpvar_29);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_30));
  mediump vec3 tmpvar_31;
  mediump vec3 srcColor_32;
  srcColor_32 = colorBlendLightMap_5;
  tmpvar_31 = (xlv_COLOR1.xyz + (srcColor_32 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_31;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = colorBlendLightMap_5;
  tmpvar_33.w = _BloomIntensity;
  tmpvar_1 = tmpvar_33;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23).xyz;
  emissionTex_4 = tmpvar_24;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_25;
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_EmissionMaskTex, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = clamp ((tmpvar_28.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_30;
  tmpvar_30 = vec3(tmpvar_29);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_30));
  mediump vec3 tmpvar_31;
  mediump vec3 srcColor_32;
  srcColor_32 = colorBlendLightMap_5;
  tmpvar_31 = (xlv_COLOR1.xyz + (srcColor_32 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_31;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = colorBlendLightMap_5;
  tmpvar_33.w = _BloomIntensity;
  tmpvar_1 = tmpvar_33;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23).xyz;
  emissionTex_4 = tmpvar_24;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_25;
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_EmissionMaskTex, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = clamp ((tmpvar_28.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_30;
  tmpvar_30 = vec3(tmpvar_29);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_30));
  mediump vec3 tmpvar_31;
  mediump vec3 srcColor_32;
  srcColor_32 = colorBlendLightMap_5;
  tmpvar_31 = (xlv_COLOR1.xyz + (srcColor_32 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_31;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = colorBlendLightMap_5;
  tmpvar_33.w = _BloomIntensity;
  tmpvar_1 = tmpvar_33;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_18;
  highp vec2 screenCoord_19;
  screenCoord_19 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_20;
  shadow_20 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_19);
    shadow_20 = tmpvar_21.x;
  };
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_20))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMask, tmpvar_23).xyz;
  emissionTex_4 = tmpvar_24;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_25;
    tmpvar_25 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_25;
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_EmissionMaskTex, tmpvar_27);
  highp float tmpvar_29;
  tmpvar_29 = clamp ((tmpvar_28.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_30;
  tmpvar_30 = vec3(tmpvar_29);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_30));
  mediump vec3 tmpvar_31;
  mediump vec3 srcColor_32;
  srcColor_32 = colorBlendLightMap_5;
  tmpvar_31 = (xlv_COLOR1.xyz + (srcColor_32 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_31;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = colorBlendLightMap_5;
  tmpvar_33.w = _BloomIntensity;
  tmpvar_1 = tmpvar_33;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_21;
  highp vec2 screenCoord_22;
  screenCoord_22 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_23;
  shadow_23 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_22);
    shadow_23 = tmpvar_24.x;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_23))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMask, tmpvar_26).xyz;
  emissionTex_4 = tmpvar_27;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_28;
    tmpvar_28 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_28;
  };
  highp vec3 tmpvar_29;
  tmpvar_29 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_EmissionMaskTex, tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = clamp ((tmpvar_31.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_33;
  tmpvar_33 = vec3(tmpvar_32);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_33));
  mediump vec3 tmpvar_34;
  mediump vec3 srcColor_35;
  srcColor_35 = colorBlendLightMap_5;
  tmpvar_34 = (xlv_COLOR1.xyz + (srcColor_35 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_34;
  highp vec4 tmpvar_36;
  tmpvar_36.xyz = colorBlendLightMap_5;
  tmpvar_36.w = _BloomIntensity;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_21;
  highp vec2 screenCoord_22;
  screenCoord_22 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_23;
  shadow_23 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_22);
    shadow_23 = tmpvar_24.x;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_23))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMask, tmpvar_26).xyz;
  emissionTex_4 = tmpvar_27;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_28;
    tmpvar_28 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_28;
  };
  highp vec3 tmpvar_29;
  tmpvar_29 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_EmissionMaskTex, tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = clamp ((tmpvar_31.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_33;
  tmpvar_33 = vec3(tmpvar_32);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_33));
  mediump vec3 tmpvar_34;
  mediump vec3 srcColor_35;
  srcColor_35 = colorBlendLightMap_5;
  tmpvar_34 = (xlv_COLOR1.xyz + (srcColor_35 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_34;
  highp vec4 tmpvar_36;
  tmpvar_36.xyz = colorBlendLightMap_5;
  tmpvar_36.w = _BloomIntensity;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_21;
  highp vec2 screenCoord_22;
  screenCoord_22 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_23;
  shadow_23 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_22);
    shadow_23 = tmpvar_24.x;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_23))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMask, tmpvar_26).xyz;
  emissionTex_4 = tmpvar_27;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_28;
    tmpvar_28 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_28;
  };
  highp vec3 tmpvar_29;
  tmpvar_29 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_EmissionMaskTex, tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = clamp ((tmpvar_31.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_33;
  tmpvar_33 = vec3(tmpvar_32);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_33));
  mediump vec3 tmpvar_34;
  mediump vec3 srcColor_35;
  srcColor_35 = colorBlendLightMap_5;
  tmpvar_34 = (xlv_COLOR1.xyz + (srcColor_35 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_34;
  highp vec4 tmpvar_36;
  tmpvar_36.xyz = colorBlendLightMap_5;
  tmpvar_36.w = _BloomIntensity;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_21;
  highp vec2 screenCoord_22;
  screenCoord_22 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_23;
  shadow_23 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_22);
    shadow_23 = tmpvar_24.x;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_23))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMask, tmpvar_26).xyz;
  emissionTex_4 = tmpvar_27;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_28;
    tmpvar_28 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_28;
  };
  highp vec3 tmpvar_29;
  tmpvar_29 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_EmissionMaskTex, tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = clamp ((tmpvar_31.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_33;
  tmpvar_33 = vec3(tmpvar_32);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_33));
  mediump vec3 tmpvar_34;
  mediump vec3 srcColor_35;
  srcColor_35 = colorBlendLightMap_5;
  tmpvar_34 = (xlv_COLOR1.xyz + (srcColor_35 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_34;
  highp vec4 tmpvar_36;
  tmpvar_36.xyz = colorBlendLightMap_5;
  tmpvar_36.w = _BloomIntensity;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_21;
  highp vec2 screenCoord_22;
  screenCoord_22 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_23;
  shadow_23 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_22);
    shadow_23 = tmpvar_24.x;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_23))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMask, tmpvar_26).xyz;
  emissionTex_4 = tmpvar_27;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_28;
    tmpvar_28 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_28;
  };
  highp vec3 tmpvar_29;
  tmpvar_29 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_EmissionMaskTex, tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = clamp ((tmpvar_31.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_33;
  tmpvar_33 = vec3(tmpvar_32);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_33));
  mediump vec3 tmpvar_34;
  mediump vec3 srcColor_35;
  srcColor_35 = colorBlendLightMap_5;
  tmpvar_34 = (xlv_COLOR1.xyz + (srcColor_35 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_34;
  highp vec4 tmpvar_36;
  tmpvar_36.xyz = colorBlendLightMap_5;
  tmpvar_36.w = _BloomIntensity;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_Lightmap, xlv_TEXCOORD0.zw);
  lmtex_7.w = tmpvar_19.w;
  lowp vec4 color_20;
  color_20 = tmpvar_19;
  lmtex_7.xyz = (unity_Lightmap_HDR.x * color_20.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_21;
  highp vec2 screenCoord_22;
  screenCoord_22 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_23;
  shadow_23 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_22);
    shadow_23 = tmpvar_24.x;
  };
  mediump vec3 tmpvar_25;
  tmpvar_25 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_23))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_27;
  tmpvar_27 = texture2D (_EmissionMask, tmpvar_26).xyz;
  emissionTex_4 = tmpvar_27;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_28;
    tmpvar_28 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_28;
  };
  highp vec3 tmpvar_29;
  tmpvar_29 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_EmissionMaskTex, tmpvar_30);
  highp float tmpvar_32;
  tmpvar_32 = clamp ((tmpvar_31.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_33;
  tmpvar_33 = vec3(tmpvar_32);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_33));
  mediump vec3 tmpvar_34;
  mediump vec3 srcColor_35;
  srcColor_35 = colorBlendLightMap_5;
  tmpvar_34 = (xlv_COLOR1.xyz + (srcColor_35 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_34;
  highp vec4 tmpvar_36;
  tmpvar_36.xyz = colorBlendLightMap_5;
  tmpvar_36.w = _BloomIntensity;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_20;
  highp vec2 screenCoord_21;
  screenCoord_21 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_22;
  shadow_22 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_21);
    shadow_22 = tmpvar_23.x;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_22))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMask, tmpvar_25).xyz;
  emissionTex_4 = tmpvar_26;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_27;
    tmpvar_27 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_27;
  };
  highp vec3 tmpvar_28;
  tmpvar_28 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_28;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_EmissionMaskTex, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = clamp ((tmpvar_30.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_32;
  tmpvar_32 = vec3(tmpvar_31);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_32));
  mediump vec3 tmpvar_33;
  mediump vec3 srcColor_34;
  srcColor_34 = colorBlendLightMap_5;
  tmpvar_33 = (xlv_COLOR1.xyz + (srcColor_34 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_33;
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = colorBlendLightMap_5;
  tmpvar_35.w = _BloomIntensity;
  tmpvar_1 = tmpvar_35;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_20;
  highp vec2 screenCoord_21;
  screenCoord_21 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_22;
  shadow_22 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_21);
    shadow_22 = tmpvar_23.x;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_22))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMask, tmpvar_25).xyz;
  emissionTex_4 = tmpvar_26;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_27;
    tmpvar_27 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_27;
  };
  highp vec3 tmpvar_28;
  tmpvar_28 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_28;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_EmissionMaskTex, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = clamp ((tmpvar_30.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_32;
  tmpvar_32 = vec3(tmpvar_31);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_32));
  mediump vec3 tmpvar_33;
  mediump vec3 srcColor_34;
  srcColor_34 = colorBlendLightMap_5;
  tmpvar_33 = (xlv_COLOR1.xyz + (srcColor_34 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_33;
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = colorBlendLightMap_5;
  tmpvar_35.w = _BloomIntensity;
  tmpvar_1 = tmpvar_35;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_3 = _glesMultiTexCoord1.xy;
  tmpvar_2.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase.xyz + (h_21 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_23 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  tmpvar_13 = tmpvar_15;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_20;
  highp vec2 screenCoord_21;
  screenCoord_21 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_22;
  shadow_22 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_21);
    shadow_22 = tmpvar_23.x;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_22))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMask, tmpvar_25).xyz;
  emissionTex_4 = tmpvar_26;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_27;
    tmpvar_27 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_27;
  };
  highp vec3 tmpvar_28;
  tmpvar_28 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_28;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_EmissionMaskTex, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = clamp ((tmpvar_30.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_32;
  tmpvar_32 = vec3(tmpvar_31);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_32));
  mediump vec3 tmpvar_33;
  mediump vec3 srcColor_34;
  srcColor_34 = colorBlendLightMap_5;
  tmpvar_33 = (xlv_COLOR1.xyz + (srcColor_34 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_33;
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = colorBlendLightMap_5;
  tmpvar_35.w = _BloomIntensity;
  tmpvar_1 = tmpvar_35;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_20;
  highp vec2 screenCoord_21;
  screenCoord_21 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_22;
  shadow_22 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_21);
    shadow_22 = tmpvar_23.x;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_22))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMask, tmpvar_25).xyz;
  emissionTex_4 = tmpvar_26;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_27;
    tmpvar_27 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_27;
  };
  highp vec3 tmpvar_28;
  tmpvar_28 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_28;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_EmissionMaskTex, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = clamp ((tmpvar_30.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_32;
  tmpvar_32 = vec3(tmpvar_31);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_32));
  mediump vec3 tmpvar_33;
  mediump vec3 srcColor_34;
  srcColor_34 = colorBlendLightMap_5;
  tmpvar_33 = (xlv_COLOR1.xyz + (srcColor_34 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_33;
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = colorBlendLightMap_5;
  tmpvar_35.w = _BloomIntensity;
  tmpvar_1 = tmpvar_35;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_20;
  highp vec2 screenCoord_21;
  screenCoord_21 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_22;
  shadow_22 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_21);
    shadow_22 = tmpvar_23.x;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_22))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMask, tmpvar_25).xyz;
  emissionTex_4 = tmpvar_26;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_27;
    tmpvar_27 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_27;
  };
  highp vec3 tmpvar_28;
  tmpvar_28 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_28;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_EmissionMaskTex, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = clamp ((tmpvar_30.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_32;
  tmpvar_32 = vec3(tmpvar_31);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_32));
  mediump vec3 tmpvar_33;
  mediump vec3 srcColor_34;
  srcColor_34 = colorBlendLightMap_5;
  tmpvar_33 = (xlv_COLOR1.xyz + (srcColor_34 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_33;
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = colorBlendLightMap_5;
  tmpvar_35.w = _BloomIntensity;
  tmpvar_1 = tmpvar_35;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _LerpFactor;
uniform highp vec4 _HeigtFogParams2;
uniform highp vec4 _HeigtFogParams3;
uniform highp vec4 _HeigtFogRamp2;
uniform highp vec4 _HeigtFogRamp3;
uniform highp vec4 _HeigtFogColBase2;
uniform highp vec4 _HeigtFogColBase3;
uniform highp vec4 _HeigtFogColDelta2;
uniform highp vec4 _HeigtFogColDelta3;
uniform highp vec4 _HeigtFogColParams2;
uniform highp vec4 _HeigtFogColParams3;
uniform highp vec4 _HeigtFogRadialCol2;
uniform highp vec4 _HeigtFogRadialCol3;
uniform highp vec4 _Mihoyo_FogColor2;
uniform highp vec4 _Mihoyo_FogColor3;
uniform highp vec4 _MainMaps_ST;
uniform highp vec4 _PropertyLightmapTexTS;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_2 = _glesMultiTexCoord1.xy;
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
  tmpvar_3 = _glesColor;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  mediump vec4 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_15;
  mediump float fogFactor_16;
  mediump vec3 fogColor_17;
  mediump vec3 heightFogColor_18;
  highp float HeightFogFactor_19;
  mediump vec3 atomesphereFogColor_20;
  mediump float h_21;
  highp float linearFogDensity_22;
  mediump float len_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_23 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_23 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_22 = (tmpvar_25 * (2.0 - tmpvar_25));
  if ((len_23 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_22 = (linearFogDensity_22 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_26;
  tmpvar_26 = min (pow (linearFogDensity_22, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_22 = tmpvar_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  h_21 = (tmpvar_27 * (2.0 - tmpvar_27));
  highp vec3 tmpvar_29;
  tmpvar_29 = (_HeigtFogColBase2.xyz + (h_21 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_20 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (atomesphereFogColor_20, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_23 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_20 = tmpvar_30;
  mediump float tmpvar_31;
  mediump float r_32;
  mediump float f_33;
  mediump float u_34;
  mediump float l_35;
  mediump float fogInt_36;
  fogInt_36 = 1.0;
  highp float tmpvar_37;
  tmpvar_37 = (_HeigtFogParams2.x * tmpvar_14.y);
  highp float tmpvar_38;
  tmpvar_38 = abs(tmpvar_37);
  if ((tmpvar_38 > 0.01)) {
    highp float tmpvar_39;
    tmpvar_39 = exp(-(tmpvar_37));
    fogInt_36 = ((1.0 - tmpvar_39) / tmpvar_37);
  };
  highp float tmpvar_40;
  tmpvar_40 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_35 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (l_35 * _HeigtFogParams2.y);
  u_34 = tmpvar_41;
  fogInt_36 = (fogInt_36 * u_34);
  mediump float tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((l_35 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_42 = tmpvar_43;
  r_32 = (tmpvar_42 * (2.0 - tmpvar_42));
  r_32 = ((r_32 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_33 = ((1.0 - clamp (
    exp2(-(fogInt_36))
  , 0.0, 1.0)) * r_32);
  highp float tmpvar_44;
  tmpvar_44 = min (f_33, _HeigtFogColBase2.w);
  tmpvar_31 = tmpvar_44;
  HeightFogFactor_19 = tmpvar_31;
  highp vec3 tmpvar_45;
  tmpvar_45 = _Mihoyo_FogColor2.xyz;
  heightFogColor_18 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = ((heightFogColor_18 * HeightFogFactor_19) + ((atomesphereFogColor_20 * tmpvar_26) * (1.0 - HeightFogFactor_19)));
  fogColor_17 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = ((1.0 - tmpvar_26) * (1.0 - HeightFogFactor_19));
  fogFactor_16 = tmpvar_47;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = fogColor_17;
  tmpvar_48.w = fogFactor_16;
  tmpvar_15 = tmpvar_48;
  highp vec4 tmpvar_49;
  mediump float fogFactor_50;
  mediump vec3 fogColor_51;
  mediump vec3 heightFogColor_52;
  highp float HeightFogFactor_53;
  mediump vec3 atomesphereFogColor_54;
  mediump float h_55;
  highp float linearFogDensity_56;
  mediump float len_57;
  highp float tmpvar_58;
  tmpvar_58 = sqrt(dot (tmpvar_14, tmpvar_14));
  len_57 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((len_57 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_56 = (tmpvar_59 * (2.0 - tmpvar_59));
  if ((len_57 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_56 = (linearFogDensity_56 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_60;
  tmpvar_60 = min (pow (linearFogDensity_56, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_56 = tmpvar_60;
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  h_55 = (tmpvar_61 * (2.0 - tmpvar_61));
  highp vec3 tmpvar_63;
  tmpvar_63 = (_HeigtFogColBase3.xyz + (h_55 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_54 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (atomesphereFogColor_54, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_57 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_54 = tmpvar_64;
  mediump float tmpvar_65;
  mediump float r_66;
  mediump float f_67;
  mediump float u_68;
  mediump float l_69;
  mediump float fogInt_70;
  fogInt_70 = 1.0;
  highp float tmpvar_71;
  tmpvar_71 = (_HeigtFogParams3.x * tmpvar_14.y);
  highp float tmpvar_72;
  tmpvar_72 = abs(tmpvar_71);
  if ((tmpvar_72 > 0.01)) {
    highp float tmpvar_73;
    tmpvar_73 = exp(-(tmpvar_71));
    fogInt_70 = ((1.0 - tmpvar_73) / tmpvar_71);
  };
  highp float tmpvar_74;
  tmpvar_74 = sqrt(dot (tmpvar_14, tmpvar_14));
  l_69 = tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = (l_69 * _HeigtFogParams3.y);
  u_68 = tmpvar_75;
  fogInt_70 = (fogInt_70 * u_68);
  mediump float tmpvar_76;
  highp float tmpvar_77;
  tmpvar_77 = clamp (((l_69 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_76 = tmpvar_77;
  r_66 = (tmpvar_76 * (2.0 - tmpvar_76));
  r_66 = ((r_66 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_67 = ((1.0 - clamp (
    exp2(-(fogInt_70))
  , 0.0, 1.0)) * r_66);
  highp float tmpvar_78;
  tmpvar_78 = min (f_67, _HeigtFogColBase3.w);
  tmpvar_65 = tmpvar_78;
  HeightFogFactor_53 = tmpvar_65;
  highp vec3 tmpvar_79;
  tmpvar_79 = _Mihoyo_FogColor3.xyz;
  heightFogColor_52 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = ((heightFogColor_52 * HeightFogFactor_53) + ((atomesphereFogColor_54 * tmpvar_60) * (1.0 - HeightFogFactor_53)));
  fogColor_51 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = ((1.0 - tmpvar_60) * (1.0 - HeightFogFactor_53));
  fogFactor_50 = tmpvar_81;
  mediump vec4 tmpvar_82;
  tmpvar_82.xyz = fogColor_51;
  tmpvar_82.w = fogFactor_50;
  tmpvar_49 = tmpvar_82;
  highp vec4 tmpvar_83;
  tmpvar_83 = mix (tmpvar_15, tmpvar_49, vec4(_LerpFactor));
  tmpvar_13 = tmpvar_83;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = o_7;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform mediump float _BloomIntensity;
uniform mediump vec3 _ShadowColor;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform mediump vec3 _LightingColor;
uniform highp float _EmissionMaskIntensity;
uniform sampler2D _EmissionMaskTex;
uniform highp vec4 _EmissionMaskTex_ST;
uniform highp vec2 _EmissionMaskTexSpeed;
uniform highp float _EmissionMaskTexIntensity;
uniform sampler2D _EmissionMask;
uniform mediump vec4 _Emission;
uniform highp int _UseChannel;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 emissionColor_2;
  mediump float emissionMask_3;
  mediump vec3 emissionTex_4;
  highp vec3 colorBlendLightMap_5;
  mediump vec4 tex_C_Color_6;
  mediump vec4 lmtex_7;
  highp float THRESHOLDS_MATRIX_8[16];
  THRESHOLDS_MATRIX_8[0] = 0.05882353;
  THRESHOLDS_MATRIX_8[1] = 0.5294118;
  THRESHOLDS_MATRIX_8[2] = 0.1764706;
  THRESHOLDS_MATRIX_8[3] = 0.6470588;
  THRESHOLDS_MATRIX_8[4] = 0.7647059;
  THRESHOLDS_MATRIX_8[5] = 0.2941177;
  THRESHOLDS_MATRIX_8[6] = 0.8823529;
  THRESHOLDS_MATRIX_8[7] = 0.4117647;
  THRESHOLDS_MATRIX_8[8] = 0.2352941;
  THRESHOLDS_MATRIX_8[9] = 0.7058824;
  THRESHOLDS_MATRIX_8[10] = 0.1176471;
  THRESHOLDS_MATRIX_8[11] = 0.5882353;
  THRESHOLDS_MATRIX_8[12] = 0.9411765;
  THRESHOLDS_MATRIX_8[13] = 0.4705882;
  THRESHOLDS_MATRIX_8[14] = 0.8235294;
  THRESHOLDS_MATRIX_8[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_9;
    tmpvar_9 = ((xlv_TEXCOORD3 / xlv_TEXCOORD3.w).xy * _ScreenParams.xy);
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_9.x / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float tmpvar_13;
    tmpvar_13 = (tmpvar_9.y / 4.0);
    highp float tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * 4.0);
    highp float tmpvar_15;
    if ((tmpvar_13 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    highp float x_16;
    x_16 = (_Transparent - THRESHOLDS_MATRIX_8[int((
      (tmpvar_12 * 4.0)
     + tmpvar_15))]);
    if ((x_16 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_17;
  vpos_17 = (((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy) / 4.0);
  vpos_17.y = ((fract(vpos_17.y) * 0.0625) + unity_LODFade.y);
  lowp float x_18;
  x_18 = (texture2D (_DitherMaskLOD2D, vpos_17).w - 0.5);
  if ((x_18 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD0.zw);
  lmtex_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tex_C_Color_6 = tmpvar_20;
  highp vec2 screenCoord_21;
  screenCoord_21 = (xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w);
  mediump float shadow_22;
  shadow_22 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_21);
    shadow_22 = tmpvar_23.x;
  };
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((tex_C_Color_6.xyz * _Color.xyz) * ((
    ((lmtex_7.xyz * _ShadowColor) * (1.0 - (clamp (
      (lmtex_7.x - _ShadowIntegration)
    , 0.0, 1.0) * (1.0 - shadow_22))))
   * _LightMapIntensity) + _LightingColor));
  colorBlendLightMap_5 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = mix (xlv_TEXCOORD0.xy, xlv_TEXCOORD1, vec2(float(_UseSet)));
  lowp vec3 tmpvar_26;
  tmpvar_26 = texture2D (_EmissionMask, tmpvar_25).xyz;
  emissionTex_4 = tmpvar_26;
  emissionMask_3 = 0.0;
  if ((_UseChannel == 2)) {
    emissionMask_3 = emissionTex_4.z;
  } else {
    highp float tmpvar_27;
    tmpvar_27 = mix (emissionTex_4.x, emissionTex_4.y, float(_UseChannel));
    emissionMask_3 = tmpvar_27;
  };
  highp vec3 tmpvar_28;
  tmpvar_28 = (((
    (emissionMask_3 * _EmissionMaskIntensity)
   * _Emission.xyz) * _Emission.w) * 2.0);
  emissionColor_2 = tmpvar_28;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((_Time.y * _EmissionMaskTexSpeed) + ((xlv_TEXCOORD1 * _EmissionMaskTex_ST.xy) + _EmissionMaskTex_ST.zw));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_EmissionMaskTex, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = clamp ((tmpvar_30.x * _EmissionMaskTexIntensity), 0.0, 1.0);
  mediump vec3 tmpvar_32;
  tmpvar_32 = vec3(tmpvar_31);
  colorBlendLightMap_5 = (colorBlendLightMap_5 + (emissionColor_2 * tmpvar_32));
  mediump vec3 tmpvar_33;
  mediump vec3 srcColor_34;
  srcColor_34 = colorBlendLightMap_5;
  tmpvar_33 = (xlv_COLOR1.xyz + (srcColor_34 * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  colorBlendLightMap_5 = tmpvar_33;
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = colorBlendLightMap_5;
  tmpvar_35.w = _BloomIntensity;
  tmpvar_1 = tmpvar_35;
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
Keywords { "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Meta/META"
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}