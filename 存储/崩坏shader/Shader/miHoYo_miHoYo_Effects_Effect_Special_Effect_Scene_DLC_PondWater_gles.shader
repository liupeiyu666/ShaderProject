//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/Scene_DLC_PondWater" {
Properties {
[Header(Shading)] _WaterColor ("Water Color", Color) = (0.4,0.2,0.1,1)
[Header(Normal)] _NormalTexture1 ("Normal 1", 2D) = "white" { }
_NormalTexture2 ("Normal 2", 2D) = "bump" { }
_NormalSpeedU_1 ("Normal SpeedU 1", Float) = 0
_NormalSpeedV_1 ("Normal SpeedV 1", Float) = 0
_NormalSpeedU_2 ("Normal SpeedU 2", Float) = 0
_NormalSpeedV_2 ("Normal SpeedV 2", Float) = 0
_NormalIntensity ("Normal Intensity", Float) = 1
_NormalCoverageMin ("NormalCoverageMin", Range(0, 50000)) = 2
_NormalCoverageMax ("NormalCoverageMax", Range(0, 50000)) = 10
[Header(Reflection)] _Fresnel0 ("F0", Range(0, 1)) = 0.04
_Gloss ("Gloss", Range(0, 10)) = 1
_SpecularPower ("SpecularPower", Range(0, 1)) = 1
_SpecularIntensity ("SpecularIntensity", Float) = 1
_WaterReflectionTexture ("WaterReflectionTexture", Cube) = "white" { }
[Header(Refraction)] _Opacity ("Opacity", Range(0, 1)) = 0.01
_DepthDiffScale ("DepthDiff Scale", Range(0, 2)) = 1
_DistortionFactor ("Distortion Factor", Range(0, 1)) = 1
_HeightDiff ("HeightDiff", Range(-20, 20)) = 1.3
_Tests ("Tests", Range(-5, 5)) = 1.3
[Header(Caustics)] _CausticTex ("CausticTex", 2D) = "white" { }
_CausticColor ("CausticColor", Color) = (1,1,1,0)
_CausticIntensity ("CausticIntensity", Float) = 1
_CausticTiling ("CausticTiling", Range(0, 1)) = 1
_CausticDistortionSpeed ("CausticDistortionSpeed", Range(0.1, 1)) = 1
_CausticDistortionTiling ("CausticDistortionTiling", Range(0, 1)) = 0.03588236
_CausticDistortionValue ("CausticDistortionValue", Range(0, 1)) = 0.1
_CausticFade ("CausticFade", Range(0.01, 10)) = 1
_CausticFadePower ("CausticFadePower", Range(0.1, 10)) = 0.1
[Header(Edge Effect)] _EdgeFoamColor ("EdgeFoam Color", Color) = (1,1,1,0)
_EdgeFoamWidth ("EdgeFoam Width", Range(0, 5)) = 0.8
_EdgeTransparentWidth ("EdgeFoam Transparent Width", Range(0, 5)) = 0.8
[Header(FogCT)] [Toggle(LERP_SKY)] _Lerp ("Lerp SKy", Float) = 0
_FogCT ("FogColor", Color) = (1,1,1,1)
_FogIntensity ("FogIntensity", Range(0, 10)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 42235
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FogIntensity;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _SpecularPower;
uniform highp float _SpecularIntensity;
uniform lowp samplerCube _WaterReflectionTexture;
uniform highp vec3 _WaterColor;
uniform highp float _Fresnel0;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp vec3 _EdgeFoamColor;
uniform highp float _EdgeFoamWidth;
uniform highp float _EdgeTransparentWidth;
uniform highp vec3 _FogCT;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 lightColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_7.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_8.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (tmpvar_7.x + tmpvar_9.x);
  tmpvar_11.y = (tmpvar_9.y + tmpvar_7.y);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (tmpvar_8.x + tmpvar_10.x);
  tmpvar_12.y = (tmpvar_10.y + tmpvar_8.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture1, tmpvar_11);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NormalTexture2, tmpvar_12);
  mediump vec4 packednormal_19;
  packednormal_19 = tmpvar_18;
  mediump float bumpScale_20;
  bumpScale_20 = _NormalIntensity;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((packednormal_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * bumpScale_20);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  N_6 = tmpvar_23;
  highp vec3 x_24;
  x_24 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.0, 1.0, 0.0), normalize(N_6.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_24, x_24)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_6 = tmpvar_25;
  highp vec3 backgroundColor_26;
  highp float tmpvar_27;
  tmpvar_27 = abs(dot (tmpvar_5, tmpvar_25));
  highp float tmpvar_28;
  tmpvar_28 = ((_HeightDiff / tmpvar_27) * _DepthDiffScale);
  highp vec2 tmpvar_29;
  tmpvar_29 = (((tmpvar_28 * 
    (tmpvar_25.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_BeforeAlphaTexture, tmpvar_29).xyz;
  backgroundColor_26 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = _LightColor0.xyz;
  highp vec3 lightColor_32;
  lightColor_32 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = (max (0.3, dot (tmpvar_25, tmpvar_4)) * lightColor_32);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_35;
  tmpvar_35 = max ((tmpvar_34 * (1.0 + tmpvar_27)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_36;
  if ((tmpvar_27 > -0.99)) {
    tmpvar_36 = (((_WaterColor * 2.0) / (1.0 + tmpvar_27)) * (1.0 - exp(
      (-(tmpvar_35) * tmpvar_28)
    )));
  } else {
    tmpvar_36 = ((2.0 * tmpvar_34) * (_WaterColor * tmpvar_28));
  };
  lowp vec3 tmpvar_37;
  tmpvar_37 = _LightColor0.xyz;
  lightColor_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (1.0 - abs(tmpvar_5.y));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_38 * tmpvar_38);
  highp float tmpvar_40;
  tmpvar_40 = ((tmpvar_38 * tmpvar_39) * tmpvar_39);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_40)
  ) + vec3(tmpvar_40)), 0.0, 1.0);
  highp vec4 reflectColor_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = -(tmpvar_5);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_25, I_44)
   * tmpvar_25)));
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_WaterReflectionTexture, tmpvar_43);
  reflectColor_42 = tmpvar_45;
  highp vec3 causticColor_46;
  highp vec4 color2_47;
  highp vec4 color1_48;
  highp float tmpvar_49;
  tmpvar_49 = ((_HeightDiff / abs(
    dot (tmpvar_25, tmpvar_5)
  )) * _DepthDiffScale);
  highp float tmpvar_50;
  tmpvar_50 = (_Time.y * _CausticDistortionSpeed);
  highp vec2 tmpvar_51;
  tmpvar_51 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (tmpvar_51 + tmpvar_50);
  tmpvar_52 = texture2D (_CausticTex, P_53);
  color1_48 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = ((tmpvar_51 * vec2(1.5, 1.5)) - tmpvar_50);
  tmpvar_54 = texture2D (_CausticTex, P_55);
  color2_47 = tmpvar_54;
  highp vec2 tmpvar_56;
  tmpvar_56 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_5 * tmpvar_49)
  ).xz) + (_CausticDistortionValue * mix (color1_48.yz, color2_47.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_CausticTex, tmpvar_56).xyz;
  causticColor_46 = tmpvar_57;
  causticColor_46 = (causticColor_46 * (_LightColor0.xyz * clamp (
    abs(dot (tmpvar_4, tmpvar_25))
  , 0.0, 1.0)));
  causticColor_46 = (causticColor_46 * (_CausticColor * _CausticIntensity));
  highp vec2 P_58;
  P_58 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_59;
  tmpvar_59 = texture2D (_BeforeAlphaTexture, P_58).xyz;
  bgColor_1 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (bgColor_1, ((
    ((((
      clamp ((_SpecularIntensity * pow (max (
        abs(dot (tmpvar_25, normalize((_ES_SunDirection + tmpvar_5))))
      , 0.0001), _Gloss)), 0.0, 16.0)
     * lightColor_3) * pow (
      max ((1.0 - abs(dot (tmpvar_5, tmpvar_25))), 0.0001)
    , _SpecularPower)) + reflectColor_42.xyz) + (_EdgeFoamColor * clamp ((xlv_COLOR.x * _EdgeFoamWidth), 0.0, 1.0)))
   * tmpvar_41) + (
    (vec3((causticColor_46.x * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_49), 0.0, 1.0)
    , 0.0001), _CausticFadePower))) + ((backgroundColor_26 * exp(
      (-(tmpvar_35) * tmpvar_28)
    )) + (tmpvar_36 * tmpvar_33)))
   * 
    (1.0 - tmpvar_41)
  )), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_61;
  srcColor_61 = tmpvar_60;
  mediump vec3 fogColor_62;
  fogColor_62 = ((xlv_COLOR1.xyz * _FogCT) * _FogIntensity);
  mediump vec3 tmpvar_63;
  tmpvar_63 = mix (srcColor_61, fogColor_62, xlv_COLOR1.www);
  finalColor_2 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64.w = 1.0;
  tmpvar_64.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_64;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FogIntensity;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _SpecularPower;
uniform highp float _SpecularIntensity;
uniform lowp samplerCube _WaterReflectionTexture;
uniform highp vec3 _WaterColor;
uniform highp float _Fresnel0;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp vec3 _EdgeFoamColor;
uniform highp float _EdgeFoamWidth;
uniform highp float _EdgeTransparentWidth;
uniform highp vec3 _FogCT;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 lightColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_7.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_8.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (tmpvar_7.x + tmpvar_9.x);
  tmpvar_11.y = (tmpvar_9.y + tmpvar_7.y);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (tmpvar_8.x + tmpvar_10.x);
  tmpvar_12.y = (tmpvar_10.y + tmpvar_8.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture1, tmpvar_11);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NormalTexture2, tmpvar_12);
  mediump vec4 packednormal_19;
  packednormal_19 = tmpvar_18;
  mediump float bumpScale_20;
  bumpScale_20 = _NormalIntensity;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((packednormal_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * bumpScale_20);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  N_6 = tmpvar_23;
  highp vec3 x_24;
  x_24 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.0, 1.0, 0.0), normalize(N_6.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_24, x_24)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_6 = tmpvar_25;
  highp vec3 backgroundColor_26;
  highp float tmpvar_27;
  tmpvar_27 = abs(dot (tmpvar_5, tmpvar_25));
  highp float tmpvar_28;
  tmpvar_28 = ((_HeightDiff / tmpvar_27) * _DepthDiffScale);
  highp vec2 tmpvar_29;
  tmpvar_29 = (((tmpvar_28 * 
    (tmpvar_25.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_BeforeAlphaTexture, tmpvar_29).xyz;
  backgroundColor_26 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = _LightColor0.xyz;
  highp vec3 lightColor_32;
  lightColor_32 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = (max (0.3, dot (tmpvar_25, tmpvar_4)) * lightColor_32);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_35;
  tmpvar_35 = max ((tmpvar_34 * (1.0 + tmpvar_27)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_36;
  if ((tmpvar_27 > -0.99)) {
    tmpvar_36 = (((_WaterColor * 2.0) / (1.0 + tmpvar_27)) * (1.0 - exp(
      (-(tmpvar_35) * tmpvar_28)
    )));
  } else {
    tmpvar_36 = ((2.0 * tmpvar_34) * (_WaterColor * tmpvar_28));
  };
  lowp vec3 tmpvar_37;
  tmpvar_37 = _LightColor0.xyz;
  lightColor_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (1.0 - abs(tmpvar_5.y));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_38 * tmpvar_38);
  highp float tmpvar_40;
  tmpvar_40 = ((tmpvar_38 * tmpvar_39) * tmpvar_39);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_40)
  ) + vec3(tmpvar_40)), 0.0, 1.0);
  highp vec4 reflectColor_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = -(tmpvar_5);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_25, I_44)
   * tmpvar_25)));
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_WaterReflectionTexture, tmpvar_43);
  reflectColor_42 = tmpvar_45;
  highp vec3 causticColor_46;
  highp vec4 color2_47;
  highp vec4 color1_48;
  highp float tmpvar_49;
  tmpvar_49 = ((_HeightDiff / abs(
    dot (tmpvar_25, tmpvar_5)
  )) * _DepthDiffScale);
  highp float tmpvar_50;
  tmpvar_50 = (_Time.y * _CausticDistortionSpeed);
  highp vec2 tmpvar_51;
  tmpvar_51 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (tmpvar_51 + tmpvar_50);
  tmpvar_52 = texture2D (_CausticTex, P_53);
  color1_48 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = ((tmpvar_51 * vec2(1.5, 1.5)) - tmpvar_50);
  tmpvar_54 = texture2D (_CausticTex, P_55);
  color2_47 = tmpvar_54;
  highp vec2 tmpvar_56;
  tmpvar_56 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_5 * tmpvar_49)
  ).xz) + (_CausticDistortionValue * mix (color1_48.yz, color2_47.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_CausticTex, tmpvar_56).xyz;
  causticColor_46 = tmpvar_57;
  causticColor_46 = (causticColor_46 * (_LightColor0.xyz * clamp (
    abs(dot (tmpvar_4, tmpvar_25))
  , 0.0, 1.0)));
  causticColor_46 = (causticColor_46 * (_CausticColor * _CausticIntensity));
  highp vec2 P_58;
  P_58 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_59;
  tmpvar_59 = texture2D (_BeforeAlphaTexture, P_58).xyz;
  bgColor_1 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (bgColor_1, ((
    ((((
      clamp ((_SpecularIntensity * pow (max (
        abs(dot (tmpvar_25, normalize((_ES_SunDirection + tmpvar_5))))
      , 0.0001), _Gloss)), 0.0, 16.0)
     * lightColor_3) * pow (
      max ((1.0 - abs(dot (tmpvar_5, tmpvar_25))), 0.0001)
    , _SpecularPower)) + reflectColor_42.xyz) + (_EdgeFoamColor * clamp ((xlv_COLOR.x * _EdgeFoamWidth), 0.0, 1.0)))
   * tmpvar_41) + (
    (vec3((causticColor_46.x * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_49), 0.0, 1.0)
    , 0.0001), _CausticFadePower))) + ((backgroundColor_26 * exp(
      (-(tmpvar_35) * tmpvar_28)
    )) + (tmpvar_36 * tmpvar_33)))
   * 
    (1.0 - tmpvar_41)
  )), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_61;
  srcColor_61 = tmpvar_60;
  mediump vec3 fogColor_62;
  fogColor_62 = ((xlv_COLOR1.xyz * _FogCT) * _FogIntensity);
  mediump vec3 tmpvar_63;
  tmpvar_63 = mix (srcColor_61, fogColor_62, xlv_COLOR1.www);
  finalColor_2 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64.w = 1.0;
  tmpvar_64.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_64;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FogIntensity;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _SpecularPower;
