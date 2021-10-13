//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/Lightmap_Prop_AddLight" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_LightMapIntensity ("Light Map Intensity", Float) = 1
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
_FogTune ("Fog Tune", Range(0, 1)) = 1
_ShadowIntegration ("Shadow Integration", Range(0, 1)) = 0.2
[MHYHeaderBox(MATCAP)] _MatcapMaskMap ("MatcapMask Map", 2D) = "white" { }
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
[MHYHeaderBox(MATCAP SPECULAR)] [Toggle(_SEPARATE_SPECULAR_ON)] _EnableMatcapSpecular ("Enable Sperate Specular", Float) = 0
_SpecularMap ("Specular MatCap", 2D) = "black" { }
_SpecularIntensity ("Specular Intensity", Range(0, 1)) = 0
[MHYHeaderBox(ADDLIGHT)] _AdditiveLightPower ("Additive Light Power", Range(0.1, 5)) = 1
_AdditiveLightIntensity ("Additive Light Intensity", Range(0, 1)) = 1
_Transparent ("_Trans", Range(0, 1)) = 1
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 39156
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_25;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_MatrixV[0].xyz;
  tmpvar_26[1] = unity_MatrixV[1].xyz;
  tmpvar_26[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * worldNorm_5);
  mediump vec3 tmpvar_28;
  tmpvar_28 = (texColor_9.xyz * _Color.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_30 - (2.0 * (
    dot (tmpvar_27, tmpvar_30)
   * tmpvar_27)));
  R_4 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = ((mix (tmpvar_27, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_33;
    highp vec2 P_34;
    P_34 = ((tmpvar_32 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_33 = texture2D (_SpecularMap, P_34);
    matcapSpecular_3 = (tmpvar_33 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MatCap, tmpvar_32);
  mc_2 = tmpvar_35;
  mc_2.xyz = ((mc_2.xyz * tmpvar_28) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_29) + matcapSpecular_3);
  highp vec3 tmpvar_36;
  tmpvar_36 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_28 * tmpvar_29) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_36;
  mediump vec3 tmpvar_37;
  tmpvar_37 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = tmpvar_37;
  tmpvar_38.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_38;
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_25;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_MatrixV[0].xyz;
  tmpvar_26[1] = unity_MatrixV[1].xyz;
  tmpvar_26[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * worldNorm_5);
  mediump vec3 tmpvar_28;
  tmpvar_28 = (texColor_9.xyz * _Color.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_30 - (2.0 * (
    dot (tmpvar_27, tmpvar_30)
   * tmpvar_27)));
  R_4 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = ((mix (tmpvar_27, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_33;
    highp vec2 P_34;
    P_34 = ((tmpvar_32 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_33 = texture2D (_SpecularMap, P_34);
    matcapSpecular_3 = (tmpvar_33 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MatCap, tmpvar_32);
  mc_2 = tmpvar_35;
  mc_2.xyz = ((mc_2.xyz * tmpvar_28) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_29) + matcapSpecular_3);
  highp vec3 tmpvar_36;
  tmpvar_36 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_28 * tmpvar_29) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_36;
  mediump vec3 tmpvar_37;
  tmpvar_37 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = tmpvar_37;
  tmpvar_38.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_38;
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_25;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_MatrixV[0].xyz;
  tmpvar_26[1] = unity_MatrixV[1].xyz;
  tmpvar_26[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * worldNorm_5);
  mediump vec3 tmpvar_28;
  tmpvar_28 = (texColor_9.xyz * _Color.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_30 - (2.0 * (
    dot (tmpvar_27, tmpvar_30)
   * tmpvar_27)));
  R_4 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = ((mix (tmpvar_27, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_33;
    highp vec2 P_34;
    P_34 = ((tmpvar_32 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_33 = texture2D (_SpecularMap, P_34);
    matcapSpecular_3 = (tmpvar_33 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MatCap, tmpvar_32);
  mc_2 = tmpvar_35;
  mc_2.xyz = ((mc_2.xyz * tmpvar_28) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_29) + matcapSpecular_3);
  highp vec3 tmpvar_36;
  tmpvar_36 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_28 * tmpvar_29) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_36;
  mediump vec3 tmpvar_37;
  tmpvar_37 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = tmpvar_37;
  tmpvar_38.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_38;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_25;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_MatrixV[0].xyz;
  tmpvar_26[1] = unity_MatrixV[1].xyz;
  tmpvar_26[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * worldNorm_5);
  mediump vec3 tmpvar_28;
  tmpvar_28 = (texColor_9.xyz * _Color.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_30 - (2.0 * (
    dot (tmpvar_27, tmpvar_30)
   * tmpvar_27)));
  R_4 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = ((mix (tmpvar_27, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_33;
    highp vec2 P_34;
    P_34 = ((tmpvar_32 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_33 = texture2D (_SpecularMap, P_34);
    matcapSpecular_3 = (tmpvar_33 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MatCap, tmpvar_32);
  mc_2 = tmpvar_35;
  mc_2.xyz = ((mc_2.xyz * tmpvar_28) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_29) + matcapSpecular_3);
  highp vec3 tmpvar_36;
  tmpvar_36 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_28 * tmpvar_29) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_36;
  mediump vec3 tmpvar_37;
  tmpvar_37 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = tmpvar_37;
  tmpvar_38.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_38;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_25;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_MatrixV[0].xyz;
  tmpvar_26[1] = unity_MatrixV[1].xyz;
  tmpvar_26[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * worldNorm_5);
  mediump vec3 tmpvar_28;
  tmpvar_28 = (texColor_9.xyz * _Color.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_30 - (2.0 * (
    dot (tmpvar_27, tmpvar_30)
   * tmpvar_27)));
  R_4 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = ((mix (tmpvar_27, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_33;
    highp vec2 P_34;
    P_34 = ((tmpvar_32 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_33 = texture2D (_SpecularMap, P_34);
    matcapSpecular_3 = (tmpvar_33 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MatCap, tmpvar_32);
  mc_2 = tmpvar_35;
  mc_2.xyz = ((mc_2.xyz * tmpvar_28) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_29) + matcapSpecular_3);
  highp vec3 tmpvar_36;
  tmpvar_36 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_28 * tmpvar_29) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_36;
  mediump vec3 tmpvar_37;
  tmpvar_37 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = tmpvar_37;
  tmpvar_38.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_38;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_MatrixV;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_25;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_MatrixV[0].xyz;
  tmpvar_26[1] = unity_MatrixV[1].xyz;
  tmpvar_26[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * worldNorm_5);
  mediump vec3 tmpvar_28;
  tmpvar_28 = (texColor_9.xyz * _Color.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_30 - (2.0 * (
    dot (tmpvar_27, tmpvar_30)
   * tmpvar_27)));
  R_4 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32 = ((mix (tmpvar_27, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_33;
    highp vec2 P_34;
    P_34 = ((tmpvar_32 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_33 = texture2D (_SpecularMap, P_34);
    matcapSpecular_3 = (tmpvar_33 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MatCap, tmpvar_32);
  mc_2 = tmpvar_35;
  mc_2.xyz = ((mc_2.xyz * tmpvar_28) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_29) + matcapSpecular_3);
  highp vec3 tmpvar_36;
  tmpvar_36 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_28 * tmpvar_29) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_36;
  mediump vec3 tmpvar_37;
  tmpvar_37 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.xyz = tmpvar_37;
  tmpvar_38.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_38;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_19;
  vpos_19 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_19.y = ((fract(vpos_19.y) * 0.0625) + unity_LODFade.y);
  lowp float x_20;
  x_20 = (texture2D (_DitherMaskLOD2D, vpos_19).w - 0.5);
  if ((x_20 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_27;
  highp mat3 tmpvar_28;
  tmpvar_28[0] = unity_MatrixV[0].xyz;
  tmpvar_28[1] = unity_MatrixV[1].xyz;
  tmpvar_28[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * worldNorm_5);
  mediump vec3 tmpvar_30;
  tmpvar_30 = (texColor_9.xyz * _Color.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_32 - (2.0 * (
    dot (tmpvar_29, tmpvar_32)
   * tmpvar_29)));
  R_4 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = ((mix (tmpvar_29, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_35;
    highp vec2 P_36;
    P_36 = ((tmpvar_34 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_35 = texture2D (_SpecularMap, P_36);
    matcapSpecular_3 = (tmpvar_35 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_MatCap, tmpvar_34);
  mc_2 = tmpvar_37;
  mc_2.xyz = ((mc_2.xyz * tmpvar_30) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_31) + matcapSpecular_3);
  highp vec3 tmpvar_38;
  tmpvar_38 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_30 * tmpvar_31) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = tmpvar_39;
  tmpvar_40.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_40;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_19;
  vpos_19 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_19.y = ((fract(vpos_19.y) * 0.0625) + unity_LODFade.y);
  lowp float x_20;
  x_20 = (texture2D (_DitherMaskLOD2D, vpos_19).w - 0.5);
  if ((x_20 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_27;
  highp mat3 tmpvar_28;
  tmpvar_28[0] = unity_MatrixV[0].xyz;
  tmpvar_28[1] = unity_MatrixV[1].xyz;
  tmpvar_28[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * worldNorm_5);
  mediump vec3 tmpvar_30;
  tmpvar_30 = (texColor_9.xyz * _Color.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_32 - (2.0 * (
    dot (tmpvar_29, tmpvar_32)
   * tmpvar_29)));
  R_4 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = ((mix (tmpvar_29, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_35;
    highp vec2 P_36;
    P_36 = ((tmpvar_34 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_35 = texture2D (_SpecularMap, P_36);
    matcapSpecular_3 = (tmpvar_35 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_MatCap, tmpvar_34);
  mc_2 = tmpvar_37;
  mc_2.xyz = ((mc_2.xyz * tmpvar_30) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_31) + matcapSpecular_3);
  highp vec3 tmpvar_38;
  tmpvar_38 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_30 * tmpvar_31) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = tmpvar_39;
  tmpvar_40.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_40;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_19;
  vpos_19 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_19.y = ((fract(vpos_19.y) * 0.0625) + unity_LODFade.y);
  lowp float x_20;
  x_20 = (texture2D (_DitherMaskLOD2D, vpos_19).w - 0.5);
  if ((x_20 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_27;
  highp mat3 tmpvar_28;
  tmpvar_28[0] = unity_MatrixV[0].xyz;
  tmpvar_28[1] = unity_MatrixV[1].xyz;
  tmpvar_28[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * worldNorm_5);
  mediump vec3 tmpvar_30;
  tmpvar_30 = (texColor_9.xyz * _Color.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_32 - (2.0 * (
    dot (tmpvar_29, tmpvar_32)
   * tmpvar_29)));
  R_4 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = ((mix (tmpvar_29, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_35;
    highp vec2 P_36;
    P_36 = ((tmpvar_34 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_35 = texture2D (_SpecularMap, P_36);
    matcapSpecular_3 = (tmpvar_35 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_MatCap, tmpvar_34);
  mc_2 = tmpvar_37;
  mc_2.xyz = ((mc_2.xyz * tmpvar_30) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_31) + matcapSpecular_3);
  highp vec3 tmpvar_38;
  tmpvar_38 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_30 * tmpvar_31) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = tmpvar_39;
  tmpvar_40.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_40;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_19;
  vpos_19 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_19.y = ((fract(vpos_19.y) * 0.0625) + unity_LODFade.y);
  lowp float x_20;
  x_20 = (texture2D (_DitherMaskLOD2D, vpos_19).w - 0.5);
  if ((x_20 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_27;
  highp mat3 tmpvar_28;
  tmpvar_28[0] = unity_MatrixV[0].xyz;
  tmpvar_28[1] = unity_MatrixV[1].xyz;
  tmpvar_28[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * worldNorm_5);
  mediump vec3 tmpvar_30;
  tmpvar_30 = (texColor_9.xyz * _Color.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_32 - (2.0 * (
    dot (tmpvar_29, tmpvar_32)
   * tmpvar_29)));
  R_4 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = ((mix (tmpvar_29, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_35;
    highp vec2 P_36;
    P_36 = ((tmpvar_34 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_35 = texture2D (_SpecularMap, P_36);
    matcapSpecular_3 = (tmpvar_35 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_MatCap, tmpvar_34);
  mc_2 = tmpvar_37;
  mc_2.xyz = ((mc_2.xyz * tmpvar_30) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_31) + matcapSpecular_3);
  highp vec3 tmpvar_38;
  tmpvar_38 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_30 * tmpvar_31) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = tmpvar_39;
  tmpvar_40.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_40;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_19;
  vpos_19 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_19.y = ((fract(vpos_19.y) * 0.0625) + unity_LODFade.y);
  lowp float x_20;
  x_20 = (texture2D (_DitherMaskLOD2D, vpos_19).w - 0.5);
  if ((x_20 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_27;
  highp mat3 tmpvar_28;
  tmpvar_28[0] = unity_MatrixV[0].xyz;
  tmpvar_28[1] = unity_MatrixV[1].xyz;
  tmpvar_28[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * worldNorm_5);
  mediump vec3 tmpvar_30;
  tmpvar_30 = (texColor_9.xyz * _Color.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_32 - (2.0 * (
    dot (tmpvar_29, tmpvar_32)
   * tmpvar_29)));
  R_4 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = ((mix (tmpvar_29, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_35;
    highp vec2 P_36;
    P_36 = ((tmpvar_34 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_35 = texture2D (_SpecularMap, P_36);
    matcapSpecular_3 = (tmpvar_35 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_MatCap, tmpvar_34);
  mc_2 = tmpvar_37;
  mc_2.xyz = ((mc_2.xyz * tmpvar_30) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_31) + matcapSpecular_3);
  highp vec3 tmpvar_38;
  tmpvar_38 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_30 * tmpvar_31) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = tmpvar_39;
  tmpvar_40.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_40;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_19;
  vpos_19 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_19.y = ((fract(vpos_19.y) * 0.0625) + unity_LODFade.y);
  lowp float x_20;
  x_20 = (texture2D (_DitherMaskLOD2D, vpos_19).w - 0.5);
  if ((x_20 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_27;
  highp mat3 tmpvar_28;
  tmpvar_28[0] = unity_MatrixV[0].xyz;
  tmpvar_28[1] = unity_MatrixV[1].xyz;
  tmpvar_28[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * worldNorm_5);
  mediump vec3 tmpvar_30;
  tmpvar_30 = (texColor_9.xyz * _Color.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_33;
  tmpvar_33 = (tmpvar_32 - (2.0 * (
    dot (tmpvar_29, tmpvar_32)
   * tmpvar_29)));
  R_4 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34 = ((mix (tmpvar_29, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_35;
    highp vec2 P_36;
    P_36 = ((tmpvar_34 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_35 = texture2D (_SpecularMap, P_36);
    matcapSpecular_3 = (tmpvar_35 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_MatCap, tmpvar_34);
  mc_2 = tmpvar_37;
  mc_2.xyz = ((mc_2.xyz * tmpvar_30) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_31) + matcapSpecular_3);
  highp vec3 tmpvar_38;
  tmpvar_38 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_30 * tmpvar_31) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = tmpvar_39;
  tmpvar_40.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_40;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_MatrixV;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_22;
  highp vec2 screenCoord_23;
  screenCoord_23 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_24;
  shadow_24 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_23);
    shadow_24 = tmpvar_25.x;
  };
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_28;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_MatrixV[0].xyz;
  tmpvar_29[1] = unity_MatrixV[1].xyz;
  tmpvar_29[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * worldNorm_5);
  mediump vec3 tmpvar_31;
  tmpvar_31 = ((texColor_9.xyz * _Color.xyz) * (1.0 - (_ShadowIntegration * 
    (1.0 - shadow_24)
  )));
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_33 - (2.0 * (
    dot (tmpvar_30, tmpvar_33)
   * tmpvar_30)));
  R_4 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = ((mix (tmpvar_30, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_36;
    highp vec2 P_37;
    P_37 = ((tmpvar_35 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_36 = texture2D (_SpecularMap, P_37);
    matcapSpecular_3 = (tmpvar_36 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_MatCap, tmpvar_35);
  mc_2 = tmpvar_38;
  mc_2.xyz = ((mc_2.xyz * tmpvar_31) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_32) + matcapSpecular_3);
  highp vec3 tmpvar_39;
  tmpvar_39 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_31 * tmpvar_32) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = tmpvar_40;
  tmpvar_41.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_41;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_MatrixV;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_22;
  highp vec2 screenCoord_23;
  screenCoord_23 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_24;
  shadow_24 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_23);
    shadow_24 = tmpvar_25.x;
  };
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_28;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_MatrixV[0].xyz;
  tmpvar_29[1] = unity_MatrixV[1].xyz;
  tmpvar_29[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * worldNorm_5);
  mediump vec3 tmpvar_31;
  tmpvar_31 = ((texColor_9.xyz * _Color.xyz) * (1.0 - (_ShadowIntegration * 
    (1.0 - shadow_24)
  )));
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_33 - (2.0 * (
    dot (tmpvar_30, tmpvar_33)
   * tmpvar_30)));
  R_4 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = ((mix (tmpvar_30, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_36;
    highp vec2 P_37;
    P_37 = ((tmpvar_35 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_36 = texture2D (_SpecularMap, P_37);
    matcapSpecular_3 = (tmpvar_36 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_MatCap, tmpvar_35);
  mc_2 = tmpvar_38;
  mc_2.xyz = ((mc_2.xyz * tmpvar_31) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_32) + matcapSpecular_3);
  highp vec3 tmpvar_39;
  tmpvar_39 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_31 * tmpvar_32) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = tmpvar_40;
  tmpvar_41.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_41;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_MatrixV;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_22;
  highp vec2 screenCoord_23;
  screenCoord_23 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_24;
  shadow_24 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_23);
    shadow_24 = tmpvar_25.x;
  };
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_28;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_MatrixV[0].xyz;
  tmpvar_29[1] = unity_MatrixV[1].xyz;
  tmpvar_29[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * worldNorm_5);
  mediump vec3 tmpvar_31;
  tmpvar_31 = ((texColor_9.xyz * _Color.xyz) * (1.0 - (_ShadowIntegration * 
    (1.0 - shadow_24)
  )));
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_33 - (2.0 * (
    dot (tmpvar_30, tmpvar_33)
   * tmpvar_30)));
  R_4 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = ((mix (tmpvar_30, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_36;
    highp vec2 P_37;
    P_37 = ((tmpvar_35 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_36 = texture2D (_SpecularMap, P_37);
    matcapSpecular_3 = (tmpvar_36 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_MatCap, tmpvar_35);
  mc_2 = tmpvar_38;
  mc_2.xyz = ((mc_2.xyz * tmpvar_31) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_32) + matcapSpecular_3);
  highp vec3 tmpvar_39;
  tmpvar_39 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_31 * tmpvar_32) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = tmpvar_40;
  tmpvar_41.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_41;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_MatrixV;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_22;
  highp vec2 screenCoord_23;
  screenCoord_23 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_24;
  shadow_24 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_23);
    shadow_24 = tmpvar_25.x;
  };
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_28;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_MatrixV[0].xyz;
  tmpvar_29[1] = unity_MatrixV[1].xyz;
  tmpvar_29[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * worldNorm_5);
  mediump vec3 tmpvar_31;
  tmpvar_31 = ((texColor_9.xyz * _Color.xyz) * (1.0 - (_ShadowIntegration * 
    (1.0 - shadow_24)
  )));
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_33 - (2.0 * (
    dot (tmpvar_30, tmpvar_33)
   * tmpvar_30)));
  R_4 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = ((mix (tmpvar_30, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_36;
    highp vec2 P_37;
    P_37 = ((tmpvar_35 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_36 = texture2D (_SpecularMap, P_37);
    matcapSpecular_3 = (tmpvar_36 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_MatCap, tmpvar_35);
  mc_2 = tmpvar_38;
  mc_2.xyz = ((mc_2.xyz * tmpvar_31) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_32) + matcapSpecular_3);
  highp vec3 tmpvar_39;
  tmpvar_39 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_31 * tmpvar_32) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = tmpvar_40;
  tmpvar_41.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_41;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_MatrixV;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_22;
  highp vec2 screenCoord_23;
  screenCoord_23 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_24;
  shadow_24 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_23);
    shadow_24 = tmpvar_25.x;
  };
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_28;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_MatrixV[0].xyz;
  tmpvar_29[1] = unity_MatrixV[1].xyz;
  tmpvar_29[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * worldNorm_5);
  mediump vec3 tmpvar_31;
  tmpvar_31 = ((texColor_9.xyz * _Color.xyz) * (1.0 - (_ShadowIntegration * 
    (1.0 - shadow_24)
  )));
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_33 - (2.0 * (
    dot (tmpvar_30, tmpvar_33)
   * tmpvar_30)));
  R_4 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = ((mix (tmpvar_30, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_36;
    highp vec2 P_37;
    P_37 = ((tmpvar_35 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_36 = texture2D (_SpecularMap, P_37);
    matcapSpecular_3 = (tmpvar_36 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_MatCap, tmpvar_35);
  mc_2 = tmpvar_38;
  mc_2.xyz = ((mc_2.xyz * tmpvar_31) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_32) + matcapSpecular_3);
  highp vec3 tmpvar_39;
  tmpvar_39 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_31 * tmpvar_32) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = tmpvar_40;
  tmpvar_41.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_41;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_MatrixV;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_22;
  highp vec2 screenCoord_23;
  screenCoord_23 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_24;
  shadow_24 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_23);
    shadow_24 = tmpvar_25.x;
  };
  mediump float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_28;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_MatrixV[0].xyz;
  tmpvar_29[1] = unity_MatrixV[1].xyz;
  tmpvar_29[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * worldNorm_5);
  mediump vec3 tmpvar_31;
  tmpvar_31 = ((texColor_9.xyz * _Color.xyz) * (1.0 - (_ShadowIntegration * 
    (1.0 - shadow_24)
  )));
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_34;
  tmpvar_34 = (tmpvar_33 - (2.0 * (
    dot (tmpvar_30, tmpvar_33)
   * tmpvar_30)));
  R_4 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35 = ((mix (tmpvar_30, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_36;
    highp vec2 P_37;
    P_37 = ((tmpvar_35 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_36 = texture2D (_SpecularMap, P_37);
    matcapSpecular_3 = (tmpvar_36 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_MatCap, tmpvar_35);
  mc_2 = tmpvar_38;
  mc_2.xyz = ((mc_2.xyz * tmpvar_31) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_32) + matcapSpecular_3);
  highp vec3 tmpvar_39;
  tmpvar_39 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_31 * tmpvar_32) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = tmpvar_40;
  tmpvar_41.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_41;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_19;
  vpos_19 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_19.y = ((fract(vpos_19.y) * 0.0625) + unity_LODFade.y);
  lowp float x_20;
  x_20 = (texture2D (_DitherMaskLOD2D, vpos_19).w - 0.5);
  if ((x_20 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_24;
  highp vec2 screenCoord_25;
  screenCoord_25 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_26;
  shadow_26 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_27;
    tmpvar_27 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_25);
    shadow_26 = tmpvar_27.x;
  };
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_30;
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_MatrixV[0].xyz;
  tmpvar_31[1] = unity_MatrixV[1].xyz;
  tmpvar_31[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * worldNorm_5);
  mediump vec3 tmpvar_33;
  tmpvar_33 = ((texColor_9.xyz * _Color.xyz) * (1.0 - (_ShadowIntegration * 
    (1.0 - shadow_26)
  )));
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 - (2.0 * (
    dot (tmpvar_32, tmpvar_35)
   * tmpvar_32)));
  R_4 = tmpvar_36;
  highp vec2 tmpvar_37;
  tmpvar_37 = ((mix (tmpvar_32, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_38;
    highp vec2 P_39;
    P_39 = ((tmpvar_37 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_38 = texture2D (_SpecularMap, P_39);
    matcapSpecular_3 = (tmpvar_38 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_MatCap, tmpvar_37);
  mc_2 = tmpvar_40;
  mc_2.xyz = ((mc_2.xyz * tmpvar_33) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_34) + matcapSpecular_3);
  highp vec3 tmpvar_41;
  tmpvar_41 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_33 * tmpvar_34) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_41;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = tmpvar_42;
  tmpvar_43.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_43;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_19;
  vpos_19 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_19.y = ((fract(vpos_19.y) * 0.0625) + unity_LODFade.y);
  lowp float x_20;
  x_20 = (texture2D (_DitherMaskLOD2D, vpos_19).w - 0.5);
  if ((x_20 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_24;
  highp vec2 screenCoord_25;
  screenCoord_25 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_26;
  shadow_26 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_27;
    tmpvar_27 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_25);
    shadow_26 = tmpvar_27.x;
  };
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_30;
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_MatrixV[0].xyz;
  tmpvar_31[1] = unity_MatrixV[1].xyz;
  tmpvar_31[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * worldNorm_5);
  mediump vec3 tmpvar_33;
  tmpvar_33 = ((texColor_9.xyz * _Color.xyz) * (1.0 - (_ShadowIntegration * 
    (1.0 - shadow_26)
  )));
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 - (2.0 * (
    dot (tmpvar_32, tmpvar_35)
   * tmpvar_32)));
  R_4 = tmpvar_36;
  highp vec2 tmpvar_37;
  tmpvar_37 = ((mix (tmpvar_32, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_38;
    highp vec2 P_39;
    P_39 = ((tmpvar_37 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_38 = texture2D (_SpecularMap, P_39);
    matcapSpecular_3 = (tmpvar_38 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_MatCap, tmpvar_37);
  mc_2 = tmpvar_40;
  mc_2.xyz = ((mc_2.xyz * tmpvar_33) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_34) + matcapSpecular_3);
  highp vec3 tmpvar_41;
  tmpvar_41 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_33 * tmpvar_34) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_41;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = tmpvar_42;
  tmpvar_43.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_43;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_19;
  vpos_19 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_19.y = ((fract(vpos_19.y) * 0.0625) + unity_LODFade.y);
  lowp float x_20;
  x_20 = (texture2D (_DitherMaskLOD2D, vpos_19).w - 0.5);
  if ((x_20 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_24;
  highp vec2 screenCoord_25;
  screenCoord_25 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_26;
  shadow_26 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_27;
    tmpvar_27 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_25);
    shadow_26 = tmpvar_27.x;
  };
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_30;
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_MatrixV[0].xyz;
  tmpvar_31[1] = unity_MatrixV[1].xyz;
  tmpvar_31[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * worldNorm_5);
  mediump vec3 tmpvar_33;
  tmpvar_33 = ((texColor_9.xyz * _Color.xyz) * (1.0 - (_ShadowIntegration * 
    (1.0 - shadow_26)
  )));
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 - (2.0 * (
    dot (tmpvar_32, tmpvar_35)
   * tmpvar_32)));
  R_4 = tmpvar_36;
  highp vec2 tmpvar_37;
  tmpvar_37 = ((mix (tmpvar_32, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_38;
    highp vec2 P_39;
    P_39 = ((tmpvar_37 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_38 = texture2D (_SpecularMap, P_39);
    matcapSpecular_3 = (tmpvar_38 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_MatCap, tmpvar_37);
  mc_2 = tmpvar_40;
  mc_2.xyz = ((mc_2.xyz * tmpvar_33) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_34) + matcapSpecular_3);
  highp vec3 tmpvar_41;
  tmpvar_41 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_33 * tmpvar_34) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_41;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = tmpvar_42;
  tmpvar_43.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_43;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_19;
  vpos_19 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_19.y = ((fract(vpos_19.y) * 0.0625) + unity_LODFade.y);
  lowp float x_20;
  x_20 = (texture2D (_DitherMaskLOD2D, vpos_19).w - 0.5);
  if ((x_20 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_24;
  highp vec2 screenCoord_25;
  screenCoord_25 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_26;
  shadow_26 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_27;
    tmpvar_27 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_25);
    shadow_26 = tmpvar_27.x;
  };
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_30;
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_MatrixV[0].xyz;
  tmpvar_31[1] = unity_MatrixV[1].xyz;
  tmpvar_31[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * worldNorm_5);
  mediump vec3 tmpvar_33;
  tmpvar_33 = ((texColor_9.xyz * _Color.xyz) * (1.0 - (_ShadowIntegration * 
    (1.0 - shadow_26)
  )));
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 - (2.0 * (
    dot (tmpvar_32, tmpvar_35)
   * tmpvar_32)));
  R_4 = tmpvar_36;
  highp vec2 tmpvar_37;
  tmpvar_37 = ((mix (tmpvar_32, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_38;
    highp vec2 P_39;
    P_39 = ((tmpvar_37 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_38 = texture2D (_SpecularMap, P_39);
    matcapSpecular_3 = (tmpvar_38 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_MatCap, tmpvar_37);
  mc_2 = tmpvar_40;
  mc_2.xyz = ((mc_2.xyz * tmpvar_33) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_34) + matcapSpecular_3);
  highp vec3 tmpvar_41;
  tmpvar_41 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_33 * tmpvar_34) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_41;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = tmpvar_42;
  tmpvar_43.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_43;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_19;
  vpos_19 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_19.y = ((fract(vpos_19.y) * 0.0625) + unity_LODFade.y);
  lowp float x_20;
  x_20 = (texture2D (_DitherMaskLOD2D, vpos_19).w - 0.5);
  if ((x_20 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_24;
  highp vec2 screenCoord_25;
  screenCoord_25 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_26;
  shadow_26 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_27;
    tmpvar_27 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_25);
    shadow_26 = tmpvar_27.x;
  };
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_30;
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_MatrixV[0].xyz;
  tmpvar_31[1] = unity_MatrixV[1].xyz;
  tmpvar_31[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * worldNorm_5);
  mediump vec3 tmpvar_33;
  tmpvar_33 = ((texColor_9.xyz * _Color.xyz) * (1.0 - (_ShadowIntegration * 
    (1.0 - shadow_26)
  )));
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 - (2.0 * (
    dot (tmpvar_32, tmpvar_35)
   * tmpvar_32)));
  R_4 = tmpvar_36;
  highp vec2 tmpvar_37;
  tmpvar_37 = ((mix (tmpvar_32, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_38;
    highp vec2 P_39;
    P_39 = ((tmpvar_37 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_38 = texture2D (_SpecularMap, P_39);
    matcapSpecular_3 = (tmpvar_38 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_MatCap, tmpvar_37);
  mc_2 = tmpvar_40;
  mc_2.xyz = ((mc_2.xyz * tmpvar_33) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_34) + matcapSpecular_3);
  highp vec3 tmpvar_41;
  tmpvar_41 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_33 * tmpvar_34) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_41;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = tmpvar_42;
  tmpvar_43.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_43;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  worldNormal_3 = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.x;
  tmpvar_17.y = worldBinormal_1.x;
  tmpvar_17.z = worldNormal_3.x;
  mediump vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_2.y;
  tmpvar_18.y = worldBinormal_1.y;
  tmpvar_18.z = worldNormal_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_2.z;
  tmpvar_19.y = worldBinormal_1.z;
  tmpvar_19.z = worldNormal_3.z;
  highp float fogTune_20;
  fogTune_20 = _FogTune;
  mediump vec4 tmpvar_21;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_22;
    highp vec3 tmpvar_23;
    tmpvar_23 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_24;
    tmpvar_24 = max (0.0, (sqrt(
      dot (tmpvar_23, tmpvar_23)
    ) - _FogStartDistance));
    highp float tmpvar_25;
    tmpvar_25 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_24))
       * 
        (_FogIntensity * tmpvar_24)
      ) * fogTune_20)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_24)) * (_FogColorIntensity * tmpvar_24))
    ), 0.0, 1.0)));
    fogColor_22.xyz = tmpvar_26;
    fogColor_22.w = tmpvar_25;
    tmpvar_21 = fogColor_22;
  } else {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_20)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, ((_FogEndDistance * fogTune_20) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCOORD5 = tmpvar_18;
  xlv_TEXCOORD6 = tmpvar_19;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 unity_LODFade;
uniform highp mat4 unity_MatrixV;
uniform sampler2D _DitherMaskLOD2D;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _Transparent;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _BloomIntensity;
uniform mediump float _EnableMatcapSpecular;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _ShadowIntegration;
uniform sampler2D _MatcapMaskMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _SpecularMap;
uniform mediump float _MetalRef;
uniform highp vec4 _SpecularMap_ST;
uniform highp float _SpecularIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 finalColor_1;
  highp vec4 mc_2;
  highp vec3 matcapSpecular_3;
  mediump vec3 R_4;
  highp vec3 worldNorm_5;
  mediump vec4 texShadowColor_6;
  mediump vec4 matcapMaskColor_7;
  mediump vec3 normals_8;
  mediump vec4 texColor_9;
  highp float THRESHOLDS_MATRIX_10[16];
  THRESHOLDS_MATRIX_10[0] = 0.05882353;
  THRESHOLDS_MATRIX_10[1] = 0.5294118;
  THRESHOLDS_MATRIX_10[2] = 0.1764706;
  THRESHOLDS_MATRIX_10[3] = 0.6470588;
  THRESHOLDS_MATRIX_10[4] = 0.7647059;
  THRESHOLDS_MATRIX_10[5] = 0.2941177;
  THRESHOLDS_MATRIX_10[6] = 0.8823529;
  THRESHOLDS_MATRIX_10[7] = 0.4117647;
  THRESHOLDS_MATRIX_10[8] = 0.2352941;
  THRESHOLDS_MATRIX_10[9] = 0.7058824;
  THRESHOLDS_MATRIX_10[10] = 0.1176471;
  THRESHOLDS_MATRIX_10[11] = 0.5882353;
  THRESHOLDS_MATRIX_10[12] = 0.9411765;
  THRESHOLDS_MATRIX_10[13] = 0.4705882;
  THRESHOLDS_MATRIX_10[14] = 0.8235294;
  THRESHOLDS_MATRIX_10[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_11;
    tmpvar_11 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_12;
    tmpvar_12 = (tmpvar_11.x / 4.0);
    highp float tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
    highp float tmpvar_14;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_14 = tmpvar_13;
    } else {
      tmpvar_14 = -(tmpvar_13);
    };
    highp float tmpvar_15;
    tmpvar_15 = (tmpvar_11.y / 4.0);
    highp float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
    highp float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    highp float x_18;
    x_18 = (_Transparent - THRESHOLDS_MATRIX_10[int((
      (tmpvar_14 * 4.0)
     + tmpvar_17))]);
    if ((x_18 < 0.0)) {
      discard;
    };
  };
  highp vec2 vpos_19;
  vpos_19 = (((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy) / 4.0);
  vpos_19.y = ((fract(vpos_19.y) * 0.0625) + unity_LODFade.y);
  lowp float x_20;
  x_20 = (texture2D (_DitherMaskLOD2D, vpos_19).w - 0.5);
  if ((x_20 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_9 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0);
  normals_8 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0.xy);
  matcapMaskColor_7 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowTex, xlv_TEXCOORD0.zw);
  texShadowColor_6 = tmpvar_24;
  highp vec2 screenCoord_25;
  screenCoord_25 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_26;
  shadow_26 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_27;
    tmpvar_27 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_25);
    shadow_26 = tmpvar_27.x;
  };
  mediump float tmpvar_28;
  tmpvar_28 = dot (xlv_TEXCOORD4, normals_8);
  worldNorm_5.x = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = dot (xlv_TEXCOORD5, normals_8);
  worldNorm_5.y = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = dot (xlv_TEXCOORD6, normals_8);
  worldNorm_5.z = tmpvar_30;
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_MatrixV[0].xyz;
  tmpvar_31[1] = unity_MatrixV[1].xyz;
  tmpvar_31[2] = unity_MatrixV[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_31 * worldNorm_5);
  mediump vec3 tmpvar_33;
  tmpvar_33 = ((texColor_9.xyz * _Color.xyz) * (1.0 - (_ShadowIntegration * 
    (1.0 - shadow_26)
  )));
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((texShadowColor_6 * 2.0) * _LightMapIntensity).xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 - (2.0 * (
    dot (tmpvar_32, tmpvar_35)
   * tmpvar_32)));
  R_4 = tmpvar_36;
  highp vec2 tmpvar_37;
  tmpvar_37 = ((mix (tmpvar_32, R_4, vec3(_MetalRef)).xy * 0.5) + 0.5);
  matcapSpecular_3 = vec3(0.0, 0.0, 0.0);
  if ((_EnableMatcapSpecular > 0.0)) {
    lowp vec4 tmpvar_38;
    highp vec2 P_39;
    P_39 = ((tmpvar_37 * _SpecularMap_ST.xy) + _SpecularMap_ST.zw);
    tmpvar_38 = texture2D (_SpecularMap, P_39);
    matcapSpecular_3 = (tmpvar_38 * _SpecularIntensity).xyz;
  };
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_MatCap, tmpvar_37);
  mc_2 = tmpvar_40;
  mc_2.xyz = ((mc_2.xyz * tmpvar_33) * vec3(2.0, 2.0, 2.0));
  mc_2.xyz = ((mc_2.xyz * tmpvar_34) + matcapSpecular_3);
  highp vec3 tmpvar_41;
  tmpvar_41 = ((mc_2.xyz * matcapMaskColor_7.x) + ((tmpvar_33 * tmpvar_34) * (1.0 - matcapMaskColor_7.x)));
  finalColor_1 = tmpvar_41;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (finalColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_1 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = tmpvar_42;
  tmpvar_43.w = _BloomIntensity;
  gl_FragData[0] = tmpvar_43;
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
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/AddLight/ADDLIGHT"
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}