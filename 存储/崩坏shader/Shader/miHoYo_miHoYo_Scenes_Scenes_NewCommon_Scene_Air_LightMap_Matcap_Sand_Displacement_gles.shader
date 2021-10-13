//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/Scene_Air_LightMap_Matcap_Sand_Displacement" {
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
[MHYHeaderBox(Displacement)] _DisplacementMap ("_Displacement Map", 2D) = "black" { }
_MaxHeight ("Max Height", Range(0, 2)) = 1
_GroundHeight ("Ground Height", Float) = 0
_BlendStrengthen ("Blend Strengthen", Range(1, 20)) = 1
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 23824
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
uniform sampler2D _DisplacementMap;
uniform mediump float _MaxHeight;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord2;
  tmpvar_4 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_5;
  mediump vec3 worldTangent_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec2 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2DLod (_DisplacementMap, _glesMultiTexCoord1.xy, 0.0);
  highp float tmpvar_19;
  tmpvar_19 = tmpvar_18.x;
  highp float s12_20;
  highp float s10_21;
  highp float s21_22;
  highp float s01_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = (_glesMultiTexCoord1.xy + vec2(0.01, 0.0));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DLod (_DisplacementMap, tmpvar_24.xy, 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = (tmpvar_25.x * _MaxHeight);
  s01_23 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (_glesMultiTexCoord1.xy - vec2(0.01, 0.0));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_DisplacementMap, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = (tmpvar_28.x * _MaxHeight);
  s21_22 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = (_glesMultiTexCoord1.xy + vec2(0.0, 0.01));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_DisplacementMap, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = (tmpvar_31.x * _MaxHeight);
  s10_21 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 0.0);
  tmpvar_33.xy = (_glesMultiTexCoord1.xy - vec2(0.0, 0.01));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_DisplacementMap, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = (tmpvar_34.x * _MaxHeight);
  s12_20 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(-0.01, 0.0);
  tmpvar_36.z = (s21_22 - s01_23);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -0.01);
  tmpvar_38.z = (s12_20 - s10_21);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((tmpvar_37.yzx * tmpvar_39.zxy) - (tmpvar_37.zxy * tmpvar_39.yzx)));
  highp vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_1;
  tmpvar_2 = (_glesVertex + ((tmpvar_41 * tmpvar_19) * _MaxHeight));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_2.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_43;
  tmpvar_43[0] = unity_WorldToObject[0].xyz;
  tmpvar_43[1] = unity_WorldToObject[1].xyz;
  tmpvar_43[2] = unity_WorldToObject[2].xyz;
  tmpvar_16 = (_glesNormal * tmpvar_43);
  tmpvar_15 = (_WorldSpaceLightPos0.xyz - ((unity_ObjectToWorld * tmpvar_2).xyz * _WorldSpaceLightPos0.w));
  tmpvar_17 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * tmpvar_2).xyz);
  highp mat3 tmpvar_44;
  tmpvar_44[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_44[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_44[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize((tmpvar_44 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((tmpvar_40.yzx * worldTangent_6.zxy) - (tmpvar_40.zxy * worldTangent_6.yzx)) * _glesTANGENT.w);
  worldBinormal_5 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47.x = worldTangent_6.x;
  tmpvar_47.y = worldBinormal_5.x;
  tmpvar_47.z = tmpvar_40.x;
  tmpvar_10 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.x = worldTangent_6.y;
  tmpvar_48.y = worldBinormal_5.y;
  tmpvar_48.z = tmpvar_40.y;
  tmpvar_11 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.x = worldTangent_6.z;
  tmpvar_49.y = worldBinormal_5.z;
  tmpvar_49.z = tmpvar_40.z;
  tmpvar_12 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize(_glesNormal);
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_52 = _glesTANGENT.xyz;
  tmpvar_53 = (((tmpvar_50.yzx * tmpvar_51.zxy) - (tmpvar_50.zxy * tmpvar_51.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_54;
  tmpvar_54[0].x = tmpvar_52.x;
  tmpvar_54[0].y = tmpvar_53.x;
  tmpvar_54[0].z = tmpvar_1.x;
  tmpvar_54[1].x = tmpvar_52.y;
  tmpvar_54[1].y = tmpvar_53.y;
  tmpvar_54[1].z = tmpvar_1.y;
  tmpvar_54[2].x = tmpvar_52.z;
  tmpvar_54[2].y = tmpvar_53.z;
  tmpvar_54[2].z = tmpvar_1.z;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 1.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  tmpvar_13 = normalize((tmpvar_54 * (tmpvar_2.xyz - 
    (unity_WorldToObject * tmpvar_55)
  .xyz)));
  tmpvar_14 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_56;
  fogTune_56 = _FogTune;
  mediump vec4 tmpvar_57;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_58;
    highp vec3 tmpvar_59;
    tmpvar_59 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_60;
    tmpvar_60 = max (0.0, (sqrt(
      dot (tmpvar_59, tmpvar_59)
    ) - _FogStartDistance));
    highp float tmpvar_61;
    tmpvar_61 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_60))
       * 
        (_FogIntensity * tmpvar_60)
      ) * fogTune_56)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_62;
    tmpvar_62 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_60)) * (_FogColorIntensity * tmpvar_60))
    ), 0.0, 1.0)));
    fogColor_58.xyz = tmpvar_62;
    fogColor_58.w = tmpvar_61;
    tmpvar_57 = fogColor_58;
  } else {
    mediump vec4 fogColor_63;
    highp vec3 tmpvar_64;
    tmpvar_64 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_65;
    tmpvar_65 = max (0.0, (sqrt(
      dot (tmpvar_64, tmpvar_64)
    ) - _FogStartDistance));
    highp float tmpvar_66;
    tmpvar_66 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_67;
    tmpvar_67 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_63.xyz = tmpvar_67;
    fogColor_63.w = tmpvar_66;
    tmpvar_57 = fogColor_63;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_COLOR1 = tmpvar_57;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = tmpvar_16;
  xlv_TEXCOORD9 = tmpvar_17;
  xlv_TEXCOORD10 = tmpvar_3;
  xlv_TEXCOORD11 = tmpvar_4;
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
uniform sampler2D _DisplacementMap;
uniform mediump float _MaxHeight;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord2;
  tmpvar_4 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_5;
  mediump vec3 worldTangent_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec2 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2DLod (_DisplacementMap, _glesMultiTexCoord1.xy, 0.0);
  highp float tmpvar_19;
  tmpvar_19 = tmpvar_18.x;
  highp float s12_20;
  highp float s10_21;
  highp float s21_22;
  highp float s01_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = (_glesMultiTexCoord1.xy + vec2(0.01, 0.0));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DLod (_DisplacementMap, tmpvar_24.xy, 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = (tmpvar_25.x * _MaxHeight);
  s01_23 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (_glesMultiTexCoord1.xy - vec2(0.01, 0.0));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_DisplacementMap, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = (tmpvar_28.x * _MaxHeight);
  s21_22 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = (_glesMultiTexCoord1.xy + vec2(0.0, 0.01));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_DisplacementMap, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = (tmpvar_31.x * _MaxHeight);
  s10_21 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 0.0);
  tmpvar_33.xy = (_glesMultiTexCoord1.xy - vec2(0.0, 0.01));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_DisplacementMap, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = (tmpvar_34.x * _MaxHeight);
  s12_20 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(-0.01, 0.0);
  tmpvar_36.z = (s21_22 - s01_23);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -0.01);
  tmpvar_38.z = (s12_20 - s10_21);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((tmpvar_37.yzx * tmpvar_39.zxy) - (tmpvar_37.zxy * tmpvar_39.yzx)));
  highp vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_1;
  tmpvar_2 = (_glesVertex + ((tmpvar_41 * tmpvar_19) * _MaxHeight));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_2.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_43;
  tmpvar_43[0] = unity_WorldToObject[0].xyz;
  tmpvar_43[1] = unity_WorldToObject[1].xyz;
  tmpvar_43[2] = unity_WorldToObject[2].xyz;
  tmpvar_16 = (_glesNormal * tmpvar_43);
  tmpvar_15 = (_WorldSpaceLightPos0.xyz - ((unity_ObjectToWorld * tmpvar_2).xyz * _WorldSpaceLightPos0.w));
  tmpvar_17 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * tmpvar_2).xyz);
  highp mat3 tmpvar_44;
  tmpvar_44[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_44[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_44[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize((tmpvar_44 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((tmpvar_40.yzx * worldTangent_6.zxy) - (tmpvar_40.zxy * worldTangent_6.yzx)) * _glesTANGENT.w);
  worldBinormal_5 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47.x = worldTangent_6.x;
  tmpvar_47.y = worldBinormal_5.x;
  tmpvar_47.z = tmpvar_40.x;
  tmpvar_10 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.x = worldTangent_6.y;
  tmpvar_48.y = worldBinormal_5.y;
  tmpvar_48.z = tmpvar_40.y;
  tmpvar_11 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.x = worldTangent_6.z;
  tmpvar_49.y = worldBinormal_5.z;
  tmpvar_49.z = tmpvar_40.z;
  tmpvar_12 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize(_glesNormal);
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_52 = _glesTANGENT.xyz;
  tmpvar_53 = (((tmpvar_50.yzx * tmpvar_51.zxy) - (tmpvar_50.zxy * tmpvar_51.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_54;
  tmpvar_54[0].x = tmpvar_52.x;
  tmpvar_54[0].y = tmpvar_53.x;
  tmpvar_54[0].z = tmpvar_1.x;
  tmpvar_54[1].x = tmpvar_52.y;
  tmpvar_54[1].y = tmpvar_53.y;
  tmpvar_54[1].z = tmpvar_1.y;
  tmpvar_54[2].x = tmpvar_52.z;
  tmpvar_54[2].y = tmpvar_53.z;
  tmpvar_54[2].z = tmpvar_1.z;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 1.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  tmpvar_13 = normalize((tmpvar_54 * (tmpvar_2.xyz - 
    (unity_WorldToObject * tmpvar_55)
  .xyz)));
  tmpvar_14 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_56;
  fogTune_56 = _FogTune;
  mediump vec4 tmpvar_57;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_58;
    highp vec3 tmpvar_59;
    tmpvar_59 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_60;
    tmpvar_60 = max (0.0, (sqrt(
      dot (tmpvar_59, tmpvar_59)
    ) - _FogStartDistance));
    highp float tmpvar_61;
    tmpvar_61 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_60))
       * 
        (_FogIntensity * tmpvar_60)
      ) * fogTune_56)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_62;
    tmpvar_62 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_60)) * (_FogColorIntensity * tmpvar_60))
    ), 0.0, 1.0)));
    fogColor_58.xyz = tmpvar_62;
    fogColor_58.w = tmpvar_61;
    tmpvar_57 = fogColor_58;
  } else {
    mediump vec4 fogColor_63;
    highp vec3 tmpvar_64;
    tmpvar_64 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_65;
    tmpvar_65 = max (0.0, (sqrt(
      dot (tmpvar_64, tmpvar_64)
    ) - _FogStartDistance));
    highp float tmpvar_66;
    tmpvar_66 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_67;
    tmpvar_67 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_63.xyz = tmpvar_67;
    fogColor_63.w = tmpvar_66;
    tmpvar_57 = fogColor_63;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_COLOR1 = tmpvar_57;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = tmpvar_16;
  xlv_TEXCOORD9 = tmpvar_17;
  xlv_TEXCOORD10 = tmpvar_3;
  xlv_TEXCOORD11 = tmpvar_4;
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
uniform sampler2D _DisplacementMap;
uniform mediump float _MaxHeight;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord2;
  tmpvar_4 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_5;
  mediump vec3 worldTangent_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec2 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2DLod (_DisplacementMap, _glesMultiTexCoord1.xy, 0.0);
  highp float tmpvar_19;
  tmpvar_19 = tmpvar_18.x;
  highp float s12_20;
  highp float s10_21;
  highp float s21_22;
  highp float s01_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = (_glesMultiTexCoord1.xy + vec2(0.01, 0.0));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DLod (_DisplacementMap, tmpvar_24.xy, 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = (tmpvar_25.x * _MaxHeight);
  s01_23 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (_glesMultiTexCoord1.xy - vec2(0.01, 0.0));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_DisplacementMap, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = (tmpvar_28.x * _MaxHeight);
  s21_22 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = (_glesMultiTexCoord1.xy + vec2(0.0, 0.01));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_DisplacementMap, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = (tmpvar_31.x * _MaxHeight);
  s10_21 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 0.0);
  tmpvar_33.xy = (_glesMultiTexCoord1.xy - vec2(0.0, 0.01));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_DisplacementMap, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = (tmpvar_34.x * _MaxHeight);
  s12_20 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(-0.01, 0.0);
  tmpvar_36.z = (s21_22 - s01_23);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -0.01);
  tmpvar_38.z = (s12_20 - s10_21);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((tmpvar_37.yzx * tmpvar_39.zxy) - (tmpvar_37.zxy * tmpvar_39.yzx)));
  highp vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_1;
  tmpvar_2 = (_glesVertex + ((tmpvar_41 * tmpvar_19) * _MaxHeight));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_2.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_43;
  tmpvar_43[0] = unity_WorldToObject[0].xyz;
  tmpvar_43[1] = unity_WorldToObject[1].xyz;
  tmpvar_43[2] = unity_WorldToObject[2].xyz;
  tmpvar_16 = (_glesNormal * tmpvar_43);
  tmpvar_15 = (_WorldSpaceLightPos0.xyz - ((unity_ObjectToWorld * tmpvar_2).xyz * _WorldSpaceLightPos0.w));
  tmpvar_17 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * tmpvar_2).xyz);
  highp mat3 tmpvar_44;
  tmpvar_44[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_44[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_44[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize((tmpvar_44 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((tmpvar_40.yzx * worldTangent_6.zxy) - (tmpvar_40.zxy * worldTangent_6.yzx)) * _glesTANGENT.w);
  worldBinormal_5 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47.x = worldTangent_6.x;
  tmpvar_47.y = worldBinormal_5.x;
  tmpvar_47.z = tmpvar_40.x;
  tmpvar_10 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.x = worldTangent_6.y;
  tmpvar_48.y = worldBinormal_5.y;
  tmpvar_48.z = tmpvar_40.y;
  tmpvar_11 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.x = worldTangent_6.z;
  tmpvar_49.y = worldBinormal_5.z;
  tmpvar_49.z = tmpvar_40.z;
  tmpvar_12 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize(_glesNormal);
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_52 = _glesTANGENT.xyz;
  tmpvar_53 = (((tmpvar_50.yzx * tmpvar_51.zxy) - (tmpvar_50.zxy * tmpvar_51.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_54;
  tmpvar_54[0].x = tmpvar_52.x;
  tmpvar_54[0].y = tmpvar_53.x;
  tmpvar_54[0].z = tmpvar_1.x;
  tmpvar_54[1].x = tmpvar_52.y;
  tmpvar_54[1].y = tmpvar_53.y;
  tmpvar_54[1].z = tmpvar_1.y;
  tmpvar_54[2].x = tmpvar_52.z;
  tmpvar_54[2].y = tmpvar_53.z;
  tmpvar_54[2].z = tmpvar_1.z;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 1.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  tmpvar_13 = normalize((tmpvar_54 * (tmpvar_2.xyz - 
    (unity_WorldToObject * tmpvar_55)
  .xyz)));
  tmpvar_14 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_56;
  fogTune_56 = _FogTune;
  mediump vec4 tmpvar_57;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_58;
    highp vec3 tmpvar_59;
    tmpvar_59 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_60;
    tmpvar_60 = max (0.0, (sqrt(
      dot (tmpvar_59, tmpvar_59)
    ) - _FogStartDistance));
    highp float tmpvar_61;
    tmpvar_61 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_60))
       * 
        (_FogIntensity * tmpvar_60)
      ) * fogTune_56)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_62;
    tmpvar_62 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_60)) * (_FogColorIntensity * tmpvar_60))
    ), 0.0, 1.0)));
    fogColor_58.xyz = tmpvar_62;
    fogColor_58.w = tmpvar_61;
    tmpvar_57 = fogColor_58;
  } else {
    mediump vec4 fogColor_63;
    highp vec3 tmpvar_64;
    tmpvar_64 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_65;
    tmpvar_65 = max (0.0, (sqrt(
      dot (tmpvar_64, tmpvar_64)
    ) - _FogStartDistance));
    highp float tmpvar_66;
    tmpvar_66 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_67;
    tmpvar_67 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_63.xyz = tmpvar_67;
    fogColor_63.w = tmpvar_66;
    tmpvar_57 = fogColor_63;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_COLOR1 = tmpvar_57;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = tmpvar_16;
  xlv_TEXCOORD9 = tmpvar_17;
  xlv_TEXCOORD10 = tmpvar_3;
  xlv_TEXCOORD11 = tmpvar_4;
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
uniform sampler2D _DisplacementMap;
uniform mediump float _MaxHeight;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord2;
  tmpvar_4 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_5;
  mediump vec3 worldTangent_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec2 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2DLod (_DisplacementMap, _glesMultiTexCoord1.xy, 0.0);
  highp float tmpvar_19;
  tmpvar_19 = tmpvar_18.x;
  highp float s12_20;
  highp float s10_21;
  highp float s21_22;
  highp float s01_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = (_glesMultiTexCoord1.xy + vec2(0.01, 0.0));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DLod (_DisplacementMap, tmpvar_24.xy, 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = (tmpvar_25.x * _MaxHeight);
  s01_23 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (_glesMultiTexCoord1.xy - vec2(0.01, 0.0));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_DisplacementMap, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = (tmpvar_28.x * _MaxHeight);
  s21_22 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = (_glesMultiTexCoord1.xy + vec2(0.0, 0.01));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_DisplacementMap, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = (tmpvar_31.x * _MaxHeight);
  s10_21 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 0.0);
  tmpvar_33.xy = (_glesMultiTexCoord1.xy - vec2(0.0, 0.01));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_DisplacementMap, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = (tmpvar_34.x * _MaxHeight);
  s12_20 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(-0.01, 0.0);
  tmpvar_36.z = (s21_22 - s01_23);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -0.01);
  tmpvar_38.z = (s12_20 - s10_21);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((tmpvar_37.yzx * tmpvar_39.zxy) - (tmpvar_37.zxy * tmpvar_39.yzx)));
  highp vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_1;
  tmpvar_2 = (_glesVertex + ((tmpvar_41 * tmpvar_19) * _MaxHeight));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_2.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_43;
  tmpvar_43[0] = unity_WorldToObject[0].xyz;
  tmpvar_43[1] = unity_WorldToObject[1].xyz;
  tmpvar_43[2] = unity_WorldToObject[2].xyz;
  tmpvar_16 = (_glesNormal * tmpvar_43);
  tmpvar_15 = (_WorldSpaceLightPos0.xyz - ((unity_ObjectToWorld * tmpvar_2).xyz * _WorldSpaceLightPos0.w));
  tmpvar_17 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * tmpvar_2).xyz);
  highp mat3 tmpvar_44;
  tmpvar_44[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_44[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_44[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize((tmpvar_44 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((tmpvar_40.yzx * worldTangent_6.zxy) - (tmpvar_40.zxy * worldTangent_6.yzx)) * _glesTANGENT.w);
  worldBinormal_5 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47.x = worldTangent_6.x;
  tmpvar_47.y = worldBinormal_5.x;
  tmpvar_47.z = tmpvar_40.x;
  tmpvar_10 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.x = worldTangent_6.y;
  tmpvar_48.y = worldBinormal_5.y;
  tmpvar_48.z = tmpvar_40.y;
  tmpvar_11 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.x = worldTangent_6.z;
  tmpvar_49.y = worldBinormal_5.z;
  tmpvar_49.z = tmpvar_40.z;
  tmpvar_12 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize(_glesNormal);
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_52 = _glesTANGENT.xyz;
  tmpvar_53 = (((tmpvar_50.yzx * tmpvar_51.zxy) - (tmpvar_50.zxy * tmpvar_51.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_54;
  tmpvar_54[0].x = tmpvar_52.x;
  tmpvar_54[0].y = tmpvar_53.x;
  tmpvar_54[0].z = tmpvar_1.x;
  tmpvar_54[1].x = tmpvar_52.y;
  tmpvar_54[1].y = tmpvar_53.y;
  tmpvar_54[1].z = tmpvar_1.y;
  tmpvar_54[2].x = tmpvar_52.z;
  tmpvar_54[2].y = tmpvar_53.z;
  tmpvar_54[2].z = tmpvar_1.z;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 1.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  tmpvar_13 = normalize((tmpvar_54 * (tmpvar_2.xyz - 
    (unity_WorldToObject * tmpvar_55)
  .xyz)));
  tmpvar_14 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_56;
  fogTune_56 = _FogTune;
  mediump vec4 tmpvar_57;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_58;
    highp vec3 tmpvar_59;
    tmpvar_59 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_60;
    tmpvar_60 = max (0.0, (sqrt(
      dot (tmpvar_59, tmpvar_59)
    ) - _FogStartDistance));
    highp float tmpvar_61;
    tmpvar_61 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_60))
       * 
        (_FogIntensity * tmpvar_60)
      ) * fogTune_56)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_62;
    tmpvar_62 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_60)) * (_FogColorIntensity * tmpvar_60))
    ), 0.0, 1.0)));
    fogColor_58.xyz = tmpvar_62;
    fogColor_58.w = tmpvar_61;
    tmpvar_57 = fogColor_58;
  } else {
    mediump vec4 fogColor_63;
    highp vec3 tmpvar_64;
    tmpvar_64 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_65;
    tmpvar_65 = max (0.0, (sqrt(
      dot (tmpvar_64, tmpvar_64)
    ) - _FogStartDistance));
    highp float tmpvar_66;
    tmpvar_66 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_67;
    tmpvar_67 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_63.xyz = tmpvar_67;
    fogColor_63.w = tmpvar_66;
    tmpvar_57 = fogColor_63;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_COLOR1 = tmpvar_57;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = tmpvar_16;
  xlv_TEXCOORD9 = tmpvar_17;
  xlv_TEXCOORD10 = tmpvar_3;
  xlv_TEXCOORD11 = tmpvar_4;
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
uniform sampler2D _DisplacementMap;
uniform mediump float _MaxHeight;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord2;
  tmpvar_4 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_5;
  mediump vec3 worldTangent_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec2 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2DLod (_DisplacementMap, _glesMultiTexCoord1.xy, 0.0);
  highp float tmpvar_19;
  tmpvar_19 = tmpvar_18.x;
  highp float s12_20;
  highp float s10_21;
  highp float s21_22;
  highp float s01_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = (_glesMultiTexCoord1.xy + vec2(0.01, 0.0));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DLod (_DisplacementMap, tmpvar_24.xy, 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = (tmpvar_25.x * _MaxHeight);
  s01_23 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (_glesMultiTexCoord1.xy - vec2(0.01, 0.0));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_DisplacementMap, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = (tmpvar_28.x * _MaxHeight);
  s21_22 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = (_glesMultiTexCoord1.xy + vec2(0.0, 0.01));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_DisplacementMap, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = (tmpvar_31.x * _MaxHeight);
  s10_21 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 0.0);
  tmpvar_33.xy = (_glesMultiTexCoord1.xy - vec2(0.0, 0.01));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_DisplacementMap, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = (tmpvar_34.x * _MaxHeight);
  s12_20 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(-0.01, 0.0);
  tmpvar_36.z = (s21_22 - s01_23);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -0.01);
  tmpvar_38.z = (s12_20 - s10_21);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((tmpvar_37.yzx * tmpvar_39.zxy) - (tmpvar_37.zxy * tmpvar_39.yzx)));
  highp vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_1;
  tmpvar_2 = (_glesVertex + ((tmpvar_41 * tmpvar_19) * _MaxHeight));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_2.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_43;
  tmpvar_43[0] = unity_WorldToObject[0].xyz;
  tmpvar_43[1] = unity_WorldToObject[1].xyz;
  tmpvar_43[2] = unity_WorldToObject[2].xyz;
  tmpvar_16 = (_glesNormal * tmpvar_43);
  tmpvar_15 = (_WorldSpaceLightPos0.xyz - ((unity_ObjectToWorld * tmpvar_2).xyz * _WorldSpaceLightPos0.w));
  tmpvar_17 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * tmpvar_2).xyz);
  highp mat3 tmpvar_44;
  tmpvar_44[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_44[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_44[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize((tmpvar_44 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((tmpvar_40.yzx * worldTangent_6.zxy) - (tmpvar_40.zxy * worldTangent_6.yzx)) * _glesTANGENT.w);
  worldBinormal_5 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47.x = worldTangent_6.x;
  tmpvar_47.y = worldBinormal_5.x;
  tmpvar_47.z = tmpvar_40.x;
  tmpvar_10 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.x = worldTangent_6.y;
  tmpvar_48.y = worldBinormal_5.y;
  tmpvar_48.z = tmpvar_40.y;
  tmpvar_11 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.x = worldTangent_6.z;
  tmpvar_49.y = worldBinormal_5.z;
  tmpvar_49.z = tmpvar_40.z;
  tmpvar_12 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize(_glesNormal);
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_52 = _glesTANGENT.xyz;
  tmpvar_53 = (((tmpvar_50.yzx * tmpvar_51.zxy) - (tmpvar_50.zxy * tmpvar_51.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_54;
  tmpvar_54[0].x = tmpvar_52.x;
  tmpvar_54[0].y = tmpvar_53.x;
  tmpvar_54[0].z = tmpvar_1.x;
  tmpvar_54[1].x = tmpvar_52.y;
  tmpvar_54[1].y = tmpvar_53.y;
  tmpvar_54[1].z = tmpvar_1.y;
  tmpvar_54[2].x = tmpvar_52.z;
  tmpvar_54[2].y = tmpvar_53.z;
  tmpvar_54[2].z = tmpvar_1.z;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 1.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  tmpvar_13 = normalize((tmpvar_54 * (tmpvar_2.xyz - 
    (unity_WorldToObject * tmpvar_55)
  .xyz)));
  tmpvar_14 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_56;
  fogTune_56 = _FogTune;
  mediump vec4 tmpvar_57;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_58;
    highp vec3 tmpvar_59;
    tmpvar_59 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_60;
    tmpvar_60 = max (0.0, (sqrt(
      dot (tmpvar_59, tmpvar_59)
    ) - _FogStartDistance));
    highp float tmpvar_61;
    tmpvar_61 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_60))
       * 
        (_FogIntensity * tmpvar_60)
      ) * fogTune_56)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_62;
    tmpvar_62 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_60)) * (_FogColorIntensity * tmpvar_60))
    ), 0.0, 1.0)));
    fogColor_58.xyz = tmpvar_62;
    fogColor_58.w = tmpvar_61;
    tmpvar_57 = fogColor_58;
  } else {
    mediump vec4 fogColor_63;
    highp vec3 tmpvar_64;
    tmpvar_64 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_65;
    tmpvar_65 = max (0.0, (sqrt(
      dot (tmpvar_64, tmpvar_64)
    ) - _FogStartDistance));
    highp float tmpvar_66;
    tmpvar_66 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_67;
    tmpvar_67 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_63.xyz = tmpvar_67;
    fogColor_63.w = tmpvar_66;
    tmpvar_57 = fogColor_63;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_COLOR1 = tmpvar_57;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = tmpvar_16;
  xlv_TEXCOORD9 = tmpvar_17;
  xlv_TEXCOORD10 = tmpvar_3;
  xlv_TEXCOORD11 = tmpvar_4;
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
uniform sampler2D _DisplacementMap;
uniform mediump float _MaxHeight;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord2;
  tmpvar_4 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_5;
  mediump vec3 worldTangent_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec2 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2DLod (_DisplacementMap, _glesMultiTexCoord1.xy, 0.0);
  highp float tmpvar_19;
  tmpvar_19 = tmpvar_18.x;
  highp float s12_20;
  highp float s10_21;
  highp float s21_22;
  highp float s01_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = (_glesMultiTexCoord1.xy + vec2(0.01, 0.0));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DLod (_DisplacementMap, tmpvar_24.xy, 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = (tmpvar_25.x * _MaxHeight);
  s01_23 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (_glesMultiTexCoord1.xy - vec2(0.01, 0.0));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_DisplacementMap, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = (tmpvar_28.x * _MaxHeight);
  s21_22 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = (_glesMultiTexCoord1.xy + vec2(0.0, 0.01));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_DisplacementMap, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = (tmpvar_31.x * _MaxHeight);
  s10_21 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 0.0);
  tmpvar_33.xy = (_glesMultiTexCoord1.xy - vec2(0.0, 0.01));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_DisplacementMap, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = (tmpvar_34.x * _MaxHeight);
  s12_20 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(-0.01, 0.0);
  tmpvar_36.z = (s21_22 - s01_23);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -0.01);
  tmpvar_38.z = (s12_20 - s10_21);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((tmpvar_37.yzx * tmpvar_39.zxy) - (tmpvar_37.zxy * tmpvar_39.yzx)));
  highp vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_1;
  tmpvar_2 = (_glesVertex + ((tmpvar_41 * tmpvar_19) * _MaxHeight));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_2.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_43;
  tmpvar_43[0] = unity_WorldToObject[0].xyz;
  tmpvar_43[1] = unity_WorldToObject[1].xyz;
  tmpvar_43[2] = unity_WorldToObject[2].xyz;
  tmpvar_16 = (_glesNormal * tmpvar_43);
  tmpvar_15 = (_WorldSpaceLightPos0.xyz - ((unity_ObjectToWorld * tmpvar_2).xyz * _WorldSpaceLightPos0.w));
  tmpvar_17 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * tmpvar_2).xyz);
  highp mat3 tmpvar_44;
  tmpvar_44[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_44[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_44[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize((tmpvar_44 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((tmpvar_40.yzx * worldTangent_6.zxy) - (tmpvar_40.zxy * worldTangent_6.yzx)) * _glesTANGENT.w);
  worldBinormal_5 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47.x = worldTangent_6.x;
  tmpvar_47.y = worldBinormal_5.x;
  tmpvar_47.z = tmpvar_40.x;
  tmpvar_10 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.x = worldTangent_6.y;
  tmpvar_48.y = worldBinormal_5.y;
  tmpvar_48.z = tmpvar_40.y;
  tmpvar_11 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.x = worldTangent_6.z;
  tmpvar_49.y = worldBinormal_5.z;
  tmpvar_49.z = tmpvar_40.z;
  tmpvar_12 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize(_glesNormal);
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_52 = _glesTANGENT.xyz;
  tmpvar_53 = (((tmpvar_50.yzx * tmpvar_51.zxy) - (tmpvar_50.zxy * tmpvar_51.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_54;
  tmpvar_54[0].x = tmpvar_52.x;
  tmpvar_54[0].y = tmpvar_53.x;
  tmpvar_54[0].z = tmpvar_1.x;
  tmpvar_54[1].x = tmpvar_52.y;
  tmpvar_54[1].y = tmpvar_53.y;
  tmpvar_54[1].z = tmpvar_1.y;
  tmpvar_54[2].x = tmpvar_52.z;
  tmpvar_54[2].y = tmpvar_53.z;
  tmpvar_54[2].z = tmpvar_1.z;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 1.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  tmpvar_13 = normalize((tmpvar_54 * (tmpvar_2.xyz - 
    (unity_WorldToObject * tmpvar_55)
  .xyz)));
  tmpvar_14 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_56;
  fogTune_56 = _FogTune;
  mediump vec4 tmpvar_57;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_58;
    highp vec3 tmpvar_59;
    tmpvar_59 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_60;
    tmpvar_60 = max (0.0, (sqrt(
      dot (tmpvar_59, tmpvar_59)
    ) - _FogStartDistance));
    highp float tmpvar_61;
    tmpvar_61 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_60))
       * 
        (_FogIntensity * tmpvar_60)
      ) * fogTune_56)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_62;
    tmpvar_62 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_60)) * (_FogColorIntensity * tmpvar_60))
    ), 0.0, 1.0)));
    fogColor_58.xyz = tmpvar_62;
    fogColor_58.w = tmpvar_61;
    tmpvar_57 = fogColor_58;
  } else {
    mediump vec4 fogColor_63;
    highp vec3 tmpvar_64;
    tmpvar_64 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_65;
    tmpvar_65 = max (0.0, (sqrt(
      dot (tmpvar_64, tmpvar_64)
    ) - _FogStartDistance));
    highp float tmpvar_66;
    tmpvar_66 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_67;
    tmpvar_67 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_63.xyz = tmpvar_67;
    fogColor_63.w = tmpvar_66;
    tmpvar_57 = fogColor_63;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_COLOR1 = tmpvar_57;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = tmpvar_16;
  xlv_TEXCOORD9 = tmpvar_17;
  xlv_TEXCOORD10 = tmpvar_3;
  xlv_TEXCOORD11 = tmpvar_4;
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
uniform sampler2D _DisplacementMap;
uniform mediump float _MaxHeight;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord2;
  tmpvar_4 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_5;
  mediump vec3 worldTangent_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec2 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2DLod (_DisplacementMap, _glesMultiTexCoord1.xy, 0.0);
  highp float tmpvar_19;
  tmpvar_19 = tmpvar_18.x;
  highp float s12_20;
  highp float s10_21;
  highp float s21_22;
  highp float s01_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = (_glesMultiTexCoord1.xy + vec2(0.01, 0.0));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DLod (_DisplacementMap, tmpvar_24.xy, 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = (tmpvar_25.x * _MaxHeight);
  s01_23 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (_glesMultiTexCoord1.xy - vec2(0.01, 0.0));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_DisplacementMap, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = (tmpvar_28.x * _MaxHeight);
  s21_22 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = (_glesMultiTexCoord1.xy + vec2(0.0, 0.01));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_DisplacementMap, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = (tmpvar_31.x * _MaxHeight);
  s10_21 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 0.0);
  tmpvar_33.xy = (_glesMultiTexCoord1.xy - vec2(0.0, 0.01));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_DisplacementMap, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = (tmpvar_34.x * _MaxHeight);
  s12_20 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(-0.01, 0.0);
  tmpvar_36.z = (s21_22 - s01_23);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -0.01);
  tmpvar_38.z = (s12_20 - s10_21);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((tmpvar_37.yzx * tmpvar_39.zxy) - (tmpvar_37.zxy * tmpvar_39.yzx)));
  highp vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_1;
  tmpvar_2 = (_glesVertex + ((tmpvar_41 * tmpvar_19) * _MaxHeight));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_2.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_43;
  tmpvar_43[0] = unity_WorldToObject[0].xyz;
  tmpvar_43[1] = unity_WorldToObject[1].xyz;
  tmpvar_43[2] = unity_WorldToObject[2].xyz;
  tmpvar_16 = (_glesNormal * tmpvar_43);
  tmpvar_15 = (_WorldSpaceLightPos0.xyz - ((unity_ObjectToWorld * tmpvar_2).xyz * _WorldSpaceLightPos0.w));
  tmpvar_17 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * tmpvar_2).xyz);
  highp mat3 tmpvar_44;
  tmpvar_44[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_44[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_44[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize((tmpvar_44 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((tmpvar_40.yzx * worldTangent_6.zxy) - (tmpvar_40.zxy * worldTangent_6.yzx)) * _glesTANGENT.w);
  worldBinormal_5 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47.x = worldTangent_6.x;
  tmpvar_47.y = worldBinormal_5.x;
  tmpvar_47.z = tmpvar_40.x;
  tmpvar_10 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.x = worldTangent_6.y;
  tmpvar_48.y = worldBinormal_5.y;
  tmpvar_48.z = tmpvar_40.y;
  tmpvar_11 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.x = worldTangent_6.z;
  tmpvar_49.y = worldBinormal_5.z;
  tmpvar_49.z = tmpvar_40.z;
  tmpvar_12 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize(_glesNormal);
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_52 = _glesTANGENT.xyz;
  tmpvar_53 = (((tmpvar_50.yzx * tmpvar_51.zxy) - (tmpvar_50.zxy * tmpvar_51.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_54;
  tmpvar_54[0].x = tmpvar_52.x;
  tmpvar_54[0].y = tmpvar_53.x;
  tmpvar_54[0].z = tmpvar_1.x;
  tmpvar_54[1].x = tmpvar_52.y;
  tmpvar_54[1].y = tmpvar_53.y;
  tmpvar_54[1].z = tmpvar_1.y;
  tmpvar_54[2].x = tmpvar_52.z;
  tmpvar_54[2].y = tmpvar_53.z;
  tmpvar_54[2].z = tmpvar_1.z;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 1.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  tmpvar_13 = normalize((tmpvar_54 * (tmpvar_2.xyz - 
    (unity_WorldToObject * tmpvar_55)
  .xyz)));
  tmpvar_14 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_56;
  fogTune_56 = _FogTune;
  mediump vec4 tmpvar_57;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_58;
    highp vec3 tmpvar_59;
    tmpvar_59 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_60;
    tmpvar_60 = max (0.0, (sqrt(
      dot (tmpvar_59, tmpvar_59)
    ) - _FogStartDistance));
    highp float tmpvar_61;
    tmpvar_61 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_60))
       * 
        (_FogIntensity * tmpvar_60)
      ) * fogTune_56)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_62;
    tmpvar_62 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_60)) * (_FogColorIntensity * tmpvar_60))
    ), 0.0, 1.0)));
    fogColor_58.xyz = tmpvar_62;
    fogColor_58.w = tmpvar_61;
    tmpvar_57 = fogColor_58;
  } else {
    mediump vec4 fogColor_63;
    highp vec3 tmpvar_64;
    tmpvar_64 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_65;
    tmpvar_65 = max (0.0, (sqrt(
      dot (tmpvar_64, tmpvar_64)
    ) - _FogStartDistance));
    highp float tmpvar_66;
    tmpvar_66 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_67;
    tmpvar_67 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_63.xyz = tmpvar_67;
    fogColor_63.w = tmpvar_66;
    tmpvar_57 = fogColor_63;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_COLOR1 = tmpvar_57;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = tmpvar_16;
  xlv_TEXCOORD9 = tmpvar_17;
  xlv_TEXCOORD10 = tmpvar_3;
  xlv_TEXCOORD11 = tmpvar_4;
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
uniform sampler2D _DisplacementMap;
uniform mediump float _MaxHeight;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord2;
  tmpvar_4 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_5;
  mediump vec3 worldTangent_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec2 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2DLod (_DisplacementMap, _glesMultiTexCoord1.xy, 0.0);
  highp float tmpvar_19;
  tmpvar_19 = tmpvar_18.x;
  highp float s12_20;
  highp float s10_21;
  highp float s21_22;
  highp float s01_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = (_glesMultiTexCoord1.xy + vec2(0.01, 0.0));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DLod (_DisplacementMap, tmpvar_24.xy, 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = (tmpvar_25.x * _MaxHeight);
  s01_23 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (_glesMultiTexCoord1.xy - vec2(0.01, 0.0));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_DisplacementMap, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = (tmpvar_28.x * _MaxHeight);
  s21_22 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = (_glesMultiTexCoord1.xy + vec2(0.0, 0.01));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_DisplacementMap, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = (tmpvar_31.x * _MaxHeight);
  s10_21 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 0.0);
  tmpvar_33.xy = (_glesMultiTexCoord1.xy - vec2(0.0, 0.01));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_DisplacementMap, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = (tmpvar_34.x * _MaxHeight);
  s12_20 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(-0.01, 0.0);
  tmpvar_36.z = (s21_22 - s01_23);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -0.01);
  tmpvar_38.z = (s12_20 - s10_21);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((tmpvar_37.yzx * tmpvar_39.zxy) - (tmpvar_37.zxy * tmpvar_39.yzx)));
  highp vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_1;
  tmpvar_2 = (_glesVertex + ((tmpvar_41 * tmpvar_19) * _MaxHeight));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_2.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_43;
  tmpvar_43[0] = unity_WorldToObject[0].xyz;
  tmpvar_43[1] = unity_WorldToObject[1].xyz;
  tmpvar_43[2] = unity_WorldToObject[2].xyz;
  tmpvar_16 = (_glesNormal * tmpvar_43);
  tmpvar_15 = (_WorldSpaceLightPos0.xyz - ((unity_ObjectToWorld * tmpvar_2).xyz * _WorldSpaceLightPos0.w));
  tmpvar_17 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * tmpvar_2).xyz);
  highp mat3 tmpvar_44;
  tmpvar_44[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_44[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_44[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize((tmpvar_44 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((tmpvar_40.yzx * worldTangent_6.zxy) - (tmpvar_40.zxy * worldTangent_6.yzx)) * _glesTANGENT.w);
  worldBinormal_5 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47.x = worldTangent_6.x;
  tmpvar_47.y = worldBinormal_5.x;
  tmpvar_47.z = tmpvar_40.x;
  tmpvar_10 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.x = worldTangent_6.y;
  tmpvar_48.y = worldBinormal_5.y;
  tmpvar_48.z = tmpvar_40.y;
  tmpvar_11 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.x = worldTangent_6.z;
  tmpvar_49.y = worldBinormal_5.z;
  tmpvar_49.z = tmpvar_40.z;
  tmpvar_12 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize(_glesNormal);
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_52 = _glesTANGENT.xyz;
  tmpvar_53 = (((tmpvar_50.yzx * tmpvar_51.zxy) - (tmpvar_50.zxy * tmpvar_51.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_54;
  tmpvar_54[0].x = tmpvar_52.x;
  tmpvar_54[0].y = tmpvar_53.x;
  tmpvar_54[0].z = tmpvar_1.x;
  tmpvar_54[1].x = tmpvar_52.y;
  tmpvar_54[1].y = tmpvar_53.y;
  tmpvar_54[1].z = tmpvar_1.y;
  tmpvar_54[2].x = tmpvar_52.z;
  tmpvar_54[2].y = tmpvar_53.z;
  tmpvar_54[2].z = tmpvar_1.z;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 1.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  tmpvar_13 = normalize((tmpvar_54 * (tmpvar_2.xyz - 
    (unity_WorldToObject * tmpvar_55)
  .xyz)));
  tmpvar_14 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_56;
  fogTune_56 = _FogTune;
  mediump vec4 tmpvar_57;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_58;
    highp vec3 tmpvar_59;
    tmpvar_59 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_60;
    tmpvar_60 = max (0.0, (sqrt(
      dot (tmpvar_59, tmpvar_59)
    ) - _FogStartDistance));
    highp float tmpvar_61;
    tmpvar_61 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_60))
       * 
        (_FogIntensity * tmpvar_60)
      ) * fogTune_56)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_62;
    tmpvar_62 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_60)) * (_FogColorIntensity * tmpvar_60))
    ), 0.0, 1.0)));
    fogColor_58.xyz = tmpvar_62;
    fogColor_58.w = tmpvar_61;
    tmpvar_57 = fogColor_58;
  } else {
    mediump vec4 fogColor_63;
    highp vec3 tmpvar_64;
    tmpvar_64 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_65;
    tmpvar_65 = max (0.0, (sqrt(
      dot (tmpvar_64, tmpvar_64)
    ) - _FogStartDistance));
    highp float tmpvar_66;
    tmpvar_66 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_67;
    tmpvar_67 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_63.xyz = tmpvar_67;
    fogColor_63.w = tmpvar_66;
    tmpvar_57 = fogColor_63;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_COLOR1 = tmpvar_57;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = tmpvar_16;
  xlv_TEXCOORD9 = tmpvar_17;
  xlv_TEXCOORD10 = tmpvar_3;
  xlv_TEXCOORD11 = tmpvar_4;
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
uniform sampler2D _DisplacementMap;
uniform mediump float _MaxHeight;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord2;
  tmpvar_4 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_5;
  mediump vec3 worldTangent_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec2 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2DLod (_DisplacementMap, _glesMultiTexCoord1.xy, 0.0);
  highp float tmpvar_19;
  tmpvar_19 = tmpvar_18.x;
  highp float s12_20;
  highp float s10_21;
  highp float s21_22;
  highp float s01_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = (_glesMultiTexCoord1.xy + vec2(0.01, 0.0));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DLod (_DisplacementMap, tmpvar_24.xy, 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = (tmpvar_25.x * _MaxHeight);
  s01_23 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (_glesMultiTexCoord1.xy - vec2(0.01, 0.0));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_DisplacementMap, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = (tmpvar_28.x * _MaxHeight);
  s21_22 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = (_glesMultiTexCoord1.xy + vec2(0.0, 0.01));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_DisplacementMap, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = (tmpvar_31.x * _MaxHeight);
  s10_21 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 0.0);
  tmpvar_33.xy = (_glesMultiTexCoord1.xy - vec2(0.0, 0.01));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_DisplacementMap, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = (tmpvar_34.x * _MaxHeight);
  s12_20 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(-0.01, 0.0);
  tmpvar_36.z = (s21_22 - s01_23);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -0.01);
  tmpvar_38.z = (s12_20 - s10_21);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((tmpvar_37.yzx * tmpvar_39.zxy) - (tmpvar_37.zxy * tmpvar_39.yzx)));
  highp vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_1;
  tmpvar_2 = (_glesVertex + ((tmpvar_41 * tmpvar_19) * _MaxHeight));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_2.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_43;
  tmpvar_43[0] = unity_WorldToObject[0].xyz;
  tmpvar_43[1] = unity_WorldToObject[1].xyz;
  tmpvar_43[2] = unity_WorldToObject[2].xyz;
  tmpvar_16 = (_glesNormal * tmpvar_43);
  tmpvar_15 = (_WorldSpaceLightPos0.xyz - ((unity_ObjectToWorld * tmpvar_2).xyz * _WorldSpaceLightPos0.w));
  tmpvar_17 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * tmpvar_2).xyz);
  highp mat3 tmpvar_44;
  tmpvar_44[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_44[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_44[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize((tmpvar_44 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((tmpvar_40.yzx * worldTangent_6.zxy) - (tmpvar_40.zxy * worldTangent_6.yzx)) * _glesTANGENT.w);
  worldBinormal_5 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47.x = worldTangent_6.x;
  tmpvar_47.y = worldBinormal_5.x;
  tmpvar_47.z = tmpvar_40.x;
  tmpvar_10 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.x = worldTangent_6.y;
  tmpvar_48.y = worldBinormal_5.y;
  tmpvar_48.z = tmpvar_40.y;
  tmpvar_11 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.x = worldTangent_6.z;
  tmpvar_49.y = worldBinormal_5.z;
  tmpvar_49.z = tmpvar_40.z;
  tmpvar_12 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize(_glesNormal);
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_52 = _glesTANGENT.xyz;
  tmpvar_53 = (((tmpvar_50.yzx * tmpvar_51.zxy) - (tmpvar_50.zxy * tmpvar_51.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_54;
  tmpvar_54[0].x = tmpvar_52.x;
  tmpvar_54[0].y = tmpvar_53.x;
  tmpvar_54[0].z = tmpvar_1.x;
  tmpvar_54[1].x = tmpvar_52.y;
  tmpvar_54[1].y = tmpvar_53.y;
  tmpvar_54[1].z = tmpvar_1.y;
  tmpvar_54[2].x = tmpvar_52.z;
  tmpvar_54[2].y = tmpvar_53.z;
  tmpvar_54[2].z = tmpvar_1.z;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 1.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  tmpvar_13 = normalize((tmpvar_54 * (tmpvar_2.xyz - 
    (unity_WorldToObject * tmpvar_55)
  .xyz)));
  tmpvar_14 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_56;
  fogTune_56 = _FogTune;
  mediump vec4 tmpvar_57;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_58;
    highp vec3 tmpvar_59;
    tmpvar_59 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_60;
    tmpvar_60 = max (0.0, (sqrt(
      dot (tmpvar_59, tmpvar_59)
    ) - _FogStartDistance));
    highp float tmpvar_61;
    tmpvar_61 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_60))
       * 
        (_FogIntensity * tmpvar_60)
      ) * fogTune_56)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_62;
    tmpvar_62 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_60)) * (_FogColorIntensity * tmpvar_60))
    ), 0.0, 1.0)));
    fogColor_58.xyz = tmpvar_62;
    fogColor_58.w = tmpvar_61;
    tmpvar_57 = fogColor_58;
  } else {
    mediump vec4 fogColor_63;
    highp vec3 tmpvar_64;
    tmpvar_64 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_65;
    tmpvar_65 = max (0.0, (sqrt(
      dot (tmpvar_64, tmpvar_64)
    ) - _FogStartDistance));
    highp float tmpvar_66;
    tmpvar_66 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_67;
    tmpvar_67 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_63.xyz = tmpvar_67;
    fogColor_63.w = tmpvar_66;
    tmpvar_57 = fogColor_63;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_COLOR1 = tmpvar_57;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = tmpvar_16;
  xlv_TEXCOORD9 = tmpvar_17;
  xlv_TEXCOORD10 = tmpvar_3;
  xlv_TEXCOORD11 = tmpvar_4;
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
uniform sampler2D _DisplacementMap;
uniform mediump float _MaxHeight;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord2;
  tmpvar_4 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_5;
  mediump vec3 worldTangent_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec2 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2DLod (_DisplacementMap, _glesMultiTexCoord1.xy, 0.0);
  highp float tmpvar_19;
  tmpvar_19 = tmpvar_18.x;
  highp float s12_20;
  highp float s10_21;
  highp float s21_22;
  highp float s01_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = (_glesMultiTexCoord1.xy + vec2(0.01, 0.0));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DLod (_DisplacementMap, tmpvar_24.xy, 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = (tmpvar_25.x * _MaxHeight);
  s01_23 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (_glesMultiTexCoord1.xy - vec2(0.01, 0.0));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_DisplacementMap, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = (tmpvar_28.x * _MaxHeight);
  s21_22 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = (_glesMultiTexCoord1.xy + vec2(0.0, 0.01));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_DisplacementMap, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = (tmpvar_31.x * _MaxHeight);
  s10_21 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 0.0);
  tmpvar_33.xy = (_glesMultiTexCoord1.xy - vec2(0.0, 0.01));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_DisplacementMap, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = (tmpvar_34.x * _MaxHeight);
  s12_20 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(-0.01, 0.0);
  tmpvar_36.z = (s21_22 - s01_23);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -0.01);
  tmpvar_38.z = (s12_20 - s10_21);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((tmpvar_37.yzx * tmpvar_39.zxy) - (tmpvar_37.zxy * tmpvar_39.yzx)));
  highp vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_1;
  tmpvar_2 = (_glesVertex + ((tmpvar_41 * tmpvar_19) * _MaxHeight));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_2.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_43;
  tmpvar_43[0] = unity_WorldToObject[0].xyz;
  tmpvar_43[1] = unity_WorldToObject[1].xyz;
  tmpvar_43[2] = unity_WorldToObject[2].xyz;
  tmpvar_16 = (_glesNormal * tmpvar_43);
  tmpvar_15 = (_WorldSpaceLightPos0.xyz - ((unity_ObjectToWorld * tmpvar_2).xyz * _WorldSpaceLightPos0.w));
  tmpvar_17 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * tmpvar_2).xyz);
  highp mat3 tmpvar_44;
  tmpvar_44[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_44[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_44[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize((tmpvar_44 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((tmpvar_40.yzx * worldTangent_6.zxy) - (tmpvar_40.zxy * worldTangent_6.yzx)) * _glesTANGENT.w);
  worldBinormal_5 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47.x = worldTangent_6.x;
  tmpvar_47.y = worldBinormal_5.x;
  tmpvar_47.z = tmpvar_40.x;
  tmpvar_10 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.x = worldTangent_6.y;
  tmpvar_48.y = worldBinormal_5.y;
  tmpvar_48.z = tmpvar_40.y;
  tmpvar_11 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.x = worldTangent_6.z;
  tmpvar_49.y = worldBinormal_5.z;
  tmpvar_49.z = tmpvar_40.z;
  tmpvar_12 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize(_glesNormal);
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_52 = _glesTANGENT.xyz;
  tmpvar_53 = (((tmpvar_50.yzx * tmpvar_51.zxy) - (tmpvar_50.zxy * tmpvar_51.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_54;
  tmpvar_54[0].x = tmpvar_52.x;
  tmpvar_54[0].y = tmpvar_53.x;
  tmpvar_54[0].z = tmpvar_1.x;
  tmpvar_54[1].x = tmpvar_52.y;
  tmpvar_54[1].y = tmpvar_53.y;
  tmpvar_54[1].z = tmpvar_1.y;
  tmpvar_54[2].x = tmpvar_52.z;
  tmpvar_54[2].y = tmpvar_53.z;
  tmpvar_54[2].z = tmpvar_1.z;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 1.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  tmpvar_13 = normalize((tmpvar_54 * (tmpvar_2.xyz - 
    (unity_WorldToObject * tmpvar_55)
  .xyz)));
  tmpvar_14 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_56;
  fogTune_56 = _FogTune;
  mediump vec4 tmpvar_57;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_58;
    highp vec3 tmpvar_59;
    tmpvar_59 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_60;
    tmpvar_60 = max (0.0, (sqrt(
      dot (tmpvar_59, tmpvar_59)
    ) - _FogStartDistance));
    highp float tmpvar_61;
    tmpvar_61 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_60))
       * 
        (_FogIntensity * tmpvar_60)
      ) * fogTune_56)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_62;
    tmpvar_62 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_60)) * (_FogColorIntensity * tmpvar_60))
    ), 0.0, 1.0)));
    fogColor_58.xyz = tmpvar_62;
    fogColor_58.w = tmpvar_61;
    tmpvar_57 = fogColor_58;
  } else {
    mediump vec4 fogColor_63;
    highp vec3 tmpvar_64;
    tmpvar_64 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_65;
    tmpvar_65 = max (0.0, (sqrt(
      dot (tmpvar_64, tmpvar_64)
    ) - _FogStartDistance));
    highp float tmpvar_66;
    tmpvar_66 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_67;
    tmpvar_67 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_63.xyz = tmpvar_67;
    fogColor_63.w = tmpvar_66;
    tmpvar_57 = fogColor_63;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_COLOR1 = tmpvar_57;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = tmpvar_16;
  xlv_TEXCOORD9 = tmpvar_17;
  xlv_TEXCOORD10 = tmpvar_3;
  xlv_TEXCOORD11 = tmpvar_4;
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
uniform sampler2D _DisplacementMap;
uniform mediump float _MaxHeight;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord2;
  tmpvar_4 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_5;
  mediump vec3 worldTangent_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec2 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2DLod (_DisplacementMap, _glesMultiTexCoord1.xy, 0.0);
  highp float tmpvar_19;
  tmpvar_19 = tmpvar_18.x;
  highp float s12_20;
  highp float s10_21;
  highp float s21_22;
  highp float s01_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = (_glesMultiTexCoord1.xy + vec2(0.01, 0.0));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DLod (_DisplacementMap, tmpvar_24.xy, 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = (tmpvar_25.x * _MaxHeight);
  s01_23 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (_glesMultiTexCoord1.xy - vec2(0.01, 0.0));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_DisplacementMap, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = (tmpvar_28.x * _MaxHeight);
  s21_22 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = (_glesMultiTexCoord1.xy + vec2(0.0, 0.01));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_DisplacementMap, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = (tmpvar_31.x * _MaxHeight);
  s10_21 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 0.0);
  tmpvar_33.xy = (_glesMultiTexCoord1.xy - vec2(0.0, 0.01));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_DisplacementMap, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = (tmpvar_34.x * _MaxHeight);
  s12_20 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(-0.01, 0.0);
  tmpvar_36.z = (s21_22 - s01_23);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -0.01);
  tmpvar_38.z = (s12_20 - s10_21);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((tmpvar_37.yzx * tmpvar_39.zxy) - (tmpvar_37.zxy * tmpvar_39.yzx)));
  highp vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_1;
  tmpvar_2 = (_glesVertex + ((tmpvar_41 * tmpvar_19) * _MaxHeight));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_2.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_43;
  tmpvar_43[0] = unity_WorldToObject[0].xyz;
  tmpvar_43[1] = unity_WorldToObject[1].xyz;
  tmpvar_43[2] = unity_WorldToObject[2].xyz;
  tmpvar_16 = (_glesNormal * tmpvar_43);
  tmpvar_15 = (_WorldSpaceLightPos0.xyz - ((unity_ObjectToWorld * tmpvar_2).xyz * _WorldSpaceLightPos0.w));
  tmpvar_17 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * tmpvar_2).xyz);
  highp mat3 tmpvar_44;
  tmpvar_44[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_44[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_44[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize((tmpvar_44 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((tmpvar_40.yzx * worldTangent_6.zxy) - (tmpvar_40.zxy * worldTangent_6.yzx)) * _glesTANGENT.w);
  worldBinormal_5 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47.x = worldTangent_6.x;
  tmpvar_47.y = worldBinormal_5.x;
  tmpvar_47.z = tmpvar_40.x;
  tmpvar_10 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.x = worldTangent_6.y;
  tmpvar_48.y = worldBinormal_5.y;
  tmpvar_48.z = tmpvar_40.y;
  tmpvar_11 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.x = worldTangent_6.z;
  tmpvar_49.y = worldBinormal_5.z;
  tmpvar_49.z = tmpvar_40.z;
  tmpvar_12 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize(_glesNormal);
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_52 = _glesTANGENT.xyz;
  tmpvar_53 = (((tmpvar_50.yzx * tmpvar_51.zxy) - (tmpvar_50.zxy * tmpvar_51.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_54;
  tmpvar_54[0].x = tmpvar_52.x;
  tmpvar_54[0].y = tmpvar_53.x;
  tmpvar_54[0].z = tmpvar_1.x;
  tmpvar_54[1].x = tmpvar_52.y;
  tmpvar_54[1].y = tmpvar_53.y;
  tmpvar_54[1].z = tmpvar_1.y;
  tmpvar_54[2].x = tmpvar_52.z;
  tmpvar_54[2].y = tmpvar_53.z;
  tmpvar_54[2].z = tmpvar_1.z;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 1.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  tmpvar_13 = normalize((tmpvar_54 * (tmpvar_2.xyz - 
    (unity_WorldToObject * tmpvar_55)
  .xyz)));
  tmpvar_14 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_56;
  fogTune_56 = _FogTune;
  mediump vec4 tmpvar_57;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_58;
    highp vec3 tmpvar_59;
    tmpvar_59 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_60;
    tmpvar_60 = max (0.0, (sqrt(
      dot (tmpvar_59, tmpvar_59)
    ) - _FogStartDistance));
    highp float tmpvar_61;
    tmpvar_61 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_60))
       * 
        (_FogIntensity * tmpvar_60)
      ) * fogTune_56)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_62;
    tmpvar_62 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_60)) * (_FogColorIntensity * tmpvar_60))
    ), 0.0, 1.0)));
    fogColor_58.xyz = tmpvar_62;
    fogColor_58.w = tmpvar_61;
    tmpvar_57 = fogColor_58;
  } else {
    mediump vec4 fogColor_63;
    highp vec3 tmpvar_64;
    tmpvar_64 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_65;
    tmpvar_65 = max (0.0, (sqrt(
      dot (tmpvar_64, tmpvar_64)
    ) - _FogStartDistance));
    highp float tmpvar_66;
    tmpvar_66 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_67;
    tmpvar_67 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_63.xyz = tmpvar_67;
    fogColor_63.w = tmpvar_66;
    tmpvar_57 = fogColor_63;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_COLOR1 = tmpvar_57;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = tmpvar_16;
  xlv_TEXCOORD9 = tmpvar_17;
  xlv_TEXCOORD10 = tmpvar_3;
  xlv_TEXCOORD11 = tmpvar_4;
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
uniform sampler2D _DisplacementMap;
uniform mediump float _MaxHeight;
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
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3 = _glesMultiTexCoord2;
  tmpvar_4 = _glesMultiTexCoord3;
  mediump vec3 worldBinormal_5;
  mediump vec3 worldTangent_6;
  highp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  mediump vec2 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2DLod (_DisplacementMap, _glesMultiTexCoord1.xy, 0.0);
  highp float tmpvar_19;
  tmpvar_19 = tmpvar_18.x;
  highp float s12_20;
  highp float s10_21;
  highp float s21_22;
  highp float s01_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = (_glesMultiTexCoord1.xy + vec2(0.01, 0.0));
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DLod (_DisplacementMap, tmpvar_24.xy, 0.0);
  mediump float tmpvar_26;
  tmpvar_26 = (tmpvar_25.x * _MaxHeight);
  s01_23 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (_glesMultiTexCoord1.xy - vec2(0.01, 0.0));
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DLod (_DisplacementMap, tmpvar_27.xy, 0.0);
  mediump float tmpvar_29;
  tmpvar_29 = (tmpvar_28.x * _MaxHeight);
  s21_22 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = (_glesMultiTexCoord1.xy + vec2(0.0, 0.01));
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DLod (_DisplacementMap, tmpvar_30.xy, 0.0);
  mediump float tmpvar_32;
  tmpvar_32 = (tmpvar_31.x * _MaxHeight);
  s10_21 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 0.0);
  tmpvar_33.xy = (_glesMultiTexCoord1.xy - vec2(0.0, 0.01));
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DLod (_DisplacementMap, tmpvar_33.xy, 0.0);
  mediump float tmpvar_35;
  tmpvar_35 = (tmpvar_34.x * _MaxHeight);
  s12_20 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(-0.01, 0.0);
  tmpvar_36.z = (s21_22 - s01_23);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -0.01);
  tmpvar_38.z = (s12_20 - s10_21);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((tmpvar_37.yzx * tmpvar_39.zxy) - (tmpvar_37.zxy * tmpvar_39.yzx)));
  highp vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_1;
  tmpvar_2 = (_glesVertex + ((tmpvar_41 * tmpvar_19) * _MaxHeight));
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = tmpvar_2.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_42));
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_43;
  tmpvar_43[0] = unity_WorldToObject[0].xyz;
  tmpvar_43[1] = unity_WorldToObject[1].xyz;
  tmpvar_43[2] = unity_WorldToObject[2].xyz;
  tmpvar_16 = (_glesNormal * tmpvar_43);
  tmpvar_15 = (_WorldSpaceLightPos0.xyz - ((unity_ObjectToWorld * tmpvar_2).xyz * _WorldSpaceLightPos0.w));
  tmpvar_17 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * tmpvar_2).xyz);
  highp mat3 tmpvar_44;
  tmpvar_44[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_44[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_44[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize((tmpvar_44 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((tmpvar_40.yzx * worldTangent_6.zxy) - (tmpvar_40.zxy * worldTangent_6.yzx)) * _glesTANGENT.w);
  worldBinormal_5 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47.x = worldTangent_6.x;
  tmpvar_47.y = worldBinormal_5.x;
  tmpvar_47.z = tmpvar_40.x;
  tmpvar_10 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.x = worldTangent_6.y;
  tmpvar_48.y = worldBinormal_5.y;
  tmpvar_48.z = tmpvar_40.y;
  tmpvar_11 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.x = worldTangent_6.z;
  tmpvar_49.y = worldBinormal_5.z;
  tmpvar_49.z = tmpvar_40.z;
  tmpvar_12 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize(_glesNormal);
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_52 = _glesTANGENT.xyz;
  tmpvar_53 = (((tmpvar_50.yzx * tmpvar_51.zxy) - (tmpvar_50.zxy * tmpvar_51.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_54;
  tmpvar_54[0].x = tmpvar_52.x;
  tmpvar_54[0].y = tmpvar_53.x;
  tmpvar_54[0].z = tmpvar_1.x;
  tmpvar_54[1].x = tmpvar_52.y;
  tmpvar_54[1].y = tmpvar_53.y;
  tmpvar_54[1].z = tmpvar_1.y;
  tmpvar_54[2].x = tmpvar_52.z;
  tmpvar_54[2].y = tmpvar_53.z;
  tmpvar_54[2].z = tmpvar_1.z;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 1.0;
  tmpvar_55.xyz = _WorldSpaceCameraPos;
  tmpvar_13 = normalize((tmpvar_54 * (tmpvar_2.xyz - 
    (unity_WorldToObject * tmpvar_55)
  .xyz)));
  tmpvar_14 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_56;
  fogTune_56 = _FogTune;
  mediump vec4 tmpvar_57;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_58;
    highp vec3 tmpvar_59;
    tmpvar_59 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_60;
    tmpvar_60 = max (0.0, (sqrt(
      dot (tmpvar_59, tmpvar_59)
    ) - _FogStartDistance));
    highp float tmpvar_61;
    tmpvar_61 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_60))
       * 
        (_FogIntensity * tmpvar_60)
      ) * fogTune_56)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_62;
    tmpvar_62 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_60)) * (_FogColorIntensity * tmpvar_60))
    ), 0.0, 1.0)));
    fogColor_58.xyz = tmpvar_62;
    fogColor_58.w = tmpvar_61;
    tmpvar_57 = fogColor_58;
  } else {
    mediump vec4 fogColor_63;
    highp vec3 tmpvar_64;
    tmpvar_64 = ((unity_ObjectToWorld * tmpvar_2).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_65;
    tmpvar_65 = max (0.0, (sqrt(
      dot (tmpvar_64, tmpvar_64)
    ) - _FogStartDistance));
    highp float tmpvar_66;
    tmpvar_66 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_56)), _FogEffectLimit);
    highp vec3 tmpvar_67;
    tmpvar_67 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_65) / max (0.1, ((_FogEndDistance * fogTune_56) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_63.xyz = tmpvar_67;
    fogColor_63.w = tmpvar_66;
    tmpvar_57 = fogColor_63;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_COLOR1 = tmpvar_57;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_12;
  xlv_TEXCOORD5 = tmpvar_13;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_TEXCOORD8 = tmpvar_16;
  xlv_TEXCOORD9 = tmpvar_17;
  xlv_TEXCOORD10 = tmpvar_3;
  xlv_TEXCOORD11 = tmpvar_4;
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