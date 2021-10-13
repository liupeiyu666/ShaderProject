//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/Scene_Air_LightMap_Matcap_Sand" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_LightMapIntensity ("Light Map Intensity", Float) = 1
[MHYHeaderBox(MATCAP)] _MatcapMaskMap ("MatcapMask Map", 2D) = "white" { }
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
[MHYHeaderBox(Fresnel)] _fresnelColA ("FresnelCol", Color) = (1,1,1,1)
_fresnelBaseA ("FresnelBase", Range(0, 4)) = 0
_fresnelScaleA ("FresnelScale", Range(0, 4)) = 0
_fresnelIndensity ("FresnelIndensity", Range(0, 5)) = 5
[MHYHeaderBox(FOG)] _FogTune ("Fog Tune", Range(0, 1)) = 1
[MHYHeaderBox(Blink)] _LightPosition ("LightPosition", Vector) = (0,0,0,0)
_SandShineTex ("SandShineTex", 2D) = "white" { }
_SecondTexColor ("SecondTexColor", Color) = (1,1,1,0)
_SecondTexIntensity ("SecondTexIntensity", Float) = -0.15
_HeiLightGlass ("HeiLightGlass", Float) = 1
_HeiLightTexSpeed ("HeiLightTexSpeed", Vector) = (0,0,0,0)
_HeiLightTexTilling ("HeiLightTexTilling", Vector) = (1,1,0,0)
_HeiLightInvertColor ("HeiLightInvertColor", Color) = (0,0,0,0)
_HeiLightInvertIntensity ("HeiLightInvertIntensity", Float) = 1
_HeiLightPointColor ("HeiLightPointColor", Color) = (1,1,1,0)
_HeiLightPointIntensity ("HeiLightPointIntensity", Float) = 1
_HeiLightPointStep ("HeiLightPointStep", Float) = 0.53
_HeiLightPointStepWidth ("HeiLightPointStepWidth", Float) = 0
_HeiLightPointTilling ("HeiLightPointTilling", Vector) = (1,1,0,0)
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 34895
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
attribute vec4 _glesMultiTexCoord3;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1 = _glesMultiTexCoord2;
  tmpvar_2 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_3;
  mediump vec3 worldTangent_4;
  mediump vec3 worldNormal_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  tmpvar_12 = (_glesNormal * tmpvar_15);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = (_WorldSpaceLightPos0.xyz - (tmpvar_16.xyz * _WorldSpaceLightPos0.w));
  tmpvar_13 = (_WorldSpaceCameraPos - tmpvar_16.xyz);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_5 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * _glesTANGENT.w);
  worldBinormal_3 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_4.x;
  tmpvar_23.y = worldBinormal_3.x;
  tmpvar_23.z = worldNormal_5.x;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = worldTangent_4.y;
  tmpvar_24.y = worldBinormal_3.y;
  tmpvar_24.z = worldNormal_5.y;
  mediump vec3 tmpvar_25;
  tmpvar_25.x = worldTangent_4.z;
  tmpvar_25.y = worldBinormal_3.z;
  tmpvar_25.z = worldNormal_5.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_glesNormal);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_28;
  highp vec3 tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_28 = _glesTANGENT.xyz;
  tmpvar_29 = (((tmpvar_26.yzx * tmpvar_27.zxy) - (tmpvar_26.zxy * tmpvar_27.yzx)) * _glesTANGENT.w);
  tmpvar_30 = _glesNormal;
  highp mat3 tmpvar_31;
  tmpvar_31[0].x = tmpvar_28.x;
  tmpvar_31[0].y = tmpvar_29.x;
  tmpvar_31[0].z = tmpvar_30.x;
  tmpvar_31[1].x = tmpvar_28.y;
  tmpvar_31[1].y = tmpvar_29.y;
  tmpvar_31[1].z = tmpvar_30.y;
  tmpvar_31[2].x = tmpvar_28.z;
  tmpvar_31[2].y = tmpvar_29.z;
  tmpvar_31[2].z = tmpvar_30.z;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = normalize((tmpvar_31 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_32)
  .xyz)));
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_33;
  fogTune_33 = _FogTune;
  mediump vec4 tmpvar_34;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    tmpvar_38 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_37))
       * 
        (_FogIntensity * tmpvar_37)
      ) * fogTune_33)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_37)) * (_FogColorIntensity * tmpvar_37))
    ), 0.0, 1.0)));
    fogColor_35.xyz = tmpvar_39;
    fogColor_35.w = tmpvar_38;
    tmpvar_34 = fogColor_35;
  } else {
    mediump vec4 fogColor_40;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_42;
    tmpvar_42 = max (0.0, (sqrt(
      dot (tmpvar_41, tmpvar_41)
    ) - _FogStartDistance));
    highp float tmpvar_43;
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_44;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_34;
  xlv_TEXCOORD2 = tmpvar_23;
  xlv_TEXCOORD3 = tmpvar_24;
  xlv_TEXCOORD4 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_TEXCOORD8 = tmpvar_12;
  xlv_TEXCOORD9 = tmpvar_13;
  xlv_TEXCOORD10 = tmpvar_1;
  xlv_TEXCOORD11 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform highp float _HeiLightGlass;
uniform highp float _HeiLightInvertIntensity;
uniform highp vec4 _HeiLightInvertColor;
uniform sampler2D _SandShineTex;
uniform highp vec4 _SandShineTex_ST;
uniform highp vec2 _HeiLightTexSpeed;
uniform highp vec2 _HeiLightTexTilling;
uniform highp float _HeiLightPointStep;
uniform highp float _HeiLightPointStepWidth;
uniform highp vec2 _HeiLightPointTilling;
uniform highp vec4 _HeiLightPointColor;
uniform highp float _HeiLightPointIntensity;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform highp vec4 _LightPosition;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  mediump vec3 OutColor_1;
  highp float smoothstepResult1_2;
  highp vec4 HeiLightTex_3;
  mediump vec3 colorBlendLightMap_4;
  highp vec4 mc_5;
  highp vec3 worldNorm_6;
  mediump float matcapMask_7;
  mediump vec4 tex_S_Color_8;
  mediump vec3 normals_9;
  mediump vec4 tex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_8 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD2, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD3, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  worldNorm_6 = (tmpvar_18 * worldNorm_6);
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (worldNorm_6, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_6, xlv_TEXCOORD5) * worldNorm_6))
  )), vec3(_MetalRef));
  worldNorm_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((tmpvar_19.xy * 0.5) + 0.5);
  tmpvar_20 = texture2D (_MatCap, P_21);
  mc_5 = tmpvar_20;
  mc_5.xyz = mix (vec3(1.0, 1.0, 1.0), mc_5.xyz, vec3(matcapMask_7));
  mc_5 = ((mc_5 * tex_10) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_22;
  tmpvar_22 = ((mc_5.xyz * (
    (((2.0 * tex_S_Color_8.xyz) * tex_S_Color_8.w) + 1.0)
   - tex_S_Color_8.w)) * _LightMapIntensity);
  colorBlendLightMap_4 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD8);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD9);
  highp float tmpvar_25;
  tmpvar_25 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (tmpvar_23, tmpvar_24))
  , _fresnelIndensity)));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + (tmpvar_25 * _fresnelColA.xyz));
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (colorBlendLightMap_4, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = pow (dot (normalize(
    (_LightPosition.xyz + tmpvar_24)
  ), tmpvar_23), _HeiLightGlass);
  highp vec2 tmpvar_28;
  tmpvar_28 = ((_Time.y * _HeiLightTexSpeed) + (xlv_TEXCOORD11.xy * _HeiLightTexTilling));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SandShineTex, tmpvar_28);
  HeiLightTex_3 = tmpvar_29;
  lowp float tmpvar_30;
  lowp float tmpvar_31;
  tmpvar_31 = clamp (((texture2D (_SandShineTex, tmpvar_28).y - 1.0) / 0.3), 0.0, 1.0);
  tmpvar_30 = (tmpvar_31 * (tmpvar_31 * (3.0 - 
    (2.0 * tmpvar_31)
  )));
  smoothstepResult1_2 = tmpvar_30;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD11.xy * _HeiLightPointTilling);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SandShineTex, tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = (_HeiLightPointStep * 0.1);
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_33.z - tmpvar_34) / (
    (tmpvar_34 + _HeiLightPointStepWidth)
   - tmpvar_34)), 0.0, 1.0);
  highp vec2 tmpvar_36;
  tmpvar_36 = ((xlv_TEXCOORD10.xy * _SandShineTex_ST.xy) + _SandShineTex_ST.zw);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_SandShineTex, tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38 = (((
    ((tmpvar_27 * _HeiLightInvertIntensity) * _HeiLightInvertColor)
   + 
    (tmpvar_27 * smoothstepResult1_2)
  ) + (
    ((((tmpvar_27 * _HeiLightPointIntensity) * (tmpvar_35 * 
      (tmpvar_35 * (3.0 - (2.0 * tmpvar_35)))
    )) * _HeiLightPointColor) * HeiLightTex_3.y)
   * HeiLightTex_3.y)).xyz + ((
    (tmpvar_37.x * _SecondTexColor)
   * _SecondTexIntensity).xyz + tmpvar_26));
  OutColor_1 = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39.xyz = OutColor_1;
  tmpvar_39.w = _BloomFactor;
  gl_FragData[0] = tmpvar_39;
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
attribute vec4 _glesMultiTexCoord2;
attribute vec4 _glesMultiTexCoord3;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1 = _glesMultiTexCoord2;
  tmpvar_2 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_3;
  mediump vec3 worldTangent_4;
  mediump vec3 worldNormal_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  tmpvar_12 = (_glesNormal * tmpvar_15);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = (_WorldSpaceLightPos0.xyz - (tmpvar_16.xyz * _WorldSpaceLightPos0.w));
  tmpvar_13 = (_WorldSpaceCameraPos - tmpvar_16.xyz);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_5 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * _glesTANGENT.w);
  worldBinormal_3 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_4.x;
  tmpvar_23.y = worldBinormal_3.x;
  tmpvar_23.z = worldNormal_5.x;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = worldTangent_4.y;
  tmpvar_24.y = worldBinormal_3.y;
  tmpvar_24.z = worldNormal_5.y;
  mediump vec3 tmpvar_25;
  tmpvar_25.x = worldTangent_4.z;
  tmpvar_25.y = worldBinormal_3.z;
  tmpvar_25.z = worldNormal_5.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_glesNormal);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_28;
  highp vec3 tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_28 = _glesTANGENT.xyz;
  tmpvar_29 = (((tmpvar_26.yzx * tmpvar_27.zxy) - (tmpvar_26.zxy * tmpvar_27.yzx)) * _glesTANGENT.w);
  tmpvar_30 = _glesNormal;
  highp mat3 tmpvar_31;
  tmpvar_31[0].x = tmpvar_28.x;
  tmpvar_31[0].y = tmpvar_29.x;
  tmpvar_31[0].z = tmpvar_30.x;
  tmpvar_31[1].x = tmpvar_28.y;
  tmpvar_31[1].y = tmpvar_29.y;
  tmpvar_31[1].z = tmpvar_30.y;
  tmpvar_31[2].x = tmpvar_28.z;
  tmpvar_31[2].y = tmpvar_29.z;
  tmpvar_31[2].z = tmpvar_30.z;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = normalize((tmpvar_31 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_32)
  .xyz)));
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_33;
  fogTune_33 = _FogTune;
  mediump vec4 tmpvar_34;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    tmpvar_38 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_37))
       * 
        (_FogIntensity * tmpvar_37)
      ) * fogTune_33)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_37)) * (_FogColorIntensity * tmpvar_37))
    ), 0.0, 1.0)));
    fogColor_35.xyz = tmpvar_39;
    fogColor_35.w = tmpvar_38;
    tmpvar_34 = fogColor_35;
  } else {
    mediump vec4 fogColor_40;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_42;
    tmpvar_42 = max (0.0, (sqrt(
      dot (tmpvar_41, tmpvar_41)
    ) - _FogStartDistance));
    highp float tmpvar_43;
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_44;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_34;
  xlv_TEXCOORD2 = tmpvar_23;
  xlv_TEXCOORD3 = tmpvar_24;
  xlv_TEXCOORD4 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_TEXCOORD8 = tmpvar_12;
  xlv_TEXCOORD9 = tmpvar_13;
  xlv_TEXCOORD10 = tmpvar_1;
  xlv_TEXCOORD11 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform highp float _HeiLightGlass;
uniform highp float _HeiLightInvertIntensity;
uniform highp vec4 _HeiLightInvertColor;
uniform sampler2D _SandShineTex;
uniform highp vec4 _SandShineTex_ST;
uniform highp vec2 _HeiLightTexSpeed;
uniform highp vec2 _HeiLightTexTilling;
uniform highp float _HeiLightPointStep;
uniform highp float _HeiLightPointStepWidth;
uniform highp vec2 _HeiLightPointTilling;
uniform highp vec4 _HeiLightPointColor;
uniform highp float _HeiLightPointIntensity;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform highp vec4 _LightPosition;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  mediump vec3 OutColor_1;
  highp float smoothstepResult1_2;
  highp vec4 HeiLightTex_3;
  mediump vec3 colorBlendLightMap_4;
  highp vec4 mc_5;
  highp vec3 worldNorm_6;
  mediump float matcapMask_7;
  mediump vec4 tex_S_Color_8;
  mediump vec3 normals_9;
  mediump vec4 tex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_8 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD2, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD3, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  worldNorm_6 = (tmpvar_18 * worldNorm_6);
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (worldNorm_6, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_6, xlv_TEXCOORD5) * worldNorm_6))
  )), vec3(_MetalRef));
  worldNorm_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((tmpvar_19.xy * 0.5) + 0.5);
  tmpvar_20 = texture2D (_MatCap, P_21);
  mc_5 = tmpvar_20;
  mc_5.xyz = mix (vec3(1.0, 1.0, 1.0), mc_5.xyz, vec3(matcapMask_7));
  mc_5 = ((mc_5 * tex_10) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_22;
  tmpvar_22 = ((mc_5.xyz * (
    (((2.0 * tex_S_Color_8.xyz) * tex_S_Color_8.w) + 1.0)
   - tex_S_Color_8.w)) * _LightMapIntensity);
  colorBlendLightMap_4 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD8);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD9);
  highp float tmpvar_25;
  tmpvar_25 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (tmpvar_23, tmpvar_24))
  , _fresnelIndensity)));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + (tmpvar_25 * _fresnelColA.xyz));
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (colorBlendLightMap_4, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = pow (dot (normalize(
    (_LightPosition.xyz + tmpvar_24)
  ), tmpvar_23), _HeiLightGlass);
  highp vec2 tmpvar_28;
  tmpvar_28 = ((_Time.y * _HeiLightTexSpeed) + (xlv_TEXCOORD11.xy * _HeiLightTexTilling));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SandShineTex, tmpvar_28);
  HeiLightTex_3 = tmpvar_29;
  lowp float tmpvar_30;
  lowp float tmpvar_31;
  tmpvar_31 = clamp (((texture2D (_SandShineTex, tmpvar_28).y - 1.0) / 0.3), 0.0, 1.0);
  tmpvar_30 = (tmpvar_31 * (tmpvar_31 * (3.0 - 
    (2.0 * tmpvar_31)
  )));
  smoothstepResult1_2 = tmpvar_30;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD11.xy * _HeiLightPointTilling);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SandShineTex, tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = (_HeiLightPointStep * 0.1);
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_33.z - tmpvar_34) / (
    (tmpvar_34 + _HeiLightPointStepWidth)
   - tmpvar_34)), 0.0, 1.0);
  highp vec2 tmpvar_36;
  tmpvar_36 = ((xlv_TEXCOORD10.xy * _SandShineTex_ST.xy) + _SandShineTex_ST.zw);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_SandShineTex, tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38 = (((
    ((tmpvar_27 * _HeiLightInvertIntensity) * _HeiLightInvertColor)
   + 
    (tmpvar_27 * smoothstepResult1_2)
  ) + (
    ((((tmpvar_27 * _HeiLightPointIntensity) * (tmpvar_35 * 
      (tmpvar_35 * (3.0 - (2.0 * tmpvar_35)))
    )) * _HeiLightPointColor) * HeiLightTex_3.y)
   * HeiLightTex_3.y)).xyz + ((
    (tmpvar_37.x * _SecondTexColor)
   * _SecondTexIntensity).xyz + tmpvar_26));
  OutColor_1 = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39.xyz = OutColor_1;
  tmpvar_39.w = _BloomFactor;
  gl_FragData[0] = tmpvar_39;
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
attribute vec4 _glesMultiTexCoord2;
attribute vec4 _glesMultiTexCoord3;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1 = _glesMultiTexCoord2;
  tmpvar_2 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_3;
  mediump vec3 worldTangent_4;
  mediump vec3 worldNormal_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  tmpvar_12 = (_glesNormal * tmpvar_15);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = (_WorldSpaceLightPos0.xyz - (tmpvar_16.xyz * _WorldSpaceLightPos0.w));
  tmpvar_13 = (_WorldSpaceCameraPos - tmpvar_16.xyz);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_5 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * _glesTANGENT.w);
  worldBinormal_3 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_4.x;
  tmpvar_23.y = worldBinormal_3.x;
  tmpvar_23.z = worldNormal_5.x;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = worldTangent_4.y;
  tmpvar_24.y = worldBinormal_3.y;
  tmpvar_24.z = worldNormal_5.y;
  mediump vec3 tmpvar_25;
  tmpvar_25.x = worldTangent_4.z;
  tmpvar_25.y = worldBinormal_3.z;
  tmpvar_25.z = worldNormal_5.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_glesNormal);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_28;
  highp vec3 tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_28 = _glesTANGENT.xyz;
  tmpvar_29 = (((tmpvar_26.yzx * tmpvar_27.zxy) - (tmpvar_26.zxy * tmpvar_27.yzx)) * _glesTANGENT.w);
  tmpvar_30 = _glesNormal;
  highp mat3 tmpvar_31;
  tmpvar_31[0].x = tmpvar_28.x;
  tmpvar_31[0].y = tmpvar_29.x;
  tmpvar_31[0].z = tmpvar_30.x;
  tmpvar_31[1].x = tmpvar_28.y;
  tmpvar_31[1].y = tmpvar_29.y;
  tmpvar_31[1].z = tmpvar_30.y;
  tmpvar_31[2].x = tmpvar_28.z;
  tmpvar_31[2].y = tmpvar_29.z;
  tmpvar_31[2].z = tmpvar_30.z;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = normalize((tmpvar_31 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_32)
  .xyz)));
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_33;
  fogTune_33 = _FogTune;
  mediump vec4 tmpvar_34;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    tmpvar_38 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_37))
       * 
        (_FogIntensity * tmpvar_37)
      ) * fogTune_33)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_37)) * (_FogColorIntensity * tmpvar_37))
    ), 0.0, 1.0)));
    fogColor_35.xyz = tmpvar_39;
    fogColor_35.w = tmpvar_38;
    tmpvar_34 = fogColor_35;
  } else {
    mediump vec4 fogColor_40;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_42;
    tmpvar_42 = max (0.0, (sqrt(
      dot (tmpvar_41, tmpvar_41)
    ) - _FogStartDistance));
    highp float tmpvar_43;
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_44;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_34;
  xlv_TEXCOORD2 = tmpvar_23;
  xlv_TEXCOORD3 = tmpvar_24;
  xlv_TEXCOORD4 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_TEXCOORD8 = tmpvar_12;
  xlv_TEXCOORD9 = tmpvar_13;
  xlv_TEXCOORD10 = tmpvar_1;
  xlv_TEXCOORD11 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform highp float _HeiLightGlass;
uniform highp float _HeiLightInvertIntensity;
uniform highp vec4 _HeiLightInvertColor;
uniform sampler2D _SandShineTex;
uniform highp vec4 _SandShineTex_ST;
uniform highp vec2 _HeiLightTexSpeed;
uniform highp vec2 _HeiLightTexTilling;
uniform highp float _HeiLightPointStep;
uniform highp float _HeiLightPointStepWidth;
uniform highp vec2 _HeiLightPointTilling;
uniform highp vec4 _HeiLightPointColor;
uniform highp float _HeiLightPointIntensity;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform highp vec4 _LightPosition;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  mediump vec3 OutColor_1;
  highp float smoothstepResult1_2;
  highp vec4 HeiLightTex_3;
  mediump vec3 colorBlendLightMap_4;
  highp vec4 mc_5;
  highp vec3 worldNorm_6;
  mediump float matcapMask_7;
  mediump vec4 tex_S_Color_8;
  mediump vec3 normals_9;
  mediump vec4 tex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_8 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD2, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD3, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  worldNorm_6 = (tmpvar_18 * worldNorm_6);
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (worldNorm_6, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_6, xlv_TEXCOORD5) * worldNorm_6))
  )), vec3(_MetalRef));
  worldNorm_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((tmpvar_19.xy * 0.5) + 0.5);
  tmpvar_20 = texture2D (_MatCap, P_21);
  mc_5 = tmpvar_20;
  mc_5.xyz = mix (vec3(1.0, 1.0, 1.0), mc_5.xyz, vec3(matcapMask_7));
  mc_5 = ((mc_5 * tex_10) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_22;
  tmpvar_22 = ((mc_5.xyz * (
    (((2.0 * tex_S_Color_8.xyz) * tex_S_Color_8.w) + 1.0)
   - tex_S_Color_8.w)) * _LightMapIntensity);
  colorBlendLightMap_4 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD8);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD9);
  highp float tmpvar_25;
  tmpvar_25 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (tmpvar_23, tmpvar_24))
  , _fresnelIndensity)));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + (tmpvar_25 * _fresnelColA.xyz));
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (colorBlendLightMap_4, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = pow (dot (normalize(
    (_LightPosition.xyz + tmpvar_24)
  ), tmpvar_23), _HeiLightGlass);
  highp vec2 tmpvar_28;
  tmpvar_28 = ((_Time.y * _HeiLightTexSpeed) + (xlv_TEXCOORD11.xy * _HeiLightTexTilling));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SandShineTex, tmpvar_28);
  HeiLightTex_3 = tmpvar_29;
  lowp float tmpvar_30;
  lowp float tmpvar_31;
  tmpvar_31 = clamp (((texture2D (_SandShineTex, tmpvar_28).y - 1.0) / 0.3), 0.0, 1.0);
  tmpvar_30 = (tmpvar_31 * (tmpvar_31 * (3.0 - 
    (2.0 * tmpvar_31)
  )));
  smoothstepResult1_2 = tmpvar_30;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD11.xy * _HeiLightPointTilling);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SandShineTex, tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = (_HeiLightPointStep * 0.1);
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_33.z - tmpvar_34) / (
    (tmpvar_34 + _HeiLightPointStepWidth)
   - tmpvar_34)), 0.0, 1.0);
  highp vec2 tmpvar_36;
  tmpvar_36 = ((xlv_TEXCOORD10.xy * _SandShineTex_ST.xy) + _SandShineTex_ST.zw);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_SandShineTex, tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38 = (((
    ((tmpvar_27 * _HeiLightInvertIntensity) * _HeiLightInvertColor)
   + 
    (tmpvar_27 * smoothstepResult1_2)
  ) + (
    ((((tmpvar_27 * _HeiLightPointIntensity) * (tmpvar_35 * 
      (tmpvar_35 * (3.0 - (2.0 * tmpvar_35)))
    )) * _HeiLightPointColor) * HeiLightTex_3.y)
   * HeiLightTex_3.y)).xyz + ((
    (tmpvar_37.x * _SecondTexColor)
   * _SecondTexIntensity).xyz + tmpvar_26));
  OutColor_1 = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39.xyz = OutColor_1;
  tmpvar_39.w = _BloomFactor;
  gl_FragData[0] = tmpvar_39;
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
attribute vec4 _glesMultiTexCoord2;
attribute vec4 _glesMultiTexCoord3;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1 = _glesMultiTexCoord2;
  tmpvar_2 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_3;
  mediump vec3 worldTangent_4;
  mediump vec3 worldNormal_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  tmpvar_12 = (_glesNormal * tmpvar_15);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = (_WorldSpaceLightPos0.xyz - (tmpvar_16.xyz * _WorldSpaceLightPos0.w));
  tmpvar_13 = (_WorldSpaceCameraPos - tmpvar_16.xyz);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_5 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * _glesTANGENT.w);
  worldBinormal_3 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_4.x;
  tmpvar_23.y = worldBinormal_3.x;
  tmpvar_23.z = worldNormal_5.x;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = worldTangent_4.y;
  tmpvar_24.y = worldBinormal_3.y;
  tmpvar_24.z = worldNormal_5.y;
  mediump vec3 tmpvar_25;
  tmpvar_25.x = worldTangent_4.z;
  tmpvar_25.y = worldBinormal_3.z;
  tmpvar_25.z = worldNormal_5.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_glesNormal);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_28;
  highp vec3 tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_28 = _glesTANGENT.xyz;
  tmpvar_29 = (((tmpvar_26.yzx * tmpvar_27.zxy) - (tmpvar_26.zxy * tmpvar_27.yzx)) * _glesTANGENT.w);
  tmpvar_30 = _glesNormal;
  highp mat3 tmpvar_31;
  tmpvar_31[0].x = tmpvar_28.x;
  tmpvar_31[0].y = tmpvar_29.x;
  tmpvar_31[0].z = tmpvar_30.x;
  tmpvar_31[1].x = tmpvar_28.y;
  tmpvar_31[1].y = tmpvar_29.y;
  tmpvar_31[1].z = tmpvar_30.y;
  tmpvar_31[2].x = tmpvar_28.z;
  tmpvar_31[2].y = tmpvar_29.z;
  tmpvar_31[2].z = tmpvar_30.z;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = normalize((tmpvar_31 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_32)
  .xyz)));
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_33;
  fogTune_33 = _FogTune;
  mediump vec4 tmpvar_34;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    tmpvar_38 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_37))
       * 
        (_FogIntensity * tmpvar_37)
      ) * fogTune_33)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_37)) * (_FogColorIntensity * tmpvar_37))
    ), 0.0, 1.0)));
    fogColor_35.xyz = tmpvar_39;
    fogColor_35.w = tmpvar_38;
    tmpvar_34 = fogColor_35;
  } else {
    mediump vec4 fogColor_40;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_42;
    tmpvar_42 = max (0.0, (sqrt(
      dot (tmpvar_41, tmpvar_41)
    ) - _FogStartDistance));
    highp float tmpvar_43;
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_44;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_34;
  xlv_TEXCOORD2 = tmpvar_23;
  xlv_TEXCOORD3 = tmpvar_24;
  xlv_TEXCOORD4 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_TEXCOORD8 = tmpvar_12;
  xlv_TEXCOORD9 = tmpvar_13;
  xlv_TEXCOORD10 = tmpvar_1;
  xlv_TEXCOORD11 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform highp float _HeiLightGlass;
uniform highp float _HeiLightInvertIntensity;
uniform highp vec4 _HeiLightInvertColor;
uniform sampler2D _SandShineTex;
uniform highp vec4 _SandShineTex_ST;
uniform highp vec2 _HeiLightTexSpeed;
uniform highp vec2 _HeiLightTexTilling;
uniform highp float _HeiLightPointStep;
uniform highp float _HeiLightPointStepWidth;
uniform highp vec2 _HeiLightPointTilling;
uniform highp vec4 _HeiLightPointColor;
uniform highp float _HeiLightPointIntensity;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform highp vec4 _LightPosition;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  mediump vec3 OutColor_1;
  highp float smoothstepResult1_2;
  highp vec4 HeiLightTex_3;
  mediump vec3 colorBlendLightMap_4;
  highp vec4 mc_5;
  highp vec3 worldNorm_6;
  mediump float matcapMask_7;
  mediump vec4 tex_S_Color_8;
  mediump vec3 normals_9;
  mediump vec4 tex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_8 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD2, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD3, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  worldNorm_6 = (tmpvar_18 * worldNorm_6);
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (worldNorm_6, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_6, xlv_TEXCOORD5) * worldNorm_6))
  )), vec3(_MetalRef));
  worldNorm_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((tmpvar_19.xy * 0.5) + 0.5);
  tmpvar_20 = texture2D (_MatCap, P_21);
  mc_5 = tmpvar_20;
  mc_5.xyz = mix (vec3(1.0, 1.0, 1.0), mc_5.xyz, vec3(matcapMask_7));
  mc_5 = ((mc_5 * tex_10) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_22;
  tmpvar_22 = ((mc_5.xyz * (
    (((2.0 * tex_S_Color_8.xyz) * tex_S_Color_8.w) + 1.0)
   - tex_S_Color_8.w)) * _LightMapIntensity);
  colorBlendLightMap_4 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD8);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD9);
  highp float tmpvar_25;
  tmpvar_25 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (tmpvar_23, tmpvar_24))
  , _fresnelIndensity)));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + (tmpvar_25 * _fresnelColA.xyz));
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (colorBlendLightMap_4, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = pow (dot (normalize(
    (_LightPosition.xyz + tmpvar_24)
  ), tmpvar_23), _HeiLightGlass);
  highp vec2 tmpvar_28;
  tmpvar_28 = ((_Time.y * _HeiLightTexSpeed) + (xlv_TEXCOORD11.xy * _HeiLightTexTilling));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SandShineTex, tmpvar_28);
  HeiLightTex_3 = tmpvar_29;
  lowp float tmpvar_30;
  lowp float tmpvar_31;
  tmpvar_31 = clamp (((texture2D (_SandShineTex, tmpvar_28).y - 1.0) / 0.3), 0.0, 1.0);
  tmpvar_30 = (tmpvar_31 * (tmpvar_31 * (3.0 - 
    (2.0 * tmpvar_31)
  )));
  smoothstepResult1_2 = tmpvar_30;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD11.xy * _HeiLightPointTilling);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SandShineTex, tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = (_HeiLightPointStep * 0.1);
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_33.z - tmpvar_34) / (
    (tmpvar_34 + _HeiLightPointStepWidth)
   - tmpvar_34)), 0.0, 1.0);
  highp vec2 tmpvar_36;
  tmpvar_36 = ((xlv_TEXCOORD10.xy * _SandShineTex_ST.xy) + _SandShineTex_ST.zw);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_SandShineTex, tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38 = (((
    ((tmpvar_27 * _HeiLightInvertIntensity) * _HeiLightInvertColor)
   + 
    (tmpvar_27 * smoothstepResult1_2)
  ) + (
    ((((tmpvar_27 * _HeiLightPointIntensity) * (tmpvar_35 * 
      (tmpvar_35 * (3.0 - (2.0 * tmpvar_35)))
    )) * _HeiLightPointColor) * HeiLightTex_3.y)
   * HeiLightTex_3.y)).xyz + ((
    (tmpvar_37.x * _SecondTexColor)
   * _SecondTexIntensity).xyz + tmpvar_26));
  OutColor_1 = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39.xyz = OutColor_1;
  tmpvar_39.w = _BloomFactor;
  gl_FragData[0] = tmpvar_39;
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
attribute vec4 _glesMultiTexCoord2;
attribute vec4 _glesMultiTexCoord3;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1 = _glesMultiTexCoord2;
  tmpvar_2 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_3;
  mediump vec3 worldTangent_4;
  mediump vec3 worldNormal_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  tmpvar_12 = (_glesNormal * tmpvar_15);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = (_WorldSpaceLightPos0.xyz - (tmpvar_16.xyz * _WorldSpaceLightPos0.w));
  tmpvar_13 = (_WorldSpaceCameraPos - tmpvar_16.xyz);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_5 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * _glesTANGENT.w);
  worldBinormal_3 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_4.x;
  tmpvar_23.y = worldBinormal_3.x;
  tmpvar_23.z = worldNormal_5.x;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = worldTangent_4.y;
  tmpvar_24.y = worldBinormal_3.y;
  tmpvar_24.z = worldNormal_5.y;
  mediump vec3 tmpvar_25;
  tmpvar_25.x = worldTangent_4.z;
  tmpvar_25.y = worldBinormal_3.z;
  tmpvar_25.z = worldNormal_5.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_glesNormal);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_28;
  highp vec3 tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_28 = _glesTANGENT.xyz;
  tmpvar_29 = (((tmpvar_26.yzx * tmpvar_27.zxy) - (tmpvar_26.zxy * tmpvar_27.yzx)) * _glesTANGENT.w);
  tmpvar_30 = _glesNormal;
  highp mat3 tmpvar_31;
  tmpvar_31[0].x = tmpvar_28.x;
  tmpvar_31[0].y = tmpvar_29.x;
  tmpvar_31[0].z = tmpvar_30.x;
  tmpvar_31[1].x = tmpvar_28.y;
  tmpvar_31[1].y = tmpvar_29.y;
  tmpvar_31[1].z = tmpvar_30.y;
  tmpvar_31[2].x = tmpvar_28.z;
  tmpvar_31[2].y = tmpvar_29.z;
  tmpvar_31[2].z = tmpvar_30.z;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = normalize((tmpvar_31 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_32)
  .xyz)));
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_33;
  fogTune_33 = _FogTune;
  mediump vec4 tmpvar_34;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    tmpvar_38 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_37))
       * 
        (_FogIntensity * tmpvar_37)
      ) * fogTune_33)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_37)) * (_FogColorIntensity * tmpvar_37))
    ), 0.0, 1.0)));
    fogColor_35.xyz = tmpvar_39;
    fogColor_35.w = tmpvar_38;
    tmpvar_34 = fogColor_35;
  } else {
    mediump vec4 fogColor_40;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_42;
    tmpvar_42 = max (0.0, (sqrt(
      dot (tmpvar_41, tmpvar_41)
    ) - _FogStartDistance));
    highp float tmpvar_43;
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_44;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_34;
  xlv_TEXCOORD2 = tmpvar_23;
  xlv_TEXCOORD3 = tmpvar_24;
  xlv_TEXCOORD4 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_TEXCOORD8 = tmpvar_12;
  xlv_TEXCOORD9 = tmpvar_13;
  xlv_TEXCOORD10 = tmpvar_1;
  xlv_TEXCOORD11 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform highp float _HeiLightGlass;
uniform highp float _HeiLightInvertIntensity;
uniform highp vec4 _HeiLightInvertColor;
uniform sampler2D _SandShineTex;
uniform highp vec4 _SandShineTex_ST;
uniform highp vec2 _HeiLightTexSpeed;
uniform highp vec2 _HeiLightTexTilling;
uniform highp float _HeiLightPointStep;
uniform highp float _HeiLightPointStepWidth;
uniform highp vec2 _HeiLightPointTilling;
uniform highp vec4 _HeiLightPointColor;
uniform highp float _HeiLightPointIntensity;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform highp vec4 _LightPosition;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  mediump vec3 OutColor_1;
  highp float smoothstepResult1_2;
  highp vec4 HeiLightTex_3;
  mediump vec3 colorBlendLightMap_4;
  highp vec4 mc_5;
  highp vec3 worldNorm_6;
  mediump float matcapMask_7;
  mediump vec4 tex_S_Color_8;
  mediump vec3 normals_9;
  mediump vec4 tex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_8 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD2, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD3, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  worldNorm_6 = (tmpvar_18 * worldNorm_6);
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (worldNorm_6, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_6, xlv_TEXCOORD5) * worldNorm_6))
  )), vec3(_MetalRef));
  worldNorm_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((tmpvar_19.xy * 0.5) + 0.5);
  tmpvar_20 = texture2D (_MatCap, P_21);
  mc_5 = tmpvar_20;
  mc_5.xyz = mix (vec3(1.0, 1.0, 1.0), mc_5.xyz, vec3(matcapMask_7));
  mc_5 = ((mc_5 * tex_10) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_22;
  tmpvar_22 = ((mc_5.xyz * (
    (((2.0 * tex_S_Color_8.xyz) * tex_S_Color_8.w) + 1.0)
   - tex_S_Color_8.w)) * _LightMapIntensity);
  colorBlendLightMap_4 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD8);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD9);
  highp float tmpvar_25;
  tmpvar_25 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (tmpvar_23, tmpvar_24))
  , _fresnelIndensity)));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + (tmpvar_25 * _fresnelColA.xyz));
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (colorBlendLightMap_4, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = pow (dot (normalize(
    (_LightPosition.xyz + tmpvar_24)
  ), tmpvar_23), _HeiLightGlass);
  highp vec2 tmpvar_28;
  tmpvar_28 = ((_Time.y * _HeiLightTexSpeed) + (xlv_TEXCOORD11.xy * _HeiLightTexTilling));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SandShineTex, tmpvar_28);
  HeiLightTex_3 = tmpvar_29;
  lowp float tmpvar_30;
  lowp float tmpvar_31;
  tmpvar_31 = clamp (((texture2D (_SandShineTex, tmpvar_28).y - 1.0) / 0.3), 0.0, 1.0);
  tmpvar_30 = (tmpvar_31 * (tmpvar_31 * (3.0 - 
    (2.0 * tmpvar_31)
  )));
  smoothstepResult1_2 = tmpvar_30;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD11.xy * _HeiLightPointTilling);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SandShineTex, tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = (_HeiLightPointStep * 0.1);
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_33.z - tmpvar_34) / (
    (tmpvar_34 + _HeiLightPointStepWidth)
   - tmpvar_34)), 0.0, 1.0);
  highp vec2 tmpvar_36;
  tmpvar_36 = ((xlv_TEXCOORD10.xy * _SandShineTex_ST.xy) + _SandShineTex_ST.zw);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_SandShineTex, tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38 = (((
    ((tmpvar_27 * _HeiLightInvertIntensity) * _HeiLightInvertColor)
   + 
    (tmpvar_27 * smoothstepResult1_2)
  ) + (
    ((((tmpvar_27 * _HeiLightPointIntensity) * (tmpvar_35 * 
      (tmpvar_35 * (3.0 - (2.0 * tmpvar_35)))
    )) * _HeiLightPointColor) * HeiLightTex_3.y)
   * HeiLightTex_3.y)).xyz + ((
    (tmpvar_37.x * _SecondTexColor)
   * _SecondTexIntensity).xyz + tmpvar_26));
  OutColor_1 = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39.xyz = OutColor_1;
  tmpvar_39.w = _BloomFactor;
  gl_FragData[0] = tmpvar_39;
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
attribute vec4 _glesMultiTexCoord2;
attribute vec4 _glesMultiTexCoord3;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1 = _glesMultiTexCoord2;
  tmpvar_2 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_3;
  mediump vec3 worldTangent_4;
  mediump vec3 worldNormal_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  tmpvar_12 = (_glesNormal * tmpvar_15);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = (_WorldSpaceLightPos0.xyz - (tmpvar_16.xyz * _WorldSpaceLightPos0.w));
  tmpvar_13 = (_WorldSpaceCameraPos - tmpvar_16.xyz);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_5 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * _glesTANGENT.w);
  worldBinormal_3 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_4.x;
  tmpvar_23.y = worldBinormal_3.x;
  tmpvar_23.z = worldNormal_5.x;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = worldTangent_4.y;
  tmpvar_24.y = worldBinormal_3.y;
  tmpvar_24.z = worldNormal_5.y;
  mediump vec3 tmpvar_25;
  tmpvar_25.x = worldTangent_4.z;
  tmpvar_25.y = worldBinormal_3.z;
  tmpvar_25.z = worldNormal_5.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_glesNormal);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_28;
  highp vec3 tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_28 = _glesTANGENT.xyz;
  tmpvar_29 = (((tmpvar_26.yzx * tmpvar_27.zxy) - (tmpvar_26.zxy * tmpvar_27.yzx)) * _glesTANGENT.w);
  tmpvar_30 = _glesNormal;
  highp mat3 tmpvar_31;
  tmpvar_31[0].x = tmpvar_28.x;
  tmpvar_31[0].y = tmpvar_29.x;
  tmpvar_31[0].z = tmpvar_30.x;
  tmpvar_31[1].x = tmpvar_28.y;
  tmpvar_31[1].y = tmpvar_29.y;
  tmpvar_31[1].z = tmpvar_30.y;
  tmpvar_31[2].x = tmpvar_28.z;
  tmpvar_31[2].y = tmpvar_29.z;
  tmpvar_31[2].z = tmpvar_30.z;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = normalize((tmpvar_31 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_32)
  .xyz)));
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_33;
  fogTune_33 = _FogTune;
  mediump vec4 tmpvar_34;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    tmpvar_38 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_37))
       * 
        (_FogIntensity * tmpvar_37)
      ) * fogTune_33)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_37)) * (_FogColorIntensity * tmpvar_37))
    ), 0.0, 1.0)));
    fogColor_35.xyz = tmpvar_39;
    fogColor_35.w = tmpvar_38;
    tmpvar_34 = fogColor_35;
  } else {
    mediump vec4 fogColor_40;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_42;
    tmpvar_42 = max (0.0, (sqrt(
      dot (tmpvar_41, tmpvar_41)
    ) - _FogStartDistance));
    highp float tmpvar_43;
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_44;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_34;
  xlv_TEXCOORD2 = tmpvar_23;
  xlv_TEXCOORD3 = tmpvar_24;
  xlv_TEXCOORD4 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_TEXCOORD8 = tmpvar_12;
  xlv_TEXCOORD9 = tmpvar_13;
  xlv_TEXCOORD10 = tmpvar_1;
  xlv_TEXCOORD11 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform highp float _HeiLightGlass;
uniform highp float _HeiLightInvertIntensity;
uniform highp vec4 _HeiLightInvertColor;
uniform sampler2D _SandShineTex;
uniform highp vec4 _SandShineTex_ST;
uniform highp vec2 _HeiLightTexSpeed;
uniform highp vec2 _HeiLightTexTilling;
uniform highp float _HeiLightPointStep;
uniform highp float _HeiLightPointStepWidth;
uniform highp vec2 _HeiLightPointTilling;
uniform highp vec4 _HeiLightPointColor;
uniform highp float _HeiLightPointIntensity;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform highp vec4 _LightPosition;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  mediump vec3 OutColor_1;
  highp float smoothstepResult1_2;
  highp vec4 HeiLightTex_3;
  mediump vec3 colorBlendLightMap_4;
  highp vec4 mc_5;
  highp vec3 worldNorm_6;
  mediump float matcapMask_7;
  mediump vec4 tex_S_Color_8;
  mediump vec3 normals_9;
  mediump vec4 tex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_8 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD2, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD3, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  worldNorm_6 = (tmpvar_18 * worldNorm_6);
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (worldNorm_6, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_6, xlv_TEXCOORD5) * worldNorm_6))
  )), vec3(_MetalRef));
  worldNorm_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((tmpvar_19.xy * 0.5) + 0.5);
  tmpvar_20 = texture2D (_MatCap, P_21);
  mc_5 = tmpvar_20;
  mc_5.xyz = mix (vec3(1.0, 1.0, 1.0), mc_5.xyz, vec3(matcapMask_7));
  mc_5 = ((mc_5 * tex_10) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_22;
  tmpvar_22 = ((mc_5.xyz * (
    (((2.0 * tex_S_Color_8.xyz) * tex_S_Color_8.w) + 1.0)
   - tex_S_Color_8.w)) * _LightMapIntensity);
  colorBlendLightMap_4 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD8);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD9);
  highp float tmpvar_25;
  tmpvar_25 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (tmpvar_23, tmpvar_24))
  , _fresnelIndensity)));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + (tmpvar_25 * _fresnelColA.xyz));
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (colorBlendLightMap_4, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colorBlendLightMap_4 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = pow (dot (normalize(
    (_LightPosition.xyz + tmpvar_24)
  ), tmpvar_23), _HeiLightGlass);
  highp vec2 tmpvar_28;
  tmpvar_28 = ((_Time.y * _HeiLightTexSpeed) + (xlv_TEXCOORD11.xy * _HeiLightTexTilling));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_SandShineTex, tmpvar_28);
  HeiLightTex_3 = tmpvar_29;
  lowp float tmpvar_30;
  lowp float tmpvar_31;
  tmpvar_31 = clamp (((texture2D (_SandShineTex, tmpvar_28).y - 1.0) / 0.3), 0.0, 1.0);
  tmpvar_30 = (tmpvar_31 * (tmpvar_31 * (3.0 - 
    (2.0 * tmpvar_31)
  )));
  smoothstepResult1_2 = tmpvar_30;
  highp vec2 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD11.xy * _HeiLightPointTilling);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_SandShineTex, tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = (_HeiLightPointStep * 0.1);
  highp float tmpvar_35;
  tmpvar_35 = clamp (((tmpvar_33.z - tmpvar_34) / (
    (tmpvar_34 + _HeiLightPointStepWidth)
   - tmpvar_34)), 0.0, 1.0);
  highp vec2 tmpvar_36;
  tmpvar_36 = ((xlv_TEXCOORD10.xy * _SandShineTex_ST.xy) + _SandShineTex_ST.zw);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_SandShineTex, tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38 = (((
    ((tmpvar_27 * _HeiLightInvertIntensity) * _HeiLightInvertColor)
   + 
    (tmpvar_27 * smoothstepResult1_2)
  ) + (
    ((((tmpvar_27 * _HeiLightPointIntensity) * (tmpvar_35 * 
      (tmpvar_35 * (3.0 - (2.0 * tmpvar_35)))
    )) * _HeiLightPointColor) * HeiLightTex_3.y)
   * HeiLightTex_3.y)).xyz + ((
    (tmpvar_37.x * _SecondTexColor)
   * _SecondTexIntensity).xyz + tmpvar_26));
  OutColor_1 = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39.xyz = OutColor_1;
  tmpvar_39.w = _BloomFactor;
  gl_FragData[0] = tmpvar_39;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