uniform highp float _SpecularIntensity;
uniform lowp samplerCube _WaterReflectionTexture;
uniform highp vec3 _WaterColor;
uniform highp float _Fresnel0;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp vec3 _EdgeFoamColor;
uniform highp float _EdgeFoamWidth;
uniform highp float _EdgeTransparentWidth;
uniform highp vec3 _FogCT;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 lightColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_7.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_8.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (tmpvar_7.x + tmpvar_9.x);
  tmpvar_11.y = (tmpvar_9.y + tmpvar_7.y);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (tmpvar_8.x + tmpvar_10.x);
  tmpvar_12.y = (tmpvar_10.y + tmpvar_8.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture1, tmpvar_11);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NormalTexture2, tmpvar_12);
  mediump vec4 packednormal_19;
  packednormal_19 = tmpvar_18;
  mediump float bumpScale_20;
  bumpScale_20 = _NormalIntensity;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((packednormal_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * bumpScale_20);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  N_6 = tmpvar_23;
  highp vec3 x_24;
  x_24 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.0, 1.0, 0.0), normalize(N_6.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_24, x_24)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_6 = tmpvar_25;
  highp vec3 backgroundColor_26;
  highp float tmpvar_27;
  tmpvar_27 = abs(dot (tmpvar_5, tmpvar_25));
  highp float tmpvar_28;
  tmpvar_28 = ((_HeightDiff / tmpvar_27) * _DepthDiffScale);
  highp vec2 tmpvar_29;
  tmpvar_29 = (((tmpvar_28 * 
    (tmpvar_25.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_BeforeAlphaTexture, tmpvar_29).xyz;
  backgroundColor_26 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = _LightColor0.xyz;
  highp vec3 lightColor_32;
  lightColor_32 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = (max (0.3, dot (tmpvar_25, tmpvar_4)) * lightColor_32);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_35;
  tmpvar_35 = max ((tmpvar_34 * (1.0 + tmpvar_27)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_36;
  if ((tmpvar_27 > -0.99)) {
    tmpvar_36 = (((_WaterColor * 2.0) / (1.0 + tmpvar_27)) * (1.0 - exp(
      (-(tmpvar_35) * tmpvar_28)
    )));
  } else {
    tmpvar_36 = ((2.0 * tmpvar_34) * (_WaterColor * tmpvar_28));
  };
  lowp vec3 tmpvar_37;
  tmpvar_37 = _LightColor0.xyz;
  lightColor_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (1.0 - abs(tmpvar_5.y));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_38 * tmpvar_38);
  highp float tmpvar_40;
  tmpvar_40 = ((tmpvar_38 * tmpvar_39) * tmpvar_39);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_40)
  ) + vec3(tmpvar_40)), 0.0, 1.0);
  highp vec4 reflectColor_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = -(tmpvar_5);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_25, I_44)
   * tmpvar_25)));
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_WaterReflectionTexture, tmpvar_43);
  reflectColor_42 = tmpvar_45;
  highp vec3 causticColor_46;
  highp vec4 color2_47;
  highp vec4 color1_48;
  highp float tmpvar_49;
  tmpvar_49 = ((_HeightDiff / abs(
    dot (tmpvar_25, tmpvar_5)
  )) * _DepthDiffScale);
  highp float tmpvar_50;
  tmpvar_50 = (_Time.y * _CausticDistortionSpeed);
  highp vec2 tmpvar_51;
  tmpvar_51 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (tmpvar_51 + tmpvar_50);
  tmpvar_52 = texture2D (_CausticTex, P_53);
  color1_48 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = ((tmpvar_51 * vec2(1.5, 1.5)) - tmpvar_50);
  tmpvar_54 = texture2D (_CausticTex, P_55);
  color2_47 = tmpvar_54;
  highp vec2 tmpvar_56;
  tmpvar_56 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_5 * tmpvar_49)
  ).xz) + (_CausticDistortionValue * mix (color1_48.yz, color2_47.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_CausticTex, tmpvar_56).xyz;
  causticColor_46 = tmpvar_57;
  causticColor_46 = (causticColor_46 * (_LightColor0.xyz * clamp (
    abs(dot (tmpvar_4, tmpvar_25))
  , 0.0, 1.0)));
  causticColor_46 = (causticColor_46 * (_CausticColor * _CausticIntensity));
  highp vec2 P_58;
  P_58 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_59;
  tmpvar_59 = texture2D (_BeforeAlphaTexture, P_58).xyz;
  bgColor_1 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (bgColor_1, ((
    ((((
      clamp ((_SpecularIntensity * pow (max (
        abs(dot (tmpvar_25, normalize((_ES_SunDirection + tmpvar_5))))
      , 0.0001), _Gloss)), 0.0, 16.0)
     * lightColor_3) * pow (
      max ((1.0 - abs(dot (tmpvar_5, tmpvar_25))), 0.0001)
    , _SpecularPower)) + reflectColor_42.xyz) + (_EdgeFoamColor * clamp ((xlv_COLOR.x * _EdgeFoamWidth), 0.0, 1.0)))
   * tmpvar_41) + (
    (vec3((causticColor_46.x * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_49), 0.0, 1.0)
    , 0.0001), _CausticFadePower))) + ((backgroundColor_26 * exp(
      (-(tmpvar_35) * tmpvar_28)
    )) + (tmpvar_36 * tmpvar_33)))
   * 
    (1.0 - tmpvar_41)
  )), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_61;
  srcColor_61 = tmpvar_60;
  mediump vec3 fogColor_62;
  fogColor_62 = ((xlv_COLOR1.xyz * _FogCT) * _FogIntensity);
  mediump vec3 tmpvar_63;
  tmpvar_63 = mix (srcColor_61, fogColor_62, xlv_COLOR1.www);
  finalColor_2 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64.w = 1.0;
  tmpvar_64.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_64;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FogIntensity;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _SpecularPower;
uniform highp float _SpecularIntensity;
uniform lowp samplerCube _WaterReflectionTexture;
uniform highp vec3 _WaterColor;
uniform highp float _Fresnel0;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp vec3 _EdgeFoamColor;
uniform highp float _EdgeFoamWidth;
uniform highp float _EdgeTransparentWidth;
uniform highp vec3 _FogCT;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 lightColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_7.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_8.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (tmpvar_7.x + tmpvar_9.x);
  tmpvar_11.y = (tmpvar_9.y + tmpvar_7.y);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (tmpvar_8.x + tmpvar_10.x);
  tmpvar_12.y = (tmpvar_10.y + tmpvar_8.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture1, tmpvar_11);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NormalTexture2, tmpvar_12);
  mediump vec4 packednormal_19;
  packednormal_19 = tmpvar_18;
  mediump float bumpScale_20;
  bumpScale_20 = _NormalIntensity;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((packednormal_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * bumpScale_20);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  N_6 = tmpvar_23;
  highp vec3 x_24;
  x_24 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.0, 1.0, 0.0), normalize(N_6.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_24, x_24)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_6 = tmpvar_25;
  highp vec3 backgroundColor_26;
  highp float tmpvar_27;
  tmpvar_27 = abs(dot (tmpvar_5, tmpvar_25));
  highp float tmpvar_28;
  tmpvar_28 = ((_HeightDiff / tmpvar_27) * _DepthDiffScale);
  highp vec2 tmpvar_29;
  tmpvar_29 = (((tmpvar_28 * 
    (tmpvar_25.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_BeforeAlphaTexture, tmpvar_29).xyz;
  backgroundColor_26 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = _LightColor0.xyz;
  highp vec3 lightColor_32;
  lightColor_32 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = (max (0.3, dot (tmpvar_25, tmpvar_4)) * lightColor_32);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_35;
  tmpvar_35 = max ((tmpvar_34 * (1.0 + tmpvar_27)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_36;
  if ((tmpvar_27 > -0.99)) {
    tmpvar_36 = (((_WaterColor * 2.0) / (1.0 + tmpvar_27)) * (1.0 - exp(
      (-(tmpvar_35) * tmpvar_28)
    )));
  } else {
    tmpvar_36 = ((2.0 * tmpvar_34) * (_WaterColor * tmpvar_28));
  };
  lowp vec3 tmpvar_37;
  tmpvar_37 = _LightColor0.xyz;
  lightColor_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (1.0 - abs(tmpvar_5.y));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_38 * tmpvar_38);
  highp float tmpvar_40;
  tmpvar_40 = ((tmpvar_38 * tmpvar_39) * tmpvar_39);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_40)
  ) + vec3(tmpvar_40)), 0.0, 1.0);
  highp vec4 reflectColor_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = -(tmpvar_5);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_25, I_44)
   * tmpvar_25)));
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_WaterReflectionTexture, tmpvar_43);
  reflectColor_42 = tmpvar_45;
  highp vec3 causticColor_46;
  highp vec4 color2_47;
  highp vec4 color1_48;
  highp float tmpvar_49;
  tmpvar_49 = ((_HeightDiff / abs(
    dot (tmpvar_25, tmpvar_5)
  )) * _DepthDiffScale);
  highp float tmpvar_50;
  tmpvar_50 = (_Time.y * _CausticDistortionSpeed);
  highp vec2 tmpvar_51;
  tmpvar_51 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (tmpvar_51 + tmpvar_50);
  tmpvar_52 = texture2D (_CausticTex, P_53);
  color1_48 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = ((tmpvar_51 * vec2(1.5, 1.5)) - tmpvar_50);
  tmpvar_54 = texture2D (_CausticTex, P_55);
  color2_47 = tmpvar_54;
  highp vec2 tmpvar_56;
  tmpvar_56 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_5 * tmpvar_49)
  ).xz) + (_CausticDistortionValue * mix (color1_48.yz, color2_47.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_CausticTex, tmpvar_56).xyz;
  causticColor_46 = tmpvar_57;
  causticColor_46 = (causticColor_46 * (_LightColor0.xyz * clamp (
    abs(dot (tmpvar_4, tmpvar_25))
  , 0.0, 1.0)));
  causticColor_46 = (causticColor_46 * (_CausticColor * _CausticIntensity));
  highp vec2 P_58;
  P_58 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_59;
  tmpvar_59 = texture2D (_BeforeAlphaTexture, P_58).xyz;
  bgColor_1 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (bgColor_1, ((
    ((((
      clamp ((_SpecularIntensity * pow (max (
        abs(dot (tmpvar_25, normalize((_ES_SunDirection + tmpvar_5))))
      , 0.0001), _Gloss)), 0.0, 16.0)
     * lightColor_3) * pow (
      max ((1.0 - abs(dot (tmpvar_5, tmpvar_25))), 0.0001)
    , _SpecularPower)) + reflectColor_42.xyz) + (_EdgeFoamColor * clamp ((xlv_COLOR.x * _EdgeFoamWidth), 0.0, 1.0)))
   * tmpvar_41) + (
    (vec3((causticColor_46.x * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_49), 0.0, 1.0)
    , 0.0001), _CausticFadePower))) + ((backgroundColor_26 * exp(
      (-(tmpvar_35) * tmpvar_28)
    )) + (tmpvar_36 * tmpvar_33)))
   * 
    (1.0 - tmpvar_41)
  )), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_61;
  srcColor_61 = tmpvar_60;
  mediump vec3 fogColor_62;
  fogColor_62 = ((xlv_COLOR1.xyz * _FogCT) * _FogIntensity);
  mediump vec3 tmpvar_63;
  tmpvar_63 = mix (srcColor_61, fogColor_62, xlv_COLOR1.www);
  finalColor_2 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64.w = 1.0;
  tmpvar_64.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_64;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FogIntensity;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _SpecularPower;
