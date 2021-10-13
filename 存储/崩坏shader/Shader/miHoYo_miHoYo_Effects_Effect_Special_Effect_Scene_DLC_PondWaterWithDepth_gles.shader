//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/Scene_DLC_PondWaterWithDepth" {
Properties {
[Header(Normal)] _NormalTexture1 ("Normal 1", 2D) = "white" { }
_NormalTexture2 ("Normal 2", 2D) = "bump" { }
_NormalSpeedU_1 ("Normal SpeedU 1", Float) = 0
_NormalSpeedV_1 ("Normal SpeedV 1", Float) = 0
_NormalSpeedU_2 ("Normal SpeedU 2", Float) = 0
_NormalSpeedV_2 ("Normal SpeedV 2", Float) = 0
_NormalIntensity ("Normal Intensity", Float) = 1
_NormalCoverageMin ("NormalCoverageMin", Range(0, 20)) = 2
_NormalCoverageMax ("NormalCoverageMax", Range(0, 50)) = 10
[Header(Reflection)] _Fresnel0 ("F0", Range(0, 1)) = 0.04
_Gloss ("Gloss", Range(0, 10)) = 1
_SpecularPower ("SpecularPower", Range(0, 1)) = 1
_SpecularIntensity ("SpecularIntensity", Float) = 1
_WaterReflectionTexture ("WaterReflectionTexture", Cube) = "white" { }
[Header(Refraction)] _WaterColor ("Water Color", Color) = (0.4,0.2,0.1,1)
_Opacity ("Opacity", Range(0, 1)) = 0.01
_DistortionFactor ("Distortion Factor", Range(0, 1)) = 1
_DepthDiffScale ("DepthDiff Scale", Range(0, 2)) = 1
_HeightDiff ("HeightDiff", Range(-20, 20)) = 1.3
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
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 33896
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
uniform highp vec4 _ZBufferParams;
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
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DistortionFactor;
uniform highp float _DepthDiffScale;
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
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 refractionLighting_3;
  highp vec3 reflectionLighting_4;
  highp vec3 lightColor_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_9.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_10.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (tmpvar_9.x + tmpvar_11.x);
  tmpvar_13.y = (tmpvar_11.y + tmpvar_9.y);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_10.x + tmpvar_12.x);
  tmpvar_14.y = (tmpvar_12.y + tmpvar_10.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_NormalTexture1, tmpvar_13);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump float bumpScale_17;
  bumpScale_17 = _NormalIntensity;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * bumpScale_17);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NormalTexture2, tmpvar_14);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _NormalIntensity;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  mediump vec3 tmpvar_25;
  tmpvar_25 = (normal_18 + normal_23);
  N_8 = tmpvar_25;
  highp vec3 x_26;
  x_26 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (vec3(0.0, 1.0, 0.0), normalize(N_8.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_26, x_26)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_8 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = _LightColor0.xyz;
  lightColor_5 = tmpvar_28;
  refractionLighting_3 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  tmpvar_29 = texture2D (_CustomDepthTexture, tmpvar_30);
  highp float z_31;
  z_31 = tmpvar_29.x;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_31)
   + _ZBufferParams.w))) - (1.0/((
    (_ZBufferParams.z * (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))
   + _ZBufferParams.w))));
  highp float tmpvar_33;
  tmpvar_33 = (1.0 - abs(tmpvar_7.y));
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_33 * tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = ((tmpvar_33 * tmpvar_34) * tmpvar_34);
  highp vec3 tmpvar_36;
  tmpvar_36 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_35)
  ) + vec3(tmpvar_35)), 0.0, 1.0);
  highp vec4 reflectColor_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = -(tmpvar_7);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (tmpvar_27, I_39)
   * tmpvar_27)));
  lowp vec4 tmpvar_40;
  tmpvar_40 = textureCube (_WaterReflectionTexture, tmpvar_38);
  reflectColor_37 = tmpvar_40;
  reflectionLighting_4 = (((
    (clamp ((_SpecularIntensity * pow (
      max (abs(dot (tmpvar_27, normalize(
        (_ES_SunDirection + tmpvar_7)
      ))), 0.0001)
    , _Gloss)), 0.0, 16.0) * lightColor_5)
   * 
    pow (max ((1.0 - abs(
      dot (tmpvar_7, tmpvar_27)
    )), 0.0001), _SpecularPower)
  ) + reflectColor_37.xyz) + (_EdgeFoamColor * clamp (
    (xlv_COLOR.x * _EdgeFoamWidth)
  , 0.0, 1.0)));
  highp vec3 tmpvar_41;
  highp vec3 causticColor_42;
  highp vec4 color2_43;
  highp vec4 color1_44;
  highp float tmpvar_45;
  tmpvar_45 = ((_HeightDiff / abs(tmpvar_7.y)) * _DepthDiffScale);
  highp float tmpvar_46;
  tmpvar_46 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_47;
  tmpvar_47 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (tmpvar_47 + tmpvar_46);
  tmpvar_48 = texture2D (_CausticTex, P_49);
  color1_44 = tmpvar_48;
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = ((tmpvar_47 * vec2(1.5, 1.5)) - tmpvar_46);
  tmpvar_50 = texture2D (_CausticTex, P_51);
  color2_43 = tmpvar_50;
  highp vec2 tmpvar_52;
  tmpvar_52 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_7 * tmpvar_45)
  ).xz) + (_CausticDistortionValue * mix (color1_44.yz, color2_43.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_53;
  tmpvar_53 = texture2D (_CausticTex, tmpvar_52).xyz;
  causticColor_42 = tmpvar_53;
  causticColor_42 = (causticColor_42 * (_LightColor0.xyz * clamp (
    abs(tmpvar_6.y)
  , 0.0, 1.0)));
  causticColor_42 = (causticColor_42 * _CausticIntensity);
  causticColor_42 = (_CausticColor * causticColor_42.x);
  tmpvar_41 = (causticColor_42 * pow (max (
    clamp (((1.0/(_CausticFade)) * tmpvar_45), 0.0, 1.0)
  , 0.0001), _CausticFadePower));
  highp vec3 backgroundColor_54;
  highp float tmpvar_55;
  tmpvar_55 = abs(dot (tmpvar_7, tmpvar_27));
  highp vec2 tmpvar_56;
  tmpvar_56 = (((tmpvar_32 * 
    (tmpvar_27.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_BeforeAlphaTexture, tmpvar_56).xyz;
  backgroundColor_54 = tmpvar_57;
  lowp vec3 tmpvar_58;
  tmpvar_58 = _LightColor0.xyz;
  highp vec3 lightColor_59;
  lightColor_59 = tmpvar_58;
  highp float depthDiff_60;
  depthDiff_60 = (tmpvar_32 * _DepthDiffScale);
  highp vec3 tmpvar_61;
  tmpvar_61 = (max (0.3, tmpvar_6.y) * lightColor_59);
  highp vec3 tmpvar_62;
  tmpvar_62 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_63;
  tmpvar_63 = max ((tmpvar_62 * (1.0 + tmpvar_55)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_64;
  if ((tmpvar_55 > -0.99)) {
    tmpvar_64 = (((_WaterColor * 2.0) / (1.0 + tmpvar_55)) * (1.0 - exp(
      (-(tmpvar_63) * depthDiff_60)
    )));
  } else {
    tmpvar_64 = ((2.0 * tmpvar_62) * (_WaterColor * depthDiff_60));
  };
  refractionLighting_3 = (tmpvar_41 + ((backgroundColor_54 * 
    exp((-(tmpvar_63) * depthDiff_60))
  ) + (tmpvar_64 * tmpvar_61)));
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_66;
  tmpvar_66 = texture2D (_BeforeAlphaTexture, P_65).xyz;
  bgColor_1 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (bgColor_1, clamp ((
    (reflectionLighting_4 * tmpvar_36)
   + 
    (refractionLighting_3 * (1.0 - tmpvar_36))
  ), 0.0, 1.0), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_68;
  srcColor_68 = tmpvar_67;
  mediump vec3 tmpvar_69;
  tmpvar_69 = mix (srcColor_68, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = tmpvar_69;
  highp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_70;
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
uniform highp vec4 _ZBufferParams;
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
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DistortionFactor;
uniform highp float _DepthDiffScale;
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
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 refractionLighting_3;
  highp vec3 reflectionLighting_4;
  highp vec3 lightColor_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_9.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_10.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (tmpvar_9.x + tmpvar_11.x);
  tmpvar_13.y = (tmpvar_11.y + tmpvar_9.y);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_10.x + tmpvar_12.x);
  tmpvar_14.y = (tmpvar_12.y + tmpvar_10.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_NormalTexture1, tmpvar_13);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump float bumpScale_17;
  bumpScale_17 = _NormalIntensity;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * bumpScale_17);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NormalTexture2, tmpvar_14);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _NormalIntensity;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  mediump vec3 tmpvar_25;
  tmpvar_25 = (normal_18 + normal_23);
  N_8 = tmpvar_25;
  highp vec3 x_26;
  x_26 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (vec3(0.0, 1.0, 0.0), normalize(N_8.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_26, x_26)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_8 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = _LightColor0.xyz;
  lightColor_5 = tmpvar_28;
  refractionLighting_3 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  tmpvar_29 = texture2D (_CustomDepthTexture, tmpvar_30);
  highp float z_31;
  z_31 = tmpvar_29.x;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_31)
   + _ZBufferParams.w))) - (1.0/((
    (_ZBufferParams.z * (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))
   + _ZBufferParams.w))));
  highp float tmpvar_33;
  tmpvar_33 = (1.0 - abs(tmpvar_7.y));
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_33 * tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = ((tmpvar_33 * tmpvar_34) * tmpvar_34);
  highp vec3 tmpvar_36;
  tmpvar_36 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_35)
  ) + vec3(tmpvar_35)), 0.0, 1.0);
  highp vec4 reflectColor_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = -(tmpvar_7);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (tmpvar_27, I_39)
   * tmpvar_27)));
  lowp vec4 tmpvar_40;
  tmpvar_40 = textureCube (_WaterReflectionTexture, tmpvar_38);
  reflectColor_37 = tmpvar_40;
  reflectionLighting_4 = (((
    (clamp ((_SpecularIntensity * pow (
      max (abs(dot (tmpvar_27, normalize(
        (_ES_SunDirection + tmpvar_7)
      ))), 0.0001)
    , _Gloss)), 0.0, 16.0) * lightColor_5)
   * 
    pow (max ((1.0 - abs(
      dot (tmpvar_7, tmpvar_27)
    )), 0.0001), _SpecularPower)
  ) + reflectColor_37.xyz) + (_EdgeFoamColor * clamp (
    (xlv_COLOR.x * _EdgeFoamWidth)
  , 0.0, 1.0)));
  highp vec3 tmpvar_41;
  highp vec3 causticColor_42;
  highp vec4 color2_43;
  highp vec4 color1_44;
  highp float tmpvar_45;
  tmpvar_45 = ((_HeightDiff / abs(tmpvar_7.y)) * _DepthDiffScale);
  highp float tmpvar_46;
  tmpvar_46 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_47;
  tmpvar_47 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (tmpvar_47 + tmpvar_46);
  tmpvar_48 = texture2D (_CausticTex, P_49);
  color1_44 = tmpvar_48;
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = ((tmpvar_47 * vec2(1.5, 1.5)) - tmpvar_46);
  tmpvar_50 = texture2D (_CausticTex, P_51);
  color2_43 = tmpvar_50;
  highp vec2 tmpvar_52;
  tmpvar_52 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_7 * tmpvar_45)
  ).xz) + (_CausticDistortionValue * mix (color1_44.yz, color2_43.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_53;
  tmpvar_53 = texture2D (_CausticTex, tmpvar_52).xyz;
  causticColor_42 = tmpvar_53;
  causticColor_42 = (causticColor_42 * (_LightColor0.xyz * clamp (
    abs(tmpvar_6.y)
  , 0.0, 1.0)));
  causticColor_42 = (causticColor_42 * _CausticIntensity);
  causticColor_42 = (_CausticColor * causticColor_42.x);
  tmpvar_41 = (causticColor_42 * pow (max (
    clamp (((1.0/(_CausticFade)) * tmpvar_45), 0.0, 1.0)
  , 0.0001), _CausticFadePower));
  highp vec3 backgroundColor_54;
  highp float tmpvar_55;
  tmpvar_55 = abs(dot (tmpvar_7, tmpvar_27));
  highp vec2 tmpvar_56;
  tmpvar_56 = (((tmpvar_32 * 
    (tmpvar_27.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_BeforeAlphaTexture, tmpvar_56).xyz;
  backgroundColor_54 = tmpvar_57;
  lowp vec3 tmpvar_58;
  tmpvar_58 = _LightColor0.xyz;
  highp vec3 lightColor_59;
  lightColor_59 = tmpvar_58;
  highp float depthDiff_60;
  depthDiff_60 = (tmpvar_32 * _DepthDiffScale);
  highp vec3 tmpvar_61;
  tmpvar_61 = (max (0.3, tmpvar_6.y) * lightColor_59);
  highp vec3 tmpvar_62;
  tmpvar_62 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_63;
  tmpvar_63 = max ((tmpvar_62 * (1.0 + tmpvar_55)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_64;
  if ((tmpvar_55 > -0.99)) {
    tmpvar_64 = (((_WaterColor * 2.0) / (1.0 + tmpvar_55)) * (1.0 - exp(
      (-(tmpvar_63) * depthDiff_60)
    )));
  } else {
    tmpvar_64 = ((2.0 * tmpvar_62) * (_WaterColor * depthDiff_60));
  };
  refractionLighting_3 = (tmpvar_41 + ((backgroundColor_54 * 
    exp((-(tmpvar_63) * depthDiff_60))
  ) + (tmpvar_64 * tmpvar_61)));
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_66;
  tmpvar_66 = texture2D (_BeforeAlphaTexture, P_65).xyz;
  bgColor_1 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (bgColor_1, clamp ((
    (reflectionLighting_4 * tmpvar_36)
   + 
    (refractionLighting_3 * (1.0 - tmpvar_36))
  ), 0.0, 1.0), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_68;
  srcColor_68 = tmpvar_67;
  mediump vec3 tmpvar_69;
  tmpvar_69 = mix (srcColor_68, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = tmpvar_69;
  highp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_70;
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
uniform highp vec4 _ZBufferParams;
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
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DistortionFactor;
uniform highp float _DepthDiffScale;
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
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 refractionLighting_3;
  highp vec3 reflectionLighting_4;
  highp vec3 lightColor_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_9.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_10.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (tmpvar_9.x + tmpvar_11.x);
  tmpvar_13.y = (tmpvar_11.y + tmpvar_9.y);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_10.x + tmpvar_12.x);
  tmpvar_14.y = (tmpvar_12.y + tmpvar_10.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_NormalTexture1, tmpvar_13);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump float bumpScale_17;
  bumpScale_17 = _NormalIntensity;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * bumpScale_17);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NormalTexture2, tmpvar_14);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _NormalIntensity;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  mediump vec3 tmpvar_25;
  tmpvar_25 = (normal_18 + normal_23);
  N_8 = tmpvar_25;
  highp vec3 x_26;
  x_26 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (vec3(0.0, 1.0, 0.0), normalize(N_8.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_26, x_26)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_8 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = _LightColor0.xyz;
  lightColor_5 = tmpvar_28;
  refractionLighting_3 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  tmpvar_29 = texture2D (_CustomDepthTexture, tmpvar_30);
  highp float z_31;
  z_31 = tmpvar_29.x;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_31)
   + _ZBufferParams.w))) - (1.0/((
    (_ZBufferParams.z * (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))
   + _ZBufferParams.w))));
  highp float tmpvar_33;
  tmpvar_33 = (1.0 - abs(tmpvar_7.y));
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_33 * tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = ((tmpvar_33 * tmpvar_34) * tmpvar_34);
  highp vec3 tmpvar_36;
  tmpvar_36 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_35)
  ) + vec3(tmpvar_35)), 0.0, 1.0);
  highp vec4 reflectColor_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = -(tmpvar_7);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (tmpvar_27, I_39)
   * tmpvar_27)));
  lowp vec4 tmpvar_40;
  tmpvar_40 = textureCube (_WaterReflectionTexture, tmpvar_38);
  reflectColor_37 = tmpvar_40;
  reflectionLighting_4 = (((
    (clamp ((_SpecularIntensity * pow (
      max (abs(dot (tmpvar_27, normalize(
        (_ES_SunDirection + tmpvar_7)
      ))), 0.0001)
    , _Gloss)), 0.0, 16.0) * lightColor_5)
   * 
    pow (max ((1.0 - abs(
      dot (tmpvar_7, tmpvar_27)
    )), 0.0001), _SpecularPower)
  ) + reflectColor_37.xyz) + (_EdgeFoamColor * clamp (
    (xlv_COLOR.x * _EdgeFoamWidth)
  , 0.0, 1.0)));
  highp vec3 tmpvar_41;
  highp vec3 causticColor_42;
  highp vec4 color2_43;
  highp vec4 color1_44;
  highp float tmpvar_45;
  tmpvar_45 = ((_HeightDiff / abs(tmpvar_7.y)) * _DepthDiffScale);
  highp float tmpvar_46;
  tmpvar_46 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_47;
  tmpvar_47 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (tmpvar_47 + tmpvar_46);
  tmpvar_48 = texture2D (_CausticTex, P_49);
  color1_44 = tmpvar_48;
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = ((tmpvar_47 * vec2(1.5, 1.5)) - tmpvar_46);
  tmpvar_50 = texture2D (_CausticTex, P_51);
  color2_43 = tmpvar_50;
  highp vec2 tmpvar_52;
  tmpvar_52 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_7 * tmpvar_45)
  ).xz) + (_CausticDistortionValue * mix (color1_44.yz, color2_43.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_53;
  tmpvar_53 = texture2D (_CausticTex, tmpvar_52).xyz;
  causticColor_42 = tmpvar_53;
  causticColor_42 = (causticColor_42 * (_LightColor0.xyz * clamp (
    abs(tmpvar_6.y)
  , 0.0, 1.0)));
  causticColor_42 = (causticColor_42 * _CausticIntensity);
  causticColor_42 = (_CausticColor * causticColor_42.x);
  tmpvar_41 = (causticColor_42 * pow (max (
    clamp (((1.0/(_CausticFade)) * tmpvar_45), 0.0, 1.0)
  , 0.0001), _CausticFadePower));
  highp vec3 backgroundColor_54;
  highp float tmpvar_55;
  tmpvar_55 = abs(dot (tmpvar_7, tmpvar_27));
  highp vec2 tmpvar_56;
  tmpvar_56 = (((tmpvar_32 * 
    (tmpvar_27.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_BeforeAlphaTexture, tmpvar_56).xyz;
  backgroundColor_54 = tmpvar_57;
  lowp vec3 tmpvar_58;
  tmpvar_58 = _LightColor0.xyz;
  highp vec3 lightColor_59;
  lightColor_59 = tmpvar_58;
  highp float depthDiff_60;
  depthDiff_60 = (tmpvar_32 * _DepthDiffScale);
  highp vec3 tmpvar_61;
  tmpvar_61 = (max (0.3, tmpvar_6.y) * lightColor_59);
  highp vec3 tmpvar_62;
  tmpvar_62 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_63;
  tmpvar_63 = max ((tmpvar_62 * (1.0 + tmpvar_55)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_64;
  if ((tmpvar_55 > -0.99)) {
    tmpvar_64 = (((_WaterColor * 2.0) / (1.0 + tmpvar_55)) * (1.0 - exp(
      (-(tmpvar_63) * depthDiff_60)
    )));
  } else {
    tmpvar_64 = ((2.0 * tmpvar_62) * (_WaterColor * depthDiff_60));
  };
  refractionLighting_3 = (tmpvar_41 + ((backgroundColor_54 * 
    exp((-(tmpvar_63) * depthDiff_60))
  ) + (tmpvar_64 * tmpvar_61)));
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_66;
  tmpvar_66 = texture2D (_BeforeAlphaTexture, P_65).xyz;
  bgColor_1 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (bgColor_1, clamp ((
    (reflectionLighting_4 * tmpvar_36)
   + 
    (refractionLighting_3 * (1.0 - tmpvar_36))
  ), 0.0, 1.0), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_68;
  srcColor_68 = tmpvar_67;
  mediump vec3 tmpvar_69;
  tmpvar_69 = mix (srcColor_68, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = tmpvar_69;
  highp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_70;
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
uniform highp vec4 _ZBufferParams;
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
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DistortionFactor;
uniform highp float _DepthDiffScale;
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
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 refractionLighting_3;
  highp vec3 reflectionLighting_4;
  highp vec3 lightColor_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_9.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_10.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (tmpvar_9.x + tmpvar_11.x);
  tmpvar_13.y = (tmpvar_11.y + tmpvar_9.y);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_10.x + tmpvar_12.x);
  tmpvar_14.y = (tmpvar_12.y + tmpvar_10.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_NormalTexture1, tmpvar_13);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump float bumpScale_17;
  bumpScale_17 = _NormalIntensity;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * bumpScale_17);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NormalTexture2, tmpvar_14);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _NormalIntensity;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  mediump vec3 tmpvar_25;
  tmpvar_25 = (normal_18 + normal_23);
  N_8 = tmpvar_25;
  highp vec3 x_26;
  x_26 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (vec3(0.0, 1.0, 0.0), normalize(N_8.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_26, x_26)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_8 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = _LightColor0.xyz;
  lightColor_5 = tmpvar_28;
  refractionLighting_3 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  tmpvar_29 = texture2D (_CustomDepthTexture, tmpvar_30);
  highp float z_31;
  z_31 = tmpvar_29.x;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_31)
   + _ZBufferParams.w))) - (1.0/((
    (_ZBufferParams.z * (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))
   + _ZBufferParams.w))));
  highp float tmpvar_33;
  tmpvar_33 = (1.0 - abs(tmpvar_7.y));
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_33 * tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = ((tmpvar_33 * tmpvar_34) * tmpvar_34);
  highp vec3 tmpvar_36;
  tmpvar_36 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_35)
  ) + vec3(tmpvar_35)), 0.0, 1.0);
  highp vec4 reflectColor_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = -(tmpvar_7);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (tmpvar_27, I_39)
   * tmpvar_27)));
  lowp vec4 tmpvar_40;
  tmpvar_40 = textureCube (_WaterReflectionTexture, tmpvar_38);
  reflectColor_37 = tmpvar_40;
  reflectionLighting_4 = (((
    (clamp ((_SpecularIntensity * pow (
      max (abs(dot (tmpvar_27, normalize(
        (_ES_SunDirection + tmpvar_7)
      ))), 0.0001)
    , _Gloss)), 0.0, 16.0) * lightColor_5)
   * 
    pow (max ((1.0 - abs(
      dot (tmpvar_7, tmpvar_27)
    )), 0.0001), _SpecularPower)
  ) + reflectColor_37.xyz) + (_EdgeFoamColor * clamp (
    (xlv_COLOR.x * _EdgeFoamWidth)
  , 0.0, 1.0)));
  highp vec3 tmpvar_41;
  highp vec3 causticColor_42;
  highp vec4 color2_43;
  highp vec4 color1_44;
  highp float tmpvar_45;
  tmpvar_45 = ((_HeightDiff / abs(tmpvar_7.y)) * _DepthDiffScale);
  highp float tmpvar_46;
  tmpvar_46 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_47;
  tmpvar_47 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (tmpvar_47 + tmpvar_46);
  tmpvar_48 = texture2D (_CausticTex, P_49);
  color1_44 = tmpvar_48;
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = ((tmpvar_47 * vec2(1.5, 1.5)) - tmpvar_46);
  tmpvar_50 = texture2D (_CausticTex, P_51);
  color2_43 = tmpvar_50;
  highp vec2 tmpvar_52;
  tmpvar_52 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_7 * tmpvar_45)
  ).xz) + (_CausticDistortionValue * mix (color1_44.yz, color2_43.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_53;
  tmpvar_53 = texture2D (_CausticTex, tmpvar_52).xyz;
  causticColor_42 = tmpvar_53;
  causticColor_42 = (causticColor_42 * (_LightColor0.xyz * clamp (
    abs(tmpvar_6.y)
  , 0.0, 1.0)));
  causticColor_42 = (causticColor_42 * _CausticIntensity);
  causticColor_42 = (_CausticColor * causticColor_42.x);
  tmpvar_41 = (causticColor_42 * pow (max (
    clamp (((1.0/(_CausticFade)) * tmpvar_45), 0.0, 1.0)
  , 0.0001), _CausticFadePower));
  highp vec3 backgroundColor_54;
  highp float tmpvar_55;
  tmpvar_55 = abs(dot (tmpvar_7, tmpvar_27));
  highp vec2 tmpvar_56;
  tmpvar_56 = (((tmpvar_32 * 
    (tmpvar_27.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_BeforeAlphaTexture, tmpvar_56).xyz;
  backgroundColor_54 = tmpvar_57;
  lowp vec3 tmpvar_58;
  tmpvar_58 = _LightColor0.xyz;
  highp vec3 lightColor_59;
  lightColor_59 = tmpvar_58;
  highp float depthDiff_60;
  depthDiff_60 = (tmpvar_32 * _DepthDiffScale);
  highp vec3 tmpvar_61;
  tmpvar_61 = (max (0.3, tmpvar_6.y) * lightColor_59);
  highp vec3 tmpvar_62;
  tmpvar_62 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_63;
  tmpvar_63 = max ((tmpvar_62 * (1.0 + tmpvar_55)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_64;
  if ((tmpvar_55 > -0.99)) {
    tmpvar_64 = (((_WaterColor * 2.0) / (1.0 + tmpvar_55)) * (1.0 - exp(
      (-(tmpvar_63) * depthDiff_60)
    )));
  } else {
    tmpvar_64 = ((2.0 * tmpvar_62) * (_WaterColor * depthDiff_60));
  };
  refractionLighting_3 = (tmpvar_41 + ((backgroundColor_54 * 
    exp((-(tmpvar_63) * depthDiff_60))
  ) + (tmpvar_64 * tmpvar_61)));
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_66;
  tmpvar_66 = texture2D (_BeforeAlphaTexture, P_65).xyz;
  bgColor_1 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (bgColor_1, clamp ((
    (reflectionLighting_4 * tmpvar_36)
   + 
    (refractionLighting_3 * (1.0 - tmpvar_36))
  ), 0.0, 1.0), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_68;
  srcColor_68 = tmpvar_67;
  mediump vec3 tmpvar_69;
  tmpvar_69 = mix (srcColor_68, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = tmpvar_69;
  highp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_70;
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
uniform highp vec4 _ZBufferParams;
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
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DistortionFactor;
uniform highp float _DepthDiffScale;
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
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 refractionLighting_3;
  highp vec3 reflectionLighting_4;
  highp vec3 lightColor_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_9.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_10.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (tmpvar_9.x + tmpvar_11.x);
  tmpvar_13.y = (tmpvar_11.y + tmpvar_9.y);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_10.x + tmpvar_12.x);
  tmpvar_14.y = (tmpvar_12.y + tmpvar_10.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_NormalTexture1, tmpvar_13);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump float bumpScale_17;
  bumpScale_17 = _NormalIntensity;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * bumpScale_17);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NormalTexture2, tmpvar_14);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _NormalIntensity;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  mediump vec3 tmpvar_25;
  tmpvar_25 = (normal_18 + normal_23);
  N_8 = tmpvar_25;
  highp vec3 x_26;
  x_26 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (vec3(0.0, 1.0, 0.0), normalize(N_8.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_26, x_26)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_8 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = _LightColor0.xyz;
  lightColor_5 = tmpvar_28;
  refractionLighting_3 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  tmpvar_29 = texture2D (_CustomDepthTexture, tmpvar_30);
  highp float z_31;
  z_31 = tmpvar_29.x;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_31)
   + _ZBufferParams.w))) - (1.0/((
    (_ZBufferParams.z * (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))
   + _ZBufferParams.w))));
  highp float tmpvar_33;
  tmpvar_33 = (1.0 - abs(tmpvar_7.y));
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_33 * tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = ((tmpvar_33 * tmpvar_34) * tmpvar_34);
  highp vec3 tmpvar_36;
  tmpvar_36 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_35)
  ) + vec3(tmpvar_35)), 0.0, 1.0);
  highp vec4 reflectColor_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = -(tmpvar_7);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (tmpvar_27, I_39)
   * tmpvar_27)));
  lowp vec4 tmpvar_40;
  tmpvar_40 = textureCube (_WaterReflectionTexture, tmpvar_38);
  reflectColor_37 = tmpvar_40;
  reflectionLighting_4 = (((
    (clamp ((_SpecularIntensity * pow (
      max (abs(dot (tmpvar_27, normalize(
        (_ES_SunDirection + tmpvar_7)
      ))), 0.0001)
    , _Gloss)), 0.0, 16.0) * lightColor_5)
   * 
    pow (max ((1.0 - abs(
      dot (tmpvar_7, tmpvar_27)
    )), 0.0001), _SpecularPower)
  ) + reflectColor_37.xyz) + (_EdgeFoamColor * clamp (
    (xlv_COLOR.x * _EdgeFoamWidth)
  , 0.0, 1.0)));
  highp vec3 tmpvar_41;
  highp vec3 causticColor_42;
  highp vec4 color2_43;
  highp vec4 color1_44;
  highp float tmpvar_45;
  tmpvar_45 = ((_HeightDiff / abs(tmpvar_7.y)) * _DepthDiffScale);
  highp float tmpvar_46;
  tmpvar_46 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_47;
  tmpvar_47 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (tmpvar_47 + tmpvar_46);
  tmpvar_48 = texture2D (_CausticTex, P_49);
  color1_44 = tmpvar_48;
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = ((tmpvar_47 * vec2(1.5, 1.5)) - tmpvar_46);
  tmpvar_50 = texture2D (_CausticTex, P_51);
  color2_43 = tmpvar_50;
  highp vec2 tmpvar_52;
  tmpvar_52 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_7 * tmpvar_45)
  ).xz) + (_CausticDistortionValue * mix (color1_44.yz, color2_43.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_53;
  tmpvar_53 = texture2D (_CausticTex, tmpvar_52).xyz;
  causticColor_42 = tmpvar_53;
  causticColor_42 = (causticColor_42 * (_LightColor0.xyz * clamp (
    abs(tmpvar_6.y)
  , 0.0, 1.0)));
  causticColor_42 = (causticColor_42 * _CausticIntensity);
  causticColor_42 = (_CausticColor * causticColor_42.x);
  tmpvar_41 = (causticColor_42 * pow (max (
    clamp (((1.0/(_CausticFade)) * tmpvar_45), 0.0, 1.0)
  , 0.0001), _CausticFadePower));
  highp vec3 backgroundColor_54;
  highp float tmpvar_55;
  tmpvar_55 = abs(dot (tmpvar_7, tmpvar_27));
  highp vec2 tmpvar_56;
  tmpvar_56 = (((tmpvar_32 * 
    (tmpvar_27.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_BeforeAlphaTexture, tmpvar_56).xyz;
  backgroundColor_54 = tmpvar_57;
  lowp vec3 tmpvar_58;
  tmpvar_58 = _LightColor0.xyz;
  highp vec3 lightColor_59;
  lightColor_59 = tmpvar_58;
  highp float depthDiff_60;
  depthDiff_60 = (tmpvar_32 * _DepthDiffScale);
  highp vec3 tmpvar_61;
  tmpvar_61 = (max (0.3, tmpvar_6.y) * lightColor_59);
  highp vec3 tmpvar_62;
  tmpvar_62 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_63;
  tmpvar_63 = max ((tmpvar_62 * (1.0 + tmpvar_55)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_64;
  if ((tmpvar_55 > -0.99)) {
    tmpvar_64 = (((_WaterColor * 2.0) / (1.0 + tmpvar_55)) * (1.0 - exp(
      (-(tmpvar_63) * depthDiff_60)
    )));
  } else {
    tmpvar_64 = ((2.0 * tmpvar_62) * (_WaterColor * depthDiff_60));
  };
  refractionLighting_3 = (tmpvar_41 + ((backgroundColor_54 * 
    exp((-(tmpvar_63) * depthDiff_60))
  ) + (tmpvar_64 * tmpvar_61)));
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_66;
  tmpvar_66 = texture2D (_BeforeAlphaTexture, P_65).xyz;
  bgColor_1 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (bgColor_1, clamp ((
    (reflectionLighting_4 * tmpvar_36)
   + 
    (refractionLighting_3 * (1.0 - tmpvar_36))
  ), 0.0, 1.0), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_68;
  srcColor_68 = tmpvar_67;
  mediump vec3 tmpvar_69;
  tmpvar_69 = mix (srcColor_68, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = tmpvar_69;
  highp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_70;
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
uniform highp vec4 _ZBufferParams;
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
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DistortionFactor;
uniform highp float _DepthDiffScale;
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
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 refractionLighting_3;
  highp vec3 reflectionLighting_4;
  highp vec3 lightColor_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_9.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_10.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (tmpvar_9.x + tmpvar_11.x);
  tmpvar_13.y = (tmpvar_11.y + tmpvar_9.y);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_10.x + tmpvar_12.x);
  tmpvar_14.y = (tmpvar_12.y + tmpvar_10.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_NormalTexture1, tmpvar_13);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump float bumpScale_17;
  bumpScale_17 = _NormalIntensity;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * bumpScale_17);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NormalTexture2, tmpvar_14);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _NormalIntensity;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  mediump vec3 tmpvar_25;
  tmpvar_25 = (normal_18 + normal_23);
  N_8 = tmpvar_25;
  highp vec3 x_26;
  x_26 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (vec3(0.0, 1.0, 0.0), normalize(N_8.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_26, x_26)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_8 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = _LightColor0.xyz;
  lightColor_5 = tmpvar_28;
  refractionLighting_3 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  tmpvar_29 = texture2D (_CustomDepthTexture, tmpvar_30);
  highp float z_31;
  z_31 = tmpvar_29.x;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_31)
   + _ZBufferParams.w))) - (1.0/((
    (_ZBufferParams.z * (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))
   + _ZBufferParams.w))));
  highp float tmpvar_33;
  tmpvar_33 = (1.0 - abs(tmpvar_7.y));
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_33 * tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = ((tmpvar_33 * tmpvar_34) * tmpvar_34);
  highp vec3 tmpvar_36;
  tmpvar_36 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_35)
  ) + vec3(tmpvar_35)), 0.0, 1.0);
  highp vec4 reflectColor_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = -(tmpvar_7);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (tmpvar_27, I_39)
   * tmpvar_27)));
  lowp vec4 tmpvar_40;
  tmpvar_40 = textureCube (_WaterReflectionTexture, tmpvar_38);
  reflectColor_37 = tmpvar_40;
  reflectionLighting_4 = (((
    (clamp ((_SpecularIntensity * pow (
      max (abs(dot (tmpvar_27, normalize(
        (_ES_SunDirection + tmpvar_7)
      ))), 0.0001)
    , _Gloss)), 0.0, 16.0) * lightColor_5)
   * 
    pow (max ((1.0 - abs(
      dot (tmpvar_7, tmpvar_27)
    )), 0.0001), _SpecularPower)
  ) + reflectColor_37.xyz) + (_EdgeFoamColor * clamp (
    (xlv_COLOR.x * _EdgeFoamWidth)
  , 0.0, 1.0)));
  highp vec3 tmpvar_41;
  highp vec3 causticColor_42;
  highp vec4 color2_43;
  highp vec4 color1_44;
  highp float tmpvar_45;
  tmpvar_45 = ((_HeightDiff / abs(tmpvar_7.y)) * _DepthDiffScale);
  highp float tmpvar_46;
  tmpvar_46 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_47;
  tmpvar_47 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (tmpvar_47 + tmpvar_46);
  tmpvar_48 = texture2D (_CausticTex, P_49);
  color1_44 = tmpvar_48;
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = ((tmpvar_47 * vec2(1.5, 1.5)) - tmpvar_46);
  tmpvar_50 = texture2D (_CausticTex, P_51);
  color2_43 = tmpvar_50;
  highp vec2 tmpvar_52;
  tmpvar_52 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_7 * tmpvar_45)
  ).xz) + (_CausticDistortionValue * mix (color1_44.yz, color2_43.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_53;
  tmpvar_53 = texture2D (_CausticTex, tmpvar_52).xyz;
  causticColor_42 = tmpvar_53;
  causticColor_42 = (causticColor_42 * (_LightColor0.xyz * clamp (
    abs(tmpvar_6.y)
  , 0.0, 1.0)));
  causticColor_42 = (causticColor_42 * _CausticIntensity);
  causticColor_42 = (_CausticColor * causticColor_42.x);
  tmpvar_41 = (causticColor_42 * pow (max (
    clamp (((1.0/(_CausticFade)) * tmpvar_45), 0.0, 1.0)
  , 0.0001), _CausticFadePower));
  highp vec3 backgroundColor_54;
  highp float tmpvar_55;
  tmpvar_55 = abs(dot (tmpvar_7, tmpvar_27));
  highp vec2 tmpvar_56;
  tmpvar_56 = (((tmpvar_32 * 
    (tmpvar_27.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_BeforeAlphaTexture, tmpvar_56).xyz;
  backgroundColor_54 = tmpvar_57;
  lowp vec3 tmpvar_58;
  tmpvar_58 = _LightColor0.xyz;
  highp vec3 lightColor_59;
  lightColor_59 = tmpvar_58;
  highp float depthDiff_60;
  depthDiff_60 = (tmpvar_32 * _DepthDiffScale);
  highp vec3 tmpvar_61;
  tmpvar_61 = (max (0.3, tmpvar_6.y) * lightColor_59);
  highp vec3 tmpvar_62;
  tmpvar_62 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_63;
  tmpvar_63 = max ((tmpvar_62 * (1.0 + tmpvar_55)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_64;
  if ((tmpvar_55 > -0.99)) {
    tmpvar_64 = (((_WaterColor * 2.0) / (1.0 + tmpvar_55)) * (1.0 - exp(
      (-(tmpvar_63) * depthDiff_60)
    )));
  } else {
    tmpvar_64 = ((2.0 * tmpvar_62) * (_WaterColor * depthDiff_60));
  };
  refractionLighting_3 = (tmpvar_41 + ((backgroundColor_54 * 
    exp((-(tmpvar_63) * depthDiff_60))
  ) + (tmpvar_64 * tmpvar_61)));
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_66;
  tmpvar_66 = texture2D (_BeforeAlphaTexture, P_65).xyz;
  bgColor_1 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (bgColor_1, clamp ((
    (reflectionLighting_4 * tmpvar_36)
   + 
    (refractionLighting_3 * (1.0 - tmpvar_36))
  ), 0.0, 1.0), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_68;
  srcColor_68 = tmpvar_67;
  mediump vec3 tmpvar_69;
  tmpvar_69 = mix (srcColor_68, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = tmpvar_69;
  highp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_70;
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
uniform highp vec4 _ZBufferParams;
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
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DistortionFactor;
uniform highp float _DepthDiffScale;
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
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 refractionLighting_3;
  highp vec3 reflectionLighting_4;
  highp vec3 lightColor_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_9.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_10.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (tmpvar_9.x + tmpvar_11.x);
  tmpvar_13.y = (tmpvar_11.y + tmpvar_9.y);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_10.x + tmpvar_12.x);
  tmpvar_14.y = (tmpvar_12.y + tmpvar_10.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_NormalTexture1, tmpvar_13);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump float bumpScale_17;
  bumpScale_17 = _NormalIntensity;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * bumpScale_17);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NormalTexture2, tmpvar_14);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _NormalIntensity;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  mediump vec3 tmpvar_25;
  tmpvar_25 = (normal_18 + normal_23);
  N_8 = tmpvar_25;
  highp vec3 x_26;
  x_26 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (vec3(0.0, 1.0, 0.0), normalize(N_8.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_26, x_26)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_8 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = _LightColor0.xyz;
  lightColor_5 = tmpvar_28;
  refractionLighting_3 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  tmpvar_29 = texture2D (_CustomDepthTexture, tmpvar_30);
  highp float z_31;
  z_31 = tmpvar_29.x;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_31)
   + _ZBufferParams.w))) - (1.0/((
    (_ZBufferParams.z * (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))
   + _ZBufferParams.w))));
  highp float tmpvar_33;
  tmpvar_33 = (1.0 - abs(tmpvar_7.y));
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_33 * tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = ((tmpvar_33 * tmpvar_34) * tmpvar_34);
  highp vec3 tmpvar_36;
  tmpvar_36 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_35)
  ) + vec3(tmpvar_35)), 0.0, 1.0);
  highp vec4 reflectColor_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = -(tmpvar_7);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (tmpvar_27, I_39)
   * tmpvar_27)));
  lowp vec4 tmpvar_40;
  tmpvar_40 = textureCube (_WaterReflectionTexture, tmpvar_38);
  reflectColor_37 = tmpvar_40;
  reflectionLighting_4 = (((
    (clamp ((_SpecularIntensity * pow (
      max (abs(dot (tmpvar_27, normalize(
        (_ES_SunDirection + tmpvar_7)
      ))), 0.0001)
    , _Gloss)), 0.0, 16.0) * lightColor_5)
   * 
    pow (max ((1.0 - abs(
      dot (tmpvar_7, tmpvar_27)
    )), 0.0001), _SpecularPower)
  ) + reflectColor_37.xyz) + (_EdgeFoamColor * clamp (
    (xlv_COLOR.x * _EdgeFoamWidth)
  , 0.0, 1.0)));
  highp vec3 tmpvar_41;
  highp vec3 causticColor_42;
  highp vec4 color2_43;
  highp vec4 color1_44;
  highp float tmpvar_45;
  tmpvar_45 = ((_HeightDiff / abs(tmpvar_7.y)) * _DepthDiffScale);
  highp float tmpvar_46;
  tmpvar_46 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_47;
  tmpvar_47 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (tmpvar_47 + tmpvar_46);
  tmpvar_48 = texture2D (_CausticTex, P_49);
  color1_44 = tmpvar_48;
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = ((tmpvar_47 * vec2(1.5, 1.5)) - tmpvar_46);
  tmpvar_50 = texture2D (_CausticTex, P_51);
  color2_43 = tmpvar_50;
  highp vec2 tmpvar_52;
  tmpvar_52 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_7 * tmpvar_45)
  ).xz) + (_CausticDistortionValue * mix (color1_44.yz, color2_43.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_53;
  tmpvar_53 = texture2D (_CausticTex, tmpvar_52).xyz;
  causticColor_42 = tmpvar_53;
  causticColor_42 = (causticColor_42 * (_LightColor0.xyz * clamp (
    abs(tmpvar_6.y)
  , 0.0, 1.0)));
  causticColor_42 = (causticColor_42 * _CausticIntensity);
  causticColor_42 = (_CausticColor * causticColor_42.x);
  tmpvar_41 = (causticColor_42 * pow (max (
    clamp (((1.0/(_CausticFade)) * tmpvar_45), 0.0, 1.0)
  , 0.0001), _CausticFadePower));
  highp vec3 backgroundColor_54;
  highp float tmpvar_55;
  tmpvar_55 = abs(dot (tmpvar_7, tmpvar_27));
  highp vec2 tmpvar_56;
  tmpvar_56 = (((tmpvar_32 * 
    (tmpvar_27.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_BeforeAlphaTexture, tmpvar_56).xyz;
  backgroundColor_54 = tmpvar_57;
  lowp vec3 tmpvar_58;
  tmpvar_58 = _LightColor0.xyz;
  highp vec3 lightColor_59;
  lightColor_59 = tmpvar_58;
  highp float depthDiff_60;
  depthDiff_60 = (tmpvar_32 * _DepthDiffScale);
  highp vec3 tmpvar_61;
  tmpvar_61 = (max (0.3, tmpvar_6.y) * lightColor_59);
  highp vec3 tmpvar_62;
  tmpvar_62 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_63;
  tmpvar_63 = max ((tmpvar_62 * (1.0 + tmpvar_55)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_64;
  if ((tmpvar_55 > -0.99)) {
    tmpvar_64 = (((_WaterColor * 2.0) / (1.0 + tmpvar_55)) * (1.0 - exp(
      (-(tmpvar_63) * depthDiff_60)
    )));
  } else {
    tmpvar_64 = ((2.0 * tmpvar_62) * (_WaterColor * depthDiff_60));
  };
  refractionLighting_3 = (tmpvar_41 + ((backgroundColor_54 * 
    exp((-(tmpvar_63) * depthDiff_60))
  ) + (tmpvar_64 * tmpvar_61)));
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_66;
  tmpvar_66 = texture2D (_BeforeAlphaTexture, P_65).xyz;
  bgColor_1 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (bgColor_1, clamp ((
    (reflectionLighting_4 * tmpvar_36)
   + 
    (refractionLighting_3 * (1.0 - tmpvar_36))
  ), 0.0, 1.0), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_68;
  srcColor_68 = tmpvar_67;
  mediump vec3 tmpvar_69;
  tmpvar_69 = mix (srcColor_68, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = tmpvar_69;
  highp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_70;
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
uniform highp vec4 _ZBufferParams;
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
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DistortionFactor;
uniform highp float _DepthDiffScale;
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
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 refractionLighting_3;
  highp vec3 reflectionLighting_4;
  highp vec3 lightColor_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_9.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_10.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (tmpvar_9.x + tmpvar_11.x);
  tmpvar_13.y = (tmpvar_11.y + tmpvar_9.y);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_10.x + tmpvar_12.x);
  tmpvar_14.y = (tmpvar_12.y + tmpvar_10.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_NormalTexture1, tmpvar_13);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump float bumpScale_17;
  bumpScale_17 = _NormalIntensity;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * bumpScale_17);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NormalTexture2, tmpvar_14);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _NormalIntensity;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  mediump vec3 tmpvar_25;
  tmpvar_25 = (normal_18 + normal_23);
  N_8 = tmpvar_25;
  highp vec3 x_26;
  x_26 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (vec3(0.0, 1.0, 0.0), normalize(N_8.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_26, x_26)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_8 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = _LightColor0.xyz;
  lightColor_5 = tmpvar_28;
  refractionLighting_3 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  tmpvar_29 = texture2D (_CustomDepthTexture, tmpvar_30);
  highp float z_31;
  z_31 = tmpvar_29.x;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_31)
   + _ZBufferParams.w))) - (1.0/((
    (_ZBufferParams.z * (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))
   + _ZBufferParams.w))));
  highp float tmpvar_33;
  tmpvar_33 = (1.0 - abs(tmpvar_7.y));
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_33 * tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = ((tmpvar_33 * tmpvar_34) * tmpvar_34);
  highp vec3 tmpvar_36;
  tmpvar_36 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_35)
  ) + vec3(tmpvar_35)), 0.0, 1.0);
  highp vec4 reflectColor_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = -(tmpvar_7);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (tmpvar_27, I_39)
   * tmpvar_27)));
  lowp vec4 tmpvar_40;
  tmpvar_40 = textureCube (_WaterReflectionTexture, tmpvar_38);
  reflectColor_37 = tmpvar_40;
  reflectionLighting_4 = (((
    (clamp ((_SpecularIntensity * pow (
      max (abs(dot (tmpvar_27, normalize(
        (_ES_SunDirection + tmpvar_7)
      ))), 0.0001)
    , _Gloss)), 0.0, 16.0) * lightColor_5)
   * 
    pow (max ((1.0 - abs(
      dot (tmpvar_7, tmpvar_27)
    )), 0.0001), _SpecularPower)
  ) + reflectColor_37.xyz) + (_EdgeFoamColor * clamp (
    (xlv_COLOR.x * _EdgeFoamWidth)
  , 0.0, 1.0)));
  highp vec3 tmpvar_41;
  highp vec3 causticColor_42;
  highp vec4 color2_43;
  highp vec4 color1_44;
  highp float tmpvar_45;
  tmpvar_45 = ((_HeightDiff / abs(tmpvar_7.y)) * _DepthDiffScale);
  highp float tmpvar_46;
  tmpvar_46 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_47;
  tmpvar_47 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (tmpvar_47 + tmpvar_46);
  tmpvar_48 = texture2D (_CausticTex, P_49);
  color1_44 = tmpvar_48;
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = ((tmpvar_47 * vec2(1.5, 1.5)) - tmpvar_46);
  tmpvar_50 = texture2D (_CausticTex, P_51);
  color2_43 = tmpvar_50;
  highp vec2 tmpvar_52;
  tmpvar_52 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_7 * tmpvar_45)
  ).xz) + (_CausticDistortionValue * mix (color1_44.yz, color2_43.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_53;
  tmpvar_53 = texture2D (_CausticTex, tmpvar_52).xyz;
  causticColor_42 = tmpvar_53;
  causticColor_42 = (causticColor_42 * (_LightColor0.xyz * clamp (
    abs(tmpvar_6.y)
  , 0.0, 1.0)));
  causticColor_42 = (causticColor_42 * _CausticIntensity);
  causticColor_42 = (_CausticColor * causticColor_42.x);
  tmpvar_41 = (causticColor_42 * pow (max (
    clamp (((1.0/(_CausticFade)) * tmpvar_45), 0.0, 1.0)
  , 0.0001), _CausticFadePower));
  highp vec3 backgroundColor_54;
  highp float tmpvar_55;
  tmpvar_55 = abs(dot (tmpvar_7, tmpvar_27));
  highp vec2 tmpvar_56;
  tmpvar_56 = (((tmpvar_32 * 
    (tmpvar_27.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_BeforeAlphaTexture, tmpvar_56).xyz;
  backgroundColor_54 = tmpvar_57;
  lowp vec3 tmpvar_58;
  tmpvar_58 = _LightColor0.xyz;
  highp vec3 lightColor_59;
  lightColor_59 = tmpvar_58;
  highp float depthDiff_60;
  depthDiff_60 = (tmpvar_32 * _DepthDiffScale);
  highp vec3 tmpvar_61;
  tmpvar_61 = (max (0.3, tmpvar_6.y) * lightColor_59);
  highp vec3 tmpvar_62;
  tmpvar_62 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_63;
  tmpvar_63 = max ((tmpvar_62 * (1.0 + tmpvar_55)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_64;
  if ((tmpvar_55 > -0.99)) {
    tmpvar_64 = (((_WaterColor * 2.0) / (1.0 + tmpvar_55)) * (1.0 - exp(
      (-(tmpvar_63) * depthDiff_60)
    )));
  } else {
    tmpvar_64 = ((2.0 * tmpvar_62) * (_WaterColor * depthDiff_60));
  };
  refractionLighting_3 = (tmpvar_41 + ((backgroundColor_54 * 
    exp((-(tmpvar_63) * depthDiff_60))
  ) + (tmpvar_64 * tmpvar_61)));
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_66;
  tmpvar_66 = texture2D (_BeforeAlphaTexture, P_65).xyz;
  bgColor_1 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (bgColor_1, clamp ((
    (reflectionLighting_4 * tmpvar_36)
   + 
    (refractionLighting_3 * (1.0 - tmpvar_36))
  ), 0.0, 1.0), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_68;
  srcColor_68 = tmpvar_67;
  mediump vec3 tmpvar_69;
  tmpvar_69 = mix (srcColor_68, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = tmpvar_69;
  highp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_70;
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
uniform highp vec4 _ZBufferParams;
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
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DistortionFactor;
uniform highp float _DepthDiffScale;
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
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 refractionLighting_3;
  highp vec3 reflectionLighting_4;
  highp vec3 lightColor_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_9.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_10.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (tmpvar_9.x + tmpvar_11.x);
  tmpvar_13.y = (tmpvar_11.y + tmpvar_9.y);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_10.x + tmpvar_12.x);
  tmpvar_14.y = (tmpvar_12.y + tmpvar_10.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_NormalTexture1, tmpvar_13);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump float bumpScale_17;
  bumpScale_17 = _NormalIntensity;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * bumpScale_17);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NormalTexture2, tmpvar_14);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _NormalIntensity;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  mediump vec3 tmpvar_25;
  tmpvar_25 = (normal_18 + normal_23);
  N_8 = tmpvar_25;
  highp vec3 x_26;
  x_26 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (vec3(0.0, 1.0, 0.0), normalize(N_8.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_26, x_26)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_8 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = _LightColor0.xyz;
  lightColor_5 = tmpvar_28;
  refractionLighting_3 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  tmpvar_29 = texture2D (_CustomDepthTexture, tmpvar_30);
  highp float z_31;
  z_31 = tmpvar_29.x;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_31)
   + _ZBufferParams.w))) - (1.0/((
    (_ZBufferParams.z * (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))
   + _ZBufferParams.w))));
  highp float tmpvar_33;
  tmpvar_33 = (1.0 - abs(tmpvar_7.y));
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_33 * tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = ((tmpvar_33 * tmpvar_34) * tmpvar_34);
  highp vec3 tmpvar_36;
  tmpvar_36 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_35)
  ) + vec3(tmpvar_35)), 0.0, 1.0);
  highp vec4 reflectColor_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = -(tmpvar_7);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (tmpvar_27, I_39)
   * tmpvar_27)));
  lowp vec4 tmpvar_40;
  tmpvar_40 = textureCube (_WaterReflectionTexture, tmpvar_38);
  reflectColor_37 = tmpvar_40;
  reflectionLighting_4 = (((
    (clamp ((_SpecularIntensity * pow (
      max (abs(dot (tmpvar_27, normalize(
        (_ES_SunDirection + tmpvar_7)
      ))), 0.0001)
    , _Gloss)), 0.0, 16.0) * lightColor_5)
   * 
    pow (max ((1.0 - abs(
      dot (tmpvar_7, tmpvar_27)
    )), 0.0001), _SpecularPower)
  ) + reflectColor_37.xyz) + (_EdgeFoamColor * clamp (
    (xlv_COLOR.x * _EdgeFoamWidth)
  , 0.0, 1.0)));
  highp vec3 tmpvar_41;
  highp vec3 causticColor_42;
  highp vec4 color2_43;
  highp vec4 color1_44;
  highp float tmpvar_45;
  tmpvar_45 = ((_HeightDiff / abs(tmpvar_7.y)) * _DepthDiffScale);
  highp float tmpvar_46;
  tmpvar_46 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_47;
  tmpvar_47 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (tmpvar_47 + tmpvar_46);
  tmpvar_48 = texture2D (_CausticTex, P_49);
  color1_44 = tmpvar_48;
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = ((tmpvar_47 * vec2(1.5, 1.5)) - tmpvar_46);
  tmpvar_50 = texture2D (_CausticTex, P_51);
  color2_43 = tmpvar_50;
  highp vec2 tmpvar_52;
  tmpvar_52 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_7 * tmpvar_45)
  ).xz) + (_CausticDistortionValue * mix (color1_44.yz, color2_43.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_53;
  tmpvar_53 = texture2D (_CausticTex, tmpvar_52).xyz;
  causticColor_42 = tmpvar_53;
  causticColor_42 = (causticColor_42 * (_LightColor0.xyz * clamp (
    abs(tmpvar_6.y)
  , 0.0, 1.0)));
  causticColor_42 = (causticColor_42 * _CausticIntensity);
  causticColor_42 = (_CausticColor * causticColor_42.x);
  tmpvar_41 = (causticColor_42 * pow (max (
    clamp (((1.0/(_CausticFade)) * tmpvar_45), 0.0, 1.0)
  , 0.0001), _CausticFadePower));
  highp vec3 backgroundColor_54;
  highp float tmpvar_55;
  tmpvar_55 = abs(dot (tmpvar_7, tmpvar_27));
  highp vec2 tmpvar_56;
  tmpvar_56 = (((tmpvar_32 * 
    (tmpvar_27.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_BeforeAlphaTexture, tmpvar_56).xyz;
  backgroundColor_54 = tmpvar_57;
  lowp vec3 tmpvar_58;
  tmpvar_58 = _LightColor0.xyz;
  highp vec3 lightColor_59;
  lightColor_59 = tmpvar_58;
  highp float depthDiff_60;
  depthDiff_60 = (tmpvar_32 * _DepthDiffScale);
  highp vec3 tmpvar_61;
  tmpvar_61 = (max (0.3, tmpvar_6.y) * lightColor_59);
  highp vec3 tmpvar_62;
  tmpvar_62 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_63;
  tmpvar_63 = max ((tmpvar_62 * (1.0 + tmpvar_55)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_64;
  if ((tmpvar_55 > -0.99)) {
    tmpvar_64 = (((_WaterColor * 2.0) / (1.0 + tmpvar_55)) * (1.0 - exp(
      (-(tmpvar_63) * depthDiff_60)
    )));
  } else {
    tmpvar_64 = ((2.0 * tmpvar_62) * (_WaterColor * depthDiff_60));
  };
  refractionLighting_3 = (tmpvar_41 + ((backgroundColor_54 * 
    exp((-(tmpvar_63) * depthDiff_60))
  ) + (tmpvar_64 * tmpvar_61)));
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_66;
  tmpvar_66 = texture2D (_BeforeAlphaTexture, P_65).xyz;
  bgColor_1 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (bgColor_1, clamp ((
    (reflectionLighting_4 * tmpvar_36)
   + 
    (refractionLighting_3 * (1.0 - tmpvar_36))
  ), 0.0, 1.0), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_68;
  srcColor_68 = tmpvar_67;
  mediump vec3 tmpvar_69;
  tmpvar_69 = mix (srcColor_68, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = tmpvar_69;
  highp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_70;
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
uniform highp vec4 _ZBufferParams;
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
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DistortionFactor;
uniform highp float _DepthDiffScale;
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
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 refractionLighting_3;
  highp vec3 reflectionLighting_4;
  highp vec3 lightColor_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_9.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_10.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (tmpvar_9.x + tmpvar_11.x);
  tmpvar_13.y = (tmpvar_11.y + tmpvar_9.y);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_10.x + tmpvar_12.x);
  tmpvar_14.y = (tmpvar_12.y + tmpvar_10.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_NormalTexture1, tmpvar_13);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump float bumpScale_17;
  bumpScale_17 = _NormalIntensity;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * bumpScale_17);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NormalTexture2, tmpvar_14);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _NormalIntensity;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  mediump vec3 tmpvar_25;
  tmpvar_25 = (normal_18 + normal_23);
  N_8 = tmpvar_25;
  highp vec3 x_26;
  x_26 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (vec3(0.0, 1.0, 0.0), normalize(N_8.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_26, x_26)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_8 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = _LightColor0.xyz;
  lightColor_5 = tmpvar_28;
  refractionLighting_3 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  tmpvar_29 = texture2D (_CustomDepthTexture, tmpvar_30);
  highp float z_31;
  z_31 = tmpvar_29.x;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_31)
   + _ZBufferParams.w))) - (1.0/((
    (_ZBufferParams.z * (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))
   + _ZBufferParams.w))));
  highp float tmpvar_33;
  tmpvar_33 = (1.0 - abs(tmpvar_7.y));
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_33 * tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = ((tmpvar_33 * tmpvar_34) * tmpvar_34);
  highp vec3 tmpvar_36;
  tmpvar_36 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_35)
  ) + vec3(tmpvar_35)), 0.0, 1.0);
  highp vec4 reflectColor_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = -(tmpvar_7);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (tmpvar_27, I_39)
   * tmpvar_27)));
  lowp vec4 tmpvar_40;
  tmpvar_40 = textureCube (_WaterReflectionTexture, tmpvar_38);
  reflectColor_37 = tmpvar_40;
  reflectionLighting_4 = (((
    (clamp ((_SpecularIntensity * pow (
      max (abs(dot (tmpvar_27, normalize(
        (_ES_SunDirection + tmpvar_7)
      ))), 0.0001)
    , _Gloss)), 0.0, 16.0) * lightColor_5)
   * 
    pow (max ((1.0 - abs(
      dot (tmpvar_7, tmpvar_27)
    )), 0.0001), _SpecularPower)
  ) + reflectColor_37.xyz) + (_EdgeFoamColor * clamp (
    (xlv_COLOR.x * _EdgeFoamWidth)
  , 0.0, 1.0)));
  highp vec3 tmpvar_41;
  highp vec3 causticColor_42;
  highp vec4 color2_43;
  highp vec4 color1_44;
  highp float tmpvar_45;
  tmpvar_45 = ((_HeightDiff / abs(tmpvar_7.y)) * _DepthDiffScale);
  highp float tmpvar_46;
  tmpvar_46 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_47;
  tmpvar_47 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (tmpvar_47 + tmpvar_46);
  tmpvar_48 = texture2D (_CausticTex, P_49);
  color1_44 = tmpvar_48;
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = ((tmpvar_47 * vec2(1.5, 1.5)) - tmpvar_46);
  tmpvar_50 = texture2D (_CausticTex, P_51);
  color2_43 = tmpvar_50;
  highp vec2 tmpvar_52;
  tmpvar_52 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_7 * tmpvar_45)
  ).xz) + (_CausticDistortionValue * mix (color1_44.yz, color2_43.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_53;
  tmpvar_53 = texture2D (_CausticTex, tmpvar_52).xyz;
  causticColor_42 = tmpvar_53;
  causticColor_42 = (causticColor_42 * (_LightColor0.xyz * clamp (
    abs(tmpvar_6.y)
  , 0.0, 1.0)));
  causticColor_42 = (causticColor_42 * _CausticIntensity);
  causticColor_42 = (_CausticColor * causticColor_42.x);
  tmpvar_41 = (causticColor_42 * pow (max (
    clamp (((1.0/(_CausticFade)) * tmpvar_45), 0.0, 1.0)
  , 0.0001), _CausticFadePower));
  highp vec3 backgroundColor_54;
  highp float tmpvar_55;
  tmpvar_55 = abs(dot (tmpvar_7, tmpvar_27));
  highp vec2 tmpvar_56;
  tmpvar_56 = (((tmpvar_32 * 
    (tmpvar_27.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_BeforeAlphaTexture, tmpvar_56).xyz;
  backgroundColor_54 = tmpvar_57;
  lowp vec3 tmpvar_58;
  tmpvar_58 = _LightColor0.xyz;
  highp vec3 lightColor_59;
  lightColor_59 = tmpvar_58;
  highp float depthDiff_60;
  depthDiff_60 = (tmpvar_32 * _DepthDiffScale);
  highp vec3 tmpvar_61;
  tmpvar_61 = (max (0.3, tmpvar_6.y) * lightColor_59);
  highp vec3 tmpvar_62;
  tmpvar_62 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_63;
  tmpvar_63 = max ((tmpvar_62 * (1.0 + tmpvar_55)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_64;
  if ((tmpvar_55 > -0.99)) {
    tmpvar_64 = (((_WaterColor * 2.0) / (1.0 + tmpvar_55)) * (1.0 - exp(
      (-(tmpvar_63) * depthDiff_60)
    )));
  } else {
    tmpvar_64 = ((2.0 * tmpvar_62) * (_WaterColor * depthDiff_60));
  };
  refractionLighting_3 = (tmpvar_41 + ((backgroundColor_54 * 
    exp((-(tmpvar_63) * depthDiff_60))
  ) + (tmpvar_64 * tmpvar_61)));
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_66;
  tmpvar_66 = texture2D (_BeforeAlphaTexture, P_65).xyz;
  bgColor_1 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (bgColor_1, clamp ((
    (reflectionLighting_4 * tmpvar_36)
   + 
    (refractionLighting_3 * (1.0 - tmpvar_36))
  ), 0.0, 1.0), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_68;
  srcColor_68 = tmpvar_67;
  mediump vec3 tmpvar_69;
  tmpvar_69 = mix (srcColor_68, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = tmpvar_69;
  highp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_70;
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
uniform highp vec4 _ZBufferParams;
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
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DistortionFactor;
uniform highp float _DepthDiffScale;
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
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 refractionLighting_3;
  highp vec3 reflectionLighting_4;
  highp vec3 lightColor_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_9.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_10.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (tmpvar_9.x + tmpvar_11.x);
  tmpvar_13.y = (tmpvar_11.y + tmpvar_9.y);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_10.x + tmpvar_12.x);
  tmpvar_14.y = (tmpvar_12.y + tmpvar_10.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_NormalTexture1, tmpvar_13);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump float bumpScale_17;
  bumpScale_17 = _NormalIntensity;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * bumpScale_17);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NormalTexture2, tmpvar_14);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _NormalIntensity;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  mediump vec3 tmpvar_25;
  tmpvar_25 = (normal_18 + normal_23);
  N_8 = tmpvar_25;
  highp vec3 x_26;
  x_26 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (vec3(0.0, 1.0, 0.0), normalize(N_8.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_26, x_26)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_8 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = _LightColor0.xyz;
  lightColor_5 = tmpvar_28;
  refractionLighting_3 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  tmpvar_29 = texture2D (_CustomDepthTexture, tmpvar_30);
  highp float z_31;
  z_31 = tmpvar_29.x;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_31)
   + _ZBufferParams.w))) - (1.0/((
    (_ZBufferParams.z * (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))
   + _ZBufferParams.w))));
  highp float tmpvar_33;
  tmpvar_33 = (1.0 - abs(tmpvar_7.y));
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_33 * tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = ((tmpvar_33 * tmpvar_34) * tmpvar_34);
  highp vec3 tmpvar_36;
  tmpvar_36 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_35)
  ) + vec3(tmpvar_35)), 0.0, 1.0);
  highp vec4 reflectColor_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = -(tmpvar_7);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (tmpvar_27, I_39)
   * tmpvar_27)));
  lowp vec4 tmpvar_40;
  tmpvar_40 = textureCube (_WaterReflectionTexture, tmpvar_38);
  reflectColor_37 = tmpvar_40;
  reflectionLighting_4 = (((
    (clamp ((_SpecularIntensity * pow (
      max (abs(dot (tmpvar_27, normalize(
        (_ES_SunDirection + tmpvar_7)
      ))), 0.0001)
    , _Gloss)), 0.0, 16.0) * lightColor_5)
   * 
    pow (max ((1.0 - abs(
      dot (tmpvar_7, tmpvar_27)
    )), 0.0001), _SpecularPower)
  ) + reflectColor_37.xyz) + (_EdgeFoamColor * clamp (
    (xlv_COLOR.x * _EdgeFoamWidth)
  , 0.0, 1.0)));
  highp vec3 tmpvar_41;
  highp vec3 causticColor_42;
  highp vec4 color2_43;
  highp vec4 color1_44;
  highp float tmpvar_45;
  tmpvar_45 = ((_HeightDiff / abs(tmpvar_7.y)) * _DepthDiffScale);
  highp float tmpvar_46;
  tmpvar_46 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_47;
  tmpvar_47 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (tmpvar_47 + tmpvar_46);
  tmpvar_48 = texture2D (_CausticTex, P_49);
  color1_44 = tmpvar_48;
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = ((tmpvar_47 * vec2(1.5, 1.5)) - tmpvar_46);
  tmpvar_50 = texture2D (_CausticTex, P_51);
  color2_43 = tmpvar_50;
  highp vec2 tmpvar_52;
  tmpvar_52 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_7 * tmpvar_45)
  ).xz) + (_CausticDistortionValue * mix (color1_44.yz, color2_43.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_53;
  tmpvar_53 = texture2D (_CausticTex, tmpvar_52).xyz;
  causticColor_42 = tmpvar_53;
  causticColor_42 = (causticColor_42 * (_LightColor0.xyz * clamp (
    abs(tmpvar_6.y)
  , 0.0, 1.0)));
  causticColor_42 = (causticColor_42 * _CausticIntensity);
  causticColor_42 = (_CausticColor * causticColor_42.x);
  tmpvar_41 = (causticColor_42 * pow (max (
    clamp (((1.0/(_CausticFade)) * tmpvar_45), 0.0, 1.0)
  , 0.0001), _CausticFadePower));
  highp vec3 backgroundColor_54;
  highp float tmpvar_55;
  tmpvar_55 = abs(dot (tmpvar_7, tmpvar_27));
  highp vec2 tmpvar_56;
  tmpvar_56 = (((tmpvar_32 * 
    (tmpvar_27.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_BeforeAlphaTexture, tmpvar_56).xyz;
  backgroundColor_54 = tmpvar_57;
  lowp vec3 tmpvar_58;
  tmpvar_58 = _LightColor0.xyz;
  highp vec3 lightColor_59;
  lightColor_59 = tmpvar_58;
  highp float depthDiff_60;
  depthDiff_60 = (tmpvar_32 * _DepthDiffScale);
  highp vec3 tmpvar_61;
  tmpvar_61 = (max (0.3, tmpvar_6.y) * lightColor_59);
  highp vec3 tmpvar_62;
  tmpvar_62 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_63;
  tmpvar_63 = max ((tmpvar_62 * (1.0 + tmpvar_55)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_64;
  if ((tmpvar_55 > -0.99)) {
    tmpvar_64 = (((_WaterColor * 2.0) / (1.0 + tmpvar_55)) * (1.0 - exp(
      (-(tmpvar_63) * depthDiff_60)
    )));
  } else {
    tmpvar_64 = ((2.0 * tmpvar_62) * (_WaterColor * depthDiff_60));
  };
  refractionLighting_3 = (tmpvar_41 + ((backgroundColor_54 * 
    exp((-(tmpvar_63) * depthDiff_60))
  ) + (tmpvar_64 * tmpvar_61)));
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_66;
  tmpvar_66 = texture2D (_BeforeAlphaTexture, P_65).xyz;
  bgColor_1 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (bgColor_1, clamp ((
    (reflectionLighting_4 * tmpvar_36)
   + 
    (refractionLighting_3 * (1.0 - tmpvar_36))
  ), 0.0, 1.0), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_68;
  srcColor_68 = tmpvar_67;
  mediump vec3 tmpvar_69;
  tmpvar_69 = mix (srcColor_68, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = tmpvar_69;
  highp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_70;
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
uniform highp vec4 _ZBufferParams;
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
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _DistortionFactor;
uniform highp float _DepthDiffScale;
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
varying highp vec3 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 bgColor_1;
  highp vec3 finalColor_2;
  highp vec3 refractionLighting_3;
  highp vec3 reflectionLighting_4;
  highp vec3 lightColor_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(max (_ES_SunDirection, vec3(0.001, 0.001, 0.001)));
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec3 N_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _NormalSpeedU_1);
  tmpvar_9.y = (_Time.y * _NormalSpeedV_1);
  highp vec2 tmpvar_10;
  tmpvar_10.x = (_Time.y * _NormalSpeedU_2);
  tmpvar_10.y = (_Time.y * _NormalSpeedV_2);
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD1.xy * _NormalTexture1_ST.xy) + _NormalTexture1_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD1.xy * _NormalTexture2_ST.xy) + _NormalTexture2_ST.zw);
  highp vec2 tmpvar_13;
  tmpvar_13.x = (tmpvar_9.x + tmpvar_11.x);
  tmpvar_13.y = (tmpvar_11.y + tmpvar_9.y);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_10.x + tmpvar_12.x);
  tmpvar_14.y = (tmpvar_12.y + tmpvar_10.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_NormalTexture1, tmpvar_13);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump float bumpScale_17;
  bumpScale_17 = _NormalIntensity;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * bumpScale_17);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_NormalTexture2, tmpvar_14);
  mediump vec4 packednormal_21;
  packednormal_21 = tmpvar_20;
  mediump float bumpScale_22;
  bumpScale_22 = _NormalIntensity;
  mediump vec3 normal_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
  normal_23.z = tmpvar_24.z;
  normal_23.xy = (tmpvar_24.xy * bumpScale_22);
  mediump vec3 tmpvar_25;
  tmpvar_25 = (normal_18 + normal_23);
  N_8 = tmpvar_25;
  highp vec3 x_26;
  x_26 = (xlv_TEXCOORD3.xyz - _WorldSpaceCameraPos);
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (vec3(0.0, 1.0, 0.0), normalize(N_8.xzy), vec3(clamp ((
    (_NormalCoverageMax - sqrt(dot (x_26, x_26)))
   / 
    (_NormalCoverageMax - _NormalCoverageMin)
  ), 0.0, 1.0)));
  N_8 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = _LightColor0.xyz;
  lightColor_5 = tmpvar_28;
  refractionLighting_3 = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_29;
  highp vec2 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  tmpvar_29 = texture2D (_CustomDepthTexture, tmpvar_30);
  highp float z_31;
  z_31 = tmpvar_29.x;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_31)
   + _ZBufferParams.w))) - (1.0/((
    (_ZBufferParams.z * (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))
   + _ZBufferParams.w))));
  highp float tmpvar_33;
  tmpvar_33 = (1.0 - abs(tmpvar_7.y));
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_33 * tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = ((tmpvar_33 * tmpvar_34) * tmpvar_34);
  highp vec3 tmpvar_36;
  tmpvar_36 = clamp (((vec3(_Fresnel0) * 
    (1.0 - tmpvar_35)
  ) + vec3(tmpvar_35)), 0.0, 1.0);
  highp vec4 reflectColor_37;
  highp vec3 tmpvar_38;
  highp vec3 I_39;
  I_39 = -(tmpvar_7);
  tmpvar_38 = (I_39 - (2.0 * (
    dot (tmpvar_27, I_39)
   * tmpvar_27)));
  lowp vec4 tmpvar_40;
  tmpvar_40 = textureCube (_WaterReflectionTexture, tmpvar_38);
  reflectColor_37 = tmpvar_40;
  reflectionLighting_4 = (((
    (clamp ((_SpecularIntensity * pow (
      max (abs(dot (tmpvar_27, normalize(
        (_ES_SunDirection + tmpvar_7)
      ))), 0.0001)
    , _Gloss)), 0.0, 16.0) * lightColor_5)
   * 
    pow (max ((1.0 - abs(
      dot (tmpvar_7, tmpvar_27)
    )), 0.0001), _SpecularPower)
  ) + reflectColor_37.xyz) + (_EdgeFoamColor * clamp (
    (xlv_COLOR.x * _EdgeFoamWidth)
  , 0.0, 1.0)));
  highp vec3 tmpvar_41;
  highp vec3 causticColor_42;
  highp vec4 color2_43;
  highp vec4 color1_44;
  highp float tmpvar_45;
  tmpvar_45 = ((_HeightDiff / abs(tmpvar_7.y)) * _DepthDiffScale);
  highp float tmpvar_46;
  tmpvar_46 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_47;
  tmpvar_47 = (xlv_TEXCOORD1.xy * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (tmpvar_47 + tmpvar_46);
  tmpvar_48 = texture2D (_CausticTex, P_49);
  color1_44 = tmpvar_48;
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = ((tmpvar_47 * vec2(1.5, 1.5)) - tmpvar_46);
  tmpvar_50 = texture2D (_CausticTex, P_51);
  color2_43 = tmpvar_50;
  highp vec2 tmpvar_52;
  tmpvar_52 = ((_CausticTiling * (xlv_TEXCOORD3.xyz + 
    (tmpvar_7 * tmpvar_45)
  ).xz) + (_CausticDistortionValue * mix (color1_44.yz, color2_43.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_53;
  tmpvar_53 = texture2D (_CausticTex, tmpvar_52).xyz;
  causticColor_42 = tmpvar_53;
  causticColor_42 = (causticColor_42 * (_LightColor0.xyz * clamp (
    abs(tmpvar_6.y)
  , 0.0, 1.0)));
  causticColor_42 = (causticColor_42 * _CausticIntensity);
  causticColor_42 = (_CausticColor * causticColor_42.x);
  tmpvar_41 = (causticColor_42 * pow (max (
    clamp (((1.0/(_CausticFade)) * tmpvar_45), 0.0, 1.0)
  , 0.0001), _CausticFadePower));
  highp vec3 backgroundColor_54;
  highp float tmpvar_55;
  tmpvar_55 = abs(dot (tmpvar_7, tmpvar_27));
  highp vec2 tmpvar_56;
  tmpvar_56 = (((tmpvar_32 * 
    (tmpvar_27.xz * _DistortionFactor)
  ) + xlv_TEXCOORD2.xy) / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_BeforeAlphaTexture, tmpvar_56).xyz;
  backgroundColor_54 = tmpvar_57;
  lowp vec3 tmpvar_58;
  tmpvar_58 = _LightColor0.xyz;
  highp vec3 lightColor_59;
  lightColor_59 = tmpvar_58;
  highp float depthDiff_60;
  depthDiff_60 = (tmpvar_32 * _DepthDiffScale);
  highp vec3 tmpvar_61;
  tmpvar_61 = (max (0.3, tmpvar_6.y) * lightColor_59);
  highp vec3 tmpvar_62;
  tmpvar_62 = ((_Opacity / max (_WaterColor, vec3(0.001, 0.001, 0.001))) / 2.0);
  highp vec3 tmpvar_63;
  tmpvar_63 = max ((tmpvar_62 * (1.0 + tmpvar_55)), vec3(1e-06, 1e-06, 1e-06));
  highp vec3 tmpvar_64;
  if ((tmpvar_55 > -0.99)) {
    tmpvar_64 = (((_WaterColor * 2.0) / (1.0 + tmpvar_55)) * (1.0 - exp(
      (-(tmpvar_63) * depthDiff_60)
    )));
  } else {
    tmpvar_64 = ((2.0 * tmpvar_62) * (_WaterColor * depthDiff_60));
  };
  refractionLighting_3 = (tmpvar_41 + ((backgroundColor_54 * 
    exp((-(tmpvar_63) * depthDiff_60))
  ) + (tmpvar_64 * tmpvar_61)));
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec3 tmpvar_66;
  tmpvar_66 = texture2D (_BeforeAlphaTexture, P_65).xyz;
  bgColor_1 = tmpvar_66;
  highp vec3 tmpvar_67;
  tmpvar_67 = mix (bgColor_1, clamp ((
    (reflectionLighting_4 * tmpvar_36)
   + 
    (refractionLighting_3 * (1.0 - tmpvar_36))
  ), 0.0, 1.0), vec3((1.0 - clamp (
    (_EdgeTransparentWidth * xlv_COLOR.x)
  , 0.0, 1.0))));
  mediump vec3 srcColor_68;
  srcColor_68 = tmpvar_67;
  mediump vec3 tmpvar_69;
  tmpvar_69 = mix (srcColor_68, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2 = tmpvar_69;
  highp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = finalColor_2;
  gl_FragData[0] = tmpvar_70;
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
}
}
}
}