attribute vec4 _glesMultiTexCoord3;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1 = _glesMultiTexCoord2;
  tmpvar_2 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_3;
  mediump vec3 worldTangent_4;
  mediump vec3 worldNormal_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  tmpvar_12 = (_glesNormal * tmpvar_15);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = (_WorldSpaceLightPos0.xyz - (tmpvar_16.xyz * _WorldSpaceLightPos0.w));
  tmpvar_13 = (_WorldSpaceCameraPos - tmpvar_16.xyz);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_5 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * _glesTANGENT.w);
  worldBinormal_3 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_4.x;
  tmpvar_23.y = worldBinormal_3.x;
  tmpvar_23.z = worldNormal_5.x;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = worldTangent_4.y;
  tmpvar_24.y = worldBinormal_3.y;
  tmpvar_24.z = worldNormal_5.y;
  mediump vec3 tmpvar_25;
  tmpvar_25.x = worldTangent_4.z;
  tmpvar_25.y = worldBinormal_3.z;
  tmpvar_25.z = worldNormal_5.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_glesNormal);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_28;
  highp vec3 tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_28 = _glesTANGENT.xyz;
  tmpvar_29 = (((tmpvar_26.yzx * tmpvar_27.zxy) - (tmpvar_26.zxy * tmpvar_27.yzx)) * _glesTANGENT.w);
  tmpvar_30 = _glesNormal;
  highp mat3 tmpvar_31;
  tmpvar_31[0].x = tmpvar_28.x;
  tmpvar_31[0].y = tmpvar_29.x;
  tmpvar_31[0].z = tmpvar_30.x;
  tmpvar_31[1].x = tmpvar_28.y;
  tmpvar_31[1].y = tmpvar_29.y;
  tmpvar_31[1].z = tmpvar_30.y;
  tmpvar_31[2].x = tmpvar_28.z;
  tmpvar_31[2].y = tmpvar_29.z;
  tmpvar_31[2].z = tmpvar_30.z;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = normalize((tmpvar_31 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_32)
  .xyz)));
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_33;
  fogTune_33 = _FogTune;
  mediump vec4 tmpvar_34;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    tmpvar_38 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_37))
       * 
        (_FogIntensity * tmpvar_37)
      ) * fogTune_33)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_37)) * (_FogColorIntensity * tmpvar_37))
    ), 0.0, 1.0)));
    fogColor_35.xyz = tmpvar_39;
    fogColor_35.w = tmpvar_38;
    tmpvar_34 = fogColor_35;
  } else {
    mediump vec4 fogColor_40;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_42;
    tmpvar_42 = max (0.0, (sqrt(
      dot (tmpvar_41, tmpvar_41)
    ) - _FogStartDistance));
    highp float tmpvar_43;
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_44;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_34;
  xlv_TEXCOORD2 = tmpvar_23;
  xlv_TEXCOORD3 = tmpvar_24;
  xlv_TEXCOORD4 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_TEXCOORD8 = tmpvar_12;
  xlv_TEXCOORD9 = tmpvar_13;
  xlv_TEXCOORD10 = tmpvar_1;
  xlv_TEXCOORD11 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform highp float _HeiLightGlass;
uniform highp float _HeiLightInvertIntensity;
uniform highp vec4 _HeiLightInvertColor;
uniform sampler2D _SandShineTex;
uniform highp vec4 _SandShineTex_ST;
uniform highp vec2 _HeiLightTexSpeed;
uniform highp vec2 _HeiLightTexTilling;
uniform highp float _HeiLightPointStep;
uniform highp float _HeiLightPointStepWidth;
uniform highp vec2 _HeiLightPointTilling;
uniform highp vec4 _HeiLightPointColor;
uniform highp float _HeiLightPointIntensity;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform highp vec4 _LightPosition;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  mediump vec3 OutColor_1;
  highp float smoothstepResult1_2;
  highp vec4 HeiLightTex_3;
  mediump vec3 colorBlendLightMap_4;
  highp vec4 mc_5;
  highp vec3 worldNorm_6;
  mediump float matcapMask_7;
  mediump vec4 tex_S_Color_8;
  mediump vec3 normals_9;
  mediump vec4 tex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_8 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD2, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD3, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  worldNorm_6 = (tmpvar_18 * worldNorm_6);
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (worldNorm_6, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_6, xlv_TEXCOORD5) * worldNorm_6))
  )), vec3(_MetalRef));
  worldNorm_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((tmpvar_19.xy * 0.5) + 0.5);
  tmpvar_20 = texture2D (_MatCap, P_21);
  mc_5 = tmpvar_20;
  mc_5.xyz = mix (vec3(1.0, 1.0, 1.0), mc_5.xyz, vec3(matcapMask_7));
  mc_5 = ((mc_5 * tex_10) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_22;
  tmpvar_22 = ((mc_5.xyz * (
    (((2.0 * tex_S_Color_8.xyz) * tex_S_Color_8.w) + 1.0)
   - tex_S_Color_8.w)) * _LightMapIntensity);
  colorBlendLightMap_4 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD8);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD9);
  highp float tmpvar_25;
  tmpvar_25 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (tmpvar_23, tmpvar_24))
  , _fresnelIndensity)));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + (tmpvar_25 * _fresnelColA.xyz));
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (colorBlendLightMap_4, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (tmpvar_26, vec3(dot (tmpvar_26, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_4 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (dot (normalize(
    (_LightPosition.xyz + tmpvar_24)
  ), tmpvar_23), _HeiLightGlass);
  highp vec2 tmpvar_29;
  tmpvar_29 = ((_Time.y * _HeiLightTexSpeed) + (xlv_TEXCOORD11.xy * _HeiLightTexTilling));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_SandShineTex, tmpvar_29);
  HeiLightTex_3 = tmpvar_30;
  lowp float tmpvar_31;
  lowp float tmpvar_32;
  tmpvar_32 = clamp (((texture2D (_SandShineTex, tmpvar_29).y - 1.0) / 0.3), 0.0, 1.0);
  tmpvar_31 = (tmpvar_32 * (tmpvar_32 * (3.0 - 
    (2.0 * tmpvar_32)
  )));
  smoothstepResult1_2 = tmpvar_31;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD11.xy * _HeiLightPointTilling);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SandShineTex, tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (_HeiLightPointStep * 0.1);
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_34.z - tmpvar_35) / (
    (tmpvar_35 + _HeiLightPointStepWidth)
   - tmpvar_35)), 0.0, 1.0);
  highp vec2 tmpvar_37;
  tmpvar_37 = ((xlv_TEXCOORD10.xy * _SandShineTex_ST.xy) + _SandShineTex_ST.zw);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_SandShineTex, tmpvar_37);
  highp vec3 tmpvar_39;
  tmpvar_39 = (((
    ((tmpvar_28 * _HeiLightInvertIntensity) * _HeiLightInvertColor)
   + 
    (tmpvar_28 * smoothstepResult1_2)
  ) + (
    ((((tmpvar_28 * _HeiLightPointIntensity) * (tmpvar_36 * 
      (tmpvar_36 * (3.0 - (2.0 * tmpvar_36)))
    )) * _HeiLightPointColor) * HeiLightTex_3.y)
   * HeiLightTex_3.y)).xyz + ((
    (tmpvar_38.x * _SecondTexColor)
   * _SecondTexIntensity).xyz + tmpvar_27));
  OutColor_1 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = OutColor_1;
  tmpvar_40.w = _BloomFactor;
  gl_FragData[0] = tmpvar_40;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