uniform highp float _SpecularIntensity;
uniform lowp samplerCube _WaterReflectionTexture;
uniform highp vec3 _WaterColor;
uniform highp float _Fresnel0;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp vec3 _EdgeFoamColor;
uniform highp float _EdgeFoamWidth;
uniform highp float _EdgeTransparentWidth;
uniform highp vec3 _FogCT;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 lightColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_7.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_8.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (tmpvar_7.x + tmpvar_9.x);
  tmpvar_11.y = (tmpvar_9.y + tmpvar_7.y);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (tmpvar_8.x + tmpvar_10.x);
  tmpvar_12.y = (tmpvar_10.y + tmpvar_8.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture1, tmpvar_11);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NormalTexture2, tmpvar_12);
  mediump vec4 packednormal_19;
  packednormal_19 = tmpvar_18;
  mediump float bumpScale_20;
  bumpScale_20 = _NormalIntensity;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((packednormal_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * bumpScale_20);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  N_6 = tmpvar_23;
  highp vec3 x_24;
  x_24 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.0, 1.0, 0.0), normalize(N_6.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_24, x_24)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_6 = tmpvar_25;
  highp vec3 backgroundColor_26;
  highp float tmpvar_27;
  tmpvar_27 = abs(dot (tmpvar_5, tmpvar_25));
  highp float tmpvar_28;
  tmpvar_28 = ((_HeightDiff / tmpvar_27) * _DepthDiffScale);
  highp vec2 tmpvar_29;
  tmpvar_29 = (((tmpvar_28 * 
    (tmpvar_25.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_BeforeAlphaTexture, tmpvar_29).xyz;
  backgroundColor_26 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = _LightColor0.xyz;
  highp vec3 lightColor_32;
  lightColor_32 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = (max (0.3, dot (tmpvar_25, tmpvar_4)) * lightColor_32);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_35;
  tmpvar_35 = max ((tmpvar_34 * (1.0 + tmpvar_27)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_36;
  if ((tmpvar_27 > -0.99)) {
    tmpvar_36 = (((_WaterColor * 2.0) / (1.0 + tmpvar_27)) * (1.0 - exp(
      (-(tmpvar_35) * tmpvar_28)
    )));
  } else {
    tmpvar_36 = ((2.0 * tmpvar_34) * (_WaterColor * tmpvar_28));
  };
  lowp vec3 tmpvar_37;
  tmpvar_37 = _LightColor0.xyz;
  lightColor_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (1.0 - abs(tmpvar_5.y));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_38 * tmpvar_38);
  highp float tmpvar_40;
  tmpvar_40 = ((tmpvar_38 * tmpvar_39) * tmpvar_39);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_40)
  ) + vec3(tmpvar_40)), 0.0, 1.0);
  highp vec4 reflectColor_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = -(tmpvar_5);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_25, I_44)
   * tmpvar_25)));
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_WaterReflectionTexture, tmpvar_43);
  reflectColor_42 = tmpvar_45;
  highp vec3 causticColor_46;
  highp vec4 color2_47;
  highp vec4 color1_48;
  highp float tmpvar_49;
  tmpvar_49 = ((_HeightDiff / abs(
    dot (tmpvar_25, tmpvar_5)
  )) * _DepthDiffScale);
  highp float tmpvar_50;
  tmpvar_50 = (_Time.y * _CausticDistortionSpeed);
  highp vec2 tmpvar_51;
  tmpvar_51 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (tmpvar_51 + tmpvar_50);
  tmpvar_52 = texture2D (_CausticTex, P_53);
  color1_48 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = ((tmpvar_51 * vec2(1.5, 1.5)) - tmpvar_50);
  tmpvar_54 = texture2D (_CausticTex, P_55);
  color2_47 = tmpvar_54;
  highp vec2 tmpvar_56;
  tmpvar_56 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_5 * tmpvar_49)
  ).xz) + (_CausticDistortionValue * mix (color1_48.yz, color2_47.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_CausticTex, tmpvar_56).xyz;
  causticColor_46 = tmpvar_57;
  causticColor_46 = (causticColor_46 * (_LightColor0.xyz * clamp (
    abs(dot (tmpvar_4, tmpvar_25))
  , 0.0, 1.0)));
  causticColor_46 = (causticColor_46 * (_CausticColor * _CausticIntensity));
  highp vec2 P_58;
  P_58 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_59;
  tmpvar_59 = texture2D (_BeforeAlphaTexture, P_58).xyz;
  bgColor_1 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (bgColor_1, ((
    ((((
      clamp ((_SpecularIntensity * pow (max (
        abs(dot (tmpvar_25, normalize((_ES_SunDirection + tmpvar_5))))
      , 0.0001), _Gloss)), 0.0, 16.0)
     * lightColor_3) * pow (
      max ((1.0 - abs(dot (tmpvar_5, tmpvar_25))), 0.0001)
    , _SpecularPower)) + reflectColor_42.xyz) + (_EdgeFoamColor * clamp ((xlv_COLOR.x * _EdgeFoamWidth), 0.0, 1.0)))
   * tmpvar_41) + (
    (vec3((causticColor_46.x * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_49), 0.0, 1.0)
    , 0.0001), _CausticFadePower))) + ((backgroundColor_26 * exp(
      (-(tmpvar_35) * tmpvar_28)
    )) + (tmpvar_36 * tmpvar_33)))
   * 
    (1.0 - tmpvar_41)
  )), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_61;
  srcColor_61 = tmpvar_60;
  mediump vec3 fogColor_62;
  fogColor_62 = ((xlv_COLOR1.xyz * _FogCT) * _FogIntensity);
  mediump vec3 tmpvar_63;
  tmpvar_63 = mix (srcColor_61, fogColor_62, xlv_COLOR1.www);
  finalColor_2 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64.w = 1.0;
  tmpvar_64.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_64;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FogIntensity;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _SpecularPower;
