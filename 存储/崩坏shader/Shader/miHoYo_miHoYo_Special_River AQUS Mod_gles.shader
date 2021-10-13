//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/River AQUS Mod" {
Properties {
[Header(MainColor)] _RefractColor ("Refract Color", Color) = (0,0.4627451,1,1)
_ReflectColor ("Reflect Color", Color) = (1,1,1,1)
_WaterColor ("Water Color", Color) = (1,1,1,1)
_FrontRefractFade ("Front Refract Fade", Float) = 1.45
_BackRefractFade ("Back Refract Fade", Float) = 1.45
_FrontDensity ("Front Density", Range(0, 10)) = 1.74
_BackDensity ("Back Density", Range(0, 10)) = 1.74
[Header(Transparency)] _FrontShoreTransparency ("Front Shore Transparency", Range(0.0001, 100)) = 0.04
_FrontShoreFade ("Front Shore Fade", Range(0.0001, 100)) = 0.3
_BackShoreTransparency ("Back Shore Transparency", Range(0.0001, 10)) = 0.04
_BackShoreFade ("Back Shore Fade", Range(0.0001, 10)) = 0.3
[Header(Fresnel)] _FrontFresnelBias ("Front Fresnel Bias", Range(0, 1)) = 0.1
_BackFresnelBias ("Back Fresnel Bias", Range(0, 1)) = 0.1
[Header(Specular)] _SunDir ("Sun Dir", Vector) = (1,1,1,1)
_Specular ("Water Specular Color strength", Range(0, 3)) = 0.15
_Gloss ("Water Gloss", Float) = 0.7
[Header(Refraction)] _ReflectionTex ("Reflection", 2D) = "white" { }
_FrontRefractDistort ("Front Refraction Distort", Range(0, 0.1)) = 0.067
_BackRefractDistort ("Back Refraction Distort", Range(0, 1)) = 0.067
_FrontReflectIntensity ("Front Reflection Intensity", Range(0, 1)) = 0.6
_BackReflectIntensity ("Back Reflection Intensity", Range(0, 1)) = 0.6
_FrontReflectDistort ("Front Reflction Distortion", Range(0, 5)) = 0.3
_BackReflectDistort ("Back Reflection Distortion", Range(0, 5)) = 0.3
_FrontReflectLerpFactor ("Front Reflect Lerp Factor", Range(0, 0.1)) = 0.005
_BackReflectLerpFactor ("Back Reflect Lerp Factor", Range(0, 0.1)) = 0.005
_BackCriticalAngle ("Total Reflection Critial Angle", Range(0, 90)) = 65
_BackAngleDistort ("Critial Angle Distort", Range(0, 500)) = 65
_BackFogDensity ("Back Fog Density", Range(0, 10)) = 0.5
_BackFogEffectLimit ("Back Fog Effect Limit", Range(0, 1)) = 0.5
_BackFogEffectStart ("Back Fog Effect Start", Range(0, 1)) = 0.5
_BackFogStart ("Back Apply Fog Start", Range(0, 1000)) = 100
_BackFogEnd ("Back Apply Fog End", Range(0, 1000)) = 200
[Header(Small Wave)] _SmallWavesTexture ("Small Waves Bump", 2D) = "bump" { }
_SmallWavesParams ("Small Waves Tilling(X, Y) Speed(Z, W)", Vector) = (1,1,1,1)
[Header(Large Wave)] _LargeWavesTexture ("Large Waves Bump", 2D) = "bump" { }
_LargeWavesParams ("Large Waves Tilling(X, Y) Speed(Z, W)", Vector) = (1,1,1,1)
[Header(Shore Foam)] _ShoreFoam ("Foam", 2D) = "black" { }
_ShoreFoamParams ("Shore Foam Tilling(X, Y) Speed(Z, W)", Vector) = (10,10,1,1)
_ShoreFoamColor ("ShoreFoam Color", Color) = (1,1,1,0)
_ShoreFoamColorStrength ("Shore Foam Color Strength", Range(0, 1000)) = 1
_ShoreFoamDepth ("Shore Foam Depth", Range(0, 500)) = 0.3
}
SubShader {
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FRONT"
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 57682
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
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
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
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
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase.xyz + (h_38 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_40 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  tmpvar_30 = tmpvar_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase.xyz + (h_38 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_40 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  tmpvar_30 = tmpvar_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase.xyz + (h_38 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_40 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  tmpvar_30 = tmpvar_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase2.xyz + (h_38 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_40 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams2.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams2.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase2.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor2.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  highp vec4 tmpvar_66;
  mediump float fogFactor_67;
  mediump vec3 fogColor_68;
  mediump vec3 heightFogColor_69;
  highp float HeightFogFactor_70;
  mediump vec3 atomesphereFogColor_71;
  mediump float h_72;
  highp float linearFogDensity_73;
  mediump float len_74;
  highp float tmpvar_75;
  tmpvar_75 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_74 = tmpvar_75;
  highp float tmpvar_76;
  tmpvar_76 = clamp (((len_74 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_73 = (tmpvar_76 * (2.0 - tmpvar_76));
  if ((len_74 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_73 = (linearFogDensity_73 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_77;
  tmpvar_77 = min (pow (linearFogDensity_73, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_73 = tmpvar_77;
  mediump float tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_25.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  h_72 = (tmpvar_78 * (2.0 - tmpvar_78));
  highp vec3 tmpvar_80;
  tmpvar_80 = (_HeigtFogColBase3.xyz + (h_72 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_71 = tmpvar_80;
  highp vec3 tmpvar_81;
  tmpvar_81 = mix (atomesphereFogColor_71, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_74 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_71 = tmpvar_81;
  mediump float tmpvar_82;
  mediump float r_83;
  mediump float f_84;
  mediump float u_85;
  mediump float l_86;
  mediump float fogInt_87;
  fogInt_87 = 1.0;
  highp float tmpvar_88;
  tmpvar_88 = (_HeigtFogParams3.x * tmpvar_31.y);
  highp float tmpvar_89;
  tmpvar_89 = abs(tmpvar_88);
  if ((tmpvar_89 > 0.01)) {
    highp float tmpvar_90;
    tmpvar_90 = exp(-(tmpvar_88));
    fogInt_87 = ((1.0 - tmpvar_90) / tmpvar_88);
  };
  highp float tmpvar_91;
  tmpvar_91 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_86 = tmpvar_91;
  highp float tmpvar_92;
  tmpvar_92 = (l_86 * _HeigtFogParams3.y);
  u_85 = tmpvar_92;
  fogInt_87 = (fogInt_87 * u_85);
  mediump float tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = clamp (((l_86 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_93 = tmpvar_94;
  r_83 = (tmpvar_93 * (2.0 - tmpvar_93));
  r_83 = ((r_83 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_84 = ((1.0 - clamp (
    exp2(-(fogInt_87))
  , 0.0, 1.0)) * r_83);
  highp float tmpvar_95;
  tmpvar_95 = min (f_84, _HeigtFogColBase3.w);
  tmpvar_82 = tmpvar_95;
  HeightFogFactor_70 = tmpvar_82;
  highp vec3 tmpvar_96;
  tmpvar_96 = _Mihoyo_FogColor3.xyz;
  heightFogColor_69 = tmpvar_96;
  highp vec3 tmpvar_97;
  tmpvar_97 = ((heightFogColor_69 * HeightFogFactor_70) + ((atomesphereFogColor_71 * tmpvar_77) * (1.0 - HeightFogFactor_70)));
  fogColor_68 = tmpvar_97;
  highp float tmpvar_98;
  tmpvar_98 = ((1.0 - tmpvar_77) * (1.0 - HeightFogFactor_70));
  fogFactor_67 = tmpvar_98;
  mediump vec4 tmpvar_99;
  tmpvar_99.xyz = fogColor_68;
  tmpvar_99.w = fogFactor_67;
  tmpvar_66 = tmpvar_99;
  highp vec4 tmpvar_100;
  tmpvar_100 = mix (tmpvar_32, tmpvar_66, vec4(_LerpFactor));
  tmpvar_30 = tmpvar_100;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase2.xyz + (h_38 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_40 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams2.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams2.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase2.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor2.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  highp vec4 tmpvar_66;
  mediump float fogFactor_67;
  mediump vec3 fogColor_68;
  mediump vec3 heightFogColor_69;
  highp float HeightFogFactor_70;
  mediump vec3 atomesphereFogColor_71;
  mediump float h_72;
  highp float linearFogDensity_73;
  mediump float len_74;
  highp float tmpvar_75;
  tmpvar_75 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_74 = tmpvar_75;
  highp float tmpvar_76;
  tmpvar_76 = clamp (((len_74 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_73 = (tmpvar_76 * (2.0 - tmpvar_76));
  if ((len_74 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_73 = (linearFogDensity_73 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_77;
  tmpvar_77 = min (pow (linearFogDensity_73, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_73 = tmpvar_77;
  mediump float tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_25.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  h_72 = (tmpvar_78 * (2.0 - tmpvar_78));
  highp vec3 tmpvar_80;
  tmpvar_80 = (_HeigtFogColBase3.xyz + (h_72 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_71 = tmpvar_80;
  highp vec3 tmpvar_81;
  tmpvar_81 = mix (atomesphereFogColor_71, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_74 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_71 = tmpvar_81;
  mediump float tmpvar_82;
  mediump float r_83;
  mediump float f_84;
  mediump float u_85;
  mediump float l_86;
  mediump float fogInt_87;
  fogInt_87 = 1.0;
  highp float tmpvar_88;
  tmpvar_88 = (_HeigtFogParams3.x * tmpvar_31.y);
  highp float tmpvar_89;
  tmpvar_89 = abs(tmpvar_88);
  if ((tmpvar_89 > 0.01)) {
    highp float tmpvar_90;
    tmpvar_90 = exp(-(tmpvar_88));
    fogInt_87 = ((1.0 - tmpvar_90) / tmpvar_88);
  };
  highp float tmpvar_91;
  tmpvar_91 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_86 = tmpvar_91;
  highp float tmpvar_92;
  tmpvar_92 = (l_86 * _HeigtFogParams3.y);
  u_85 = tmpvar_92;
  fogInt_87 = (fogInt_87 * u_85);
  mediump float tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = clamp (((l_86 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_93 = tmpvar_94;
  r_83 = (tmpvar_93 * (2.0 - tmpvar_93));
  r_83 = ((r_83 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_84 = ((1.0 - clamp (
    exp2(-(fogInt_87))
  , 0.0, 1.0)) * r_83);
  highp float tmpvar_95;
  tmpvar_95 = min (f_84, _HeigtFogColBase3.w);
  tmpvar_82 = tmpvar_95;
  HeightFogFactor_70 = tmpvar_82;
  highp vec3 tmpvar_96;
  tmpvar_96 = _Mihoyo_FogColor3.xyz;
  heightFogColor_69 = tmpvar_96;
  highp vec3 tmpvar_97;
  tmpvar_97 = ((heightFogColor_69 * HeightFogFactor_70) + ((atomesphereFogColor_71 * tmpvar_77) * (1.0 - HeightFogFactor_70)));
  fogColor_68 = tmpvar_97;
  highp float tmpvar_98;
  tmpvar_98 = ((1.0 - tmpvar_77) * (1.0 - HeightFogFactor_70));
  fogFactor_67 = tmpvar_98;
  mediump vec4 tmpvar_99;
  tmpvar_99.xyz = fogColor_68;
  tmpvar_99.w = fogFactor_67;
  tmpvar_66 = tmpvar_99;
  highp vec4 tmpvar_100;
  tmpvar_100 = mix (tmpvar_32, tmpvar_66, vec4(_LerpFactor));
  tmpvar_30 = tmpvar_100;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase2.xyz + (h_38 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_40 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams2.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams2.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase2.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor2.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  highp vec4 tmpvar_66;
  mediump float fogFactor_67;
  mediump vec3 fogColor_68;
  mediump vec3 heightFogColor_69;
  highp float HeightFogFactor_70;
  mediump vec3 atomesphereFogColor_71;
  mediump float h_72;
  highp float linearFogDensity_73;
  mediump float len_74;
  highp float tmpvar_75;
  tmpvar_75 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_74 = tmpvar_75;
  highp float tmpvar_76;
  tmpvar_76 = clamp (((len_74 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_73 = (tmpvar_76 * (2.0 - tmpvar_76));
  if ((len_74 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_73 = (linearFogDensity_73 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_77;
  tmpvar_77 = min (pow (linearFogDensity_73, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_73 = tmpvar_77;
  mediump float tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_25.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  h_72 = (tmpvar_78 * (2.0 - tmpvar_78));
  highp vec3 tmpvar_80;
  tmpvar_80 = (_HeigtFogColBase3.xyz + (h_72 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_71 = tmpvar_80;
  highp vec3 tmpvar_81;
  tmpvar_81 = mix (atomesphereFogColor_71, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_74 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_71 = tmpvar_81;
  mediump float tmpvar_82;
  mediump float r_83;
  mediump float f_84;
  mediump float u_85;
  mediump float l_86;
  mediump float fogInt_87;
  fogInt_87 = 1.0;
  highp float tmpvar_88;
  tmpvar_88 = (_HeigtFogParams3.x * tmpvar_31.y);
  highp float tmpvar_89;
  tmpvar_89 = abs(tmpvar_88);
  if ((tmpvar_89 > 0.01)) {
    highp float tmpvar_90;
    tmpvar_90 = exp(-(tmpvar_88));
    fogInt_87 = ((1.0 - tmpvar_90) / tmpvar_88);
  };
  highp float tmpvar_91;
  tmpvar_91 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_86 = tmpvar_91;
  highp float tmpvar_92;
  tmpvar_92 = (l_86 * _HeigtFogParams3.y);
  u_85 = tmpvar_92;
  fogInt_87 = (fogInt_87 * u_85);
  mediump float tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = clamp (((l_86 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_93 = tmpvar_94;
  r_83 = (tmpvar_93 * (2.0 - tmpvar_93));
  r_83 = ((r_83 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_84 = ((1.0 - clamp (
    exp2(-(fogInt_87))
  , 0.0, 1.0)) * r_83);
  highp float tmpvar_95;
  tmpvar_95 = min (f_84, _HeigtFogColBase3.w);
  tmpvar_82 = tmpvar_95;
  HeightFogFactor_70 = tmpvar_82;
  highp vec3 tmpvar_96;
  tmpvar_96 = _Mihoyo_FogColor3.xyz;
  heightFogColor_69 = tmpvar_96;
  highp vec3 tmpvar_97;
  tmpvar_97 = ((heightFogColor_69 * HeightFogFactor_70) + ((atomesphereFogColor_71 * tmpvar_77) * (1.0 - HeightFogFactor_70)));
  fogColor_68 = tmpvar_97;
  highp float tmpvar_98;
  tmpvar_98 = ((1.0 - tmpvar_77) * (1.0 - HeightFogFactor_70));
  fogFactor_67 = tmpvar_98;
  mediump vec4 tmpvar_99;
  tmpvar_99.xyz = fogColor_68;
  tmpvar_99.w = fogFactor_67;
  tmpvar_66 = tmpvar_99;
  highp vec4 tmpvar_100;
  tmpvar_100 = mix (tmpvar_32, tmpvar_66, vec4(_LerpFactor));
  tmpvar_30 = tmpvar_100;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase.xyz + (h_38 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_40 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  tmpvar_30 = tmpvar_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase.xyz + (h_38 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_40 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  tmpvar_30 = tmpvar_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase.xyz + (h_38 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_40 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  tmpvar_30 = tmpvar_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase2.xyz + (h_38 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_40 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams2.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams2.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase2.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor2.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  highp vec4 tmpvar_66;
  mediump float fogFactor_67;
  mediump vec3 fogColor_68;
  mediump vec3 heightFogColor_69;
  highp float HeightFogFactor_70;
  mediump vec3 atomesphereFogColor_71;
  mediump float h_72;
  highp float linearFogDensity_73;
  mediump float len_74;
  highp float tmpvar_75;
  tmpvar_75 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_74 = tmpvar_75;
  highp float tmpvar_76;
  tmpvar_76 = clamp (((len_74 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_73 = (tmpvar_76 * (2.0 - tmpvar_76));
  if ((len_74 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_73 = (linearFogDensity_73 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_77;
  tmpvar_77 = min (pow (linearFogDensity_73, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_73 = tmpvar_77;
  mediump float tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_25.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  h_72 = (tmpvar_78 * (2.0 - tmpvar_78));
  highp vec3 tmpvar_80;
  tmpvar_80 = (_HeigtFogColBase3.xyz + (h_72 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_71 = tmpvar_80;
  highp vec3 tmpvar_81;
  tmpvar_81 = mix (atomesphereFogColor_71, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_74 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_71 = tmpvar_81;
  mediump float tmpvar_82;
  mediump float r_83;
  mediump float f_84;
  mediump float u_85;
  mediump float l_86;
  mediump float fogInt_87;
  fogInt_87 = 1.0;
  highp float tmpvar_88;
  tmpvar_88 = (_HeigtFogParams3.x * tmpvar_31.y);
  highp float tmpvar_89;
  tmpvar_89 = abs(tmpvar_88);
  if ((tmpvar_89 > 0.01)) {
    highp float tmpvar_90;
    tmpvar_90 = exp(-(tmpvar_88));
    fogInt_87 = ((1.0 - tmpvar_90) / tmpvar_88);
  };
  highp float tmpvar_91;
  tmpvar_91 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_86 = tmpvar_91;
  highp float tmpvar_92;
  tmpvar_92 = (l_86 * _HeigtFogParams3.y);
  u_85 = tmpvar_92;
  fogInt_87 = (fogInt_87 * u_85);
  mediump float tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = clamp (((l_86 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_93 = tmpvar_94;
  r_83 = (tmpvar_93 * (2.0 - tmpvar_93));
  r_83 = ((r_83 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_84 = ((1.0 - clamp (
    exp2(-(fogInt_87))
  , 0.0, 1.0)) * r_83);
  highp float tmpvar_95;
  tmpvar_95 = min (f_84, _HeigtFogColBase3.w);
  tmpvar_82 = tmpvar_95;
  HeightFogFactor_70 = tmpvar_82;
  highp vec3 tmpvar_96;
  tmpvar_96 = _Mihoyo_FogColor3.xyz;
  heightFogColor_69 = tmpvar_96;
  highp vec3 tmpvar_97;
  tmpvar_97 = ((heightFogColor_69 * HeightFogFactor_70) + ((atomesphereFogColor_71 * tmpvar_77) * (1.0 - HeightFogFactor_70)));
  fogColor_68 = tmpvar_97;
  highp float tmpvar_98;
  tmpvar_98 = ((1.0 - tmpvar_77) * (1.0 - HeightFogFactor_70));
  fogFactor_67 = tmpvar_98;
  mediump vec4 tmpvar_99;
  tmpvar_99.xyz = fogColor_68;
  tmpvar_99.w = fogFactor_67;
  tmpvar_66 = tmpvar_99;
  highp vec4 tmpvar_100;
  tmpvar_100 = mix (tmpvar_32, tmpvar_66, vec4(_LerpFactor));
  tmpvar_30 = tmpvar_100;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase2.xyz + (h_38 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_40 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams2.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams2.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase2.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor2.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  highp vec4 tmpvar_66;
  mediump float fogFactor_67;
  mediump vec3 fogColor_68;
  mediump vec3 heightFogColor_69;
  highp float HeightFogFactor_70;
  mediump vec3 atomesphereFogColor_71;
  mediump float h_72;
  highp float linearFogDensity_73;
  mediump float len_74;
  highp float tmpvar_75;
  tmpvar_75 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_74 = tmpvar_75;
  highp float tmpvar_76;
  tmpvar_76 = clamp (((len_74 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_73 = (tmpvar_76 * (2.0 - tmpvar_76));
  if ((len_74 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_73 = (linearFogDensity_73 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_77;
  tmpvar_77 = min (pow (linearFogDensity_73, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_73 = tmpvar_77;
  mediump float tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_25.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  h_72 = (tmpvar_78 * (2.0 - tmpvar_78));
  highp vec3 tmpvar_80;
  tmpvar_80 = (_HeigtFogColBase3.xyz + (h_72 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_71 = tmpvar_80;
  highp vec3 tmpvar_81;
  tmpvar_81 = mix (atomesphereFogColor_71, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_74 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_71 = tmpvar_81;
  mediump float tmpvar_82;
  mediump float r_83;
  mediump float f_84;
  mediump float u_85;
  mediump float l_86;
  mediump float fogInt_87;
  fogInt_87 = 1.0;
  highp float tmpvar_88;
  tmpvar_88 = (_HeigtFogParams3.x * tmpvar_31.y);
  highp float tmpvar_89;
  tmpvar_89 = abs(tmpvar_88);
  if ((tmpvar_89 > 0.01)) {
    highp float tmpvar_90;
    tmpvar_90 = exp(-(tmpvar_88));
    fogInt_87 = ((1.0 - tmpvar_90) / tmpvar_88);
  };
  highp float tmpvar_91;
  tmpvar_91 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_86 = tmpvar_91;
  highp float tmpvar_92;
  tmpvar_92 = (l_86 * _HeigtFogParams3.y);
  u_85 = tmpvar_92;
  fogInt_87 = (fogInt_87 * u_85);
  mediump float tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = clamp (((l_86 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_93 = tmpvar_94;
  r_83 = (tmpvar_93 * (2.0 - tmpvar_93));
  r_83 = ((r_83 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_84 = ((1.0 - clamp (
    exp2(-(fogInt_87))
  , 0.0, 1.0)) * r_83);
  highp float tmpvar_95;
  tmpvar_95 = min (f_84, _HeigtFogColBase3.w);
  tmpvar_82 = tmpvar_95;
  HeightFogFactor_70 = tmpvar_82;
  highp vec3 tmpvar_96;
  tmpvar_96 = _Mihoyo_FogColor3.xyz;
  heightFogColor_69 = tmpvar_96;
  highp vec3 tmpvar_97;
  tmpvar_97 = ((heightFogColor_69 * HeightFogFactor_70) + ((atomesphereFogColor_71 * tmpvar_77) * (1.0 - HeightFogFactor_70)));
  fogColor_68 = tmpvar_97;
  highp float tmpvar_98;
  tmpvar_98 = ((1.0 - tmpvar_77) * (1.0 - HeightFogFactor_70));
  fogFactor_67 = tmpvar_98;
  mediump vec4 tmpvar_99;
  tmpvar_99.xyz = fogColor_68;
  tmpvar_99.w = fogFactor_67;
  tmpvar_66 = tmpvar_99;
  highp vec4 tmpvar_100;
  tmpvar_100 = mix (tmpvar_32, tmpvar_66, vec4(_LerpFactor));
  tmpvar_30 = tmpvar_100;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase2.xyz + (h_38 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_40 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams2.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams2.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase2.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor2.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  highp vec4 tmpvar_66;
  mediump float fogFactor_67;
  mediump vec3 fogColor_68;
  mediump vec3 heightFogColor_69;
  highp float HeightFogFactor_70;
  mediump vec3 atomesphereFogColor_71;
  mediump float h_72;
  highp float linearFogDensity_73;
  mediump float len_74;
  highp float tmpvar_75;
  tmpvar_75 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_74 = tmpvar_75;
  highp float tmpvar_76;
  tmpvar_76 = clamp (((len_74 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_73 = (tmpvar_76 * (2.0 - tmpvar_76));
  if ((len_74 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_73 = (linearFogDensity_73 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_77;
  tmpvar_77 = min (pow (linearFogDensity_73, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_73 = tmpvar_77;
  mediump float tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_25.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  h_72 = (tmpvar_78 * (2.0 - tmpvar_78));
  highp vec3 tmpvar_80;
  tmpvar_80 = (_HeigtFogColBase3.xyz + (h_72 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_71 = tmpvar_80;
  highp vec3 tmpvar_81;
  tmpvar_81 = mix (atomesphereFogColor_71, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_74 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_71 = tmpvar_81;
  mediump float tmpvar_82;
  mediump float r_83;
  mediump float f_84;
  mediump float u_85;
  mediump float l_86;
  mediump float fogInt_87;
  fogInt_87 = 1.0;
  highp float tmpvar_88;
  tmpvar_88 = (_HeigtFogParams3.x * tmpvar_31.y);
  highp float tmpvar_89;
  tmpvar_89 = abs(tmpvar_88);
  if ((tmpvar_89 > 0.01)) {
    highp float tmpvar_90;
    tmpvar_90 = exp(-(tmpvar_88));
    fogInt_87 = ((1.0 - tmpvar_90) / tmpvar_88);
  };
  highp float tmpvar_91;
  tmpvar_91 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_86 = tmpvar_91;
  highp float tmpvar_92;
  tmpvar_92 = (l_86 * _HeigtFogParams3.y);
  u_85 = tmpvar_92;
  fogInt_87 = (fogInt_87 * u_85);
  mediump float tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = clamp (((l_86 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_93 = tmpvar_94;
  r_83 = (tmpvar_93 * (2.0 - tmpvar_93));
  r_83 = ((r_83 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_84 = ((1.0 - clamp (
    exp2(-(fogInt_87))
  , 0.0, 1.0)) * r_83);
  highp float tmpvar_95;
  tmpvar_95 = min (f_84, _HeigtFogColBase3.w);
  tmpvar_82 = tmpvar_95;
  HeightFogFactor_70 = tmpvar_82;
  highp vec3 tmpvar_96;
  tmpvar_96 = _Mihoyo_FogColor3.xyz;
  heightFogColor_69 = tmpvar_96;
  highp vec3 tmpvar_97;
  tmpvar_97 = ((heightFogColor_69 * HeightFogFactor_70) + ((atomesphereFogColor_71 * tmpvar_77) * (1.0 - HeightFogFactor_70)));
  fogColor_68 = tmpvar_97;
  highp float tmpvar_98;
  tmpvar_98 = ((1.0 - tmpvar_77) * (1.0 - HeightFogFactor_70));
  fogFactor_67 = tmpvar_98;
  mediump vec4 tmpvar_99;
  tmpvar_99.xyz = fogColor_68;
  tmpvar_99.w = fogFactor_67;
  tmpvar_66 = tmpvar_99;
  highp vec4 tmpvar_100;
  tmpvar_100 = mix (tmpvar_32, tmpvar_66, vec4(_LerpFactor));
  tmpvar_30 = tmpvar_100;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase.xyz + (h_38 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_40 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  tmpvar_30 = tmpvar_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase.xyz + (h_38 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_40 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  tmpvar_30 = tmpvar_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase.xyz + (h_38 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_40 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  tmpvar_30 = tmpvar_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase2.xyz + (h_38 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_40 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams2.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams2.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase2.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor2.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  highp vec4 tmpvar_66;
  mediump float fogFactor_67;
  mediump vec3 fogColor_68;
  mediump vec3 heightFogColor_69;
  highp float HeightFogFactor_70;
  mediump vec3 atomesphereFogColor_71;
  mediump float h_72;
  highp float linearFogDensity_73;
  mediump float len_74;
  highp float tmpvar_75;
  tmpvar_75 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_74 = tmpvar_75;
  highp float tmpvar_76;
  tmpvar_76 = clamp (((len_74 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_73 = (tmpvar_76 * (2.0 - tmpvar_76));
  if ((len_74 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_73 = (linearFogDensity_73 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_77;
  tmpvar_77 = min (pow (linearFogDensity_73, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_73 = tmpvar_77;
  mediump float tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_25.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  h_72 = (tmpvar_78 * (2.0 - tmpvar_78));
  highp vec3 tmpvar_80;
  tmpvar_80 = (_HeigtFogColBase3.xyz + (h_72 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_71 = tmpvar_80;
  highp vec3 tmpvar_81;
  tmpvar_81 = mix (atomesphereFogColor_71, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_74 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_71 = tmpvar_81;
  mediump float tmpvar_82;
  mediump float r_83;
  mediump float f_84;
  mediump float u_85;
  mediump float l_86;
  mediump float fogInt_87;
  fogInt_87 = 1.0;
  highp float tmpvar_88;
  tmpvar_88 = (_HeigtFogParams3.x * tmpvar_31.y);
  highp float tmpvar_89;
  tmpvar_89 = abs(tmpvar_88);
  if ((tmpvar_89 > 0.01)) {
    highp float tmpvar_90;
    tmpvar_90 = exp(-(tmpvar_88));
    fogInt_87 = ((1.0 - tmpvar_90) / tmpvar_88);
  };
  highp float tmpvar_91;
  tmpvar_91 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_86 = tmpvar_91;
  highp float tmpvar_92;
  tmpvar_92 = (l_86 * _HeigtFogParams3.y);
  u_85 = tmpvar_92;
  fogInt_87 = (fogInt_87 * u_85);
  mediump float tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = clamp (((l_86 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_93 = tmpvar_94;
  r_83 = (tmpvar_93 * (2.0 - tmpvar_93));
  r_83 = ((r_83 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_84 = ((1.0 - clamp (
    exp2(-(fogInt_87))
  , 0.0, 1.0)) * r_83);
  highp float tmpvar_95;
  tmpvar_95 = min (f_84, _HeigtFogColBase3.w);
  tmpvar_82 = tmpvar_95;
  HeightFogFactor_70 = tmpvar_82;
  highp vec3 tmpvar_96;
  tmpvar_96 = _Mihoyo_FogColor3.xyz;
  heightFogColor_69 = tmpvar_96;
  highp vec3 tmpvar_97;
  tmpvar_97 = ((heightFogColor_69 * HeightFogFactor_70) + ((atomesphereFogColor_71 * tmpvar_77) * (1.0 - HeightFogFactor_70)));
  fogColor_68 = tmpvar_97;
  highp float tmpvar_98;
  tmpvar_98 = ((1.0 - tmpvar_77) * (1.0 - HeightFogFactor_70));
  fogFactor_67 = tmpvar_98;
  mediump vec4 tmpvar_99;
  tmpvar_99.xyz = fogColor_68;
  tmpvar_99.w = fogFactor_67;
  tmpvar_66 = tmpvar_99;
  highp vec4 tmpvar_100;
  tmpvar_100 = mix (tmpvar_32, tmpvar_66, vec4(_LerpFactor));
  tmpvar_30 = tmpvar_100;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase2.xyz + (h_38 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_40 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams2.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams2.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase2.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor2.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  highp vec4 tmpvar_66;
  mediump float fogFactor_67;
  mediump vec3 fogColor_68;
  mediump vec3 heightFogColor_69;
  highp float HeightFogFactor_70;
  mediump vec3 atomesphereFogColor_71;
  mediump float h_72;
  highp float linearFogDensity_73;
  mediump float len_74;
  highp float tmpvar_75;
  tmpvar_75 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_74 = tmpvar_75;
  highp float tmpvar_76;
  tmpvar_76 = clamp (((len_74 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_73 = (tmpvar_76 * (2.0 - tmpvar_76));
  if ((len_74 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_73 = (linearFogDensity_73 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_77;
  tmpvar_77 = min (pow (linearFogDensity_73, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_73 = tmpvar_77;
  mediump float tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_25.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  h_72 = (tmpvar_78 * (2.0 - tmpvar_78));
  highp vec3 tmpvar_80;
  tmpvar_80 = (_HeigtFogColBase3.xyz + (h_72 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_71 = tmpvar_80;
  highp vec3 tmpvar_81;
  tmpvar_81 = mix (atomesphereFogColor_71, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_74 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_71 = tmpvar_81;
  mediump float tmpvar_82;
  mediump float r_83;
  mediump float f_84;
  mediump float u_85;
  mediump float l_86;
  mediump float fogInt_87;
  fogInt_87 = 1.0;
  highp float tmpvar_88;
  tmpvar_88 = (_HeigtFogParams3.x * tmpvar_31.y);
  highp float tmpvar_89;
  tmpvar_89 = abs(tmpvar_88);
  if ((tmpvar_89 > 0.01)) {
    highp float tmpvar_90;
    tmpvar_90 = exp(-(tmpvar_88));
    fogInt_87 = ((1.0 - tmpvar_90) / tmpvar_88);
  };
  highp float tmpvar_91;
  tmpvar_91 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_86 = tmpvar_91;
  highp float tmpvar_92;
  tmpvar_92 = (l_86 * _HeigtFogParams3.y);
  u_85 = tmpvar_92;
  fogInt_87 = (fogInt_87 * u_85);
  mediump float tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = clamp (((l_86 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_93 = tmpvar_94;
  r_83 = (tmpvar_93 * (2.0 - tmpvar_93));
  r_83 = ((r_83 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_84 = ((1.0 - clamp (
    exp2(-(fogInt_87))
  , 0.0, 1.0)) * r_83);
  highp float tmpvar_95;
  tmpvar_95 = min (f_84, _HeigtFogColBase3.w);
  tmpvar_82 = tmpvar_95;
  HeightFogFactor_70 = tmpvar_82;
  highp vec3 tmpvar_96;
  tmpvar_96 = _Mihoyo_FogColor3.xyz;
  heightFogColor_69 = tmpvar_96;
  highp vec3 tmpvar_97;
  tmpvar_97 = ((heightFogColor_69 * HeightFogFactor_70) + ((atomesphereFogColor_71 * tmpvar_77) * (1.0 - HeightFogFactor_70)));
  fogColor_68 = tmpvar_97;
  highp float tmpvar_98;
  tmpvar_98 = ((1.0 - tmpvar_77) * (1.0 - HeightFogFactor_70));
  fogFactor_67 = tmpvar_98;
  mediump vec4 tmpvar_99;
  tmpvar_99.xyz = fogColor_68;
  tmpvar_99.w = fogFactor_67;
  tmpvar_66 = tmpvar_99;
  highp vec4 tmpvar_100;
  tmpvar_100 = mix (tmpvar_32, tmpvar_66, vec4(_LerpFactor));
  tmpvar_30 = tmpvar_100;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase2.xyz + (h_38 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_40 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams2.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams2.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase2.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor2.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  highp vec4 tmpvar_66;
  mediump float fogFactor_67;
  mediump vec3 fogColor_68;
  mediump vec3 heightFogColor_69;
  highp float HeightFogFactor_70;
  mediump vec3 atomesphereFogColor_71;
  mediump float h_72;
  highp float linearFogDensity_73;
  mediump float len_74;
  highp float tmpvar_75;
  tmpvar_75 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_74 = tmpvar_75;
  highp float tmpvar_76;
  tmpvar_76 = clamp (((len_74 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_73 = (tmpvar_76 * (2.0 - tmpvar_76));
  if ((len_74 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_73 = (linearFogDensity_73 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_77;
  tmpvar_77 = min (pow (linearFogDensity_73, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_73 = tmpvar_77;
  mediump float tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_25.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  h_72 = (tmpvar_78 * (2.0 - tmpvar_78));
  highp vec3 tmpvar_80;
  tmpvar_80 = (_HeigtFogColBase3.xyz + (h_72 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_71 = tmpvar_80;
  highp vec3 tmpvar_81;
  tmpvar_81 = mix (atomesphereFogColor_71, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_74 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_71 = tmpvar_81;
  mediump float tmpvar_82;
  mediump float r_83;
  mediump float f_84;
  mediump float u_85;
  mediump float l_86;
  mediump float fogInt_87;
  fogInt_87 = 1.0;
  highp float tmpvar_88;
  tmpvar_88 = (_HeigtFogParams3.x * tmpvar_31.y);
  highp float tmpvar_89;
  tmpvar_89 = abs(tmpvar_88);
  if ((tmpvar_89 > 0.01)) {
    highp float tmpvar_90;
    tmpvar_90 = exp(-(tmpvar_88));
    fogInt_87 = ((1.0 - tmpvar_90) / tmpvar_88);
  };
  highp float tmpvar_91;
  tmpvar_91 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_86 = tmpvar_91;
  highp float tmpvar_92;
  tmpvar_92 = (l_86 * _HeigtFogParams3.y);
  u_85 = tmpvar_92;
  fogInt_87 = (fogInt_87 * u_85);
  mediump float tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = clamp (((l_86 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_93 = tmpvar_94;
  r_83 = (tmpvar_93 * (2.0 - tmpvar_93));
  r_83 = ((r_83 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_84 = ((1.0 - clamp (
    exp2(-(fogInt_87))
  , 0.0, 1.0)) * r_83);
  highp float tmpvar_95;
  tmpvar_95 = min (f_84, _HeigtFogColBase3.w);
  tmpvar_82 = tmpvar_95;
  HeightFogFactor_70 = tmpvar_82;
  highp vec3 tmpvar_96;
  tmpvar_96 = _Mihoyo_FogColor3.xyz;
  heightFogColor_69 = tmpvar_96;
  highp vec3 tmpvar_97;
  tmpvar_97 = ((heightFogColor_69 * HeightFogFactor_70) + ((atomesphereFogColor_71 * tmpvar_77) * (1.0 - HeightFogFactor_70)));
  fogColor_68 = tmpvar_97;
  highp float tmpvar_98;
  tmpvar_98 = ((1.0 - tmpvar_77) * (1.0 - HeightFogFactor_70));
  fogFactor_67 = tmpvar_98;
  mediump vec4 tmpvar_99;
  tmpvar_99.xyz = fogColor_68;
  tmpvar_99.w = fogFactor_67;
  tmpvar_66 = tmpvar_99;
  highp vec4 tmpvar_100;
  tmpvar_100 = mix (tmpvar_32, tmpvar_66, vec4(_LerpFactor));
  tmpvar_30 = tmpvar_100;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  tmpvar_9.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_25));
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_29;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_32)
      ) * (_FogIntensity * tmpvar_32))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_32)) * (_FogColorIntensity * tmpvar_32))
    ), 0.0, 1.0)));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_29 = fogColor_30;
  } else {
    mediump vec4 fogColor_35;
    highp vec3 tmpvar_36;
    tmpvar_36 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_37;
    tmpvar_37 = max (0.0, (sqrt(
      dot (tmpvar_36, tmpvar_36)
    ) - _FogStartDistance));
    highp float tmpvar_38;
    highp float tmpvar_39;
    tmpvar_39 = (_FogEndDistance - _FogStartDistance);
    tmpvar_38 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_37) / max (0.1, tmpvar_39))
    , 0.0, 1.0))));
    fogColor_35.xyz = tmpvar_40;
    fogColor_35.w = tmpvar_38;
    tmpvar_29 = fogColor_35;
  };
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_29;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase.xyz + (h_38 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_40 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  tmpvar_30 = tmpvar_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase.xyz + (h_38 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_40 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  tmpvar_30 = tmpvar_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase.xyz + (h_38 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_40 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  tmpvar_30 = tmpvar_32;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase2.xyz + (h_38 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_40 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams2.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams2.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase2.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor2.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  highp vec4 tmpvar_66;
  mediump float fogFactor_67;
  mediump vec3 fogColor_68;
  mediump vec3 heightFogColor_69;
  highp float HeightFogFactor_70;
  mediump vec3 atomesphereFogColor_71;
  mediump float h_72;
  highp float linearFogDensity_73;
  mediump float len_74;
  highp float tmpvar_75;
  tmpvar_75 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_74 = tmpvar_75;
  highp float tmpvar_76;
  tmpvar_76 = clamp (((len_74 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_73 = (tmpvar_76 * (2.0 - tmpvar_76));
  if ((len_74 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_73 = (linearFogDensity_73 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_77;
  tmpvar_77 = min (pow (linearFogDensity_73, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_73 = tmpvar_77;
  mediump float tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_25.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  h_72 = (tmpvar_78 * (2.0 - tmpvar_78));
  highp vec3 tmpvar_80;
  tmpvar_80 = (_HeigtFogColBase3.xyz + (h_72 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_71 = tmpvar_80;
  highp vec3 tmpvar_81;
  tmpvar_81 = mix (atomesphereFogColor_71, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_74 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_71 = tmpvar_81;
  mediump float tmpvar_82;
  mediump float r_83;
  mediump float f_84;
  mediump float u_85;
  mediump float l_86;
  mediump float fogInt_87;
  fogInt_87 = 1.0;
  highp float tmpvar_88;
  tmpvar_88 = (_HeigtFogParams3.x * tmpvar_31.y);
  highp float tmpvar_89;
  tmpvar_89 = abs(tmpvar_88);
  if ((tmpvar_89 > 0.01)) {
    highp float tmpvar_90;
    tmpvar_90 = exp(-(tmpvar_88));
    fogInt_87 = ((1.0 - tmpvar_90) / tmpvar_88);
  };
  highp float tmpvar_91;
  tmpvar_91 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_86 = tmpvar_91;
  highp float tmpvar_92;
  tmpvar_92 = (l_86 * _HeigtFogParams3.y);
  u_85 = tmpvar_92;
  fogInt_87 = (fogInt_87 * u_85);
  mediump float tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = clamp (((l_86 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_93 = tmpvar_94;
  r_83 = (tmpvar_93 * (2.0 - tmpvar_93));
  r_83 = ((r_83 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_84 = ((1.0 - clamp (
    exp2(-(fogInt_87))
  , 0.0, 1.0)) * r_83);
  highp float tmpvar_95;
  tmpvar_95 = min (f_84, _HeigtFogColBase3.w);
  tmpvar_82 = tmpvar_95;
  HeightFogFactor_70 = tmpvar_82;
  highp vec3 tmpvar_96;
  tmpvar_96 = _Mihoyo_FogColor3.xyz;
  heightFogColor_69 = tmpvar_96;
  highp vec3 tmpvar_97;
  tmpvar_97 = ((heightFogColor_69 * HeightFogFactor_70) + ((atomesphereFogColor_71 * tmpvar_77) * (1.0 - HeightFogFactor_70)));
  fogColor_68 = tmpvar_97;
  highp float tmpvar_98;
  tmpvar_98 = ((1.0 - tmpvar_77) * (1.0 - HeightFogFactor_70));
  fogFactor_67 = tmpvar_98;
  mediump vec4 tmpvar_99;
  tmpvar_99.xyz = fogColor_68;
  tmpvar_99.w = fogFactor_67;
  tmpvar_66 = tmpvar_99;
  highp vec4 tmpvar_100;
  tmpvar_100 = mix (tmpvar_32, tmpvar_66, vec4(_LerpFactor));
  tmpvar_30 = tmpvar_100;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase2.xyz + (h_38 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_40 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams2.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams2.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase2.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor2.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  highp vec4 tmpvar_66;
  mediump float fogFactor_67;
  mediump vec3 fogColor_68;
  mediump vec3 heightFogColor_69;
  highp float HeightFogFactor_70;
  mediump vec3 atomesphereFogColor_71;
  mediump float h_72;
  highp float linearFogDensity_73;
  mediump float len_74;
  highp float tmpvar_75;
  tmpvar_75 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_74 = tmpvar_75;
  highp float tmpvar_76;
  tmpvar_76 = clamp (((len_74 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_73 = (tmpvar_76 * (2.0 - tmpvar_76));
  if ((len_74 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_73 = (linearFogDensity_73 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_77;
  tmpvar_77 = min (pow (linearFogDensity_73, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_73 = tmpvar_77;
  mediump float tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_25.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  h_72 = (tmpvar_78 * (2.0 - tmpvar_78));
  highp vec3 tmpvar_80;
  tmpvar_80 = (_HeigtFogColBase3.xyz + (h_72 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_71 = tmpvar_80;
  highp vec3 tmpvar_81;
  tmpvar_81 = mix (atomesphereFogColor_71, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_74 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_71 = tmpvar_81;
  mediump float tmpvar_82;
  mediump float r_83;
  mediump float f_84;
  mediump float u_85;
  mediump float l_86;
  mediump float fogInt_87;
  fogInt_87 = 1.0;
  highp float tmpvar_88;
  tmpvar_88 = (_HeigtFogParams3.x * tmpvar_31.y);
  highp float tmpvar_89;
  tmpvar_89 = abs(tmpvar_88);
  if ((tmpvar_89 > 0.01)) {
    highp float tmpvar_90;
    tmpvar_90 = exp(-(tmpvar_88));
    fogInt_87 = ((1.0 - tmpvar_90) / tmpvar_88);
  };
  highp float tmpvar_91;
  tmpvar_91 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_86 = tmpvar_91;
  highp float tmpvar_92;
  tmpvar_92 = (l_86 * _HeigtFogParams3.y);
  u_85 = tmpvar_92;
  fogInt_87 = (fogInt_87 * u_85);
  mediump float tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = clamp (((l_86 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_93 = tmpvar_94;
  r_83 = (tmpvar_93 * (2.0 - tmpvar_93));
  r_83 = ((r_83 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_84 = ((1.0 - clamp (
    exp2(-(fogInt_87))
  , 0.0, 1.0)) * r_83);
  highp float tmpvar_95;
  tmpvar_95 = min (f_84, _HeigtFogColBase3.w);
  tmpvar_82 = tmpvar_95;
  HeightFogFactor_70 = tmpvar_82;
  highp vec3 tmpvar_96;
  tmpvar_96 = _Mihoyo_FogColor3.xyz;
  heightFogColor_69 = tmpvar_96;
  highp vec3 tmpvar_97;
  tmpvar_97 = ((heightFogColor_69 * HeightFogFactor_70) + ((atomesphereFogColor_71 * tmpvar_77) * (1.0 - HeightFogFactor_70)));
  fogColor_68 = tmpvar_97;
  highp float tmpvar_98;
  tmpvar_98 = ((1.0 - tmpvar_77) * (1.0 - HeightFogFactor_70));
  fogFactor_67 = tmpvar_98;
  mediump vec4 tmpvar_99;
  tmpvar_99.xyz = fogColor_68;
  tmpvar_99.w = fogFactor_67;
  tmpvar_66 = tmpvar_99;
  highp vec4 tmpvar_100;
  tmpvar_100 = mix (tmpvar_32, tmpvar_66, vec4(_LerpFactor));
  tmpvar_30 = tmpvar_100;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
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
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _FrontDensity;
uniform highp float _FrontShoreTransparency;
uniform highp vec4 _ShoreFoamParams;
uniform highp vec4 _ShoreFoamColor;
uniform highp float _ShoreFoamColorStrength;
uniform highp float _ShoreFoamDepth;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 uv_Foam_1;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18.x = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_18.y = sqrt(dot (v_16.xyz, v_16.xyz));
  tmpvar_18.z = sqrt(dot (v_17.xyz, v_17.xyz));
  highp vec3 tmpvar_19;
  tmpvar_19 = (0.1 / tmpvar_18);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_4 = tmpvar_21;
  tmpvar_7.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_7.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_19.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_2 = tmpvar_23;
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_8.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec2 tmpvar_24;
  tmpvar_24 = ((_glesMultiTexCoord0.xy * _ShoreFoamParams.xy) * tmpvar_19.xz);
  uv_Foam_1 = tmpvar_24;
  uv_Foam_1 = (uv_Foam_1 + ((_ShoreFoamParams.zw * _Time.y) * 0.1));
  tmpvar_6.zw = uv_Foam_1;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  tmpvar_10 = normalize((_glesNormal * tmpvar_26));
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_13.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_11.w = (1.0/(_FrontShoreTransparency));
  tmpvar_12.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_12.w = (1.0/(_ShoreFoamDepth));
  tmpvar_9.w = (1.0/(_UV_Mix_Range));
  mediump vec4 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_32;
  mediump float fogFactor_33;
  mediump vec3 fogColor_34;
  mediump vec3 heightFogColor_35;
  highp float HeightFogFactor_36;
  mediump vec3 atomesphereFogColor_37;
  mediump float h_38;
  highp float linearFogDensity_39;
  mediump float len_40;
  highp float tmpvar_41;
  tmpvar_41 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_40 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((len_40 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_39 = (tmpvar_42 * (2.0 - tmpvar_42));
  if ((len_40 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_39 = (linearFogDensity_39 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_43;
  tmpvar_43 = min (pow (linearFogDensity_39, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_39 = tmpvar_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((tmpvar_25.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  h_38 = (tmpvar_44 * (2.0 - tmpvar_44));
  highp vec3 tmpvar_46;
  tmpvar_46 = (_HeigtFogColBase2.xyz + (h_38 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_37 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (atomesphereFogColor_37, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_40 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_37 = tmpvar_47;
  mediump float tmpvar_48;
  mediump float r_49;
  mediump float f_50;
  mediump float u_51;
  mediump float l_52;
  mediump float fogInt_53;
  fogInt_53 = 1.0;
  highp float tmpvar_54;
  tmpvar_54 = (_HeigtFogParams2.x * tmpvar_31.y);
  highp float tmpvar_55;
  tmpvar_55 = abs(tmpvar_54);
  if ((tmpvar_55 > 0.01)) {
    highp float tmpvar_56;
    tmpvar_56 = exp(-(tmpvar_54));
    fogInt_53 = ((1.0 - tmpvar_56) / tmpvar_54);
  };
  highp float tmpvar_57;
  tmpvar_57 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_52 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (l_52 * _HeigtFogParams2.y);
  u_51 = tmpvar_58;
  fogInt_53 = (fogInt_53 * u_51);
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (((l_52 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  r_49 = (tmpvar_59 * (2.0 - tmpvar_59));
  r_49 = ((r_49 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_50 = ((1.0 - clamp (
    exp2(-(fogInt_53))
  , 0.0, 1.0)) * r_49);
  highp float tmpvar_61;
  tmpvar_61 = min (f_50, _HeigtFogColBase2.w);
  tmpvar_48 = tmpvar_61;
  HeightFogFactor_36 = tmpvar_48;
  highp vec3 tmpvar_62;
  tmpvar_62 = _Mihoyo_FogColor2.xyz;
  heightFogColor_35 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = ((heightFogColor_35 * HeightFogFactor_36) + ((atomesphereFogColor_37 * tmpvar_43) * (1.0 - HeightFogFactor_36)));
  fogColor_34 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = ((1.0 - tmpvar_43) * (1.0 - HeightFogFactor_36));
  fogFactor_33 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.xyz = fogColor_34;
  tmpvar_65.w = fogFactor_33;
  tmpvar_32 = tmpvar_65;
  highp vec4 tmpvar_66;
  mediump float fogFactor_67;
  mediump vec3 fogColor_68;
  mediump vec3 heightFogColor_69;
  highp float HeightFogFactor_70;
  mediump vec3 atomesphereFogColor_71;
  mediump float h_72;
  highp float linearFogDensity_73;
  mediump float len_74;
  highp float tmpvar_75;
  tmpvar_75 = sqrt(dot (tmpvar_31, tmpvar_31));
  len_74 = tmpvar_75;
  highp float tmpvar_76;
  tmpvar_76 = clamp (((len_74 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_73 = (tmpvar_76 * (2.0 - tmpvar_76));
  if ((len_74 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_73 = (linearFogDensity_73 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_77;
  tmpvar_77 = min (pow (linearFogDensity_73, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_73 = tmpvar_77;
  mediump float tmpvar_78;
  highp float tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_25.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  h_72 = (tmpvar_78 * (2.0 - tmpvar_78));
  highp vec3 tmpvar_80;
  tmpvar_80 = (_HeigtFogColBase3.xyz + (h_72 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_71 = tmpvar_80;
  highp vec3 tmpvar_81;
  tmpvar_81 = mix (atomesphereFogColor_71, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_74 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_71 = tmpvar_81;
  mediump float tmpvar_82;
  mediump float r_83;
  mediump float f_84;
  mediump float u_85;
  mediump float l_86;
  mediump float fogInt_87;
  fogInt_87 = 1.0;
  highp float tmpvar_88;
  tmpvar_88 = (_HeigtFogParams3.x * tmpvar_31.y);
  highp float tmpvar_89;
  tmpvar_89 = abs(tmpvar_88);
  if ((tmpvar_89 > 0.01)) {
    highp float tmpvar_90;
    tmpvar_90 = exp(-(tmpvar_88));
    fogInt_87 = ((1.0 - tmpvar_90) / tmpvar_88);
  };
  highp float tmpvar_91;
  tmpvar_91 = sqrt(dot (tmpvar_31, tmpvar_31));
  l_86 = tmpvar_91;
  highp float tmpvar_92;
  tmpvar_92 = (l_86 * _HeigtFogParams3.y);
  u_85 = tmpvar_92;
  fogInt_87 = (fogInt_87 * u_85);
  mediump float tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = clamp (((l_86 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_93 = tmpvar_94;
  r_83 = (tmpvar_93 * (2.0 - tmpvar_93));
  r_83 = ((r_83 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_84 = ((1.0 - clamp (
    exp2(-(fogInt_87))
  , 0.0, 1.0)) * r_83);
  highp float tmpvar_95;
  tmpvar_95 = min (f_84, _HeigtFogColBase3.w);
  tmpvar_82 = tmpvar_95;
  HeightFogFactor_70 = tmpvar_82;
  highp vec3 tmpvar_96;
  tmpvar_96 = _Mihoyo_FogColor3.xyz;
  heightFogColor_69 = tmpvar_96;
  highp vec3 tmpvar_97;
  tmpvar_97 = ((heightFogColor_69 * HeightFogFactor_70) + ((atomesphereFogColor_71 * tmpvar_77) * (1.0 - HeightFogFactor_70)));
  fogColor_68 = tmpvar_97;
  highp float tmpvar_98;
  tmpvar_98 = ((1.0 - tmpvar_77) * (1.0 - HeightFogFactor_70));
  fogFactor_67 = tmpvar_98;
  mediump vec4 tmpvar_99;
  tmpvar_99.xyz = fogColor_68;
  tmpvar_99.w = fogFactor_67;
  tmpvar_66 = tmpvar_99;
  highp vec4 tmpvar_100;
  tmpvar_100 = mix (tmpvar_32, tmpvar_66, vec4(_LerpFactor));
  tmpvar_30 = tmpvar_100;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_9;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = tmpvar_12;
  xlv_COLOR1 = tmpvar_30;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _SunDir;
uniform highp float _Specular;
uniform highp float _Gloss;
uniform mediump vec4 _LightColor0;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform highp float _FrontReflectLerpFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump float spec_1;
  mediump float specPow_2;
  mediump vec4 finalRGBA_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 reflUV_5;
  mediump vec3 reflectColor_6;
  mediump vec4 waterColor_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec3 normalLocal_10;
  mediump vec3 largeNormal_11;
  mediump vec3 smallNormal_12;
  mediump vec3 worldViewDir_13;
  highp float len_14;
  mediump vec3 worldView_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = sqrt(dot (worldView_15, worldView_15));
  len_14 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (worldView_15 / len_14);
  worldViewDir_13 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_12 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_12 = (smallNormal_12 + tmpvar_20);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_11 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_11 = (largeNormal_11 + tmpvar_22);
  normalLocal_10.xz = (smallNormal_12 + largeNormal_11).xy;
  normalLocal_10.y = 1.0;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(normalLocal_10);
  normalLocal_10 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (tmpvar_23.xz * _FrontRefractDistort);
  highp vec4 tmpvar_27;
  tmpvar_27 = (xlv_TEXCOORD5 + tmpvar_26);
  distortScreenPos_9 = tmpvar_27;
  lowp vec4 tmpvar_28;
  mediump vec2 P_29;
  P_29 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_28 = texture2D (_BeforeAlphaTexture, P_29);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((2.0 * _RefractColor).xyz * tmpvar_28.xyz);
  refraColor_8 = tmpvar_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (pow ((
    clamp ((((1.0/(
      ((_ZBufferParams.z * z_25) + _ZBufferParams.w)
    )) - xlv_TEXCOORD5.w) * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = _ReflectColor.xyz;
  reflectColor_6 = tmpvar_33;
  reflUV_5 = xlv_TEXCOORD5;
  highp vec2 tmpvar_34;
  tmpvar_34 = (((tmpvar_23.xz * _FrontReflectDistort) * reflUV_5.w) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_5.xy = (reflUV_5.xy + tmpvar_34);
  lowp vec4 tmpvar_35;
  mediump vec2 P_36;
  P_36 = (reflUV_5.xy / reflUV_5.w);
  tmpvar_35 = texture2D (_ReflectionTex, P_36);
  ssrRefl_4 = tmpvar_35;
  highp vec3 tmpvar_37;
  tmpvar_37 = vec3((1.0 - clamp ((len_14 * _FrontReflectLerpFactor), 0.0, 1.0)));
  reflectColor_6 = ((_FrontReflectIntensity * mix (reflectColor_6, ssrRefl_4.xyz, tmpvar_37)) + ((1.0 - _FrontReflectIntensity) * _ReflectColor.xyz));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (worldViewDir_13, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - tmpvar_38);
  highp vec3 tmpvar_40;
  tmpvar_40 = mix (refraColor_8, reflectColor_6, vec3((_FrontFresnelBias + (
    (1.0 - _FrontFresnelBias)
   * 
    pow (tmpvar_39, 5.0)
  ))));
  waterColor_7.xyz = tmpvar_40;
  finalRGBA_3.w = 0.0;
  finalRGBA_3.xyz = waterColor_7.xyz;
  highp float tmpvar_41;
  tmpvar_41 = (_Gloss * 128.0);
  specPow_2 = tmpvar_41;
  highp vec3 L_42;
  L_42 = normalize(_SunDir).xyz;
  highp float tmpvar_43;
  highp float noh_44;
  mediump vec3 H_45;
  if ((L_42.y <= 0.0)) {
    tmpvar_43 = 0.0;
  } else {
    highp vec3 tmpvar_46;
    tmpvar_46 = normalize((worldViewDir_13 + L_42));
    H_45 = tmpvar_46;
    mediump float tmpvar_47;
    tmpvar_47 = max (dot (tmpvar_23, H_45), 0.0001);
    noh_44 = tmpvar_47;
    mediump float y_48;
    y_48 = (specPow_2 + 1e-06);
    tmpvar_43 = (((specPow_2 * 0.159155) + 0.31831) * pow (noh_44, y_48));
  };
  spec_1 = tmpvar_43;
  spec_1 = (spec_1 * (0.2 * _Specular));
  mediump float tmpvar_49;
  tmpvar_49 = clamp (spec_1, 0.0, 16.0);
  spec_1 = tmpvar_49;
  finalRGBA_3.xyz = (waterColor_7.xyz + (tmpvar_49 * _LightColor0.xyz));
  finalRGBA_3.w = tmpvar_31;
  finalRGBA_3.xyz = (xlv_COLOR1.xyz + (finalRGBA_3.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalRGBA_3.xyz = mix (finalRGBA_3.xyz, vec3(dot (finalRGBA_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_3.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_3;
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
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
}
}
 Pass {
  Name "BACK"
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 131024
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _BackDensity;
uniform highp float _BackShoreTransparency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 largeWaveSpeedTilling_1;
  mediump vec2 largeWaveTilling_2;
  mediump vec2 smallWaveSpeedTilling_3;
  mediump vec2 smallWaveTilling_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14.x = sqrt(dot (v_11.xyz, v_11.xyz));
  tmpvar_14.y = sqrt(dot (v_12.xyz, v_12.xyz));
  tmpvar_14.z = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec3 tmpvar_15;
  tmpvar_15 = (0.1 / tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xz * _SmallWavesParams.xy);
  smallWaveTilling_4 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_3 = tmpvar_17;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_4) + smallWaveSpeedTilling_3);
  tmpvar_5.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_4) * 2.0) + (smallWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_15.xz * _LargeWavesParams.xy);
  largeWaveTilling_2 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_1 = tmpvar_19;
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_2) + largeWaveSpeedTilling_1);
  tmpvar_6.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_2) * 2.0) + (largeWaveSpeedTilling_1 * 1.5));
  tmpvar_7.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  tmpvar_8.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_8.w = (1.0/(_BackShoreTransparency));
  tmpvar_7.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_20));
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _WaterColor;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackReflectLerpFactor;
uniform highp float _BackCriticalAngle;
uniform highp float _BackAngleDistort;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec3 reflectColor_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 waterColor_5;
  mediump vec3 coff_6;
  mediump float testAngle_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec4 uvDistort_10;
  mediump vec3 normalLocal_11;
  mediump vec3 largeNormal_12;
  mediump vec3 smallNormal_13;
  mediump vec3 worldViewDir_14;
  highp float len_15;
  mediump vec3 worldView_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = sqrt(dot (worldView_16, worldView_16));
  len_15 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (worldView_16 / len_15);
  worldViewDir_14 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_13 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_13 = (smallNormal_13 + tmpvar_21);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_12 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_12 = (largeNormal_12 + tmpvar_23);
  normalLocal_11.xz = (-(smallNormal_13) - largeNormal_12).xy;
  normalLocal_11.y = 1.0;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(normalLocal_11);
  normalLocal_11 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (tmpvar_24.xz * _BackRefractDistort);
  uvDistort_10 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (xlv_TEXCOORD5 + uvDistort_10);
  distortScreenPos_9 = tmpvar_28;
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_29 = texture2D (_BeforeAlphaTexture, P_30);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((2.0 * _RefractColor).xyz * tmpvar_29.xyz);
  refraColor_8 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_26)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.w);
  mediump float tmpvar_33;
  tmpvar_33 = dot (worldViewDir_14, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((1.570796 - 
    (sign(tmpvar_33) * (1.570796 - (sqrt(
      (1.0 - abs(tmpvar_33))
    ) * (1.570796 + 
      (abs(tmpvar_33) * (-0.2146018 + (abs(tmpvar_33) * (0.08656672 + 
        (abs(tmpvar_33) * -0.03102955)
      ))))
    ))))
  ) * 57.29583) + ((tmpvar_24.x + tmpvar_24.z) * _BackAngleDistort));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (worldViewDir_14, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_35;
  tmpvar_35 = (1.0 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * pow (tmpvar_35, 5.0)));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * pow ((
    clamp (((-(tmpvar_32) * 0.5) * xlv_TEXCOORD6.xyz), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_6 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = _WaterColor.xyz;
  waterColor_5 = tmpvar_38;
  if ((testAngle_7 < _BackCriticalAngle)) {
    waterColor_5.xyz = (_WaterColor.xyz + (refraColor_8 * coff_6));
  };
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_39;
  tmpvar_39 = (((tmpvar_24.xz * _BackReflectDistort) * (reflUV_3.w * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_39);
  lowp vec4 tmpvar_40;
  mediump vec2 P_41;
  P_41 = (reflUV_3.xy / reflUV_3.w);
  tmpvar_40 = texture2D (_ReflectionTex, P_41);
  ssrRefl_4 = tmpvar_40;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (_UWFogColorFar.xyz, ssrRefl_4.xyz, vec3((1.0 - clamp (
    (len_15 * _BackReflectLerpFactor)
  , 0.0, 1.0))));
  reflectColor_2 = tmpvar_42;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_43;
    tmpvar_43 = mix (_WaterColor.xyz, reflectColor_2, vec3((_BackReflectIntensity * tmpvar_36)));
    waterColor_5.xyz = tmpvar_43;
  };
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 1.0;
  tmpvar_44.xyz = waterColor_5.xyz;
  finalRGBA_1.xyz = tmpvar_44.xyz;
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (pow ((
    clamp ((tmpvar_32 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  finalRGBA_1.w = tmpvar_45;
  gl_FragData[0] = finalRGBA_1;
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
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _BackDensity;
uniform highp float _BackShoreTransparency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 largeWaveSpeedTilling_1;
  mediump vec2 largeWaveTilling_2;
  mediump vec2 smallWaveSpeedTilling_3;
  mediump vec2 smallWaveTilling_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14.x = sqrt(dot (v_11.xyz, v_11.xyz));
  tmpvar_14.y = sqrt(dot (v_12.xyz, v_12.xyz));
  tmpvar_14.z = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec3 tmpvar_15;
  tmpvar_15 = (0.1 / tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xz * _SmallWavesParams.xy);
  smallWaveTilling_4 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_3 = tmpvar_17;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_4) + smallWaveSpeedTilling_3);
  tmpvar_5.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_4) * 2.0) + (smallWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_15.xz * _LargeWavesParams.xy);
  largeWaveTilling_2 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_1 = tmpvar_19;
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_2) + largeWaveSpeedTilling_1);
  tmpvar_6.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_2) * 2.0) + (largeWaveSpeedTilling_1 * 1.5));
  tmpvar_7.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  tmpvar_8.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_8.w = (1.0/(_BackShoreTransparency));
  tmpvar_7.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_20));
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _WaterColor;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackReflectLerpFactor;
uniform highp float _BackCriticalAngle;
uniform highp float _BackAngleDistort;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec3 reflectColor_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 waterColor_5;
  mediump vec3 coff_6;
  mediump float testAngle_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec4 uvDistort_10;
  mediump vec3 normalLocal_11;
  mediump vec3 largeNormal_12;
  mediump vec3 smallNormal_13;
  mediump vec3 worldViewDir_14;
  highp float len_15;
  mediump vec3 worldView_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = sqrt(dot (worldView_16, worldView_16));
  len_15 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (worldView_16 / len_15);
  worldViewDir_14 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_13 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_13 = (smallNormal_13 + tmpvar_21);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_12 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_12 = (largeNormal_12 + tmpvar_23);
  normalLocal_11.xz = (-(smallNormal_13) - largeNormal_12).xy;
  normalLocal_11.y = 1.0;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(normalLocal_11);
  normalLocal_11 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (tmpvar_24.xz * _BackRefractDistort);
  uvDistort_10 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (xlv_TEXCOORD5 + uvDistort_10);
  distortScreenPos_9 = tmpvar_28;
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_29 = texture2D (_BeforeAlphaTexture, P_30);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((2.0 * _RefractColor).xyz * tmpvar_29.xyz);
  refraColor_8 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_26)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.w);
  mediump float tmpvar_33;
  tmpvar_33 = dot (worldViewDir_14, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((1.570796 - 
    (sign(tmpvar_33) * (1.570796 - (sqrt(
      (1.0 - abs(tmpvar_33))
    ) * (1.570796 + 
      (abs(tmpvar_33) * (-0.2146018 + (abs(tmpvar_33) * (0.08656672 + 
        (abs(tmpvar_33) * -0.03102955)
      ))))
    ))))
  ) * 57.29583) + ((tmpvar_24.x + tmpvar_24.z) * _BackAngleDistort));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (worldViewDir_14, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_35;
  tmpvar_35 = (1.0 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * pow (tmpvar_35, 5.0)));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * pow ((
    clamp (((-(tmpvar_32) * 0.5) * xlv_TEXCOORD6.xyz), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_6 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = _WaterColor.xyz;
  waterColor_5 = tmpvar_38;
  if ((testAngle_7 < _BackCriticalAngle)) {
    waterColor_5.xyz = (_WaterColor.xyz + (refraColor_8 * coff_6));
  };
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_39;
  tmpvar_39 = (((tmpvar_24.xz * _BackReflectDistort) * (reflUV_3.w * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_39);
  lowp vec4 tmpvar_40;
  mediump vec2 P_41;
  P_41 = (reflUV_3.xy / reflUV_3.w);
  tmpvar_40 = texture2D (_ReflectionTex, P_41);
  ssrRefl_4 = tmpvar_40;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (_UWFogColorFar.xyz, ssrRefl_4.xyz, vec3((1.0 - clamp (
    (len_15 * _BackReflectLerpFactor)
  , 0.0, 1.0))));
  reflectColor_2 = tmpvar_42;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_43;
    tmpvar_43 = mix (_WaterColor.xyz, reflectColor_2, vec3((_BackReflectIntensity * tmpvar_36)));
    waterColor_5.xyz = tmpvar_43;
  };
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 1.0;
  tmpvar_44.xyz = waterColor_5.xyz;
  finalRGBA_1.xyz = tmpvar_44.xyz;
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (pow ((
    clamp ((tmpvar_32 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  finalRGBA_1.w = tmpvar_45;
  gl_FragData[0] = finalRGBA_1;
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
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _BackDensity;
uniform highp float _BackShoreTransparency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 largeWaveSpeedTilling_1;
  mediump vec2 largeWaveTilling_2;
  mediump vec2 smallWaveSpeedTilling_3;
  mediump vec2 smallWaveTilling_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14.x = sqrt(dot (v_11.xyz, v_11.xyz));
  tmpvar_14.y = sqrt(dot (v_12.xyz, v_12.xyz));
  tmpvar_14.z = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec3 tmpvar_15;
  tmpvar_15 = (0.1 / tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xz * _SmallWavesParams.xy);
  smallWaveTilling_4 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_3 = tmpvar_17;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_4) + smallWaveSpeedTilling_3);
  tmpvar_5.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_4) * 2.0) + (smallWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_15.xz * _LargeWavesParams.xy);
  largeWaveTilling_2 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_1 = tmpvar_19;
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_2) + largeWaveSpeedTilling_1);
  tmpvar_6.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_2) * 2.0) + (largeWaveSpeedTilling_1 * 1.5));
  tmpvar_7.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  tmpvar_8.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_8.w = (1.0/(_BackShoreTransparency));
  tmpvar_7.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_20));
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _WaterColor;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackReflectLerpFactor;
uniform highp float _BackCriticalAngle;
uniform highp float _BackAngleDistort;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec3 reflectColor_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 waterColor_5;
  mediump vec3 coff_6;
  mediump float testAngle_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec4 uvDistort_10;
  mediump vec3 normalLocal_11;
  mediump vec3 largeNormal_12;
  mediump vec3 smallNormal_13;
  mediump vec3 worldViewDir_14;
  highp float len_15;
  mediump vec3 worldView_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = sqrt(dot (worldView_16, worldView_16));
  len_15 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (worldView_16 / len_15);
  worldViewDir_14 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_13 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_13 = (smallNormal_13 + tmpvar_21);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_12 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_12 = (largeNormal_12 + tmpvar_23);
  normalLocal_11.xz = (-(smallNormal_13) - largeNormal_12).xy;
  normalLocal_11.y = 1.0;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(normalLocal_11);
  normalLocal_11 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (tmpvar_24.xz * _BackRefractDistort);
  uvDistort_10 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (xlv_TEXCOORD5 + uvDistort_10);
  distortScreenPos_9 = tmpvar_28;
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_29 = texture2D (_BeforeAlphaTexture, P_30);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((2.0 * _RefractColor).xyz * tmpvar_29.xyz);
  refraColor_8 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_26)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.w);
  mediump float tmpvar_33;
  tmpvar_33 = dot (worldViewDir_14, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((1.570796 - 
    (sign(tmpvar_33) * (1.570796 - (sqrt(
      (1.0 - abs(tmpvar_33))
    ) * (1.570796 + 
      (abs(tmpvar_33) * (-0.2146018 + (abs(tmpvar_33) * (0.08656672 + 
        (abs(tmpvar_33) * -0.03102955)
      ))))
    ))))
  ) * 57.29583) + ((tmpvar_24.x + tmpvar_24.z) * _BackAngleDistort));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (worldViewDir_14, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_35;
  tmpvar_35 = (1.0 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * pow (tmpvar_35, 5.0)));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * pow ((
    clamp (((-(tmpvar_32) * 0.5) * xlv_TEXCOORD6.xyz), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_6 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = _WaterColor.xyz;
  waterColor_5 = tmpvar_38;
  if ((testAngle_7 < _BackCriticalAngle)) {
    waterColor_5.xyz = (_WaterColor.xyz + (refraColor_8 * coff_6));
  };
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_39;
  tmpvar_39 = (((tmpvar_24.xz * _BackReflectDistort) * (reflUV_3.w * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_39);
  lowp vec4 tmpvar_40;
  mediump vec2 P_41;
  P_41 = (reflUV_3.xy / reflUV_3.w);
  tmpvar_40 = texture2D (_ReflectionTex, P_41);
  ssrRefl_4 = tmpvar_40;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (_UWFogColorFar.xyz, ssrRefl_4.xyz, vec3((1.0 - clamp (
    (len_15 * _BackReflectLerpFactor)
  , 0.0, 1.0))));
  reflectColor_2 = tmpvar_42;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_43;
    tmpvar_43 = mix (_WaterColor.xyz, reflectColor_2, vec3((_BackReflectIntensity * tmpvar_36)));
    waterColor_5.xyz = tmpvar_43;
  };
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 1.0;
  tmpvar_44.xyz = waterColor_5.xyz;
  finalRGBA_1.xyz = tmpvar_44.xyz;
  mediump float tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (pow ((
    clamp ((tmpvar_32 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  finalRGBA_1.w = tmpvar_45;
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _BackDensity;
uniform highp float _BackShoreTransparency;
uniform highp float _BackFogDensity;
uniform highp float _BackFogEffectLimit;
uniform highp float _BackFogEffectStart;
uniform highp float _BackFogStart;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec2 largeWaveSpeedTilling_1;
  mediump vec2 largeWaveTilling_2;
  mediump vec2 smallWaveSpeedTilling_3;
  mediump vec2 smallWaveTilling_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14.x = sqrt(dot (v_11.xyz, v_11.xyz));
  tmpvar_14.y = sqrt(dot (v_12.xyz, v_12.xyz));
  tmpvar_14.z = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec3 tmpvar_15;
  tmpvar_15 = (0.1 / tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xz * _SmallWavesParams.xy);
  smallWaveTilling_4 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_3 = tmpvar_17;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_4) + smallWaveSpeedTilling_3);
  tmpvar_5.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_4) * 2.0) + (smallWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_15.xz * _LargeWavesParams.xy);
  largeWaveTilling_2 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_1 = tmpvar_19;
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_2) + largeWaveSpeedTilling_1);
  tmpvar_6.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_2) * 2.0) + (largeWaveSpeedTilling_1 * 1.5));
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7.xyz = tmpvar_20.xyz;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_9.zw;
  tmpvar_8.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_8.w = (1.0/(_BackShoreTransparency));
  tmpvar_7.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_25;
  fogParam_25.w = 0.0;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = max (0.0, (sqrt(
    dot (tmpvar_26, tmpvar_26)
  ) - _BackFogStart));
  highp float tmpvar_28;
  tmpvar_28 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_27)
    ) * (_BackFogDensity * tmpvar_27))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_29;
  tmpvar_29 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_27))
   * 
    (_UWFogColorNFIntensity * tmpvar_27)
  )), 0.0, 1.0);
  fogParam_25.x = tmpvar_29;
  fogParam_25.y = (1.0 - tmpvar_28);
  fogParam_25.z = tmpvar_20.y;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_21));
  xlv_TEXCOORD5 = o_22;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = fogParam_25.xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _WaterColor;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackReflectLerpFactor;
uniform highp float _BackCriticalAngle;
uniform highp float _BackAngleDistort;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec3 reflectColor_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 waterColor_5;
  mediump vec3 coff_6;
  mediump float testAngle_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec4 uvDistort_10;
  mediump vec3 normalLocal_11;
  mediump vec3 largeNormal_12;
  mediump vec3 smallNormal_13;
  mediump vec3 worldViewDir_14;
  highp float len_15;
  mediump vec3 worldView_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = sqrt(dot (worldView_16, worldView_16));
  len_15 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (worldView_16 / len_15);
  worldViewDir_14 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_13 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_13 = (smallNormal_13 + tmpvar_21);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_12 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_12 = (largeNormal_12 + tmpvar_23);
  normalLocal_11.xz = (-(smallNormal_13) - largeNormal_12).xy;
  normalLocal_11.y = 1.0;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(normalLocal_11);
  normalLocal_11 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (tmpvar_24.xz * _BackRefractDistort);
  uvDistort_10 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (xlv_TEXCOORD5 + uvDistort_10);
  distortScreenPos_9 = tmpvar_28;
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_29 = texture2D (_BeforeAlphaTexture, P_30);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((2.0 * _RefractColor).xyz * tmpvar_29.xyz);
  refraColor_8 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_26)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.w);
  mediump float tmpvar_33;
  tmpvar_33 = dot (worldViewDir_14, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((1.570796 - 
    (sign(tmpvar_33) * (1.570796 - (sqrt(
      (1.0 - abs(tmpvar_33))
    ) * (1.570796 + 
      (abs(tmpvar_33) * (-0.2146018 + (abs(tmpvar_33) * (0.08656672 + 
        (abs(tmpvar_33) * -0.03102955)
      ))))
    ))))
  ) * 57.29583) + ((tmpvar_24.x + tmpvar_24.z) * _BackAngleDistort));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (worldViewDir_14, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_35;
  tmpvar_35 = (1.0 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * pow (tmpvar_35, 5.0)));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * pow ((
    clamp (((-(tmpvar_32) * 0.5) * xlv_TEXCOORD6.xyz), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_6 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = _WaterColor.xyz;
  waterColor_5 = tmpvar_38;
  if ((testAngle_7 < _BackCriticalAngle)) {
    waterColor_5.xyz = (_WaterColor.xyz + (refraColor_8 * coff_6));
  };
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_39;
  tmpvar_39 = (((tmpvar_24.xz * _BackReflectDistort) * (reflUV_3.w * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_39);
  lowp vec4 tmpvar_40;
  mediump vec2 P_41;
  P_41 = (reflUV_3.xy / reflUV_3.w);
  tmpvar_40 = texture2D (_ReflectionTex, P_41);
  ssrRefl_4 = tmpvar_40;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (_UWFogColorFar.xyz, ssrRefl_4.xyz, vec3((1.0 - clamp (
    (len_15 * _BackReflectLerpFactor)
  , 0.0, 1.0))));
  reflectColor_2 = tmpvar_42;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_43;
    tmpvar_43 = mix (_WaterColor.xyz, reflectColor_2, vec3((_BackReflectIntensity * tmpvar_36)));
    waterColor_5.xyz = tmpvar_43;
  };
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 1.0;
  tmpvar_44.xyz = waterColor_5.xyz;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = tmpvar_44.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_45, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_46;
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (pow ((
    clamp ((tmpvar_32 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  finalRGBA_1.w = tmpvar_47;
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _BackDensity;
uniform highp float _BackShoreTransparency;
uniform highp float _BackFogDensity;
uniform highp float _BackFogEffectLimit;
uniform highp float _BackFogEffectStart;
uniform highp float _BackFogStart;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec2 largeWaveSpeedTilling_1;
  mediump vec2 largeWaveTilling_2;
  mediump vec2 smallWaveSpeedTilling_3;
  mediump vec2 smallWaveTilling_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14.x = sqrt(dot (v_11.xyz, v_11.xyz));
  tmpvar_14.y = sqrt(dot (v_12.xyz, v_12.xyz));
  tmpvar_14.z = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec3 tmpvar_15;
  tmpvar_15 = (0.1 / tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xz * _SmallWavesParams.xy);
  smallWaveTilling_4 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_3 = tmpvar_17;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_4) + smallWaveSpeedTilling_3);
  tmpvar_5.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_4) * 2.0) + (smallWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_15.xz * _LargeWavesParams.xy);
  largeWaveTilling_2 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_1 = tmpvar_19;
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_2) + largeWaveSpeedTilling_1);
  tmpvar_6.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_2) * 2.0) + (largeWaveSpeedTilling_1 * 1.5));
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7.xyz = tmpvar_20.xyz;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_9.zw;
  tmpvar_8.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_8.w = (1.0/(_BackShoreTransparency));
  tmpvar_7.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_25;
  fogParam_25.w = 0.0;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = max (0.0, (sqrt(
    dot (tmpvar_26, tmpvar_26)
  ) - _BackFogStart));
  highp float tmpvar_28;
  tmpvar_28 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_27)
    ) * (_BackFogDensity * tmpvar_27))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_29;
  tmpvar_29 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_27))
   * 
    (_UWFogColorNFIntensity * tmpvar_27)
  )), 0.0, 1.0);
  fogParam_25.x = tmpvar_29;
  fogParam_25.y = (1.0 - tmpvar_28);
  fogParam_25.z = tmpvar_20.y;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_21));
  xlv_TEXCOORD5 = o_22;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = fogParam_25.xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _WaterColor;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackReflectLerpFactor;
uniform highp float _BackCriticalAngle;
uniform highp float _BackAngleDistort;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec3 reflectColor_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 waterColor_5;
  mediump vec3 coff_6;
  mediump float testAngle_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec4 uvDistort_10;
  mediump vec3 normalLocal_11;
  mediump vec3 largeNormal_12;
  mediump vec3 smallNormal_13;
  mediump vec3 worldViewDir_14;
  highp float len_15;
  mediump vec3 worldView_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = sqrt(dot (worldView_16, worldView_16));
  len_15 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (worldView_16 / len_15);
  worldViewDir_14 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_13 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_13 = (smallNormal_13 + tmpvar_21);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_12 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_12 = (largeNormal_12 + tmpvar_23);
  normalLocal_11.xz = (-(smallNormal_13) - largeNormal_12).xy;
  normalLocal_11.y = 1.0;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(normalLocal_11);
  normalLocal_11 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (tmpvar_24.xz * _BackRefractDistort);
  uvDistort_10 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (xlv_TEXCOORD5 + uvDistort_10);
  distortScreenPos_9 = tmpvar_28;
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_29 = texture2D (_BeforeAlphaTexture, P_30);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((2.0 * _RefractColor).xyz * tmpvar_29.xyz);
  refraColor_8 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_26)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.w);
  mediump float tmpvar_33;
  tmpvar_33 = dot (worldViewDir_14, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((1.570796 - 
    (sign(tmpvar_33) * (1.570796 - (sqrt(
      (1.0 - abs(tmpvar_33))
    ) * (1.570796 + 
      (abs(tmpvar_33) * (-0.2146018 + (abs(tmpvar_33) * (0.08656672 + 
        (abs(tmpvar_33) * -0.03102955)
      ))))
    ))))
  ) * 57.29583) + ((tmpvar_24.x + tmpvar_24.z) * _BackAngleDistort));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (worldViewDir_14, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_35;
  tmpvar_35 = (1.0 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * pow (tmpvar_35, 5.0)));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * pow ((
    clamp (((-(tmpvar_32) * 0.5) * xlv_TEXCOORD6.xyz), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_6 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = _WaterColor.xyz;
  waterColor_5 = tmpvar_38;
  if ((testAngle_7 < _BackCriticalAngle)) {
    waterColor_5.xyz = (_WaterColor.xyz + (refraColor_8 * coff_6));
  };
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_39;
  tmpvar_39 = (((tmpvar_24.xz * _BackReflectDistort) * (reflUV_3.w * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_39);
  lowp vec4 tmpvar_40;
  mediump vec2 P_41;
  P_41 = (reflUV_3.xy / reflUV_3.w);
  tmpvar_40 = texture2D (_ReflectionTex, P_41);
  ssrRefl_4 = tmpvar_40;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (_UWFogColorFar.xyz, ssrRefl_4.xyz, vec3((1.0 - clamp (
    (len_15 * _BackReflectLerpFactor)
  , 0.0, 1.0))));
  reflectColor_2 = tmpvar_42;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_43;
    tmpvar_43 = mix (_WaterColor.xyz, reflectColor_2, vec3((_BackReflectIntensity * tmpvar_36)));
    waterColor_5.xyz = tmpvar_43;
  };
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 1.0;
  tmpvar_44.xyz = waterColor_5.xyz;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = tmpvar_44.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_45, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_46;
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (pow ((
    clamp ((tmpvar_32 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  finalRGBA_1.w = tmpvar_47;
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _BackDensity;
uniform highp float _BackShoreTransparency;
uniform highp float _BackFogDensity;
uniform highp float _BackFogEffectLimit;
uniform highp float _BackFogEffectStart;
uniform highp float _BackFogStart;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec2 largeWaveSpeedTilling_1;
  mediump vec2 largeWaveTilling_2;
  mediump vec2 smallWaveSpeedTilling_3;
  mediump vec2 smallWaveTilling_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14.x = sqrt(dot (v_11.xyz, v_11.xyz));
  tmpvar_14.y = sqrt(dot (v_12.xyz, v_12.xyz));
  tmpvar_14.z = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec3 tmpvar_15;
  tmpvar_15 = (0.1 / tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xz * _SmallWavesParams.xy);
  smallWaveTilling_4 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_3 = tmpvar_17;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_4) + smallWaveSpeedTilling_3);
  tmpvar_5.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_4) * 2.0) + (smallWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_15.xz * _LargeWavesParams.xy);
  largeWaveTilling_2 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_1 = tmpvar_19;
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_2) + largeWaveSpeedTilling_1);
  tmpvar_6.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_2) * 2.0) + (largeWaveSpeedTilling_1 * 1.5));
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7.xyz = tmpvar_20.xyz;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_9.zw;
  tmpvar_8.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_8.w = (1.0/(_BackShoreTransparency));
  tmpvar_7.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_25;
  fogParam_25.w = 0.0;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = max (0.0, (sqrt(
    dot (tmpvar_26, tmpvar_26)
  ) - _BackFogStart));
  highp float tmpvar_28;
  tmpvar_28 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_27)
    ) * (_BackFogDensity * tmpvar_27))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_29;
  tmpvar_29 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_27))
   * 
    (_UWFogColorNFIntensity * tmpvar_27)
  )), 0.0, 1.0);
  fogParam_25.x = tmpvar_29;
  fogParam_25.y = (1.0 - tmpvar_28);
  fogParam_25.z = tmpvar_20.y;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_21));
  xlv_TEXCOORD5 = o_22;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = fogParam_25.xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _WaterColor;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackReflectLerpFactor;
uniform highp float _BackCriticalAngle;
uniform highp float _BackAngleDistort;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec3 reflectColor_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 waterColor_5;
  mediump vec3 coff_6;
  mediump float testAngle_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec4 uvDistort_10;
  mediump vec3 normalLocal_11;
  mediump vec3 largeNormal_12;
  mediump vec3 smallNormal_13;
  mediump vec3 worldViewDir_14;
  highp float len_15;
  mediump vec3 worldView_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = sqrt(dot (worldView_16, worldView_16));
  len_15 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (worldView_16 / len_15);
  worldViewDir_14 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_13 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_13 = (smallNormal_13 + tmpvar_21);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_12 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_12 = (largeNormal_12 + tmpvar_23);
  normalLocal_11.xz = (-(smallNormal_13) - largeNormal_12).xy;
  normalLocal_11.y = 1.0;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(normalLocal_11);
  normalLocal_11 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (tmpvar_24.xz * _BackRefractDistort);
  uvDistort_10 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (xlv_TEXCOORD5 + uvDistort_10);
  distortScreenPos_9 = tmpvar_28;
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_29 = texture2D (_BeforeAlphaTexture, P_30);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((2.0 * _RefractColor).xyz * tmpvar_29.xyz);
  refraColor_8 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_26)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.w);
  mediump float tmpvar_33;
  tmpvar_33 = dot (worldViewDir_14, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((1.570796 - 
    (sign(tmpvar_33) * (1.570796 - (sqrt(
      (1.0 - abs(tmpvar_33))
    ) * (1.570796 + 
      (abs(tmpvar_33) * (-0.2146018 + (abs(tmpvar_33) * (0.08656672 + 
        (abs(tmpvar_33) * -0.03102955)
      ))))
    ))))
  ) * 57.29583) + ((tmpvar_24.x + tmpvar_24.z) * _BackAngleDistort));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (worldViewDir_14, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_35;
  tmpvar_35 = (1.0 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * pow (tmpvar_35, 5.0)));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * pow ((
    clamp (((-(tmpvar_32) * 0.5) * xlv_TEXCOORD6.xyz), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_6 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = _WaterColor.xyz;
  waterColor_5 = tmpvar_38;
  if ((testAngle_7 < _BackCriticalAngle)) {
    waterColor_5.xyz = (_WaterColor.xyz + (refraColor_8 * coff_6));
  };
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_39;
  tmpvar_39 = (((tmpvar_24.xz * _BackReflectDistort) * (reflUV_3.w * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_39);
  lowp vec4 tmpvar_40;
  mediump vec2 P_41;
  P_41 = (reflUV_3.xy / reflUV_3.w);
  tmpvar_40 = texture2D (_ReflectionTex, P_41);
  ssrRefl_4 = tmpvar_40;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (_UWFogColorFar.xyz, ssrRefl_4.xyz, vec3((1.0 - clamp (
    (len_15 * _BackReflectLerpFactor)
  , 0.0, 1.0))));
  reflectColor_2 = tmpvar_42;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_43;
    tmpvar_43 = mix (_WaterColor.xyz, reflectColor_2, vec3((_BackReflectIntensity * tmpvar_36)));
    waterColor_5.xyz = tmpvar_43;
  };
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 1.0;
  tmpvar_44.xyz = waterColor_5.xyz;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = tmpvar_44.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_45, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_46;
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (pow ((
    clamp ((tmpvar_32 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  finalRGBA_1.w = tmpvar_47;
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _BackDensity;
uniform highp float _BackShoreTransparency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 largeWaveSpeedTilling_1;
  mediump vec2 largeWaveTilling_2;
  mediump vec2 smallWaveSpeedTilling_3;
  mediump vec2 smallWaveTilling_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14.x = sqrt(dot (v_11.xyz, v_11.xyz));
  tmpvar_14.y = sqrt(dot (v_12.xyz, v_12.xyz));
  tmpvar_14.z = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec3 tmpvar_15;
  tmpvar_15 = (0.1 / tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xz * _SmallWavesParams.xy);
  smallWaveTilling_4 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_3 = tmpvar_17;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_4) + smallWaveSpeedTilling_3);
  tmpvar_5.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_4) * 2.0) + (smallWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_15.xz * _LargeWavesParams.xy);
  largeWaveTilling_2 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_1 = tmpvar_19;
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_2) + largeWaveSpeedTilling_1);
  tmpvar_6.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_2) * 2.0) + (largeWaveSpeedTilling_1 * 1.5));
  tmpvar_7.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  tmpvar_8.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_8.w = (1.0/(_BackShoreTransparency));
  tmpvar_7.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_20));
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _WaterColor;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackReflectLerpFactor;
uniform highp float _BackCriticalAngle;
uniform highp float _BackAngleDistort;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec3 reflectColor_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 waterColor_5;
  mediump vec3 coff_6;
  mediump float testAngle_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec4 uvDistort_10;
  mediump vec3 normalLocal_11;
  mediump vec3 largeNormal_12;
  mediump vec3 smallNormal_13;
  mediump vec3 worldViewDir_14;
  highp float len_15;
  mediump vec3 worldView_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = sqrt(dot (worldView_16, worldView_16));
  len_15 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (worldView_16 / len_15);
  worldViewDir_14 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_13 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_13 = (smallNormal_13 + tmpvar_21);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_12 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_12 = (largeNormal_12 + tmpvar_23);
  normalLocal_11.xz = (-(smallNormal_13) - largeNormal_12).xy;
  normalLocal_11.y = 1.0;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(normalLocal_11);
  normalLocal_11 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (tmpvar_24.xz * _BackRefractDistort);
  uvDistort_10 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (xlv_TEXCOORD5 + uvDistort_10);
  distortScreenPos_9 = tmpvar_28;
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_29 = texture2D (_BeforeAlphaTexture, P_30);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((2.0 * _RefractColor).xyz * tmpvar_29.xyz);
  refraColor_8 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_26)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.w);
  mediump float tmpvar_33;
  tmpvar_33 = dot (worldViewDir_14, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((1.570796 - 
    (sign(tmpvar_33) * (1.570796 - (sqrt(
      (1.0 - abs(tmpvar_33))
    ) * (1.570796 + 
      (abs(tmpvar_33) * (-0.2146018 + (abs(tmpvar_33) * (0.08656672 + 
        (abs(tmpvar_33) * -0.03102955)
      ))))
    ))))
  ) * 57.29583) + ((tmpvar_24.x + tmpvar_24.z) * _BackAngleDistort));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (worldViewDir_14, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_35;
  tmpvar_35 = (1.0 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * pow (tmpvar_35, 5.0)));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * pow ((
    clamp (((-(tmpvar_32) * 0.5) * xlv_TEXCOORD6.xyz), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_6 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = _WaterColor.xyz;
  waterColor_5 = tmpvar_38;
  if ((testAngle_7 < _BackCriticalAngle)) {
    waterColor_5.xyz = (_WaterColor.xyz + (refraColor_8 * coff_6));
  };
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_39;
  tmpvar_39 = (((tmpvar_24.xz * _BackReflectDistort) * (reflUV_3.w * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_39);
  lowp vec4 tmpvar_40;
  mediump vec2 P_41;
  P_41 = (reflUV_3.xy / reflUV_3.w);
  tmpvar_40 = texture2D (_ReflectionTex, P_41);
  ssrRefl_4 = tmpvar_40;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (_UWFogColorFar.xyz, ssrRefl_4.xyz, vec3((1.0 - clamp (
    (len_15 * _BackReflectLerpFactor)
  , 0.0, 1.0))));
  reflectColor_2 = tmpvar_42;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_43;
    tmpvar_43 = mix (_WaterColor.xyz, reflectColor_2, vec3((_BackReflectIntensity * tmpvar_36)));
    waterColor_5.xyz = tmpvar_43;
  };
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (pow ((
    clamp ((tmpvar_32 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  finalRGBA_1.w = tmpvar_44;
  finalRGBA_1.xyz = mix (waterColor_5.xyz, vec3(dot (waterColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _BackDensity;
uniform highp float _BackShoreTransparency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 largeWaveSpeedTilling_1;
  mediump vec2 largeWaveTilling_2;
  mediump vec2 smallWaveSpeedTilling_3;
  mediump vec2 smallWaveTilling_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14.x = sqrt(dot (v_11.xyz, v_11.xyz));
  tmpvar_14.y = sqrt(dot (v_12.xyz, v_12.xyz));
  tmpvar_14.z = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec3 tmpvar_15;
  tmpvar_15 = (0.1 / tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xz * _SmallWavesParams.xy);
  smallWaveTilling_4 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_3 = tmpvar_17;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_4) + smallWaveSpeedTilling_3);
  tmpvar_5.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_4) * 2.0) + (smallWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_15.xz * _LargeWavesParams.xy);
  largeWaveTilling_2 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_1 = tmpvar_19;
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_2) + largeWaveSpeedTilling_1);
  tmpvar_6.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_2) * 2.0) + (largeWaveSpeedTilling_1 * 1.5));
  tmpvar_7.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  tmpvar_8.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_8.w = (1.0/(_BackShoreTransparency));
  tmpvar_7.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_20));
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _WaterColor;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackReflectLerpFactor;
uniform highp float _BackCriticalAngle;
uniform highp float _BackAngleDistort;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec3 reflectColor_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 waterColor_5;
  mediump vec3 coff_6;
  mediump float testAngle_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec4 uvDistort_10;
  mediump vec3 normalLocal_11;
  mediump vec3 largeNormal_12;
  mediump vec3 smallNormal_13;
  mediump vec3 worldViewDir_14;
  highp float len_15;
  mediump vec3 worldView_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = sqrt(dot (worldView_16, worldView_16));
  len_15 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (worldView_16 / len_15);
  worldViewDir_14 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_13 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_13 = (smallNormal_13 + tmpvar_21);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_12 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_12 = (largeNormal_12 + tmpvar_23);
  normalLocal_11.xz = (-(smallNormal_13) - largeNormal_12).xy;
  normalLocal_11.y = 1.0;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(normalLocal_11);
  normalLocal_11 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (tmpvar_24.xz * _BackRefractDistort);
  uvDistort_10 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (xlv_TEXCOORD5 + uvDistort_10);
  distortScreenPos_9 = tmpvar_28;
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_29 = texture2D (_BeforeAlphaTexture, P_30);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((2.0 * _RefractColor).xyz * tmpvar_29.xyz);
  refraColor_8 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_26)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.w);
  mediump float tmpvar_33;
  tmpvar_33 = dot (worldViewDir_14, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((1.570796 - 
    (sign(tmpvar_33) * (1.570796 - (sqrt(
      (1.0 - abs(tmpvar_33))
    ) * (1.570796 + 
      (abs(tmpvar_33) * (-0.2146018 + (abs(tmpvar_33) * (0.08656672 + 
        (abs(tmpvar_33) * -0.03102955)
      ))))
    ))))
  ) * 57.29583) + ((tmpvar_24.x + tmpvar_24.z) * _BackAngleDistort));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (worldViewDir_14, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_35;
  tmpvar_35 = (1.0 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * pow (tmpvar_35, 5.0)));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * pow ((
    clamp (((-(tmpvar_32) * 0.5) * xlv_TEXCOORD6.xyz), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_6 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = _WaterColor.xyz;
  waterColor_5 = tmpvar_38;
  if ((testAngle_7 < _BackCriticalAngle)) {
    waterColor_5.xyz = (_WaterColor.xyz + (refraColor_8 * coff_6));
  };
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_39;
  tmpvar_39 = (((tmpvar_24.xz * _BackReflectDistort) * (reflUV_3.w * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_39);
  lowp vec4 tmpvar_40;
  mediump vec2 P_41;
  P_41 = (reflUV_3.xy / reflUV_3.w);
  tmpvar_40 = texture2D (_ReflectionTex, P_41);
  ssrRefl_4 = tmpvar_40;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (_UWFogColorFar.xyz, ssrRefl_4.xyz, vec3((1.0 - clamp (
    (len_15 * _BackReflectLerpFactor)
  , 0.0, 1.0))));
  reflectColor_2 = tmpvar_42;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_43;
    tmpvar_43 = mix (_WaterColor.xyz, reflectColor_2, vec3((_BackReflectIntensity * tmpvar_36)));
    waterColor_5.xyz = tmpvar_43;
  };
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (pow ((
    clamp ((tmpvar_32 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  finalRGBA_1.w = tmpvar_44;
  finalRGBA_1.xyz = mix (waterColor_5.xyz, vec3(dot (waterColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _BackDensity;
uniform highp float _BackShoreTransparency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec2 largeWaveSpeedTilling_1;
  mediump vec2 largeWaveTilling_2;
  mediump vec2 smallWaveSpeedTilling_3;
  mediump vec2 smallWaveTilling_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14.x = sqrt(dot (v_11.xyz, v_11.xyz));
  tmpvar_14.y = sqrt(dot (v_12.xyz, v_12.xyz));
  tmpvar_14.z = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec3 tmpvar_15;
  tmpvar_15 = (0.1 / tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xz * _SmallWavesParams.xy);
  smallWaveTilling_4 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_3 = tmpvar_17;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_4) + smallWaveSpeedTilling_3);
  tmpvar_5.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_4) * 2.0) + (smallWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_15.xz * _LargeWavesParams.xy);
  largeWaveTilling_2 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_1 = tmpvar_19;
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_2) + largeWaveSpeedTilling_1);
  tmpvar_6.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_2) * 2.0) + (largeWaveSpeedTilling_1 * 1.5));
  tmpvar_7.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_9.zw;
  tmpvar_8.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_8.w = (1.0/(_BackShoreTransparency));
  tmpvar_7.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_20));
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _WaterColor;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackReflectLerpFactor;
uniform highp float _BackCriticalAngle;
uniform highp float _BackAngleDistort;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec3 reflectColor_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 waterColor_5;
  mediump vec3 coff_6;
  mediump float testAngle_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec4 uvDistort_10;
  mediump vec3 normalLocal_11;
  mediump vec3 largeNormal_12;
  mediump vec3 smallNormal_13;
  mediump vec3 worldViewDir_14;
  highp float len_15;
  mediump vec3 worldView_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = sqrt(dot (worldView_16, worldView_16));
  len_15 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (worldView_16 / len_15);
  worldViewDir_14 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_13 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_13 = (smallNormal_13 + tmpvar_21);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_12 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_12 = (largeNormal_12 + tmpvar_23);
  normalLocal_11.xz = (-(smallNormal_13) - largeNormal_12).xy;
  normalLocal_11.y = 1.0;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(normalLocal_11);
  normalLocal_11 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (tmpvar_24.xz * _BackRefractDistort);
  uvDistort_10 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (xlv_TEXCOORD5 + uvDistort_10);
  distortScreenPos_9 = tmpvar_28;
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_29 = texture2D (_BeforeAlphaTexture, P_30);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((2.0 * _RefractColor).xyz * tmpvar_29.xyz);
  refraColor_8 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_26)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.w);
  mediump float tmpvar_33;
  tmpvar_33 = dot (worldViewDir_14, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((1.570796 - 
    (sign(tmpvar_33) * (1.570796 - (sqrt(
      (1.0 - abs(tmpvar_33))
    ) * (1.570796 + 
      (abs(tmpvar_33) * (-0.2146018 + (abs(tmpvar_33) * (0.08656672 + 
        (abs(tmpvar_33) * -0.03102955)
      ))))
    ))))
  ) * 57.29583) + ((tmpvar_24.x + tmpvar_24.z) * _BackAngleDistort));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (worldViewDir_14, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_35;
  tmpvar_35 = (1.0 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * pow (tmpvar_35, 5.0)));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * pow ((
    clamp (((-(tmpvar_32) * 0.5) * xlv_TEXCOORD6.xyz), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_6 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = _WaterColor.xyz;
  waterColor_5 = tmpvar_38;
  if ((testAngle_7 < _BackCriticalAngle)) {
    waterColor_5.xyz = (_WaterColor.xyz + (refraColor_8 * coff_6));
  };
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_39;
  tmpvar_39 = (((tmpvar_24.xz * _BackReflectDistort) * (reflUV_3.w * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_39);
  lowp vec4 tmpvar_40;
  mediump vec2 P_41;
  P_41 = (reflUV_3.xy / reflUV_3.w);
  tmpvar_40 = texture2D (_ReflectionTex, P_41);
  ssrRefl_4 = tmpvar_40;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (_UWFogColorFar.xyz, ssrRefl_4.xyz, vec3((1.0 - clamp (
    (len_15 * _BackReflectLerpFactor)
  , 0.0, 1.0))));
  reflectColor_2 = tmpvar_42;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_43;
    tmpvar_43 = mix (_WaterColor.xyz, reflectColor_2, vec3((_BackReflectIntensity * tmpvar_36)));
    waterColor_5.xyz = tmpvar_43;
  };
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (pow ((
    clamp ((tmpvar_32 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  finalRGBA_1.w = tmpvar_44;
  finalRGBA_1.xyz = mix (waterColor_5.xyz, vec3(dot (waterColor_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _BackDensity;
uniform highp float _BackShoreTransparency;
uniform highp float _BackFogDensity;
uniform highp float _BackFogEffectLimit;
uniform highp float _BackFogEffectStart;
uniform highp float _BackFogStart;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec2 largeWaveSpeedTilling_1;
  mediump vec2 largeWaveTilling_2;
  mediump vec2 smallWaveSpeedTilling_3;
  mediump vec2 smallWaveTilling_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14.x = sqrt(dot (v_11.xyz, v_11.xyz));
  tmpvar_14.y = sqrt(dot (v_12.xyz, v_12.xyz));
  tmpvar_14.z = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec3 tmpvar_15;
  tmpvar_15 = (0.1 / tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xz * _SmallWavesParams.xy);
  smallWaveTilling_4 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_3 = tmpvar_17;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_4) + smallWaveSpeedTilling_3);
  tmpvar_5.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_4) * 2.0) + (smallWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_15.xz * _LargeWavesParams.xy);
  largeWaveTilling_2 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_1 = tmpvar_19;
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_2) + largeWaveSpeedTilling_1);
  tmpvar_6.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_2) * 2.0) + (largeWaveSpeedTilling_1 * 1.5));
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7.xyz = tmpvar_20.xyz;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_9.zw;
  tmpvar_8.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_8.w = (1.0/(_BackShoreTransparency));
  tmpvar_7.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_25;
  fogParam_25.w = 0.0;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = max (0.0, (sqrt(
    dot (tmpvar_26, tmpvar_26)
  ) - _BackFogStart));
  highp float tmpvar_28;
  tmpvar_28 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_27)
    ) * (_BackFogDensity * tmpvar_27))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_29;
  tmpvar_29 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_27))
   * 
    (_UWFogColorNFIntensity * tmpvar_27)
  )), 0.0, 1.0);
  fogParam_25.x = tmpvar_29;
  fogParam_25.y = (1.0 - tmpvar_28);
  fogParam_25.z = tmpvar_20.y;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_21));
  xlv_TEXCOORD5 = o_22;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = fogParam_25.xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _WaterColor;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackReflectLerpFactor;
uniform highp float _BackCriticalAngle;
uniform highp float _BackAngleDistort;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec3 reflectColor_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 waterColor_5;
  mediump vec3 coff_6;
  mediump float testAngle_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec4 uvDistort_10;
  mediump vec3 normalLocal_11;
  mediump vec3 largeNormal_12;
  mediump vec3 smallNormal_13;
  mediump vec3 worldViewDir_14;
  highp float len_15;
  mediump vec3 worldView_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = sqrt(dot (worldView_16, worldView_16));
  len_15 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (worldView_16 / len_15);
  worldViewDir_14 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_13 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_13 = (smallNormal_13 + tmpvar_21);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_12 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_12 = (largeNormal_12 + tmpvar_23);
  normalLocal_11.xz = (-(smallNormal_13) - largeNormal_12).xy;
  normalLocal_11.y = 1.0;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(normalLocal_11);
  normalLocal_11 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (tmpvar_24.xz * _BackRefractDistort);
  uvDistort_10 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (xlv_TEXCOORD5 + uvDistort_10);
  distortScreenPos_9 = tmpvar_28;
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_29 = texture2D (_BeforeAlphaTexture, P_30);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((2.0 * _RefractColor).xyz * tmpvar_29.xyz);
  refraColor_8 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_26)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.w);
  mediump float tmpvar_33;
  tmpvar_33 = dot (worldViewDir_14, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((1.570796 - 
    (sign(tmpvar_33) * (1.570796 - (sqrt(
      (1.0 - abs(tmpvar_33))
    ) * (1.570796 + 
      (abs(tmpvar_33) * (-0.2146018 + (abs(tmpvar_33) * (0.08656672 + 
        (abs(tmpvar_33) * -0.03102955)
      ))))
    ))))
  ) * 57.29583) + ((tmpvar_24.x + tmpvar_24.z) * _BackAngleDistort));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (worldViewDir_14, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_35;
  tmpvar_35 = (1.0 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * pow (tmpvar_35, 5.0)));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * pow ((
    clamp (((-(tmpvar_32) * 0.5) * xlv_TEXCOORD6.xyz), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_6 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = _WaterColor.xyz;
  waterColor_5 = tmpvar_38;
  if ((testAngle_7 < _BackCriticalAngle)) {
    waterColor_5.xyz = (_WaterColor.xyz + (refraColor_8 * coff_6));
  };
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_39;
  tmpvar_39 = (((tmpvar_24.xz * _BackReflectDistort) * (reflUV_3.w * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_39);
  lowp vec4 tmpvar_40;
  mediump vec2 P_41;
  P_41 = (reflUV_3.xy / reflUV_3.w);
  tmpvar_40 = texture2D (_ReflectionTex, P_41);
  ssrRefl_4 = tmpvar_40;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (_UWFogColorFar.xyz, ssrRefl_4.xyz, vec3((1.0 - clamp (
    (len_15 * _BackReflectLerpFactor)
  , 0.0, 1.0))));
  reflectColor_2 = tmpvar_42;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_43;
    tmpvar_43 = mix (_WaterColor.xyz, reflectColor_2, vec3((_BackReflectIntensity * tmpvar_36)));
    waterColor_5.xyz = tmpvar_43;
  };
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 1.0;
  tmpvar_44.xyz = waterColor_5.xyz;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = tmpvar_44.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_45, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_46;
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (pow ((
    clamp ((tmpvar_32 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  finalRGBA_1.w = tmpvar_47;
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _BackDensity;
uniform highp float _BackShoreTransparency;
uniform highp float _BackFogDensity;
uniform highp float _BackFogEffectLimit;
uniform highp float _BackFogEffectStart;
uniform highp float _BackFogStart;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec2 largeWaveSpeedTilling_1;
  mediump vec2 largeWaveTilling_2;
  mediump vec2 smallWaveSpeedTilling_3;
  mediump vec2 smallWaveTilling_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14.x = sqrt(dot (v_11.xyz, v_11.xyz));
  tmpvar_14.y = sqrt(dot (v_12.xyz, v_12.xyz));
  tmpvar_14.z = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec3 tmpvar_15;
  tmpvar_15 = (0.1 / tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xz * _SmallWavesParams.xy);
  smallWaveTilling_4 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_3 = tmpvar_17;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_4) + smallWaveSpeedTilling_3);
  tmpvar_5.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_4) * 2.0) + (smallWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_15.xz * _LargeWavesParams.xy);
  largeWaveTilling_2 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_1 = tmpvar_19;
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_2) + largeWaveSpeedTilling_1);
  tmpvar_6.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_2) * 2.0) + (largeWaveSpeedTilling_1 * 1.5));
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7.xyz = tmpvar_20.xyz;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_9.zw;
  tmpvar_8.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_8.w = (1.0/(_BackShoreTransparency));
  tmpvar_7.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_25;
  fogParam_25.w = 0.0;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = max (0.0, (sqrt(
    dot (tmpvar_26, tmpvar_26)
  ) - _BackFogStart));
  highp float tmpvar_28;
  tmpvar_28 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_27)
    ) * (_BackFogDensity * tmpvar_27))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_29;
  tmpvar_29 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_27))
   * 
    (_UWFogColorNFIntensity * tmpvar_27)
  )), 0.0, 1.0);
  fogParam_25.x = tmpvar_29;
  fogParam_25.y = (1.0 - tmpvar_28);
  fogParam_25.z = tmpvar_20.y;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_21));
  xlv_TEXCOORD5 = o_22;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = fogParam_25.xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _WaterColor;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackReflectLerpFactor;
uniform highp float _BackCriticalAngle;
uniform highp float _BackAngleDistort;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec3 reflectColor_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 waterColor_5;
  mediump vec3 coff_6;
  mediump float testAngle_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec4 uvDistort_10;
  mediump vec3 normalLocal_11;
  mediump vec3 largeNormal_12;
  mediump vec3 smallNormal_13;
  mediump vec3 worldViewDir_14;
  highp float len_15;
  mediump vec3 worldView_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = sqrt(dot (worldView_16, worldView_16));
  len_15 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (worldView_16 / len_15);
  worldViewDir_14 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_13 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_13 = (smallNormal_13 + tmpvar_21);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_12 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_12 = (largeNormal_12 + tmpvar_23);
  normalLocal_11.xz = (-(smallNormal_13) - largeNormal_12).xy;
  normalLocal_11.y = 1.0;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(normalLocal_11);
  normalLocal_11 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (tmpvar_24.xz * _BackRefractDistort);
  uvDistort_10 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (xlv_TEXCOORD5 + uvDistort_10);
  distortScreenPos_9 = tmpvar_28;
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_29 = texture2D (_BeforeAlphaTexture, P_30);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((2.0 * _RefractColor).xyz * tmpvar_29.xyz);
  refraColor_8 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_26)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.w);
  mediump float tmpvar_33;
  tmpvar_33 = dot (worldViewDir_14, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((1.570796 - 
    (sign(tmpvar_33) * (1.570796 - (sqrt(
      (1.0 - abs(tmpvar_33))
    ) * (1.570796 + 
      (abs(tmpvar_33) * (-0.2146018 + (abs(tmpvar_33) * (0.08656672 + 
        (abs(tmpvar_33) * -0.03102955)
      ))))
    ))))
  ) * 57.29583) + ((tmpvar_24.x + tmpvar_24.z) * _BackAngleDistort));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (worldViewDir_14, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_35;
  tmpvar_35 = (1.0 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * pow (tmpvar_35, 5.0)));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * pow ((
    clamp (((-(tmpvar_32) * 0.5) * xlv_TEXCOORD6.xyz), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_6 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = _WaterColor.xyz;
  waterColor_5 = tmpvar_38;
  if ((testAngle_7 < _BackCriticalAngle)) {
    waterColor_5.xyz = (_WaterColor.xyz + (refraColor_8 * coff_6));
  };
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_39;
  tmpvar_39 = (((tmpvar_24.xz * _BackReflectDistort) * (reflUV_3.w * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_39);
  lowp vec4 tmpvar_40;
  mediump vec2 P_41;
  P_41 = (reflUV_3.xy / reflUV_3.w);
  tmpvar_40 = texture2D (_ReflectionTex, P_41);
  ssrRefl_4 = tmpvar_40;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (_UWFogColorFar.xyz, ssrRefl_4.xyz, vec3((1.0 - clamp (
    (len_15 * _BackReflectLerpFactor)
  , 0.0, 1.0))));
  reflectColor_2 = tmpvar_42;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_43;
    tmpvar_43 = mix (_WaterColor.xyz, reflectColor_2, vec3((_BackReflectIntensity * tmpvar_36)));
    waterColor_5.xyz = tmpvar_43;
  };
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 1.0;
  tmpvar_44.xyz = waterColor_5.xyz;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = tmpvar_44.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_45, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_46;
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (pow ((
    clamp ((tmpvar_32 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  finalRGBA_1.w = tmpvar_47;
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UV_Mix_Range;
uniform highp vec4 _SmallWavesParams;
uniform highp vec4 _LargeWavesParams;
uniform highp vec4 _RefractColor;
uniform highp float _BackDensity;
uniform highp float _BackShoreTransparency;
uniform highp float _BackFogDensity;
uniform highp float _BackFogEffectLimit;
uniform highp float _BackFogEffectStart;
uniform highp float _BackFogStart;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec2 largeWaveSpeedTilling_1;
  mediump vec2 largeWaveTilling_2;
  mediump vec2 smallWaveSpeedTilling_3;
  mediump vec2 smallWaveTilling_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14.x = sqrt(dot (v_11.xyz, v_11.xyz));
  tmpvar_14.y = sqrt(dot (v_12.xyz, v_12.xyz));
  tmpvar_14.z = sqrt(dot (v_13.xyz, v_13.xyz));
  highp vec3 tmpvar_15;
  tmpvar_15 = (0.1 / tmpvar_14);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xz * _SmallWavesParams.xy);
  smallWaveTilling_4 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((_SmallWavesParams.zw * _Time.y) * 0.1);
  smallWaveSpeedTilling_3 = tmpvar_17;
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * smallWaveTilling_4) + smallWaveSpeedTilling_3);
  tmpvar_5.zw = (((_glesMultiTexCoord0.xy * smallWaveTilling_4) * 2.0) + (smallWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_15.xz * _LargeWavesParams.xy);
  largeWaveTilling_2 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_LargeWavesParams.zw * _Time.y) * 0.1);
  largeWaveSpeedTilling_1 = tmpvar_19;
  tmpvar_6.xy = ((_glesMultiTexCoord0.xy * largeWaveTilling_2) + largeWaveSpeedTilling_1);
  tmpvar_6.zw = (((_glesMultiTexCoord0.xy * largeWaveTilling_2) * 2.0) + (largeWaveSpeedTilling_1 * 1.5));
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7.xyz = tmpvar_20.xyz;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_9.zw;
  tmpvar_8.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_8.w = (1.0/(_BackShoreTransparency));
  tmpvar_7.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_25;
  fogParam_25.w = 0.0;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_20.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_27;
  tmpvar_27 = max (0.0, (sqrt(
    dot (tmpvar_26, tmpvar_26)
  ) - _BackFogStart));
  highp float tmpvar_28;
  tmpvar_28 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_27)
    ) * (_BackFogDensity * tmpvar_27))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_29;
  tmpvar_29 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_27))
   * 
    (_UWFogColorNFIntensity * tmpvar_27)
  )), 0.0, 1.0);
  fogParam_25.x = tmpvar_29;
  fogParam_25.y = (1.0 - tmpvar_28);
  fogParam_25.z = tmpvar_20.y;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_21));
  xlv_TEXCOORD5 = o_22;
  xlv_TEXCOORD6 = tmpvar_8;
  xlv_TEXCOORD7 = fogParam_25.xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp vec4 _WaterColor;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _RefractColor;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackReflectLerpFactor;
uniform highp float _BackCriticalAngle;
uniform highp float _BackAngleDistort;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec3 reflectColor_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec4 waterColor_5;
  mediump vec3 coff_6;
  mediump float testAngle_7;
  mediump vec3 refraColor_8;
  mediump vec4 distortScreenPos_9;
  mediump vec4 uvDistort_10;
  mediump vec3 normalLocal_11;
  mediump vec3 largeNormal_12;
  mediump vec3 smallNormal_13;
  mediump vec3 worldViewDir_14;
  highp float len_15;
  mediump vec3 worldView_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = sqrt(dot (worldView_16, worldView_16));
  len_15 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (worldView_16 / len_15);
  worldViewDir_14 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_13 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_13 = (smallNormal_13 + tmpvar_21);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_12 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_12 = (largeNormal_12 + tmpvar_23);
  normalLocal_11.xz = (-(smallNormal_13) - largeNormal_12).xy;
  normalLocal_11.y = 1.0;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(normalLocal_11);
  normalLocal_11 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD5);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 0.0);
  tmpvar_27.xy = (tmpvar_24.xz * _BackRefractDistort);
  uvDistort_10 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (xlv_TEXCOORD5 + uvDistort_10);
  distortScreenPos_9 = tmpvar_28;
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = (distortScreenPos_9.xy / distortScreenPos_9.w);
  tmpvar_29 = texture2D (_BeforeAlphaTexture, P_30);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((2.0 * _RefractColor).xyz * tmpvar_29.xyz);
  refraColor_8 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = ((1.0/((
    (_ZBufferParams.z * z_26)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.w);
  mediump float tmpvar_33;
  tmpvar_33 = dot (worldViewDir_14, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((1.570796 - 
    (sign(tmpvar_33) * (1.570796 - (sqrt(
      (1.0 - abs(tmpvar_33))
    ) * (1.570796 + 
      (abs(tmpvar_33) * (-0.2146018 + (abs(tmpvar_33) * (0.08656672 + 
        (abs(tmpvar_33) * -0.03102955)
      ))))
    ))))
  ) * 57.29583) + ((tmpvar_24.x + tmpvar_24.z) * _BackAngleDistort));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (worldViewDir_14, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_35;
  tmpvar_35 = (1.0 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * pow (tmpvar_35, 5.0)));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 * pow ((
    clamp (((-(tmpvar_32) * 0.5) * xlv_TEXCOORD6.xyz), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_6 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = _WaterColor.xyz;
  waterColor_5 = tmpvar_38;
  if ((testAngle_7 < _BackCriticalAngle)) {
    waterColor_5.xyz = (_WaterColor.xyz + (refraColor_8 * coff_6));
  };
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_39;
  tmpvar_39 = (((tmpvar_24.xz * _BackReflectDistort) * (reflUV_3.w * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.w) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_39);
  lowp vec4 tmpvar_40;
  mediump vec2 P_41;
  P_41 = (reflUV_3.xy / reflUV_3.w);
  tmpvar_40 = texture2D (_ReflectionTex, P_41);
  ssrRefl_4 = tmpvar_40;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (_UWFogColorFar.xyz, ssrRefl_4.xyz, vec3((1.0 - clamp (
    (len_15 * _BackReflectLerpFactor)
  , 0.0, 1.0))));
  reflectColor_2 = tmpvar_42;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_43;
    tmpvar_43 = mix (_WaterColor.xyz, reflectColor_2, vec3((_BackReflectIntensity * tmpvar_36)));
    waterColor_5.xyz = tmpvar_43;
  };
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 1.0;
  tmpvar_44.xyz = waterColor_5.xyz;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = tmpvar_44.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_45, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_46;
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (pow ((
    clamp ((tmpvar_32 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  finalRGBA_1.w = tmpvar_47;
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalRGBA_1;
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
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
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
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
}
}
}
Fallback "Diffuse"
}