attribute vec4 _glesMultiTexCoord3;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1 = _glesMultiTexCoord2;
  tmpvar_2 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_3;
  mediump vec3 worldTangent_4;
  mediump vec3 worldNormal_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  tmpvar_12 = (_glesNormal * tmpvar_15);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = (_WorldSpaceLightPos0.xyz - (tmpvar_16.xyz * _WorldSpaceLightPos0.w));
  tmpvar_13 = (_WorldSpaceCameraPos - tmpvar_16.xyz);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_5 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * _glesTANGENT.w);
  worldBinormal_3 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_4.x;
  tmpvar_23.y = worldBinormal_3.x;
  tmpvar_23.z = worldNormal_5.x;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = worldTangent_4.y;
  tmpvar_24.y = worldBinormal_3.y;
  tmpvar_24.z = worldNormal_5.y;
  mediump vec3 tmpvar_25;
  tmpvar_25.x = worldTangent_4.z;
  tmpvar_25.y = worldBinormal_3.z;
  tmpvar_25.z = worldNormal_5.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_glesNormal);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_28;
  highp vec3 tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_28 = _glesTANGENT.xyz;
  tmpvar_29 = (((tmpvar_26.yzx * tmpvar_27.zxy) - (tmpvar_26.zxy * tmpvar_27.yzx)) * _glesTANGENT.w);
  tmpvar_30 = _glesNormal;
  highp mat3 tmpvar_31;
  tmpvar_31[0].x = tmpvar_28.x;
  tmpvar_31[0].y = tmpvar_29.x;
  tmpvar_31[0].z = tmpvar_30.x;
  tmpvar_31[1].x = tmpvar_28.y;
  tmpvar_31[1].y = tmpvar_29.y;
  tmpvar_31[1].z = tmpvar_30.y;
  tmpvar_31[2].x = tmpvar_28.z;
  tmpvar_31[2].y = tmpvar_29.z;
  tmpvar_31[2].z = tmpvar_30.z;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = normalize((tmpvar_31 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_32)
  .xyz)));
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_33;
  fogTune_33 = _FogTune;
  mediump vec4 tmpvar_34;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    tmpvar_38 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_37))
       * 
        (_FogIntensity * tmpvar_37)
      ) * fogTune_33)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_37)) * (_FogColorIntensity * tmpvar_37))
    ), 0.0, 1.0)));
    fogColor_35.xyz = tmpvar_39;
    fogColor_35.w = tmpvar_38;
    tmpvar_34 = fogColor_35;
  } else {
    mediump vec4 fogColor_40;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_42;
    tmpvar_42 = max (0.0, (sqrt(
      dot (tmpvar_41, tmpvar_41)
    ) - _FogStartDistance));
    highp float tmpvar_43;
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_44;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_34;
  xlv_TEXCOORD2 = tmpvar_23;
  xlv_TEXCOORD3 = tmpvar_24;
  xlv_TEXCOORD4 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_TEXCOORD8 = tmpvar_12;
  xlv_TEXCOORD9 = tmpvar_13;
  xlv_TEXCOORD10 = tmpvar_1;
  xlv_TEXCOORD11 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform highp float _HeiLightGlass;
uniform highp float _HeiLightInvertIntensity;
uniform highp vec4 _HeiLightInvertColor;
uniform sampler2D _SandShineTex;
uniform highp vec4 _SandShineTex_ST;
uniform highp vec2 _HeiLightTexSpeed;
uniform highp vec2 _HeiLightTexTilling;
uniform highp float _HeiLightPointStep;
uniform highp float _HeiLightPointStepWidth;
uniform highp vec2 _HeiLightPointTilling;
uniform highp vec4 _HeiLightPointColor;
uniform highp float _HeiLightPointIntensity;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform highp vec4 _LightPosition;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  mediump vec3 OutColor_1;
  highp float smoothstepResult1_2;
  highp vec4 HeiLightTex_3;
  mediump vec3 colorBlendLightMap_4;
  highp vec4 mc_5;
  highp vec3 worldNorm_6;
  mediump float matcapMask_7;
  mediump vec4 tex_S_Color_8;
  mediump vec3 normals_9;
  mediump vec4 tex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_8 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD2, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD3, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  worldNorm_6 = (tmpvar_18 * worldNorm_6);
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (worldNorm_6, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_6, xlv_TEXCOORD5) * worldNorm_6))
  )), vec3(_MetalRef));
  worldNorm_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((tmpvar_19.xy * 0.5) + 0.5);
  tmpvar_20 = texture2D (_MatCap, P_21);
  mc_5 = tmpvar_20;
  mc_5.xyz = mix (vec3(1.0, 1.0, 1.0), mc_5.xyz, vec3(matcapMask_7));
  mc_5 = ((mc_5 * tex_10) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_22;
  tmpvar_22 = ((mc_5.xyz * (
    (((2.0 * tex_S_Color_8.xyz) * tex_S_Color_8.w) + 1.0)
   - tex_S_Color_8.w)) * _LightMapIntensity);
  colorBlendLightMap_4 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD8);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD9);
  highp float tmpvar_25;
  tmpvar_25 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (tmpvar_23, tmpvar_24))
  , _fresnelIndensity)));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + (tmpvar_25 * _fresnelColA.xyz));
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (colorBlendLightMap_4, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (tmpvar_26, vec3(dot (tmpvar_26, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_4 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (dot (normalize(
    (_LightPosition.xyz + tmpvar_24)
  ), tmpvar_23), _HeiLightGlass);
  highp vec2 tmpvar_29;
  tmpvar_29 = ((_Time.y * _HeiLightTexSpeed) + (xlv_TEXCOORD11.xy * _HeiLightTexTilling));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_SandShineTex, tmpvar_29);
  HeiLightTex_3 = tmpvar_30;
  lowp float tmpvar_31;
  lowp float tmpvar_32;
  tmpvar_32 = clamp (((texture2D (_SandShineTex, tmpvar_29).y - 1.0) / 0.3), 0.0, 1.0);
  tmpvar_31 = (tmpvar_32 * (tmpvar_32 * (3.0 - 
    (2.0 * tmpvar_32)
  )));
  smoothstepResult1_2 = tmpvar_31;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD11.xy * _HeiLightPointTilling);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SandShineTex, tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (_HeiLightPointStep * 0.1);
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_34.z - tmpvar_35) / (
    (tmpvar_35 + _HeiLightPointStepWidth)
   - tmpvar_35)), 0.0, 1.0);
  highp vec2 tmpvar_37;
  tmpvar_37 = ((xlv_TEXCOORD10.xy * _SandShineTex_ST.xy) + _SandShineTex_ST.zw);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_SandShineTex, tmpvar_37);
  highp vec3 tmpvar_39;
  tmpvar_39 = (((
    ((tmpvar_28 * _HeiLightInvertIntensity) * _HeiLightInvertColor)
   + 
    (tmpvar_28 * smoothstepResult1_2)
  ) + (
    ((((tmpvar_28 * _HeiLightPointIntensity) * (tmpvar_36 * 
      (tmpvar_36 * (3.0 - (2.0 * tmpvar_36)))
    )) * _HeiLightPointColor) * HeiLightTex_3.y)
   * HeiLightTex_3.y)).xyz + ((
    (tmpvar_38.x * _SecondTexColor)
   * _SecondTexIntensity).xyz + tmpvar_27));
  OutColor_1 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = OutColor_1;
  tmpvar_40.w = _BloomFactor;
  gl_FragData[0] = tmpvar_40;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