uniform highp float _SpecularIntensity;
uniform lowp samplerCube _WaterReflectionTexture;
uniform highp vec3 _WaterColor;
uniform highp float _Fresnel0;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp vec3 _EdgeFoamColor;
uniform highp float _EdgeFoamWidth;
uniform highp float _EdgeTransparentWidth;
uniform highp vec3 _FogCT;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 lightColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_7.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_8.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (tmpvar_7.x + tmpvar_9.x);
  tmpvar_11.y = (tmpvar_9.y + tmpvar_7.y);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (tmpvar_8.x + tmpvar_10.x);
  tmpvar_12.y = (tmpvar_10.y + tmpvar_8.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture1, tmpvar_11);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NormalTexture2, tmpvar_12);
  mediump vec4 packednormal_19;
  packednormal_19 = tmpvar_18;
  mediump float bumpScale_20;
  bumpScale_20 = _NormalIntensity;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((packednormal_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * bumpScale_20);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  N_6 = tmpvar_23;
  highp vec3 x_24;
  x_24 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.0, 1.0, 0.0), normalize(N_6.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_24, x_24)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_6 = tmpvar_25;
  highp vec3 backgroundColor_26;
  highp float tmpvar_27;
  tmpvar_27 = abs(dot (tmpvar_5, tmpvar_25));
  highp float tmpvar_28;
  tmpvar_28 = ((_HeightDiff / tmpvar_27) * _DepthDiffScale);
  highp vec2 tmpvar_29;
  tmpvar_29 = (((tmpvar_28 * 
    (tmpvar_25.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_BeforeAlphaTexture, tmpvar_29).xyz;
  backgroundColor_26 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = _LightColor0.xyz;
  highp vec3 lightColor_32;
  lightColor_32 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = (max (0.3, dot (tmpvar_25, tmpvar_4)) * lightColor_32);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_35;
  tmpvar_35 = max ((tmpvar_34 * (1.0 + tmpvar_27)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_36;
  if ((tmpvar_27 > -0.99)) {
    tmpvar_36 = (((_WaterColor * 2.0) / (1.0 + tmpvar_27)) * (1.0 - exp(
      (-(tmpvar_35) * tmpvar_28)
    )));
  } else {
    tmpvar_36 = ((2.0 * tmpvar_34) * (_WaterColor * tmpvar_28));
  };
  lowp vec3 tmpvar_37;
  tmpvar_37 = _LightColor0.xyz;
  lightColor_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (1.0 - abs(tmpvar_5.y));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_38 * tmpvar_38);
  highp float tmpvar_40;
  tmpvar_40 = ((tmpvar_38 * tmpvar_39) * tmpvar_39);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_40)
  ) + vec3(tmpvar_40)), 0.0, 1.0);
  highp vec4 reflectColor_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = -(tmpvar_5);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_25, I_44)
   * tmpvar_25)));
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_WaterReflectionTexture, tmpvar_43);
  reflectColor_42 = tmpvar_45;
  highp vec3 causticColor_46;
  highp vec4 color2_47;
  highp vec4 color1_48;
  highp float tmpvar_49;
  tmpvar_49 = ((_HeightDiff / abs(
    dot (tmpvar_25, tmpvar_5)
  )) * _DepthDiffScale);
  highp float tmpvar_50;
  tmpvar_50 = (_Time.y * _CausticDistortionSpeed);
  highp vec2 tmpvar_51;
  tmpvar_51 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (tmpvar_51 + tmpvar_50);
  tmpvar_52 = texture2D (_CausticTex, P_53);
  color1_48 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = ((tmpvar_51 * vec2(1.5, 1.5)) - tmpvar_50);
  tmpvar_54 = texture2D (_CausticTex, P_55);
  color2_47 = tmpvar_54;
  highp vec2 tmpvar_56;
  tmpvar_56 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_5 * tmpvar_49)
  ).xz) + (_CausticDistortionValue * mix (color1_48.yz, color2_47.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_CausticTex, tmpvar_56).xyz;
  causticColor_46 = tmpvar_57;
  causticColor_46 = (causticColor_46 * (_LightColor0.xyz * clamp (
    abs(dot (tmpvar_4, tmpvar_25))
  , 0.0, 1.0)));
  causticColor_46 = (causticColor_46 * (_CausticColor * _CausticIntensity));
  highp vec2 P_58;
  P_58 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_59;
  tmpvar_59 = texture2D (_BeforeAlphaTexture, P_58).xyz;
  bgColor_1 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (bgColor_1, ((
    ((((
      clamp ((_SpecularIntensity * pow (max (
        abs(dot (tmpvar_25, normalize((_ES_SunDirection + tmpvar_5))))
      , 0.0001), _Gloss)), 0.0, 16.0)
     * lightColor_3) * pow (
      max ((1.0 - abs(dot (tmpvar_5, tmpvar_25))), 0.0001)
    , _SpecularPower)) + reflectColor_42.xyz) + (_EdgeFoamColor * clamp ((xlv_COLOR.x * _EdgeFoamWidth), 0.0, 1.0)))
   * tmpvar_41) + (
    (vec3((causticColor_46.x * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_49), 0.0, 1.0)
    , 0.0001), _CausticFadePower))) + ((backgroundColor_26 * exp(
      (-(tmpvar_35) * tmpvar_28)
    )) + (tmpvar_36 * tmpvar_33)))
   * 
    (1.0 - tmpvar_41)
  )), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_61;
  srcColor_61 = tmpvar_60;
  mediump vec3 fogColor_62;
  fogColor_62 = ((xlv_COLOR1.xyz * _FogCT) * _FogIntensity);
  mediump vec3 tmpvar_63;
  tmpvar_63 = mix (srcColor_61, fogColor_62, xlv_COLOR1.www);
  finalColor_2 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64.w = 1.0;
  tmpvar_64.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_64;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_SKY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp vec3 _WaterColor;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 N_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_2.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_3.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + tmpvar_4.x);
  tmpvar_6.y = (tmpvar_4.y + tmpvar_2.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = (tmpvar_3.x + tmpvar_5.x);
  tmpvar_7.y = (tmpvar_5.y + tmpvar_3.y);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_NormalTexture1, tmpvar_6);
  mediump vec4 packednormal_9;
  packednormal_9 = tmpvar_8;
  mediump float bumpScale_10;
  bumpScale_10 = _NormalIntensity;
  mediump vec3 normal_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((packednormal_9.xyz * 2.0) - 1.0);
  normal_11.z = tmpvar_12.z;
  normal_11.xy = (tmpvar_12.xy * bumpScale_10);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture2, tmpvar_7);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  mediump vec3 tmpvar_18;
  tmpvar_18 = (normal_11 + normal_16);
  N_1 = tmpvar_18;
  highp vec3 x_19;
  x_19 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (vec3(0.0, 1.0, 0.0), normalize(N_1.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_19, x_19)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_1 = tmpvar_20;
  highp vec3 backgroundColor_21;
  highp float tmpvar_22;
  tmpvar_22 = abs(dot (normalize(
    (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
  ), tmpvar_20));
  highp float tmpvar_23;
  tmpvar_23 = ((_HeightDiff / tmpvar_22) * _DepthDiffScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * 
    (tmpvar_20.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, tmpvar_24).xyz;
  backgroundColor_21 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = _LightColor0.xyz;
  highp vec3 lightColor_27;
  lightColor_27 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = (max (0.3, dot (tmpvar_20, 
    normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)))
  )) * lightColor_27);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = max ((tmpvar_29 * (1.0 + tmpvar_22)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_31;
  if ((tmpvar_22 > -0.99)) {
    tmpvar_31 = (((_WaterColor * 2.0) / (1.0 + tmpvar_22)) * (1.0 - exp(
      (-(tmpvar_30) * tmpvar_23)
    )));
  } else {
    tmpvar_31 = ((2.0 * tmpvar_29) * (_WaterColor * tmpvar_23));
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((backgroundColor_21 * exp(
    (-(tmpvar_30) * tmpvar_23)
  )) + (tmpvar_31 * tmpvar_28));
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_SKY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp vec3 _WaterColor;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 N_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_2.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_3.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + tmpvar_4.x);
  tmpvar_6.y = (tmpvar_4.y + tmpvar_2.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = (tmpvar_3.x + tmpvar_5.x);
  tmpvar_7.y = (tmpvar_5.y + tmpvar_3.y);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_NormalTexture1, tmpvar_6);
  mediump vec4 packednormal_9;
  packednormal_9 = tmpvar_8;
  mediump float bumpScale_10;
  bumpScale_10 = _NormalIntensity;
  mediump vec3 normal_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((packednormal_9.xyz * 2.0) - 1.0);
  normal_11.z = tmpvar_12.z;
  normal_11.xy = (tmpvar_12.xy * bumpScale_10);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture2, tmpvar_7);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  mediump vec3 tmpvar_18;
  tmpvar_18 = (normal_11 + normal_16);
  N_1 = tmpvar_18;
  highp vec3 x_19;
  x_19 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (vec3(0.0, 1.0, 0.0), normalize(N_1.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_19, x_19)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_1 = tmpvar_20;
  highp vec3 backgroundColor_21;
  highp float tmpvar_22;
  tmpvar_22 = abs(dot (normalize(
    (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
  ), tmpvar_20));
  highp float tmpvar_23;
  tmpvar_23 = ((_HeightDiff / tmpvar_22) * _DepthDiffScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * 
    (tmpvar_20.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, tmpvar_24).xyz;
  backgroundColor_21 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = _LightColor0.xyz;
  highp vec3 lightColor_27;
  lightColor_27 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = (max (0.3, dot (tmpvar_20, 
    normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)))
  )) * lightColor_27);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = max ((tmpvar_29 * (1.0 + tmpvar_22)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_31;
  if ((tmpvar_22 > -0.99)) {
    tmpvar_31 = (((_WaterColor * 2.0) / (1.0 + tmpvar_22)) * (1.0 - exp(
      (-(tmpvar_30) * tmpvar_23)
    )));
  } else {
    tmpvar_31 = ((2.0 * tmpvar_29) * (_WaterColor * tmpvar_23));
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((backgroundColor_21 * exp(
    (-(tmpvar_30) * tmpvar_23)
  )) + (tmpvar_31 * tmpvar_28));
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_SKY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp vec3 _WaterColor;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 N_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_2.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_3.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + tmpvar_4.x);
  tmpvar_6.y = (tmpvar_4.y + tmpvar_2.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = (tmpvar_3.x + tmpvar_5.x);
  tmpvar_7.y = (tmpvar_5.y + tmpvar_3.y);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_NormalTexture1, tmpvar_6);
  mediump vec4 packednormal_9;
  packednormal_9 = tmpvar_8;
  mediump float bumpScale_10;
  bumpScale_10 = _NormalIntensity;
  mediump vec3 normal_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((packednormal_9.xyz * 2.0) - 1.0);
  normal_11.z = tmpvar_12.z;
  normal_11.xy = (tmpvar_12.xy * bumpScale_10);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture2, tmpvar_7);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  mediump vec3 tmpvar_18;
  tmpvar_18 = (normal_11 + normal_16);
  N_1 = tmpvar_18;
  highp vec3 x_19;
  x_19 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (vec3(0.0, 1.0, 0.0), normalize(N_1.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_19, x_19)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_1 = tmpvar_20;
  highp vec3 backgroundColor_21;
  highp float tmpvar_22;
  tmpvar_22 = abs(dot (normalize(
    (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
  ), tmpvar_20));
  highp float tmpvar_23;
  tmpvar_23 = ((_HeightDiff / tmpvar_22) * _DepthDiffScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * 
    (tmpvar_20.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, tmpvar_24).xyz;
  backgroundColor_21 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = _LightColor0.xyz;
  highp vec3 lightColor_27;
  lightColor_27 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = (max (0.3, dot (tmpvar_20, 
    normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)))
  )) * lightColor_27);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = max ((tmpvar_29 * (1.0 + tmpvar_22)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_31;
  if ((tmpvar_22 > -0.99)) {
    tmpvar_31 = (((_WaterColor * 2.0) / (1.0 + tmpvar_22)) * (1.0 - exp(
      (-(tmpvar_30) * tmpvar_23)
    )));
  } else {
    tmpvar_31 = ((2.0 * tmpvar_29) * (_WaterColor * tmpvar_23));
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((backgroundColor_21 * exp(
    (-(tmpvar_30) * tmpvar_23)
  )) + (tmpvar_31 * tmpvar_28));
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_REFLECTION" "LERP_SKY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp vec3 _WaterColor;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 N_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_2.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_3.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + tmpvar_4.x);
  tmpvar_6.y = (tmpvar_4.y + tmpvar_2.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = (tmpvar_3.x + tmpvar_5.x);
  tmpvar_7.y = (tmpvar_5.y + tmpvar_3.y);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_NormalTexture1, tmpvar_6);
  mediump vec4 packednormal_9;
  packednormal_9 = tmpvar_8;
  mediump float bumpScale_10;
  bumpScale_10 = _NormalIntensity;
  mediump vec3 normal_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((packednormal_9.xyz * 2.0) - 1.0);
  normal_11.z = tmpvar_12.z;
  normal_11.xy = (tmpvar_12.xy * bumpScale_10);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture2, tmpvar_7);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  mediump vec3 tmpvar_18;
  tmpvar_18 = (normal_11 + normal_16);
  N_1 = tmpvar_18;
  highp vec3 x_19;
  x_19 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (vec3(0.0, 1.0, 0.0), normalize(N_1.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_19, x_19)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_1 = tmpvar_20;
  highp vec3 backgroundColor_21;
  highp float tmpvar_22;
  tmpvar_22 = abs(dot (normalize(
    (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
  ), tmpvar_20));
  highp float tmpvar_23;
  tmpvar_23 = ((_HeightDiff / tmpvar_22) * _DepthDiffScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * 
    (tmpvar_20.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, tmpvar_24).xyz;
  backgroundColor_21 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = _LightColor0.xyz;
  highp vec3 lightColor_27;
  lightColor_27 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = (max (0.3, dot (tmpvar_20, 
    normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)))
  )) * lightColor_27);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = max ((tmpvar_29 * (1.0 + tmpvar_22)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_31;
  if ((tmpvar_22 > -0.99)) {
    tmpvar_31 = (((_WaterColor * 2.0) / (1.0 + tmpvar_22)) * (1.0 - exp(
      (-(tmpvar_30) * tmpvar_23)
    )));
  } else {
    tmpvar_31 = ((2.0 * tmpvar_29) * (_WaterColor * tmpvar_23));
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((backgroundColor_21 * exp(
    (-(tmpvar_30) * tmpvar_23)
  )) + (tmpvar_31 * tmpvar_28));
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" "LERP_SKY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp vec3 _WaterColor;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 N_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_2.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_3.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + tmpvar_4.x);
  tmpvar_6.y = (tmpvar_4.y + tmpvar_2.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = (tmpvar_3.x + tmpvar_5.x);
  tmpvar_7.y = (tmpvar_5.y + tmpvar_3.y);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_NormalTexture1, tmpvar_6);
  mediump vec4 packednormal_9;
  packednormal_9 = tmpvar_8;
  mediump float bumpScale_10;
  bumpScale_10 = _NormalIntensity;
  mediump vec3 normal_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((packednormal_9.xyz * 2.0) - 1.0);
  normal_11.z = tmpvar_12.z;
  normal_11.xy = (tmpvar_12.xy * bumpScale_10);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture2, tmpvar_7);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  mediump vec3 tmpvar_18;
  tmpvar_18 = (normal_11 + normal_16);
  N_1 = tmpvar_18;
  highp vec3 x_19;
  x_19 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (vec3(0.0, 1.0, 0.0), normalize(N_1.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_19, x_19)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_1 = tmpvar_20;
  highp vec3 backgroundColor_21;
  highp float tmpvar_22;
  tmpvar_22 = abs(dot (normalize(
    (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
  ), tmpvar_20));
  highp float tmpvar_23;
  tmpvar_23 = ((_HeightDiff / tmpvar_22) * _DepthDiffScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * 
    (tmpvar_20.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, tmpvar_24).xyz;
  backgroundColor_21 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = _LightColor0.xyz;
  highp vec3 lightColor_27;
  lightColor_27 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = (max (0.3, dot (tmpvar_20, 
    normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)))
  )) * lightColor_27);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = max ((tmpvar_29 * (1.0 + tmpvar_22)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_31;
  if ((tmpvar_22 > -0.99)) {
    tmpvar_31 = (((_WaterColor * 2.0) / (1.0 + tmpvar_22)) * (1.0 - exp(
      (-(tmpvar_30) * tmpvar_23)
    )));
  } else {
    tmpvar_31 = ((2.0 * tmpvar_29) * (_WaterColor * tmpvar_23));
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((backgroundColor_21 * exp(
    (-(tmpvar_30) * tmpvar_23)
  )) + (tmpvar_31 * tmpvar_28));
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" "LERP_SKY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp vec3 _WaterColor;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 N_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_2.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_3.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + tmpvar_4.x);
  tmpvar_6.y = (tmpvar_4.y + tmpvar_2.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = (tmpvar_3.x + tmpvar_5.x);
  tmpvar_7.y = (tmpvar_5.y + tmpvar_3.y);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_NormalTexture1, tmpvar_6);
  mediump vec4 packednormal_9;
  packednormal_9 = tmpvar_8;
  mediump float bumpScale_10;
  bumpScale_10 = _NormalIntensity;
  mediump vec3 normal_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((packednormal_9.xyz * 2.0) - 1.0);
  normal_11.z = tmpvar_12.z;
  normal_11.xy = (tmpvar_12.xy * bumpScale_10);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture2, tmpvar_7);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  mediump vec3 tmpvar_18;
  tmpvar_18 = (normal_11 + normal_16);
  N_1 = tmpvar_18;
  highp vec3 x_19;
  x_19 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (vec3(0.0, 1.0, 0.0), normalize(N_1.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_19, x_19)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_1 = tmpvar_20;
  highp vec3 backgroundColor_21;
  highp float tmpvar_22;
  tmpvar_22 = abs(dot (normalize(
    (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
  ), tmpvar_20));
  highp float tmpvar_23;
  tmpvar_23 = ((_HeightDiff / tmpvar_22) * _DepthDiffScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * 
    (tmpvar_20.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, tmpvar_24).xyz;
  backgroundColor_21 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = _LightColor0.xyz;
  highp vec3 lightColor_27;
  lightColor_27 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = (max (0.3, dot (tmpvar_20, 
    normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)))
  )) * lightColor_27);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = max ((tmpvar_29 * (1.0 + tmpvar_22)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_31;
  if ((tmpvar_22 > -0.99)) {
    tmpvar_31 = (((_WaterColor * 2.0) / (1.0 + tmpvar_22)) * (1.0 - exp(
      (-(tmpvar_30) * tmpvar_23)
    )));
  } else {
    tmpvar_31 = ((2.0 * tmpvar_29) * (_WaterColor * tmpvar_23));
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((backgroundColor_21 * exp(
    (-(tmpvar_30) * tmpvar_23)
  )) + (tmpvar_31 * tmpvar_28));
  gl_FragData[0] = tmpvar_32;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FogIntensity;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _SpecularPower;
uniform highp float _SpecularIntensity;
uniform lowp samplerCube _WaterReflectionTexture;
uniform highp vec3 _WaterColor;
uniform highp float _Fresnel0;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp vec3 _EdgeFoamColor;
uniform highp float _EdgeFoamWidth;
uniform highp float _EdgeTransparentWidth;
uniform highp vec3 _FogCT;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 lightColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_7.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_8.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (tmpvar_7.x + tmpvar_9.x);
  tmpvar_11.y = (tmpvar_9.y + tmpvar_7.y);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (tmpvar_8.x + tmpvar_10.x);
  tmpvar_12.y = (tmpvar_10.y + tmpvar_8.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture1, tmpvar_11);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NormalTexture2, tmpvar_12);
  mediump vec4 packednormal_19;
  packednormal_19 = tmpvar_18;
  mediump float bumpScale_20;
  bumpScale_20 = _NormalIntensity;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((packednormal_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * bumpScale_20);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  N_6 = tmpvar_23;
  highp vec3 x_24;
  x_24 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.0, 1.0, 0.0), normalize(N_6.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_24, x_24)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_6 = tmpvar_25;
  highp vec3 backgroundColor_26;
  highp float tmpvar_27;
  tmpvar_27 = abs(dot (tmpvar_5, tmpvar_25));
  highp float tmpvar_28;
  tmpvar_28 = ((_HeightDiff / tmpvar_27) * _DepthDiffScale);
  highp vec2 tmpvar_29;
  tmpvar_29 = (((tmpvar_28 * 
    (tmpvar_25.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_BeforeAlphaTexture, tmpvar_29).xyz;
  backgroundColor_26 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = _LightColor0.xyz;
  highp vec3 lightColor_32;
  lightColor_32 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = (max (0.3, dot (tmpvar_25, tmpvar_4)) * lightColor_32);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_35;
  tmpvar_35 = max ((tmpvar_34 * (1.0 + tmpvar_27)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_36;
  if ((tmpvar_27 > -0.99)) {
    tmpvar_36 = (((_WaterColor * 2.0) / (1.0 + tmpvar_27)) * (1.0 - exp(
      (-(tmpvar_35) * tmpvar_28)
    )));
  } else {
    tmpvar_36 = ((2.0 * tmpvar_34) * (_WaterColor * tmpvar_28));
  };
  lowp vec3 tmpvar_37;
  tmpvar_37 = _LightColor0.xyz;
  lightColor_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (1.0 - abs(tmpvar_5.y));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_38 * tmpvar_38);
  highp float tmpvar_40;
  tmpvar_40 = ((tmpvar_38 * tmpvar_39) * tmpvar_39);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_40)
  ) + vec3(tmpvar_40)), 0.0, 1.0);
  highp vec4 reflectColor_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = -(tmpvar_5);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_25, I_44)
   * tmpvar_25)));
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_WaterReflectionTexture, tmpvar_43);
  reflectColor_42 = tmpvar_45;
  highp vec3 causticColor_46;
  highp vec4 color2_47;
  highp vec4 color1_48;
  highp float tmpvar_49;
  tmpvar_49 = ((_HeightDiff / abs(
    dot (tmpvar_25, tmpvar_5)
  )) * _DepthDiffScale);
  highp float tmpvar_50;
  tmpvar_50 = (_Time.y * _CausticDistortionSpeed);
  highp vec2 tmpvar_51;
  tmpvar_51 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (tmpvar_51 + tmpvar_50);
  tmpvar_52 = texture2D (_CausticTex, P_53);
  color1_48 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = ((tmpvar_51 * vec2(1.5, 1.5)) - tmpvar_50);
  tmpvar_54 = texture2D (_CausticTex, P_55);
  color2_47 = tmpvar_54;
  highp vec2 tmpvar_56;
  tmpvar_56 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_5 * tmpvar_49)
  ).xz) + (_CausticDistortionValue * mix (color1_48.yz, color2_47.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_CausticTex, tmpvar_56).xyz;
  causticColor_46 = tmpvar_57;
  causticColor_46 = (causticColor_46 * (_LightColor0.xyz * clamp (
    abs(dot (tmpvar_4, tmpvar_25))
  , 0.0, 1.0)));
  causticColor_46 = (causticColor_46 * (_CausticColor * _CausticIntensity));
  highp vec2 P_58;
  P_58 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_59;
  tmpvar_59 = texture2D (_BeforeAlphaTexture, P_58).xyz;
  bgColor_1 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (bgColor_1, ((
    ((((
      clamp ((_SpecularIntensity * pow (max (
        abs(dot (tmpvar_25, normalize((_ES_SunDirection + tmpvar_5))))
      , 0.0001), _Gloss)), 0.0, 16.0)
     * lightColor_3) * pow (
      max ((1.0 - abs(dot (tmpvar_5, tmpvar_25))), 0.0001)
    , _SpecularPower)) + reflectColor_42.xyz) + (_EdgeFoamColor * clamp ((xlv_COLOR.x * _EdgeFoamWidth), 0.0, 1.0)))
   * tmpvar_41) + (
    (vec3((causticColor_46.x * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_49), 0.0, 1.0)
    , 0.0001), _CausticFadePower))) + ((backgroundColor_26 * exp(
      (-(tmpvar_35) * tmpvar_28)
    )) + (tmpvar_36 * tmpvar_33)))
   * 
    (1.0 - tmpvar_41)
  )), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_61;
  srcColor_61 = tmpvar_60;
  mediump vec3 fogColor_62;
  fogColor_62 = ((xlv_COLOR1.xyz * _FogCT) * _FogIntensity);
  mediump vec3 tmpvar_63;
  tmpvar_63 = mix (srcColor_61, fogColor_62, xlv_COLOR1.www);
  finalColor_2 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64.w = 1.0;
  tmpvar_64.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_64;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FogIntensity;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _SpecularPower;
uniform highp float _SpecularIntensity;
uniform lowp samplerCube _WaterReflectionTexture;
uniform highp vec3 _WaterColor;
uniform highp float _Fresnel0;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp vec3 _EdgeFoamColor;
uniform highp float _EdgeFoamWidth;
uniform highp float _EdgeTransparentWidth;
uniform highp vec3 _FogCT;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 lightColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_7.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_8.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (tmpvar_7.x + tmpvar_9.x);
  tmpvar_11.y = (tmpvar_9.y + tmpvar_7.y);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (tmpvar_8.x + tmpvar_10.x);
  tmpvar_12.y = (tmpvar_10.y + tmpvar_8.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture1, tmpvar_11);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NormalTexture2, tmpvar_12);
  mediump vec4 packednormal_19;
  packednormal_19 = tmpvar_18;
  mediump float bumpScale_20;
  bumpScale_20 = _NormalIntensity;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((packednormal_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * bumpScale_20);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  N_6 = tmpvar_23;
  highp vec3 x_24;
  x_24 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.0, 1.0, 0.0), normalize(N_6.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_24, x_24)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_6 = tmpvar_25;
  highp vec3 backgroundColor_26;
  highp float tmpvar_27;
  tmpvar_27 = abs(dot (tmpvar_5, tmpvar_25));
  highp float tmpvar_28;
  tmpvar_28 = ((_HeightDiff / tmpvar_27) * _DepthDiffScale);
  highp vec2 tmpvar_29;
  tmpvar_29 = (((tmpvar_28 * 
    (tmpvar_25.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_BeforeAlphaTexture, tmpvar_29).xyz;
  backgroundColor_26 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = _LightColor0.xyz;
  highp vec3 lightColor_32;
  lightColor_32 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = (max (0.3, dot (tmpvar_25, tmpvar_4)) * lightColor_32);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_35;
  tmpvar_35 = max ((tmpvar_34 * (1.0 + tmpvar_27)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_36;
  if ((tmpvar_27 > -0.99)) {
    tmpvar_36 = (((_WaterColor * 2.0) / (1.0 + tmpvar_27)) * (1.0 - exp(
      (-(tmpvar_35) * tmpvar_28)
    )));
  } else {
    tmpvar_36 = ((2.0 * tmpvar_34) * (_WaterColor * tmpvar_28));
  };
  lowp vec3 tmpvar_37;
  tmpvar_37 = _LightColor0.xyz;
  lightColor_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (1.0 - abs(tmpvar_5.y));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_38 * tmpvar_38);
  highp float tmpvar_40;
  tmpvar_40 = ((tmpvar_38 * tmpvar_39) * tmpvar_39);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_40)
  ) + vec3(tmpvar_40)), 0.0, 1.0);
  highp vec4 reflectColor_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = -(tmpvar_5);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_25, I_44)
   * tmpvar_25)));
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_WaterReflectionTexture, tmpvar_43);
  reflectColor_42 = tmpvar_45;
  highp vec3 causticColor_46;
  highp vec4 color2_47;
  highp vec4 color1_48;
  highp float tmpvar_49;
  tmpvar_49 = ((_HeightDiff / abs(
    dot (tmpvar_25, tmpvar_5)
  )) * _DepthDiffScale);
  highp float tmpvar_50;
  tmpvar_50 = (_Time.y * _CausticDistortionSpeed);
  highp vec2 tmpvar_51;
  tmpvar_51 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (tmpvar_51 + tmpvar_50);
  tmpvar_52 = texture2D (_CausticTex, P_53);
  color1_48 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = ((tmpvar_51 * vec2(1.5, 1.5)) - tmpvar_50);
  tmpvar_54 = texture2D (_CausticTex, P_55);
  color2_47 = tmpvar_54;
  highp vec2 tmpvar_56;
  tmpvar_56 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_5 * tmpvar_49)
  ).xz) + (_CausticDistortionValue * mix (color1_48.yz, color2_47.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_CausticTex, tmpvar_56).xyz;
  causticColor_46 = tmpvar_57;
  causticColor_46 = (causticColor_46 * (_LightColor0.xyz * clamp (
    abs(dot (tmpvar_4, tmpvar_25))
  , 0.0, 1.0)));
  causticColor_46 = (causticColor_46 * (_CausticColor * _CausticIntensity));
  highp vec2 P_58;
  P_58 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_59;
  tmpvar_59 = texture2D (_BeforeAlphaTexture, P_58).xyz;
  bgColor_1 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (bgColor_1, ((
    ((((
      clamp ((_SpecularIntensity * pow (max (
        abs(dot (tmpvar_25, normalize((_ES_SunDirection + tmpvar_5))))
      , 0.0001), _Gloss)), 0.0, 16.0)
     * lightColor_3) * pow (
      max ((1.0 - abs(dot (tmpvar_5, tmpvar_25))), 0.0001)
    , _SpecularPower)) + reflectColor_42.xyz) + (_EdgeFoamColor * clamp ((xlv_COLOR.x * _EdgeFoamWidth), 0.0, 1.0)))
   * tmpvar_41) + (
    (vec3((causticColor_46.x * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_49), 0.0, 1.0)
    , 0.0001), _CausticFadePower))) + ((backgroundColor_26 * exp(
      (-(tmpvar_35) * tmpvar_28)
    )) + (tmpvar_36 * tmpvar_33)))
   * 
    (1.0 - tmpvar_41)
  )), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_61;
  srcColor_61 = tmpvar_60;
  mediump vec3 fogColor_62;
  fogColor_62 = ((xlv_COLOR1.xyz * _FogCT) * _FogIntensity);
  mediump vec3 tmpvar_63;
  tmpvar_63 = mix (srcColor_61, fogColor_62, xlv_COLOR1.www);
  finalColor_2 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64.w = 1.0;
  tmpvar_64.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_64;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FogIntensity;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _SpecularPower;