attribute vec4 _glesMultiTexCoord3;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1 = _glesMultiTexCoord2;
  tmpvar_2 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_3;
  mediump vec3 worldTangent_4;
  mediump vec3 worldNormal_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  tmpvar_12 = (_glesNormal * tmpvar_15);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = (_WorldSpaceLightPos0.xyz - (tmpvar_16.xyz * _WorldSpaceLightPos0.w));
  tmpvar_13 = (_WorldSpaceCameraPos - tmpvar_16.xyz);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_5 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * _glesTANGENT.w);
  worldBinormal_3 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_4.x;
  tmpvar_23.y = worldBinormal_3.x;
  tmpvar_23.z = worldNormal_5.x;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = worldTangent_4.y;
  tmpvar_24.y = worldBinormal_3.y;
  tmpvar_24.z = worldNormal_5.y;
  mediump vec3 tmpvar_25;
  tmpvar_25.x = worldTangent_4.z;
  tmpvar_25.y = worldBinormal_3.z;
  tmpvar_25.z = worldNormal_5.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_glesNormal);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_28;
  highp vec3 tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_28 = _glesTANGENT.xyz;
  tmpvar_29 = (((tmpvar_26.yzx * tmpvar_27.zxy) - (tmpvar_26.zxy * tmpvar_27.yzx)) * _glesTANGENT.w);
  tmpvar_30 = _glesNormal;
  highp mat3 tmpvar_31;
  tmpvar_31[0].x = tmpvar_28.x;
  tmpvar_31[0].y = tmpvar_29.x;
  tmpvar_31[0].z = tmpvar_30.x;
  tmpvar_31[1].x = tmpvar_28.y;
  tmpvar_31[1].y = tmpvar_29.y;
  tmpvar_31[1].z = tmpvar_30.y;
  tmpvar_31[2].x = tmpvar_28.z;
  tmpvar_31[2].y = tmpvar_29.z;
  tmpvar_31[2].z = tmpvar_30.z;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = normalize((tmpvar_31 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_32)
  .xyz)));
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_33;
  fogTune_33 = _FogTune;
  mediump vec4 tmpvar_34;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    tmpvar_38 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_37))
       * 
        (_FogIntensity * tmpvar_37)
      ) * fogTune_33)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_37)) * (_FogColorIntensity * tmpvar_37))
    ), 0.0, 1.0)));
    fogColor_35.xyz = tmpvar_39;
    fogColor_35.w = tmpvar_38;
    tmpvar_34 = fogColor_35;
  } else {
    mediump vec4 fogColor_40;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_42;
    tmpvar_42 = max (0.0, (sqrt(
      dot (tmpvar_41, tmpvar_41)
    ) - _FogStartDistance));
    highp float tmpvar_43;
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_44;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_34;
  xlv_TEXCOORD2 = tmpvar_23;
  xlv_TEXCOORD3 = tmpvar_24;
  xlv_TEXCOORD4 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_TEXCOORD8 = tmpvar_12;
  xlv_TEXCOORD9 = tmpvar_13;
  xlv_TEXCOORD10 = tmpvar_1;
  xlv_TEXCOORD11 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform highp float _HeiLightGlass;
uniform highp float _HeiLightInvertIntensity;
uniform highp vec4 _HeiLightInvertColor;
uniform sampler2D _SandShineTex;
uniform highp vec4 _SandShineTex_ST;
uniform highp vec2 _HeiLightTexSpeed;
uniform highp vec2 _HeiLightTexTilling;
uniform highp float _HeiLightPointStep;
uniform highp float _HeiLightPointStepWidth;
uniform highp vec2 _HeiLightPointTilling;
uniform highp vec4 _HeiLightPointColor;
uniform highp float _HeiLightPointIntensity;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform highp vec4 _LightPosition;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  mediump vec3 OutColor_1;
  highp float smoothstepResult1_2;
  highp vec4 HeiLightTex_3;
  mediump vec3 colorBlendLightMap_4;
  highp vec4 mc_5;
  highp vec3 worldNorm_6;
  mediump float matcapMask_7;
  mediump vec4 tex_S_Color_8;
  mediump vec3 normals_9;
  mediump vec4 tex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_8 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD2, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD3, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  worldNorm_6 = (tmpvar_18 * worldNorm_6);
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (worldNorm_6, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_6, xlv_TEXCOORD5) * worldNorm_6))
  )), vec3(_MetalRef));
  worldNorm_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((tmpvar_19.xy * 0.5) + 0.5);
  tmpvar_20 = texture2D (_MatCap, P_21);
  mc_5 = tmpvar_20;
  mc_5.xyz = mix (vec3(1.0, 1.0, 1.0), mc_5.xyz, vec3(matcapMask_7));
  mc_5 = ((mc_5 * tex_10) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_22;
  tmpvar_22 = ((mc_5.xyz * (
    (((2.0 * tex_S_Color_8.xyz) * tex_S_Color_8.w) + 1.0)
   - tex_S_Color_8.w)) * _LightMapIntensity);
  colorBlendLightMap_4 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD8);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD9);
  highp float tmpvar_25;
  tmpvar_25 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (tmpvar_23, tmpvar_24))
  , _fresnelIndensity)));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + (tmpvar_25 * _fresnelColA.xyz));
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (colorBlendLightMap_4, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (tmpvar_26, vec3(dot (tmpvar_26, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_4 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (dot (normalize(
    (_LightPosition.xyz + tmpvar_24)
  ), tmpvar_23), _HeiLightGlass);
  highp vec2 tmpvar_29;
  tmpvar_29 = ((_Time.y * _HeiLightTexSpeed) + (xlv_TEXCOORD11.xy * _HeiLightTexTilling));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_SandShineTex, tmpvar_29);
  HeiLightTex_3 = tmpvar_30;
  lowp float tmpvar_31;
  lowp float tmpvar_32;
  tmpvar_32 = clamp (((texture2D (_SandShineTex, tmpvar_29).y - 1.0) / 0.3), 0.0, 1.0);
  tmpvar_31 = (tmpvar_32 * (tmpvar_32 * (3.0 - 
    (2.0 * tmpvar_32)
  )));
  smoothstepResult1_2 = tmpvar_31;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD11.xy * _HeiLightPointTilling);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SandShineTex, tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (_HeiLightPointStep * 0.1);
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_34.z - tmpvar_35) / (
    (tmpvar_35 + _HeiLightPointStepWidth)
   - tmpvar_35)), 0.0, 1.0);
  highp vec2 tmpvar_37;
  tmpvar_37 = ((xlv_TEXCOORD10.xy * _SandShineTex_ST.xy) + _SandShineTex_ST.zw);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_SandShineTex, tmpvar_37);
  highp vec3 tmpvar_39;
  tmpvar_39 = (((
    ((tmpvar_28 * _HeiLightInvertIntensity) * _HeiLightInvertColor)
   + 
    (tmpvar_28 * smoothstepResult1_2)
  ) + (
    ((((tmpvar_28 * _HeiLightPointIntensity) * (tmpvar_36 * 
      (tmpvar_36 * (3.0 - (2.0 * tmpvar_36)))
    )) * _HeiLightPointColor) * HeiLightTex_3.y)
   * HeiLightTex_3.y)).xyz + ((
    (tmpvar_38.x * _SecondTexColor)
   * _SecondTexIntensity).xyz + tmpvar_27));
  OutColor_1 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = OutColor_1;
  tmpvar_40.w = _BloomFactor;
  gl_FragData[0] = tmpvar_40;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