uniform highp float _SpecularIntensity;
uniform lowp samplerCube _WaterReflectionTexture;
uniform highp vec3 _WaterColor;
uniform highp float _Fresnel0;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp vec3 _EdgeFoamColor;
uniform highp float _EdgeFoamWidth;
uniform highp float _EdgeTransparentWidth;
uniform highp vec3 _FogCT;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 lightColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_7.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_8.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (tmpvar_7.x + tmpvar_9.x);
  tmpvar_11.y = (tmpvar_9.y + tmpvar_7.y);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (tmpvar_8.x + tmpvar_10.x);
  tmpvar_12.y = (tmpvar_10.y + tmpvar_8.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture1, tmpvar_11);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NormalTexture2, tmpvar_12);
  mediump vec4 packednormal_19;
  packednormal_19 = tmpvar_18;
  mediump float bumpScale_20;
  bumpScale_20 = _NormalIntensity;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((packednormal_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * bumpScale_20);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  N_6 = tmpvar_23;
  highp vec3 x_24;
  x_24 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.0, 1.0, 0.0), normalize(N_6.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_24, x_24)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_6 = tmpvar_25;
  highp vec3 backgroundColor_26;
  highp float tmpvar_27;
  tmpvar_27 = abs(dot (tmpvar_5, tmpvar_25));
  highp float tmpvar_28;
  tmpvar_28 = ((_HeightDiff / tmpvar_27) * _DepthDiffScale);
  highp vec2 tmpvar_29;
  tmpvar_29 = (((tmpvar_28 * 
    (tmpvar_25.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_BeforeAlphaTexture, tmpvar_29).xyz;
  backgroundColor_26 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = _LightColor0.xyz;
  highp vec3 lightColor_32;
  lightColor_32 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = (max (0.3, dot (tmpvar_25, tmpvar_4)) * lightColor_32);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_35;
  tmpvar_35 = max ((tmpvar_34 * (1.0 + tmpvar_27)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_36;
  if ((tmpvar_27 > -0.99)) {
    tmpvar_36 = (((_WaterColor * 2.0) / (1.0 + tmpvar_27)) * (1.0 - exp(
      (-(tmpvar_35) * tmpvar_28)
    )));
  } else {
    tmpvar_36 = ((2.0 * tmpvar_34) * (_WaterColor * tmpvar_28));
  };
  lowp vec3 tmpvar_37;
  tmpvar_37 = _LightColor0.xyz;
  lightColor_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (1.0 - abs(tmpvar_5.y));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_38 * tmpvar_38);
  highp float tmpvar_40;
  tmpvar_40 = ((tmpvar_38 * tmpvar_39) * tmpvar_39);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_40)
  ) + vec3(tmpvar_40)), 0.0, 1.0);
  highp vec4 reflectColor_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = -(tmpvar_5);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_25, I_44)
   * tmpvar_25)));
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_WaterReflectionTexture, tmpvar_43);
  reflectColor_42 = tmpvar_45;
  highp vec3 causticColor_46;
  highp vec4 color2_47;
  highp vec4 color1_48;
  highp float tmpvar_49;
  tmpvar_49 = ((_HeightDiff / abs(
    dot (tmpvar_25, tmpvar_5)
  )) * _DepthDiffScale);
  highp float tmpvar_50;
  tmpvar_50 = (_Time.y * _CausticDistortionSpeed);
  highp vec2 tmpvar_51;
  tmpvar_51 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (tmpvar_51 + tmpvar_50);
  tmpvar_52 = texture2D (_CausticTex, P_53);
  color1_48 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = ((tmpvar_51 * vec2(1.5, 1.5)) - tmpvar_50);
  tmpvar_54 = texture2D (_CausticTex, P_55);
  color2_47 = tmpvar_54;
  highp vec2 tmpvar_56;
  tmpvar_56 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_5 * tmpvar_49)
  ).xz) + (_CausticDistortionValue * mix (color1_48.yz, color2_47.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_CausticTex, tmpvar_56).xyz;
  causticColor_46 = tmpvar_57;
  causticColor_46 = (causticColor_46 * (_LightColor0.xyz * clamp (
    abs(dot (tmpvar_4, tmpvar_25))
  , 0.0, 1.0)));
  causticColor_46 = (causticColor_46 * (_CausticColor * _CausticIntensity));
  highp vec2 P_58;
  P_58 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_59;
  tmpvar_59 = texture2D (_BeforeAlphaTexture, P_58).xyz;
  bgColor_1 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (bgColor_1, ((
    ((((
      clamp ((_SpecularIntensity * pow (max (
        abs(dot (tmpvar_25, normalize((_ES_SunDirection + tmpvar_5))))
      , 0.0001), _Gloss)), 0.0, 16.0)
     * lightColor_3) * pow (
      max ((1.0 - abs(dot (tmpvar_5, tmpvar_25))), 0.0001)
    , _SpecularPower)) + reflectColor_42.xyz) + (_EdgeFoamColor * clamp ((xlv_COLOR.x * _EdgeFoamWidth), 0.0, 1.0)))
   * tmpvar_41) + (
    (vec3((causticColor_46.x * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_49), 0.0, 1.0)
    , 0.0001), _CausticFadePower))) + ((backgroundColor_26 * exp(
      (-(tmpvar_35) * tmpvar_28)
    )) + (tmpvar_36 * tmpvar_33)))
   * 
    (1.0 - tmpvar_41)
  )), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_61;
  srcColor_61 = tmpvar_60;
  mediump vec3 fogColor_62;
  fogColor_62 = ((xlv_COLOR1.xyz * _FogCT) * _FogIntensity);
  mediump vec3 tmpvar_63;
  tmpvar_63 = mix (srcColor_61, fogColor_62, xlv_COLOR1.www);
  finalColor_2 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64.w = 1.0;
  tmpvar_64.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_64;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FogIntensity;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _SpecularPower;
uniform highp float _SpecularIntensity;
uniform lowp samplerCube _WaterReflectionTexture;
uniform highp vec3 _WaterColor;
uniform highp float _Fresnel0;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp vec3 _EdgeFoamColor;
uniform highp float _EdgeFoamWidth;
uniform highp float _EdgeTransparentWidth;
uniform highp vec3 _FogCT;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 lightColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_7.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_8.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (tmpvar_7.x + tmpvar_9.x);
  tmpvar_11.y = (tmpvar_9.y + tmpvar_7.y);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (tmpvar_8.x + tmpvar_10.x);
  tmpvar_12.y = (tmpvar_10.y + tmpvar_8.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture1, tmpvar_11);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NormalTexture2, tmpvar_12);
  mediump vec4 packednormal_19;
  packednormal_19 = tmpvar_18;
  mediump float bumpScale_20;
  bumpScale_20 = _NormalIntensity;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((packednormal_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * bumpScale_20);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  N_6 = tmpvar_23;
  highp vec3 x_24;
  x_24 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.0, 1.0, 0.0), normalize(N_6.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_24, x_24)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_6 = tmpvar_25;
  highp vec3 backgroundColor_26;
  highp float tmpvar_27;
  tmpvar_27 = abs(dot (tmpvar_5, tmpvar_25));
  highp float tmpvar_28;
  tmpvar_28 = ((_HeightDiff / tmpvar_27) * _DepthDiffScale);
  highp vec2 tmpvar_29;
  tmpvar_29 = (((tmpvar_28 * 
    (tmpvar_25.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_BeforeAlphaTexture, tmpvar_29).xyz;
  backgroundColor_26 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = _LightColor0.xyz;
  highp vec3 lightColor_32;
  lightColor_32 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = (max (0.3, dot (tmpvar_25, tmpvar_4)) * lightColor_32);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_35;
  tmpvar_35 = max ((tmpvar_34 * (1.0 + tmpvar_27)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_36;
  if ((tmpvar_27 > -0.99)) {
    tmpvar_36 = (((_WaterColor * 2.0) / (1.0 + tmpvar_27)) * (1.0 - exp(
      (-(tmpvar_35) * tmpvar_28)
    )));
  } else {
    tmpvar_36 = ((2.0 * tmpvar_34) * (_WaterColor * tmpvar_28));
  };
  lowp vec3 tmpvar_37;
  tmpvar_37 = _LightColor0.xyz;
  lightColor_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (1.0 - abs(tmpvar_5.y));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_38 * tmpvar_38);
  highp float tmpvar_40;
  tmpvar_40 = ((tmpvar_38 * tmpvar_39) * tmpvar_39);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_40)
  ) + vec3(tmpvar_40)), 0.0, 1.0);
  highp vec4 reflectColor_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = -(tmpvar_5);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_25, I_44)
   * tmpvar_25)));
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_WaterReflectionTexture, tmpvar_43);
  reflectColor_42 = tmpvar_45;
  highp vec3 causticColor_46;
  highp vec4 color2_47;
  highp vec4 color1_48;
  highp float tmpvar_49;
  tmpvar_49 = ((_HeightDiff / abs(
    dot (tmpvar_25, tmpvar_5)
  )) * _DepthDiffScale);
  highp float tmpvar_50;
  tmpvar_50 = (_Time.y * _CausticDistortionSpeed);
  highp vec2 tmpvar_51;
  tmpvar_51 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (tmpvar_51 + tmpvar_50);
  tmpvar_52 = texture2D (_CausticTex, P_53);
  color1_48 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = ((tmpvar_51 * vec2(1.5, 1.5)) - tmpvar_50);
  tmpvar_54 = texture2D (_CausticTex, P_55);
  color2_47 = tmpvar_54;
  highp vec2 tmpvar_56;
  tmpvar_56 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_5 * tmpvar_49)
  ).xz) + (_CausticDistortionValue * mix (color1_48.yz, color2_47.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_CausticTex, tmpvar_56).xyz;
  causticColor_46 = tmpvar_57;
  causticColor_46 = (causticColor_46 * (_LightColor0.xyz * clamp (
    abs(dot (tmpvar_4, tmpvar_25))
  , 0.0, 1.0)));
  causticColor_46 = (causticColor_46 * (_CausticColor * _CausticIntensity));
  highp vec2 P_58;
  P_58 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_59;
  tmpvar_59 = texture2D (_BeforeAlphaTexture, P_58).xyz;
  bgColor_1 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (bgColor_1, ((
    ((((
      clamp ((_SpecularIntensity * pow (max (
        abs(dot (tmpvar_25, normalize((_ES_SunDirection + tmpvar_5))))
      , 0.0001), _Gloss)), 0.0, 16.0)
     * lightColor_3) * pow (
      max ((1.0 - abs(dot (tmpvar_5, tmpvar_25))), 0.0001)
    , _SpecularPower)) + reflectColor_42.xyz) + (_EdgeFoamColor * clamp ((xlv_COLOR.x * _EdgeFoamWidth), 0.0, 1.0)))
   * tmpvar_41) + (
    (vec3((causticColor_46.x * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_49), 0.0, 1.0)
    , 0.0001), _CausticFadePower))) + ((backgroundColor_26 * exp(
      (-(tmpvar_35) * tmpvar_28)
    )) + (tmpvar_36 * tmpvar_33)))
   * 
    (1.0 - tmpvar_41)
  )), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_61;
  srcColor_61 = tmpvar_60;
  mediump vec3 fogColor_62;
  fogColor_62 = ((xlv_COLOR1.xyz * _FogCT) * _FogIntensity);
  mediump vec3 tmpvar_63;
  tmpvar_63 = mix (srcColor_61, fogColor_62, xlv_COLOR1.www);
  finalColor_2 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64.w = 1.0;
  tmpvar_64.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_64;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FogIntensity;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _SpecularPower;
uniform highp float _SpecularIntensity;
uniform lowp samplerCube _WaterReflectionTexture;
uniform highp vec3 _WaterColor;
uniform highp float _Fresnel0;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp vec3 _EdgeFoamColor;
uniform highp float _EdgeFoamWidth;
uniform highp float _EdgeTransparentWidth;
uniform highp vec3 _FogCT;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 lightColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_7.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_8.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (tmpvar_7.x + tmpvar_9.x);
  tmpvar_11.y = (tmpvar_9.y + tmpvar_7.y);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (tmpvar_8.x + tmpvar_10.x);
  tmpvar_12.y = (tmpvar_10.y + tmpvar_8.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture1, tmpvar_11);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NormalTexture2, tmpvar_12);
  mediump vec4 packednormal_19;
  packednormal_19 = tmpvar_18;
  mediump float bumpScale_20;
  bumpScale_20 = _NormalIntensity;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((packednormal_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * bumpScale_20);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  N_6 = tmpvar_23;
  highp vec3 x_24;
  x_24 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.0, 1.0, 0.0), normalize(N_6.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_24, x_24)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_6 = tmpvar_25;
  highp vec3 backgroundColor_26;
  highp float tmpvar_27;
  tmpvar_27 = abs(dot (tmpvar_5, tmpvar_25));
  highp float tmpvar_28;
  tmpvar_28 = ((_HeightDiff / tmpvar_27) * _DepthDiffScale);
  highp vec2 tmpvar_29;
  tmpvar_29 = (((tmpvar_28 * 
    (tmpvar_25.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_BeforeAlphaTexture, tmpvar_29).xyz;
  backgroundColor_26 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = _LightColor0.xyz;
  highp vec3 lightColor_32;
  lightColor_32 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = (max (0.3, dot (tmpvar_25, tmpvar_4)) * lightColor_32);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_35;
  tmpvar_35 = max ((tmpvar_34 * (1.0 + tmpvar_27)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_36;
  if ((tmpvar_27 > -0.99)) {
    tmpvar_36 = (((_WaterColor * 2.0) / (1.0 + tmpvar_27)) * (1.0 - exp(
      (-(tmpvar_35) * tmpvar_28)
    )));
  } else {
    tmpvar_36 = ((2.0 * tmpvar_34) * (_WaterColor * tmpvar_28));
  };
  lowp vec3 tmpvar_37;
  tmpvar_37 = _LightColor0.xyz;
  lightColor_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (1.0 - abs(tmpvar_5.y));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_38 * tmpvar_38);
  highp float tmpvar_40;
  tmpvar_40 = ((tmpvar_38 * tmpvar_39) * tmpvar_39);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_40)
  ) + vec3(tmpvar_40)), 0.0, 1.0);
  highp vec4 reflectColor_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = -(tmpvar_5);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_25, I_44)
   * tmpvar_25)));
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_WaterReflectionTexture, tmpvar_43);
  reflectColor_42 = tmpvar_45;
  highp vec3 causticColor_46;
  highp vec4 color2_47;
  highp vec4 color1_48;
  highp float tmpvar_49;
  tmpvar_49 = ((_HeightDiff / abs(
    dot (tmpvar_25, tmpvar_5)
  )) * _DepthDiffScale);
  highp float tmpvar_50;
  tmpvar_50 = (_Time.y * _CausticDistortionSpeed);
  highp vec2 tmpvar_51;
  tmpvar_51 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (tmpvar_51 + tmpvar_50);
  tmpvar_52 = texture2D (_CausticTex, P_53);
  color1_48 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = ((tmpvar_51 * vec2(1.5, 1.5)) - tmpvar_50);
  tmpvar_54 = texture2D (_CausticTex, P_55);
  color2_47 = tmpvar_54;
  highp vec2 tmpvar_56;
  tmpvar_56 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_5 * tmpvar_49)
  ).xz) + (_CausticDistortionValue * mix (color1_48.yz, color2_47.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_CausticTex, tmpvar_56).xyz;
  causticColor_46 = tmpvar_57;
  causticColor_46 = (causticColor_46 * (_LightColor0.xyz * clamp (
    abs(dot (tmpvar_4, tmpvar_25))
  , 0.0, 1.0)));
  causticColor_46 = (causticColor_46 * (_CausticColor * _CausticIntensity));
  highp vec2 P_58;
  P_58 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_59;
  tmpvar_59 = texture2D (_BeforeAlphaTexture, P_58).xyz;
  bgColor_1 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (bgColor_1, ((
    ((((
      clamp ((_SpecularIntensity * pow (max (
        abs(dot (tmpvar_25, normalize((_ES_SunDirection + tmpvar_5))))
      , 0.0001), _Gloss)), 0.0, 16.0)
     * lightColor_3) * pow (
      max ((1.0 - abs(dot (tmpvar_5, tmpvar_25))), 0.0001)
    , _SpecularPower)) + reflectColor_42.xyz) + (_EdgeFoamColor * clamp ((xlv_COLOR.x * _EdgeFoamWidth), 0.0, 1.0)))
   * tmpvar_41) + (
    (vec3((causticColor_46.x * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_49), 0.0, 1.0)
    , 0.0001), _CausticFadePower))) + ((backgroundColor_26 * exp(
      (-(tmpvar_35) * tmpvar_28)
    )) + (tmpvar_36 * tmpvar_33)))
   * 
    (1.0 - tmpvar_41)
  )), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_61;
  srcColor_61 = tmpvar_60;
  mediump vec3 fogColor_62;
  fogColor_62 = ((xlv_COLOR1.xyz * _FogCT) * _FogIntensity);
  mediump vec3 tmpvar_63;
  tmpvar_63 = mix (srcColor_61, fogColor_62, xlv_COLOR1.www);
  finalColor_2 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64.w = 1.0;
  tmpvar_64.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_64;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _FogIntensity;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _SpecularPower;