attribute vec4 _glesMultiTexCoord3;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1 = _glesMultiTexCoord2;
  tmpvar_2 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_3;
  mediump vec3 worldTangent_4;
  mediump vec3 worldNormal_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  tmpvar_12 = (_glesNormal * tmpvar_15);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = (_WorldSpaceLightPos0.xyz - (tmpvar_16.xyz * _WorldSpaceLightPos0.w));
  tmpvar_13 = (_WorldSpaceCameraPos - tmpvar_16.xyz);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_5 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * _glesTANGENT.w);
  worldBinormal_3 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_4.x;
  tmpvar_23.y = worldBinormal_3.x;
  tmpvar_23.z = worldNormal_5.x;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = worldTangent_4.y;
  tmpvar_24.y = worldBinormal_3.y;
  tmpvar_24.z = worldNormal_5.y;
  mediump vec3 tmpvar_25;
  tmpvar_25.x = worldTangent_4.z;
  tmpvar_25.y = worldBinormal_3.z;
  tmpvar_25.z = worldNormal_5.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_glesNormal);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_28;
  highp vec3 tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_28 = _glesTANGENT.xyz;
  tmpvar_29 = (((tmpvar_26.yzx * tmpvar_27.zxy) - (tmpvar_26.zxy * tmpvar_27.yzx)) * _glesTANGENT.w);
  tmpvar_30 = _glesNormal;
  highp mat3 tmpvar_31;
  tmpvar_31[0].x = tmpvar_28.x;
  tmpvar_31[0].y = tmpvar_29.x;
  tmpvar_31[0].z = tmpvar_30.x;
  tmpvar_31[1].x = tmpvar_28.y;
  tmpvar_31[1].y = tmpvar_29.y;
  tmpvar_31[1].z = tmpvar_30.y;
  tmpvar_31[2].x = tmpvar_28.z;
  tmpvar_31[2].y = tmpvar_29.z;
  tmpvar_31[2].z = tmpvar_30.z;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = normalize((tmpvar_31 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_32)
  .xyz)));
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_33;
  fogTune_33 = _FogTune;
  mediump vec4 tmpvar_34;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    tmpvar_38 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_37))
       * 
        (_FogIntensity * tmpvar_37)
      ) * fogTune_33)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_37)) * (_FogColorIntensity * tmpvar_37))
    ), 0.0, 1.0)));
    fogColor_35.xyz = tmpvar_39;
    fogColor_35.w = tmpvar_38;
    tmpvar_34 = fogColor_35;
  } else {
    mediump vec4 fogColor_40;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_42;
    tmpvar_42 = max (0.0, (sqrt(
      dot (tmpvar_41, tmpvar_41)
    ) - _FogStartDistance));
    highp float tmpvar_43;
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_44;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_34;
  xlv_TEXCOORD2 = tmpvar_23;
  xlv_TEXCOORD3 = tmpvar_24;
  xlv_TEXCOORD4 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_TEXCOORD8 = tmpvar_12;
  xlv_TEXCOORD9 = tmpvar_13;
  xlv_TEXCOORD10 = tmpvar_1;
  xlv_TEXCOORD11 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform highp float _HeiLightGlass;
uniform highp float _HeiLightInvertIntensity;
uniform highp vec4 _HeiLightInvertColor;
uniform sampler2D _SandShineTex;
uniform highp vec4 _SandShineTex_ST;
uniform highp vec2 _HeiLightTexSpeed;
uniform highp vec2 _HeiLightTexTilling;
uniform highp float _HeiLightPointStep;
uniform highp float _HeiLightPointStepWidth;
uniform highp vec2 _HeiLightPointTilling;
uniform highp vec4 _HeiLightPointColor;
uniform highp float _HeiLightPointIntensity;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform highp vec4 _LightPosition;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  mediump vec3 OutColor_1;
  highp float smoothstepResult1_2;
  highp vec4 HeiLightTex_3;
  mediump vec3 colorBlendLightMap_4;
  highp vec4 mc_5;
  highp vec3 worldNorm_6;
  mediump float matcapMask_7;
  mediump vec4 tex_S_Color_8;
  mediump vec3 normals_9;
  mediump vec4 tex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_8 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD2, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD3, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  worldNorm_6 = (tmpvar_18 * worldNorm_6);
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (worldNorm_6, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_6, xlv_TEXCOORD5) * worldNorm_6))
  )), vec3(_MetalRef));
  worldNorm_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((tmpvar_19.xy * 0.5) + 0.5);
  tmpvar_20 = texture2D (_MatCap, P_21);
  mc_5 = tmpvar_20;
  mc_5.xyz = mix (vec3(1.0, 1.0, 1.0), mc_5.xyz, vec3(matcapMask_7));
  mc_5 = ((mc_5 * tex_10) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_22;
  tmpvar_22 = ((mc_5.xyz * (
    (((2.0 * tex_S_Color_8.xyz) * tex_S_Color_8.w) + 1.0)
   - tex_S_Color_8.w)) * _LightMapIntensity);
  colorBlendLightMap_4 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD8);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD9);
  highp float tmpvar_25;
  tmpvar_25 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (tmpvar_23, tmpvar_24))
  , _fresnelIndensity)));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + (tmpvar_25 * _fresnelColA.xyz));
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (colorBlendLightMap_4, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (tmpvar_26, vec3(dot (tmpvar_26, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_4 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (dot (normalize(
    (_LightPosition.xyz + tmpvar_24)
  ), tmpvar_23), _HeiLightGlass);
  highp vec2 tmpvar_29;
  tmpvar_29 = ((_Time.y * _HeiLightTexSpeed) + (xlv_TEXCOORD11.xy * _HeiLightTexTilling));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_SandShineTex, tmpvar_29);
  HeiLightTex_3 = tmpvar_30;
  lowp float tmpvar_31;
  lowp float tmpvar_32;
  tmpvar_32 = clamp (((texture2D (_SandShineTex, tmpvar_29).y - 1.0) / 0.3), 0.0, 1.0);
  tmpvar_31 = (tmpvar_32 * (tmpvar_32 * (3.0 - 
    (2.0 * tmpvar_32)
  )));
  smoothstepResult1_2 = tmpvar_31;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD11.xy * _HeiLightPointTilling);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SandShineTex, tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (_HeiLightPointStep * 0.1);
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_34.z - tmpvar_35) / (
    (tmpvar_35 + _HeiLightPointStepWidth)
   - tmpvar_35)), 0.0, 1.0);
  highp vec2 tmpvar_37;
  tmpvar_37 = ((xlv_TEXCOORD10.xy * _SandShineTex_ST.xy) + _SandShineTex_ST.zw);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_SandShineTex, tmpvar_37);
  highp vec3 tmpvar_39;
  tmpvar_39 = (((
    ((tmpvar_28 * _HeiLightInvertIntensity) * _HeiLightInvertColor)
   + 
    (tmpvar_28 * smoothstepResult1_2)
  ) + (
    ((((tmpvar_28 * _HeiLightPointIntensity) * (tmpvar_36 * 
      (tmpvar_36 * (3.0 - (2.0 * tmpvar_36)))
    )) * _HeiLightPointColor) * HeiLightTex_3.y)
   * HeiLightTex_3.y)).xyz + ((
    (tmpvar_38.x * _SecondTexColor)
   * _SecondTexIntensity).xyz + tmpvar_27));
  OutColor_1 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = OutColor_1;
  tmpvar_40.w = _BloomFactor;
  gl_FragData[0] = tmpvar_40;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