uniform highp float _SpecularIntensity;
uniform lowp samplerCube _WaterReflectionTexture;
uniform highp vec3 _WaterColor;
uniform highp float _Fresnel0;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp vec3 _EdgeFoamColor;
uniform highp float _EdgeFoamWidth;
uniform highp float _EdgeTransparentWidth;
uniform highp vec3 _FogCT;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 lightColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_7.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_8.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = (tmpvar_7.x + tmpvar_9.x);
  tmpvar_11.y = (tmpvar_9.y + tmpvar_7.y);
  highp vec2 tmpvar_12;
  tmpvar_12.x = (tmpvar_8.x + tmpvar_10.x);
  tmpvar_12.y = (tmpvar_10.y + tmpvar_8.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture1, tmpvar_11);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_NormalTexture2, tmpvar_12);
  mediump vec4 packednormal_19;
  packednormal_19 = tmpvar_18;
  mediump float bumpScale_20;
  bumpScale_20 = _NormalIntensity;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((packednormal_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * bumpScale_20);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  N_6 = tmpvar_23;
  highp vec3 x_24;
  x_24 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.0, 1.0, 0.0), normalize(N_6.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_24, x_24)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_6 = tmpvar_25;
  highp vec3 backgroundColor_26;
  highp float tmpvar_27;
  tmpvar_27 = abs(dot (tmpvar_5, tmpvar_25));
  highp float tmpvar_28;
  tmpvar_28 = ((_HeightDiff / tmpvar_27) * _DepthDiffScale);
  highp vec2 tmpvar_29;
  tmpvar_29 = (((tmpvar_28 * 
    (tmpvar_25.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_BeforeAlphaTexture, tmpvar_29).xyz;
  backgroundColor_26 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = _LightColor0.xyz;
  highp vec3 lightColor_32;
  lightColor_32 = tmpvar_31;
  highp vec3 tmpvar_33;
  tmpvar_33 = (max (0.3, dot (tmpvar_25, tmpvar_4)) * lightColor_32);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_35;
  tmpvar_35 = max ((tmpvar_34 * (1.0 + tmpvar_27)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_36;
  if ((tmpvar_27 > -0.99)) {
    tmpvar_36 = (((_WaterColor * 2.0) / (1.0 + tmpvar_27)) * (1.0 - exp(
      (-(tmpvar_35) * tmpvar_28)
    )));
  } else {
    tmpvar_36 = ((2.0 * tmpvar_34) * (_WaterColor * tmpvar_28));
  };
  lowp vec3 tmpvar_37;
  tmpvar_37 = _LightColor0.xyz;
  lightColor_3 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (1.0 - abs(tmpvar_5.y));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_38 * tmpvar_38);
  highp float tmpvar_40;
  tmpvar_40 = ((tmpvar_38 * tmpvar_39) * tmpvar_39);
  highp vec3 tmpvar_41;
  tmpvar_41 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_40)
  ) + vec3(tmpvar_40)), 0.0, 1.0);
  highp vec4 reflectColor_42;
  highp vec3 tmpvar_43;
  highp vec3 I_44;
  I_44 = -(tmpvar_5);
  tmpvar_43 = (I_44 - (2.0 * (
    dot (tmpvar_25, I_44)
   * tmpvar_25)));
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureCube (_WaterReflectionTexture, tmpvar_43);
  reflectColor_42 = tmpvar_45;
  highp vec3 causticColor_46;
  highp vec4 color2_47;
  highp vec4 color1_48;
  highp float tmpvar_49;
  tmpvar_49 = ((_HeightDiff / abs(
    dot (tmpvar_25, tmpvar_5)
  )) * _DepthDiffScale);
  highp float tmpvar_50;
  tmpvar_50 = (_Time.y * _CausticDistortionSpeed);
  highp vec2 tmpvar_51;
  tmpvar_51 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (tmpvar_51 + tmpvar_50);
  tmpvar_52 = texture2D (_CausticTex, P_53);
  color1_48 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = ((tmpvar_51 * vec2(1.5, 1.5)) - tmpvar_50);
  tmpvar_54 = texture2D (_CausticTex, P_55);
  color2_47 = tmpvar_54;
  highp vec2 tmpvar_56;
  tmpvar_56 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_5 * tmpvar_49)
  ).xz) + (_CausticDistortionValue * mix (color1_48.yz, color2_47.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_CausticTex, tmpvar_56).xyz;
  causticColor_46 = tmpvar_57;
  causticColor_46 = (causticColor_46 * (_LightColor0.xyz * clamp (
    abs(dot (tmpvar_4, tmpvar_25))
  , 0.0, 1.0)));
  causticColor_46 = (causticColor_46 * (_CausticColor * _CausticIntensity));
  highp vec2 P_58;
  P_58 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_59;
  tmpvar_59 = texture2D (_BeforeAlphaTexture, P_58).xyz;
  bgColor_1 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (bgColor_1, ((
    ((((
      clamp ((_SpecularIntensity * pow (max (
        abs(dot (tmpvar_25, normalize((_ES_SunDirection + tmpvar_5))))
      , 0.0001), _Gloss)), 0.0, 16.0)
     * lightColor_3) * pow (
      max ((1.0 - abs(dot (tmpvar_5, tmpvar_25))), 0.0001)
    , _SpecularPower)) + reflectColor_42.xyz) + (_EdgeFoamColor * clamp ((xlv_COLOR.x * _EdgeFoamWidth), 0.0, 1.0)))
   * tmpvar_41) + (
    (vec3((causticColor_46.x * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_49), 0.0, 1.0)
    , 0.0001), _CausticFadePower))) + ((backgroundColor_26 * exp(
      (-(tmpvar_35) * tmpvar_28)
    )) + (tmpvar_36 * tmpvar_33)))
   * 
    (1.0 - tmpvar_41)
  )), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_61;
  srcColor_61 = tmpvar_60;
  mediump vec3 fogColor_62;
  fogColor_62 = ((xlv_COLOR1.xyz * _FogCT) * _FogIntensity);
  mediump vec3 tmpvar_63;
  tmpvar_63 = mix (srcColor_61, fogColor_62, xlv_COLOR1.www);
  finalColor_2 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64.w = 1.0;
  tmpvar_64.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_64;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "LERP_SKY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp vec3 _WaterColor;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 N_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_2.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_3.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + tmpvar_4.x);
  tmpvar_6.y = (tmpvar_4.y + tmpvar_2.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = (tmpvar_3.x + tmpvar_5.x);
  tmpvar_7.y = (tmpvar_5.y + tmpvar_3.y);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_NormalTexture1, tmpvar_6);
  mediump vec4 packednormal_9;
  packednormal_9 = tmpvar_8;
  mediump float bumpScale_10;
  bumpScale_10 = _NormalIntensity;
  mediump vec3 normal_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((packednormal_9.xyz * 2.0) - 1.0);
  normal_11.z = tmpvar_12.z;
  normal_11.xy = (tmpvar_12.xy * bumpScale_10);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture2, tmpvar_7);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  mediump vec3 tmpvar_18;
  tmpvar_18 = (normal_11 + normal_16);
  N_1 = tmpvar_18;
  highp vec3 x_19;
  x_19 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (vec3(0.0, 1.0, 0.0), normalize(N_1.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_19, x_19)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_1 = tmpvar_20;
  highp vec3 backgroundColor_21;
  highp float tmpvar_22;
  tmpvar_22 = abs(dot (normalize(
    (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
  ), tmpvar_20));
  highp float tmpvar_23;
  tmpvar_23 = ((_HeightDiff / tmpvar_22) * _DepthDiffScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * 
    (tmpvar_20.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, tmpvar_24).xyz;
  backgroundColor_21 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = _LightColor0.xyz;
  highp vec3 lightColor_27;
  lightColor_27 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = (max (0.3, dot (tmpvar_20, 
    normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)))
  )) * lightColor_27);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = max ((tmpvar_29 * (1.0 + tmpvar_22)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_31;
  if ((tmpvar_22 > -0.99)) {
    tmpvar_31 = (((_WaterColor * 2.0) / (1.0 + tmpvar_22)) * (1.0 - exp(
      (-(tmpvar_30) * tmpvar_23)
    )));
  } else {
    tmpvar_31 = ((2.0 * tmpvar_29) * (_WaterColor * tmpvar_23));
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((backgroundColor_21 * exp(
    (-(tmpvar_30) * tmpvar_23)
  )) + (tmpvar_31 * tmpvar_28));
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "LERP_SKY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp vec3 _WaterColor;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 N_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_2.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_3.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + tmpvar_4.x);
  tmpvar_6.y = (tmpvar_4.y + tmpvar_2.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = (tmpvar_3.x + tmpvar_5.x);
  tmpvar_7.y = (tmpvar_5.y + tmpvar_3.y);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_NormalTexture1, tmpvar_6);
  mediump vec4 packednormal_9;
  packednormal_9 = tmpvar_8;
  mediump float bumpScale_10;
  bumpScale_10 = _NormalIntensity;
  mediump vec3 normal_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((packednormal_9.xyz * 2.0) - 1.0);
  normal_11.z = tmpvar_12.z;
  normal_11.xy = (tmpvar_12.xy * bumpScale_10);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture2, tmpvar_7);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  mediump vec3 tmpvar_18;
  tmpvar_18 = (normal_11 + normal_16);
  N_1 = tmpvar_18;
  highp vec3 x_19;
  x_19 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (vec3(0.0, 1.0, 0.0), normalize(N_1.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_19, x_19)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_1 = tmpvar_20;
  highp vec3 backgroundColor_21;
  highp float tmpvar_22;
  tmpvar_22 = abs(dot (normalize(
    (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
  ), tmpvar_20));
  highp float tmpvar_23;
  tmpvar_23 = ((_HeightDiff / tmpvar_22) * _DepthDiffScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * 
    (tmpvar_20.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, tmpvar_24).xyz;
  backgroundColor_21 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = _LightColor0.xyz;
  highp vec3 lightColor_27;
  lightColor_27 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = (max (0.3, dot (tmpvar_20, 
    normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)))
  )) * lightColor_27);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = max ((tmpvar_29 * (1.0 + tmpvar_22)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_31;
  if ((tmpvar_22 > -0.99)) {
    tmpvar_31 = (((_WaterColor * 2.0) / (1.0 + tmpvar_22)) * (1.0 - exp(
      (-(tmpvar_30) * tmpvar_23)
    )));
  } else {
    tmpvar_31 = ((2.0 * tmpvar_29) * (_WaterColor * tmpvar_23));
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((backgroundColor_21 * exp(
    (-(tmpvar_30) * tmpvar_23)
  )) + (tmpvar_31 * tmpvar_28));
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "LERP_SKY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp vec3 _WaterColor;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 N_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_2.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_3.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + tmpvar_4.x);
  tmpvar_6.y = (tmpvar_4.y + tmpvar_2.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = (tmpvar_3.x + tmpvar_5.x);
  tmpvar_7.y = (tmpvar_5.y + tmpvar_3.y);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_NormalTexture1, tmpvar_6);
  mediump vec4 packednormal_9;
  packednormal_9 = tmpvar_8;
  mediump float bumpScale_10;
  bumpScale_10 = _NormalIntensity;
  mediump vec3 normal_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((packednormal_9.xyz * 2.0) - 1.0);
  normal_11.z = tmpvar_12.z;
  normal_11.xy = (tmpvar_12.xy * bumpScale_10);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture2, tmpvar_7);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  mediump vec3 tmpvar_18;
  tmpvar_18 = (normal_11 + normal_16);
  N_1 = tmpvar_18;
  highp vec3 x_19;
  x_19 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (vec3(0.0, 1.0, 0.0), normalize(N_1.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_19, x_19)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_1 = tmpvar_20;
  highp vec3 backgroundColor_21;
  highp float tmpvar_22;
  tmpvar_22 = abs(dot (normalize(
    (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
  ), tmpvar_20));
  highp float tmpvar_23;
  tmpvar_23 = ((_HeightDiff / tmpvar_22) * _DepthDiffScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * 
    (tmpvar_20.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, tmpvar_24).xyz;
  backgroundColor_21 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = _LightColor0.xyz;
  highp vec3 lightColor_27;
  lightColor_27 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = (max (0.3, dot (tmpvar_20, 
    normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)))
  )) * lightColor_27);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = max ((tmpvar_29 * (1.0 + tmpvar_22)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_31;
  if ((tmpvar_22 > -0.99)) {
    tmpvar_31 = (((_WaterColor * 2.0) / (1.0 + tmpvar_22)) * (1.0 - exp(
      (-(tmpvar_30) * tmpvar_23)
    )));
  } else {
    tmpvar_31 = ((2.0 * tmpvar_29) * (_WaterColor * tmpvar_23));
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((backgroundColor_21 * exp(
    (-(tmpvar_30) * tmpvar_23)
  )) + (tmpvar_31 * tmpvar_28));
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp vec3 _WaterColor;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 N_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_2.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_3.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + tmpvar_4.x);
  tmpvar_6.y = (tmpvar_4.y + tmpvar_2.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = (tmpvar_3.x + tmpvar_5.x);
  tmpvar_7.y = (tmpvar_5.y + tmpvar_3.y);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_NormalTexture1, tmpvar_6);
  mediump vec4 packednormal_9;
  packednormal_9 = tmpvar_8;
  mediump float bumpScale_10;
  bumpScale_10 = _NormalIntensity;
  mediump vec3 normal_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((packednormal_9.xyz * 2.0) - 1.0);
  normal_11.z = tmpvar_12.z;
  normal_11.xy = (tmpvar_12.xy * bumpScale_10);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture2, tmpvar_7);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  mediump vec3 tmpvar_18;
  tmpvar_18 = (normal_11 + normal_16);
  N_1 = tmpvar_18;
  highp vec3 x_19;
  x_19 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (vec3(0.0, 1.0, 0.0), normalize(N_1.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_19, x_19)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_1 = tmpvar_20;
  highp vec3 backgroundColor_21;
  highp float tmpvar_22;
  tmpvar_22 = abs(dot (normalize(
    (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
  ), tmpvar_20));
  highp float tmpvar_23;
  tmpvar_23 = ((_HeightDiff / tmpvar_22) * _DepthDiffScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * 
    (tmpvar_20.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, tmpvar_24).xyz;
  backgroundColor_21 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = _LightColor0.xyz;
  highp vec3 lightColor_27;
  lightColor_27 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = (max (0.3, dot (tmpvar_20, 
    normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)))
  )) * lightColor_27);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = max ((tmpvar_29 * (1.0 + tmpvar_22)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_31;
  if ((tmpvar_22 > -0.99)) {
    tmpvar_31 = (((_WaterColor * 2.0) / (1.0 + tmpvar_22)) * (1.0 - exp(
      (-(tmpvar_30) * tmpvar_23)
    )));
  } else {
    tmpvar_31 = ((2.0 * tmpvar_29) * (_WaterColor * tmpvar_23));
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((backgroundColor_21 * exp(
    (-(tmpvar_30) * tmpvar_23)
  )) + (tmpvar_31 * tmpvar_28));
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp vec3 _WaterColor;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 N_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_2.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_3.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + tmpvar_4.x);
  tmpvar_6.y = (tmpvar_4.y + tmpvar_2.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = (tmpvar_3.x + tmpvar_5.x);
  tmpvar_7.y = (tmpvar_5.y + tmpvar_3.y);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_NormalTexture1, tmpvar_6);
  mediump vec4 packednormal_9;
  packednormal_9 = tmpvar_8;
  mediump float bumpScale_10;
  bumpScale_10 = _NormalIntensity;
  mediump vec3 normal_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((packednormal_9.xyz * 2.0) - 1.0);
  normal_11.z = tmpvar_12.z;
  normal_11.xy = (tmpvar_12.xy * bumpScale_10);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture2, tmpvar_7);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  mediump vec3 tmpvar_18;
  tmpvar_18 = (normal_11 + normal_16);
  N_1 = tmpvar_18;
  highp vec3 x_19;
  x_19 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (vec3(0.0, 1.0, 0.0), normalize(N_1.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_19, x_19)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_1 = tmpvar_20;
  highp vec3 backgroundColor_21;
  highp float tmpvar_22;
  tmpvar_22 = abs(dot (normalize(
    (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
  ), tmpvar_20));
  highp float tmpvar_23;
  tmpvar_23 = ((_HeightDiff / tmpvar_22) * _DepthDiffScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * 
    (tmpvar_20.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, tmpvar_24).xyz;
  backgroundColor_21 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = _LightColor0.xyz;
  highp vec3 lightColor_27;
  lightColor_27 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = (max (0.3, dot (tmpvar_20, 
    normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)))
  )) * lightColor_27);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = max ((tmpvar_29 * (1.0 + tmpvar_22)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_31;
  if ((tmpvar_22 > -0.99)) {
    tmpvar_31 = (((_WaterColor * 2.0) / (1.0 + tmpvar_22)) * (1.0 - exp(
      (-(tmpvar_30) * tmpvar_23)
    )));
  } else {
    tmpvar_31 = ((2.0 * tmpvar_29) * (_WaterColor * tmpvar_23));
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((backgroundColor_21 * exp(
    (-(tmpvar_30) * tmpvar_23)
  )) + (tmpvar_31 * tmpvar_28));
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_10.zw;
  tmpvar_5.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_4.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_8.xyz = tmpvar_19;
  tmpvar_9.xyz = (((tmpvar_16.yzx * tmpvar_19.zxy) - (tmpvar_16.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_20));
  tmpvar_3 = _glesColor.xyz;
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_24)
      ) * (_FogIntensity * tmpvar_24))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_31;
    tmpvar_31 = (_FogEndDistance - _FogStartDistance);
    tmpvar_30 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_29) / max (0.1, tmpvar_31))
    , 0.0, 1.0))));
    fogColor_27.xyz = tmpvar_32;
    fogColor_27.w = tmpvar_30;
    tmpvar_21 = fogColor_27;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = o_12;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = tmpvar_9;
  xlv_COLOR1 = tmpvar_21;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _NormalTexture1;
uniform sampler2D _NormalTexture2;
uniform highp vec4 _NormalTexture1_ST;
uniform highp vec4 _NormalTexture2_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalSpeedU_1;
uniform highp float _NormalSpeedV_1;
uniform highp float _NormalSpeedU_2;
uniform highp float _NormalSpeedV_2;
uniform highp float _NormalCoverageMax;
uniform highp float _NormalCoverageMin;
uniform highp vec3 _ES_SunDirection;
uniform highp vec3 _WaterColor;
uniform highp float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DepthDiffScale;
uniform highp float _DistortionFactor;
uniform highp float _HeightDiff;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 N_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_2.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_3.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_2.x + tmpvar_4.x);
  tmpvar_6.y = (tmpvar_4.y + tmpvar_2.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = (tmpvar_3.x + tmpvar_5.x);
  tmpvar_7.y = (tmpvar_5.y + tmpvar_3.y);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_NormalTexture1, tmpvar_6);
  mediump vec4 packednormal_9;
  packednormal_9 = tmpvar_8;
  mediump float bumpScale_10;
  bumpScale_10 = _NormalIntensity;
  mediump vec3 normal_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((packednormal_9.xyz * 2.0) - 1.0);
  normal_11.z = tmpvar_12.z;
  normal_11.xy = (tmpvar_12.xy * bumpScale_10);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NormalTexture2, tmpvar_7);
  mediump vec4 packednormal_14;
  packednormal_14 = tmpvar_13;
  mediump float bumpScale_15;
  bumpScale_15 = _NormalIntensity;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((packednormal_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * bumpScale_15);
  mediump vec3 tmpvar_18;
  tmpvar_18 = (normal_11 + normal_16);
  N_1 = tmpvar_18;
  highp vec3 x_19;
  x_19 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (vec3(0.0, 1.0, 0.0), normalize(N_1.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_19, x_19)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_1 = tmpvar_20;
  highp vec3 backgroundColor_21;
  highp float tmpvar_22;
  tmpvar_22 = abs(dot (normalize(
    (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
  ), tmpvar_20));
  highp float tmpvar_23;
  tmpvar_23 = ((_HeightDiff / tmpvar_22) * _DepthDiffScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * 
    (tmpvar_20.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, tmpvar_24).xyz;
  backgroundColor_21 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = _LightColor0.xyz;
  highp vec3 lightColor_27;
  lightColor_27 = tmpvar_26;
  highp vec3 tmpvar_28;
  tmpvar_28 = (max (0.3, dot (tmpvar_20, 
    normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)))
  )) * lightColor_27);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_30;
  tmpvar_30 = max ((tmpvar_29 * (1.0 + tmpvar_22)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_31;
  if ((tmpvar_22 > -0.99)) {
    tmpvar_31 = (((_WaterColor * 2.0) / (1.0 + tmpvar_22)) * (1.0 - exp(
      (-(tmpvar_30) * tmpvar_23)
    )));
  } else {
    tmpvar_31 = ((2.0 * tmpvar_29) * (_WaterColor * tmpvar_23));
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((backgroundColor_21 * exp(
    (-(tmpvar_30) * tmpvar_23)
  )) + (tmpvar_31 * tmpvar_28));
  gl_FragData[0] = tmpvar_32;
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
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_SKY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_SKY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_SKY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "LERP_SKY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "LERP_SKY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "LERP_SKY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" "LERP_SKY" }
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
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "LERP_SKY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "LERP_SKY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "LERP_SKY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "LERP_SKY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "LERP_SKY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "LERP_SKY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" "LERP_SKY" }
""
}
}
}
}
}