attribute vec4 _glesMultiTexCoord3;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1 = _glesMultiTexCoord2;
  tmpvar_2 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_3;
  mediump vec3 worldTangent_4;
  mediump vec3 worldNormal_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  tmpvar_12 = (_glesNormal * tmpvar_15);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = (_WorldSpaceLightPos0.xyz - (tmpvar_16.xyz * _WorldSpaceLightPos0.w));
  tmpvar_13 = (_WorldSpaceCameraPos - tmpvar_16.xyz);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_5 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * _glesTANGENT.w);
  worldBinormal_3 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_4.x;
  tmpvar_23.y = worldBinormal_3.x;
  tmpvar_23.z = worldNormal_5.x;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = worldTangent_4.y;
  tmpvar_24.y = worldBinormal_3.y;
  tmpvar_24.z = worldNormal_5.y;
  mediump vec3 tmpvar_25;
  tmpvar_25.x = worldTangent_4.z;
  tmpvar_25.y = worldBinormal_3.z;
  tmpvar_25.z = worldNormal_5.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_glesNormal);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_28;
  highp vec3 tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_28 = _glesTANGENT.xyz;
  tmpvar_29 = (((tmpvar_26.yzx * tmpvar_27.zxy) - (tmpvar_26.zxy * tmpvar_27.yzx)) * _glesTANGENT.w);
  tmpvar_30 = _glesNormal;
  highp mat3 tmpvar_31;
  tmpvar_31[0].x = tmpvar_28.x;
  tmpvar_31[0].y = tmpvar_29.x;
  tmpvar_31[0].z = tmpvar_30.x;
  tmpvar_31[1].x = tmpvar_28.y;
  tmpvar_31[1].y = tmpvar_29.y;
  tmpvar_31[1].z = tmpvar_30.y;
  tmpvar_31[2].x = tmpvar_28.z;
  tmpvar_31[2].y = tmpvar_29.z;
  tmpvar_31[2].z = tmpvar_30.z;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = normalize((tmpvar_31 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_32)
  .xyz)));
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_33;
  fogTune_33 = _FogTune;
  mediump vec4 tmpvar_34;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    tmpvar_38 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_37))
       * 
        (_FogIntensity * tmpvar_37)
      ) * fogTune_33)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_37)) * (_FogColorIntensity * tmpvar_37))
    ), 0.0, 1.0)));
    fogColor_35.xyz = tmpvar_39;
    fogColor_35.w = tmpvar_38;
    tmpvar_34 = fogColor_35;
  } else {
    mediump vec4 fogColor_40;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_42;
    tmpvar_42 = max (0.0, (sqrt(
      dot (tmpvar_41, tmpvar_41)
    ) - _FogStartDistance));
    highp float tmpvar_43;
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_44;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_34;
  xlv_TEXCOORD2 = tmpvar_23;
  xlv_TEXCOORD3 = tmpvar_24;
  xlv_TEXCOORD4 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_TEXCOORD8 = tmpvar_12;
  xlv_TEXCOORD9 = tmpvar_13;
  xlv_TEXCOORD10 = tmpvar_1;
  xlv_TEXCOORD11 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform highp float _HeiLightGlass;
uniform highp float _HeiLightInvertIntensity;
uniform highp vec4 _HeiLightInvertColor;
uniform sampler2D _SandShineTex;
uniform highp vec4 _SandShineTex_ST;
uniform highp vec2 _HeiLightTexSpeed;
uniform highp vec2 _HeiLightTexTilling;
uniform highp float _HeiLightPointStep;
uniform highp float _HeiLightPointStepWidth;
uniform highp vec2 _HeiLightPointTilling;
uniform highp vec4 _HeiLightPointColor;
uniform highp float _HeiLightPointIntensity;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform highp vec4 _LightPosition;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  mediump vec3 OutColor_1;
  highp float smoothstepResult1_2;
  highp vec4 HeiLightTex_3;
  mediump vec3 colorBlendLightMap_4;
  highp vec4 mc_5;
  highp vec3 worldNorm_6;
  mediump float matcapMask_7;
  mediump vec4 tex_S_Color_8;
  mediump vec3 normals_9;
  mediump vec4 tex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_8 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD2, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD3, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  worldNorm_6 = (tmpvar_18 * worldNorm_6);
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (worldNorm_6, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_6, xlv_TEXCOORD5) * worldNorm_6))
  )), vec3(_MetalRef));
  worldNorm_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((tmpvar_19.xy * 0.5) + 0.5);
  tmpvar_20 = texture2D (_MatCap, P_21);
  mc_5 = tmpvar_20;
  mc_5.xyz = mix (vec3(1.0, 1.0, 1.0), mc_5.xyz, vec3(matcapMask_7));
  mc_5 = ((mc_5 * tex_10) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_22;
  tmpvar_22 = ((mc_5.xyz * (
    (((2.0 * tex_S_Color_8.xyz) * tex_S_Color_8.w) + 1.0)
   - tex_S_Color_8.w)) * _LightMapIntensity);
  colorBlendLightMap_4 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD8);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD9);
  highp float tmpvar_25;
  tmpvar_25 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (tmpvar_23, tmpvar_24))
  , _fresnelIndensity)));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + (tmpvar_25 * _fresnelColA.xyz));
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (colorBlendLightMap_4, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (tmpvar_26, vec3(dot (tmpvar_26, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_4 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (dot (normalize(
    (_LightPosition.xyz + tmpvar_24)
  ), tmpvar_23), _HeiLightGlass);
  highp vec2 tmpvar_29;
  tmpvar_29 = ((_Time.y * _HeiLightTexSpeed) + (xlv_TEXCOORD11.xy * _HeiLightTexTilling));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_SandShineTex, tmpvar_29);
  HeiLightTex_3 = tmpvar_30;
  lowp float tmpvar_31;
  lowp float tmpvar_32;
  tmpvar_32 = clamp (((texture2D (_SandShineTex, tmpvar_29).y - 1.0) / 0.3), 0.0, 1.0);
  tmpvar_31 = (tmpvar_32 * (tmpvar_32 * (3.0 - 
    (2.0 * tmpvar_32)
  )));
  smoothstepResult1_2 = tmpvar_31;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD11.xy * _HeiLightPointTilling);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SandShineTex, tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (_HeiLightPointStep * 0.1);
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_34.z - tmpvar_35) / (
    (tmpvar_35 + _HeiLightPointStepWidth)
   - tmpvar_35)), 0.0, 1.0);
  highp vec2 tmpvar_37;
  tmpvar_37 = ((xlv_TEXCOORD10.xy * _SandShineTex_ST.xy) + _SandShineTex_ST.zw);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_SandShineTex, tmpvar_37);
  highp vec3 tmpvar_39;
  tmpvar_39 = (((
    ((tmpvar_28 * _HeiLightInvertIntensity) * _HeiLightInvertColor)
   + 
    (tmpvar_28 * smoothstepResult1_2)
  ) + (
    ((((tmpvar_28 * _HeiLightPointIntensity) * (tmpvar_36 * 
      (tmpvar_36 * (3.0 - (2.0 * tmpvar_36)))
    )) * _HeiLightPointColor) * HeiLightTex_3.y)
   * HeiLightTex_3.y)).xyz + ((
    (tmpvar_38.x * _SecondTexColor)
   * _SecondTexIntensity).xyz + tmpvar_27));
  OutColor_1 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = OutColor_1;
  tmpvar_40.w = _BloomFactor;
  gl_FragData[0] = tmpvar_40;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
attribute vec4 _glesMultiTexCoord3;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
uniform mediump vec4 _ShadowTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD7;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1 = _glesMultiTexCoord2;
  tmpvar_2 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_3;
  mediump vec3 worldTangent_4;
  mediump vec3 worldNormal_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  tmpvar_12 = (_glesNormal * tmpvar_15);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = (_WorldSpaceLightPos0.xyz - (tmpvar_16.xyz * _WorldSpaceLightPos0.w));
  tmpvar_13 = (_WorldSpaceCameraPos - tmpvar_16.xyz);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_5 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_19[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_19[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = ((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * _glesTANGENT.w);
  worldBinormal_3 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = worldTangent_4.x;
  tmpvar_23.y = worldBinormal_3.x;
  tmpvar_23.z = worldNormal_5.x;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = worldTangent_4.y;
  tmpvar_24.y = worldBinormal_3.y;
  tmpvar_24.z = worldNormal_5.y;
  mediump vec3 tmpvar_25;
  tmpvar_25.x = worldTangent_4.z;
  tmpvar_25.y = worldBinormal_3.z;
  tmpvar_25.z = worldNormal_5.z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(_glesNormal);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_28;
  highp vec3 tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_28 = _glesTANGENT.xyz;
  tmpvar_29 = (((tmpvar_26.yzx * tmpvar_27.zxy) - (tmpvar_26.zxy * tmpvar_27.yzx)) * _glesTANGENT.w);
  tmpvar_30 = _glesNormal;
  highp mat3 tmpvar_31;
  tmpvar_31[0].x = tmpvar_28.x;
  tmpvar_31[0].y = tmpvar_29.x;
  tmpvar_31[0].z = tmpvar_30.x;
  tmpvar_31[1].x = tmpvar_28.y;
  tmpvar_31[1].y = tmpvar_29.y;
  tmpvar_31[1].z = tmpvar_30.y;
  tmpvar_31[2].x = tmpvar_28.z;
  tmpvar_31[2].y = tmpvar_29.z;
  tmpvar_31[2].z = tmpvar_30.z;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _WorldSpaceCameraPos;
  tmpvar_9 = normalize((tmpvar_31 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_32)
  .xyz)));
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_33;
  fogTune_33 = _FogTune;
  mediump vec4 tmpvar_34;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    tmpvar_38 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_37))
       * 
        (_FogIntensity * tmpvar_37)
      ) * fogTune_33)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_39;
    tmpvar_39 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_37)) * (_FogColorIntensity * tmpvar_37))
    ), 0.0, 1.0)));
    fogColor_35.xyz = tmpvar_39;
    fogColor_35.w = tmpvar_38;
    tmpvar_34 = fogColor_35;
  } else {
    mediump vec4 fogColor_40;
    highp vec3 tmpvar_41;
    tmpvar_41 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_42;
    tmpvar_42 = max (0.0, (sqrt(
      dot (tmpvar_41, tmpvar_41)
    ) - _FogStartDistance));
    highp float tmpvar_43;
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_33)), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, ((_FogEndDistance * fogTune_33) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_44;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_34;
  xlv_TEXCOORD2 = tmpvar_23;
  xlv_TEXCOORD3 = tmpvar_24;
  xlv_TEXCOORD4 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = tmpvar_11;
  xlv_TEXCOORD8 = tmpvar_12;
  xlv_TEXCOORD9 = tmpvar_13;
  xlv_TEXCOORD10 = tmpvar_1;
  xlv_TEXCOORD11 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _ShadowTex;
uniform mediump float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
uniform highp float _fresnelBaseA;
uniform highp float _fresnelScaleA;
uniform highp float _fresnelIndensity;
uniform highp vec4 _fresnelColA;
uniform highp float _HeiLightGlass;
uniform highp float _HeiLightInvertIntensity;
uniform highp vec4 _HeiLightInvertColor;
uniform sampler2D _SandShineTex;
uniform highp vec4 _SandShineTex_ST;
uniform highp vec2 _HeiLightTexSpeed;
uniform highp vec2 _HeiLightTexTilling;
uniform highp float _HeiLightPointStep;
uniform highp float _HeiLightPointStepWidth;
uniform highp vec2 _HeiLightPointTilling;
uniform highp vec4 _HeiLightPointColor;
uniform highp float _HeiLightPointIntensity;
uniform highp vec4 _SecondTexColor;
uniform highp float _SecondTexIntensity;
uniform highp vec4 _LightPosition;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
uniform sampler2D _MatcapMaskMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying mediump vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
varying highp vec4 xlv_TEXCOORD10;
varying highp vec4 xlv_TEXCOORD11;
void main ()
{
  mediump vec3 OutColor_1;
  highp float smoothstepResult1_2;
  highp vec4 HeiLightTex_3;
  mediump vec3 colorBlendLightMap_4;
  highp vec4 mc_5;
  highp vec3 worldNorm_6;
  mediump float matcapMask_7;
  mediump vec4 tex_S_Color_8;
  mediump vec3 normals_9;
  mediump vec4 tex_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_9 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowTex, xlv_TEXCOORD6);
  tex_S_Color_8 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MatcapMaskMap, xlv_TEXCOORD0).x;
  matcapMask_7 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD2, normals_9);
  worldNorm_6.x = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD3, normals_9);
  worldNorm_6.y = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, normals_9);
  worldNorm_6.z = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_MatrixV[0].xyz;
  tmpvar_18[1] = unity_MatrixV[1].xyz;
  tmpvar_18[2] = unity_MatrixV[2].xyz;
  worldNorm_6 = (tmpvar_18 * worldNorm_6);
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (worldNorm_6, normalize((xlv_TEXCOORD5 - 
    (2.0 * (dot (worldNorm_6, xlv_TEXCOORD5) * worldNorm_6))
  )), vec3(_MetalRef));
  worldNorm_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((tmpvar_19.xy * 0.5) + 0.5);
  tmpvar_20 = texture2D (_MatCap, P_21);
  mc_5 = tmpvar_20;
  mc_5.xyz = mix (vec3(1.0, 1.0, 1.0), mc_5.xyz, vec3(matcapMask_7));
  mc_5 = ((mc_5 * tex_10) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  highp vec3 tmpvar_22;
  tmpvar_22 = ((mc_5.xyz * (
    (((2.0 * tex_S_Color_8.xyz) * tex_S_Color_8.w) + 1.0)
   - tex_S_Color_8.w)) * _LightMapIntensity);
  colorBlendLightMap_4 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD8);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD9);
  highp float tmpvar_25;
  tmpvar_25 = (_fresnelBaseA + (_fresnelScaleA * pow (
    (1.001 - dot (tmpvar_23, tmpvar_24))
  , _fresnelIndensity)));
  colorBlendLightMap_4 = (colorBlendLightMap_4 + (tmpvar_25 * _fresnelColA.xyz));
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix (colorBlendLightMap_4, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec3 tmpvar_27;
  tmpvar_27 = mix (tmpvar_26, vec3(dot (tmpvar_26, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  colorBlendLightMap_4 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = pow (dot (normalize(
    (_LightPosition.xyz + tmpvar_24)
  ), tmpvar_23), _HeiLightGlass);
  highp vec2 tmpvar_29;
  tmpvar_29 = ((_Time.y * _HeiLightTexSpeed) + (xlv_TEXCOORD11.xy * _HeiLightTexTilling));
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_SandShineTex, tmpvar_29);
  HeiLightTex_3 = tmpvar_30;
  lowp float tmpvar_31;
  lowp float tmpvar_32;
  tmpvar_32 = clamp (((texture2D (_SandShineTex, tmpvar_29).y - 1.0) / 0.3), 0.0, 1.0);
  tmpvar_31 = (tmpvar_32 * (tmpvar_32 * (3.0 - 
    (2.0 * tmpvar_32)
  )));
  smoothstepResult1_2 = tmpvar_31;
  highp vec2 tmpvar_33;
  tmpvar_33 = (xlv_TEXCOORD11.xy * _HeiLightPointTilling);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_SandShineTex, tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (_HeiLightPointStep * 0.1);
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_34.z - tmpvar_35) / (
    (tmpvar_35 + _HeiLightPointStepWidth)
   - tmpvar_35)), 0.0, 1.0);
  highp vec2 tmpvar_37;
  tmpvar_37 = ((xlv_TEXCOORD10.xy * _SandShineTex_ST.xy) + _SandShineTex_ST.zw);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_SandShineTex, tmpvar_37);
  highp vec3 tmpvar_39;
  tmpvar_39 = (((
    ((tmpvar_28 * _HeiLightInvertIntensity) * _HeiLightInvertColor)
   + 
    (tmpvar_28 * smoothstepResult1_2)
  ) + (
    ((((tmpvar_28 * _HeiLightPointIntensity) * (tmpvar_36 * 
      (tmpvar_36 * (3.0 - (2.0 * tmpvar_36)))
    )) * _HeiLightPointColor) * HeiLightTex_3.y)
   * HeiLightTex_3.y)).xyz + ((
    (tmpvar_38.x * _SecondTexColor)
   * _SecondTexIntensity).xyz + tmpvar_27));
  OutColor_1 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = OutColor_1;
  tmpvar_40.w = _BloomFactor;
  gl_FragData[0] = tmpvar_40;
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
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
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
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
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
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
}
}
}
Fallback "VertexLit"
}