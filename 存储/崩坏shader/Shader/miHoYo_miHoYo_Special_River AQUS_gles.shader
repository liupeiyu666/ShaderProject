//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/River AQUS" {
Properties {
[Header(Global)] _UV_Mix_Start_Distance ("UV_Mix_Start_Distance", Range(0, 3000)) = 400
_UV_Mix_Range ("UV_Mix_Range", Range(1, 500)) = 100
[Header(MainColor)] _RefractColor ("Refract Color", Color) = (0,0.4627451,1,1)
_ReflectColor ("Reflect Color", Color) = (1,1,1,1)
_WaterColor ("Water Color", Color) = (1,1,1,1)
_FrontRefractFade ("Front Refract Fade", Float) = 1.45
_BackRefractFade ("Back Refract Fade", Float) = 1.45
_FrontDensity ("Front Density", Range(0, 10)) = 1.74
_BackDensity ("Back Density", Range(0, 10)) = 1.74
[Header(Transparency)] _FrontShoreTransparency ("Front Shore Transparency", Range(0.0001, 10)) = 0.04
_FrontShoreFade ("Front Shore Fade", Range(0.0001, 10)) = 0.3
_BackShoreTransparency ("Back Shore Transparency", Range(0.0001, 10)) = 0.04
_BackShoreFade ("Back Shore Fade", Range(0.0001, 10)) = 0.3
[Header(Fresnel)] _FrontFresnelBias ("Front Fresnel Bias", Range(0, 1)) = 0.1
_BackFresnelBias ("Back Fresnel Bias", Range(0, 1)) = 0.1
[Header(Refraction)] _ReflectionTex ("Reflection", 2D) = "white" { }
_FrontRefractDistort ("Front Refraction Distort", Range(0, 0.1)) = 0.067
_BackRefractDistort ("Back Refraction Distort", Range(0, 0.1)) = 0.067
_FrontReflectIntensity ("Front Reflection Intensity", Range(0, 1)) = 0.6
_BackReflectIntensity ("Back Reflection Intensity", Range(0, 1)) = 0.6
_FrontReflectDistort ("Front Reflction Distortion", Range(0, 5)) = 0.3
_BackReflectDistort ("Back Reflection Distortion", Range(0, 5)) = 0.3
_BackCriticalAngle ("Total Reflection Critial Angle", Float) = 65
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
_ShoreFoamDepth ("Shore Foam Depth", Range(0, 5)) = 0.3
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FRONT"
  LOD 200
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 51552
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  ssrRefl_4 = _ReflectColor;
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 0.0;
  tmpvar_44.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (_ReflectColor, tmpvar_44, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = (1.0 - tmpvar_46);
  highp float tmpvar_48;
  tmpvar_48 = (tmpvar_47 * tmpvar_47);
  fresnel_2 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (fresnel_2 * tmpvar_47);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_49;
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_53;
  tmpvar_53 = ((tmpvar_52.x * (1.0 - tmpvar_50)) * tmpvar_38);
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_53));
  waterColor_7.xyz = tmpvar_54;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  ssrRefl_4 = _ReflectColor;
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 0.0;
  tmpvar_44.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (_ReflectColor, tmpvar_44, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = (1.0 - tmpvar_46);
  highp float tmpvar_48;
  tmpvar_48 = (tmpvar_47 * tmpvar_47);
  fresnel_2 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (fresnel_2 * tmpvar_47);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_49;
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_53;
  tmpvar_53 = ((tmpvar_52.x * (1.0 - tmpvar_50)) * tmpvar_38);
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_53));
  waterColor_7.xyz = tmpvar_54;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  ssrRefl_4 = _ReflectColor;
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 0.0;
  tmpvar_44.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (_ReflectColor, tmpvar_44, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = (1.0 - tmpvar_46);
  highp float tmpvar_48;
  tmpvar_48 = (tmpvar_47 * tmpvar_47);
  fresnel_2 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (fresnel_2 * tmpvar_47);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_49;
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_53;
  tmpvar_53 = ((tmpvar_52.x * (1.0 - tmpvar_50)) * tmpvar_38);
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_53));
  waterColor_7.xyz = tmpvar_54;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_REFLECTION" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (_ReflectColor, tmpvar_45, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - tmpvar_47);
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (fresnel_2 * tmpvar_48);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_50;
  mediump float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_51 = tmpvar_52;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_54;
  tmpvar_54 = ((tmpvar_53.x * (1.0 - tmpvar_51)) * tmpvar_38);
  highp vec3 tmpvar_55;
  tmpvar_55 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_54));
  waterColor_7.xyz = tmpvar_55;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (_ReflectColor, tmpvar_45, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - tmpvar_47);
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (fresnel_2 * tmpvar_48);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_50;
  mediump float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_51 = tmpvar_52;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_54;
  tmpvar_54 = ((tmpvar_53.x * (1.0 - tmpvar_51)) * tmpvar_38);
  highp vec3 tmpvar_55;
  tmpvar_55 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_54));
  waterColor_7.xyz = tmpvar_55;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (_ReflectColor, tmpvar_45, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - tmpvar_47);
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (fresnel_2 * tmpvar_48);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_50;
  mediump float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_51 = tmpvar_52;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_54;
  tmpvar_54 = ((tmpvar_53.x * (1.0 - tmpvar_51)) * tmpvar_38);
  highp vec3 tmpvar_55;
  tmpvar_55 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_54));
  waterColor_7.xyz = tmpvar_55;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  ssrRefl_4 = _ReflectColor;
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 0.0;
  tmpvar_44.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (_ReflectColor, tmpvar_44, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = (1.0 - tmpvar_46);
  highp float tmpvar_48;
  tmpvar_48 = (tmpvar_47 * tmpvar_47);
  fresnel_2 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (fresnel_2 * tmpvar_47);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_49;
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_53;
  tmpvar_53 = ((tmpvar_52.x * (1.0 - tmpvar_50)) * tmpvar_38);
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_53));
  waterColor_7.xyz = tmpvar_54;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  ssrRefl_4 = _ReflectColor;
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 0.0;
  tmpvar_44.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (_ReflectColor, tmpvar_44, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = (1.0 - tmpvar_46);
  highp float tmpvar_48;
  tmpvar_48 = (tmpvar_47 * tmpvar_47);
  fresnel_2 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (fresnel_2 * tmpvar_47);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_49;
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_53;
  tmpvar_53 = ((tmpvar_52.x * (1.0 - tmpvar_50)) * tmpvar_38);
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_53));
  waterColor_7.xyz = tmpvar_54;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  ssrRefl_4 = _ReflectColor;
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 0.0;
  tmpvar_44.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (_ReflectColor, tmpvar_44, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = (1.0 - tmpvar_46);
  highp float tmpvar_48;
  tmpvar_48 = (tmpvar_47 * tmpvar_47);
  fresnel_2 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (fresnel_2 * tmpvar_47);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_49;
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_53;
  tmpvar_53 = ((tmpvar_52.x * (1.0 - tmpvar_50)) * tmpvar_38);
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_53));
  waterColor_7.xyz = tmpvar_54;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (_ReflectColor, tmpvar_45, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - tmpvar_47);
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (fresnel_2 * tmpvar_48);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_50;
  mediump float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_51 = tmpvar_52;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_54;
  tmpvar_54 = ((tmpvar_53.x * (1.0 - tmpvar_51)) * tmpvar_38);
  highp vec3 tmpvar_55;
  tmpvar_55 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_54));
  waterColor_7.xyz = tmpvar_55;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (_ReflectColor, tmpvar_45, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - tmpvar_47);
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (fresnel_2 * tmpvar_48);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_50;
  mediump float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_51 = tmpvar_52;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_54;
  tmpvar_54 = ((tmpvar_53.x * (1.0 - tmpvar_51)) * tmpvar_38);
  highp vec3 tmpvar_55;
  tmpvar_55 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_54));
  waterColor_7.xyz = tmpvar_55;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (_ReflectColor, tmpvar_45, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - tmpvar_47);
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (fresnel_2 * tmpvar_48);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_50;
  mediump float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_51 = tmpvar_52;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_54;
  tmpvar_54 = ((tmpvar_53.x * (1.0 - tmpvar_51)) * tmpvar_38);
  highp vec3 tmpvar_55;
  tmpvar_55 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_54));
  waterColor_7.xyz = tmpvar_55;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  ssrRefl_4 = _ReflectColor;
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 0.0;
  tmpvar_44.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (_ReflectColor, tmpvar_44, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = (1.0 - tmpvar_46);
  highp float tmpvar_48;
  tmpvar_48 = (tmpvar_47 * tmpvar_47);
  fresnel_2 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (fresnel_2 * tmpvar_47);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_49;
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_53;
  tmpvar_53 = ((tmpvar_52.x * (1.0 - tmpvar_50)) * tmpvar_38);
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_53));
  waterColor_7.xyz = tmpvar_54;
  finalRGBA_1.w = tmpvar_38;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  ssrRefl_4 = _ReflectColor;
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 0.0;
  tmpvar_44.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (_ReflectColor, tmpvar_44, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = (1.0 - tmpvar_46);
  highp float tmpvar_48;
  tmpvar_48 = (tmpvar_47 * tmpvar_47);
  fresnel_2 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (fresnel_2 * tmpvar_47);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_49;
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_53;
  tmpvar_53 = ((tmpvar_52.x * (1.0 - tmpvar_50)) * tmpvar_38);
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_53));
  waterColor_7.xyz = tmpvar_54;
  finalRGBA_1.w = tmpvar_38;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  ssrRefl_4 = _ReflectColor;
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 0.0;
  tmpvar_44.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (_ReflectColor, tmpvar_44, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = (1.0 - tmpvar_46);
  highp float tmpvar_48;
  tmpvar_48 = (tmpvar_47 * tmpvar_47);
  fresnel_2 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (fresnel_2 * tmpvar_47);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_49;
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_53;
  tmpvar_53 = ((tmpvar_52.x * (1.0 - tmpvar_50)) * tmpvar_38);
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_53));
  waterColor_7.xyz = tmpvar_54;
  finalRGBA_1.w = tmpvar_38;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (_ReflectColor, tmpvar_45, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - tmpvar_47);
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (fresnel_2 * tmpvar_48);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_50;
  mediump float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_51 = tmpvar_52;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_54;
  tmpvar_54 = ((tmpvar_53.x * (1.0 - tmpvar_51)) * tmpvar_38);
  highp vec3 tmpvar_55;
  tmpvar_55 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_54));
  waterColor_7.xyz = tmpvar_55;
  finalRGBA_1.w = tmpvar_38;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (_ReflectColor, tmpvar_45, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - tmpvar_47);
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (fresnel_2 * tmpvar_48);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_50;
  mediump float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_51 = tmpvar_52;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_54;
  tmpvar_54 = ((tmpvar_53.x * (1.0 - tmpvar_51)) * tmpvar_38);
  highp vec3 tmpvar_55;
  tmpvar_55 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_54));
  waterColor_7.xyz = tmpvar_55;
  finalRGBA_1.w = tmpvar_38;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (_ReflectColor, tmpvar_45, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - tmpvar_47);
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (fresnel_2 * tmpvar_48);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_50;
  mediump float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_51 = tmpvar_52;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_54;
  tmpvar_54 = ((tmpvar_53.x * (1.0 - tmpvar_51)) * tmpvar_38);
  highp vec3 tmpvar_55;
  tmpvar_55 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_54));
  waterColor_7.xyz = tmpvar_55;
  finalRGBA_1.w = tmpvar_38;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  ssrRefl_4 = _ReflectColor;
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 0.0;
  tmpvar_44.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (_ReflectColor, tmpvar_44, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = (1.0 - tmpvar_46);
  highp float tmpvar_48;
  tmpvar_48 = (tmpvar_47 * tmpvar_47);
  fresnel_2 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (fresnel_2 * tmpvar_47);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_49;
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_53;
  tmpvar_53 = ((tmpvar_52.x * (1.0 - tmpvar_50)) * tmpvar_38);
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_53));
  waterColor_7.xyz = tmpvar_54;
  finalRGBA_1.w = tmpvar_38;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  ssrRefl_4 = _ReflectColor;
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 0.0;
  tmpvar_44.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (_ReflectColor, tmpvar_44, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = (1.0 - tmpvar_46);
  highp float tmpvar_48;
  tmpvar_48 = (tmpvar_47 * tmpvar_47);
  fresnel_2 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (fresnel_2 * tmpvar_47);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_49;
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_53;
  tmpvar_53 = ((tmpvar_52.x * (1.0 - tmpvar_50)) * tmpvar_38);
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_53));
  waterColor_7.xyz = tmpvar_54;
  finalRGBA_1.w = tmpvar_38;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  ssrRefl_4 = _ReflectColor;
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 0.0;
  tmpvar_44.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = mix (_ReflectColor, tmpvar_44, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = (1.0 - tmpvar_46);
  highp float tmpvar_48;
  tmpvar_48 = (tmpvar_47 * tmpvar_47);
  fresnel_2 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (fresnel_2 * tmpvar_47);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_49;
  tmpvar_49 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_49;
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_53;
  tmpvar_53 = ((tmpvar_52.x * (1.0 - tmpvar_50)) * tmpvar_38);
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_53));
  waterColor_7.xyz = tmpvar_54;
  finalRGBA_1.w = tmpvar_38;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (_ReflectColor, tmpvar_45, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - tmpvar_47);
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (fresnel_2 * tmpvar_48);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_50;
  mediump float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_51 = tmpvar_52;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_54;
  tmpvar_54 = ((tmpvar_53.x * (1.0 - tmpvar_51)) * tmpvar_38);
  highp vec3 tmpvar_55;
  tmpvar_55 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_54));
  waterColor_7.xyz = tmpvar_55;
  finalRGBA_1.w = tmpvar_38;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (_ReflectColor, tmpvar_45, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - tmpvar_47);
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (fresnel_2 * tmpvar_48);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_50;
  mediump float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_51 = tmpvar_52;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_54;
  tmpvar_54 = ((tmpvar_53.x * (1.0 - tmpvar_51)) * tmpvar_38);
  highp vec3 tmpvar_55;
  tmpvar_55 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_54));
  waterColor_7.xyz = tmpvar_55;
  finalRGBA_1.w = tmpvar_38;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 uv_Foam_2;
  mediump vec2 largeWaveSpeedTilling_3;
  mediump vec2 largeWaveTilling_4;
  mediump vec2 smallWaveSpeedTilling_5;
  mediump vec2 smallWaveTilling_6;
  mediump vec4 curTime_7;
  mediump vec2 uv_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21.x = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_21.y = sqrt(dot (v_19.xyz, v_19.xyz));
  tmpvar_21.z = sqrt(dot (v_20.xyz, v_20.xyz));
  highp vec3 tmpvar_22;
  tmpvar_22 = (0.1 / tmpvar_21);
  highp vec2 tmpvar_23;
  tmpvar_23 = tmpvar_1.xy;
  uv_8 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (_Time * 0.1);
  curTime_7 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_22.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_26;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_22.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_28;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_29;
  tmpvar_29 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_22.xz);
  uv_Foam_2 = tmpvar_29;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  tmpvar_13 = normalize((_glesNormal * tmpvar_30));
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_16 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_16.zw;
  tmpvar_14.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_14.w = (1.0/(_FrontShoreTransparency));
  tmpvar_15.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_15.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_37)
      ) * (_FogIntensity * tmpvar_37))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_44;
    tmpvar_44 = (_FogEndDistance - _FogStartDistance);
    tmpvar_43 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_45;
    tmpvar_45 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_42) / max (0.1, tmpvar_44))
    , 0.0, 1.0))));
    fogColor_40.xyz = tmpvar_45;
    fogColor_40.w = tmpvar_43;
    tmpvar_34 = fogColor_40;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = tmpvar_13;
  xlv_TEXCOORD5 = o_31;
  xlv_TEXCOORD6 = tmpvar_14;
  xlv_TEXCOORD7 = tmpvar_15;
  xlv_COLOR1 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform sampler2D _ReflectionTex;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp vec4 _ReflectColor;
uniform highp vec4 _WaterColor;
uniform highp float _FrontRefractFade;
uniform highp float _FrontFresnelBias;
uniform highp float _FrontShoreFade;
uniform highp float _FrontRefractDistort;
uniform highp float _FrontReflectIntensity;
uniform highp float _FrontReflectDistort;
uniform sampler2D _ShoreFoam;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 finalRGBA_1;
  highp float fresnel_2;
  mediump vec4 reflUV_3;
  mediump vec4 ssrRefl_4;
  mediump vec3 reflectColor_5;
  mediump vec3 coff_6;
  mediump vec4 waterColor_7;
  mediump float mask_8;
  mediump vec3 refraColor_9;
  mediump vec4 distortScreenPos_10;
  mediump vec4 uvDistort_11;
  mediump vec3 normalLocal_12;
  mediump vec3 largeNormal_13;
  mediump vec3 smallNormal_14;
  mediump float refraDistort_15;
  mediump float distFade_16;
  mediump vec3 worldViewDir_17;
  highp float len_18;
  mediump vec3 worldView_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_19 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = sqrt(dot (worldView_19, worldView_19));
  len_18 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (worldView_19 / len_18);
  worldViewDir_17 = tmpvar_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (((len_18 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  distFade_16 = (tmpvar_23 * tmpvar_23);
  distFade_16 = (distFade_16 * distFade_16);
  highp float tmpvar_25;
  tmpvar_25 = mix (_FrontRefractDistort, (_FrontRefractDistort * 0.25), distFade_16);
  refraDistort_15 = tmpvar_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_14 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_14 = (smallNormal_14 + tmpvar_27);
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_13 = tmpvar_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_13 = (largeNormal_13 + tmpvar_29);
  normalLocal_12.xz = (smallNormal_14 + largeNormal_13).xy;
  normalLocal_12.y = 1.0;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(normalLocal_12);
  normalLocal_12 = tmpvar_30;
  uvDistort_11.zw = vec2(0.0, 0.0);
  distortScreenPos_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_32;
  z_32 = tmpvar_31.x;
  uvDistort_11.xy = (tmpvar_30.xz * refraDistort_15);
  distortScreenPos_10 = (xlv_TEXCOORD5 + uvDistort_11);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_CustomDepthTexture, distortScreenPos_10);
  highp float z_34;
  z_34 = tmpvar_33.x;
  highp float tmpvar_35;
  tmpvar_35 = float(((1.0/(
    ((_ZBufferParams.z * z_34) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_8 = tmpvar_35;
  distortScreenPos_10 = (xlv_TEXCOORD5 + (uvDistort_11 * mask_8));
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_10);
  refraColor_9 = tmpvar_36.xyz;
  highp float tmpvar_37;
  tmpvar_37 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (pow ((
    clamp ((tmpvar_37 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _FrontShoreFade), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump float tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((tmpvar_37 * 0.05), 0.0, 1.0);
  tmpvar_40 = tmpvar_41;
  waterColor_7 = _WaterColor;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  waterColor_7.xyz = clamp ((waterColor_7.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_43;
  tmpvar_43 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_43);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 0.0;
  tmpvar_45.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_46;
  tmpvar_46 = mix (_ReflectColor, tmpvar_45, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - tmpvar_47);
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_48 * tmpvar_48);
  fresnel_2 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (fresnel_2 * tmpvar_48);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_50;
  tmpvar_50 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_50;
  mediump float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_51 = tmpvar_52;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_54;
  tmpvar_54 = ((tmpvar_53.x * (1.0 - tmpvar_51)) * tmpvar_38);
  highp vec3 tmpvar_55;
  tmpvar_55 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_54));
  waterColor_7.xyz = tmpvar_55;
  finalRGBA_1.w = tmpvar_38;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
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
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
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
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
}
}
 Pass {
  Name "BACK"
  LOD 200
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 74017
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  tmpvar_10.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_25));
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  highp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = _UWFogColorFar.xyz;
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.xyz = waterColor_8.xyz;
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  tmpvar_10.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_25));
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  highp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = _UWFogColorFar.xyz;
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.xyz = waterColor_8.xyz;
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  tmpvar_10.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_25));
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  highp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = _UWFogColorFar.xyz;
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.xyz = waterColor_8.xyz;
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_REFLECTION" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  tmpvar_10.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_25));
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2DProj (_ReflectionTex, reflUV_2);
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.xyz = waterColor_8.xyz;
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  tmpvar_10.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_25));
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2DProj (_ReflectionTex, reflUV_2);
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.xyz = waterColor_8.xyz;
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  tmpvar_10.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_25));
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2DProj (_ReflectionTex, reflUV_2);
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.xyz = waterColor_8.xyz;
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_30;
  fogParam_30.w = 0.0;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_32;
  tmpvar_32 = max (0.0, (sqrt(
    dot (tmpvar_31, tmpvar_31)
  ) - _BackFogStart));
  highp float tmpvar_33;
  tmpvar_33 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_32)
    ) * (_BackFogDensity * tmpvar_32))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_32))
   * 
    (_UWFogColorNFIntensity * tmpvar_32)
  )), 0.0, 1.0);
  fogParam_30.x = tmpvar_34;
  fogParam_30.y = (1.0 - tmpvar_33);
  fogParam_30.z = tmpvar_25.y;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_26));
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = fogParam_30.xyz;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  highp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = _UWFogColorFar.xyz;
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.w = 0.0;
  finalRGBA_1.xyz = waterColor_8.xyz;
  mediump vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = finalRGBA_1.xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_53, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_54;
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_30;
  fogParam_30.w = 0.0;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_32;
  tmpvar_32 = max (0.0, (sqrt(
    dot (tmpvar_31, tmpvar_31)
  ) - _BackFogStart));
  highp float tmpvar_33;
  tmpvar_33 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_32)
    ) * (_BackFogDensity * tmpvar_32))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_32))
   * 
    (_UWFogColorNFIntensity * tmpvar_32)
  )), 0.0, 1.0);
  fogParam_30.x = tmpvar_34;
  fogParam_30.y = (1.0 - tmpvar_33);
  fogParam_30.z = tmpvar_25.y;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_26));
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = fogParam_30.xyz;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  highp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = _UWFogColorFar.xyz;
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.w = 0.0;
  finalRGBA_1.xyz = waterColor_8.xyz;
  mediump vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = finalRGBA_1.xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_53, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_54;
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_30;
  fogParam_30.w = 0.0;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_32;
  tmpvar_32 = max (0.0, (sqrt(
    dot (tmpvar_31, tmpvar_31)
  ) - _BackFogStart));
  highp float tmpvar_33;
  tmpvar_33 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_32)
    ) * (_BackFogDensity * tmpvar_32))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_32))
   * 
    (_UWFogColorNFIntensity * tmpvar_32)
  )), 0.0, 1.0);
  fogParam_30.x = tmpvar_34;
  fogParam_30.y = (1.0 - tmpvar_33);
  fogParam_30.z = tmpvar_25.y;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_26));
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = fogParam_30.xyz;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  highp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = _UWFogColorFar.xyz;
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.w = 0.0;
  finalRGBA_1.xyz = waterColor_8.xyz;
  mediump vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = finalRGBA_1.xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_53, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_54;
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_30;
  fogParam_30.w = 0.0;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_32;
  tmpvar_32 = max (0.0, (sqrt(
    dot (tmpvar_31, tmpvar_31)
  ) - _BackFogStart));
  highp float tmpvar_33;
  tmpvar_33 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_32)
    ) * (_BackFogDensity * tmpvar_32))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_32))
   * 
    (_UWFogColorNFIntensity * tmpvar_32)
  )), 0.0, 1.0);
  fogParam_30.x = tmpvar_34;
  fogParam_30.y = (1.0 - tmpvar_33);
  fogParam_30.z = tmpvar_25.y;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_26));
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = fogParam_30.xyz;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2DProj (_ReflectionTex, reflUV_2);
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.w = 0.0;
  finalRGBA_1.xyz = waterColor_8.xyz;
  mediump vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = finalRGBA_1.xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_53, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_54;
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_30;
  fogParam_30.w = 0.0;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_32;
  tmpvar_32 = max (0.0, (sqrt(
    dot (tmpvar_31, tmpvar_31)
  ) - _BackFogStart));
  highp float tmpvar_33;
  tmpvar_33 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_32)
    ) * (_BackFogDensity * tmpvar_32))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_32))
   * 
    (_UWFogColorNFIntensity * tmpvar_32)
  )), 0.0, 1.0);
  fogParam_30.x = tmpvar_34;
  fogParam_30.y = (1.0 - tmpvar_33);
  fogParam_30.z = tmpvar_25.y;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_26));
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = fogParam_30.xyz;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2DProj (_ReflectionTex, reflUV_2);
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.w = 0.0;
  finalRGBA_1.xyz = waterColor_8.xyz;
  mediump vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = finalRGBA_1.xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_53, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_54;
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_30;
  fogParam_30.w = 0.0;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_32;
  tmpvar_32 = max (0.0, (sqrt(
    dot (tmpvar_31, tmpvar_31)
  ) - _BackFogStart));
  highp float tmpvar_33;
  tmpvar_33 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_32)
    ) * (_BackFogDensity * tmpvar_32))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_32))
   * 
    (_UWFogColorNFIntensity * tmpvar_32)
  )), 0.0, 1.0);
  fogParam_30.x = tmpvar_34;
  fogParam_30.y = (1.0 - tmpvar_33);
  fogParam_30.z = tmpvar_25.y;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_26));
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = fogParam_30.xyz;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying mediump vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2DProj (_ReflectionTex, reflUV_2);
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.w = 0.0;
  finalRGBA_1.xyz = waterColor_8.xyz;
  mediump vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = finalRGBA_1.xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_53, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_54;
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  tmpvar_10.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_25));
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  highp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = _UWFogColorFar.xyz;
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.xyz = mix (waterColor_8.xyz, vec3(dot (waterColor_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  tmpvar_10.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_25));
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  highp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = _UWFogColorFar.xyz;
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.xyz = mix (waterColor_8.xyz, vec3(dot (waterColor_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  tmpvar_10.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_25));
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _UWFogColorFar;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  highp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = _UWFogColorFar.xyz;
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.xyz = mix (waterColor_8.xyz, vec3(dot (waterColor_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  tmpvar_10.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_25));
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2DProj (_ReflectionTex, reflUV_2);
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.xyz = mix (waterColor_8.xyz, vec3(dot (waterColor_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  tmpvar_10.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_25));
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2DProj (_ReflectionTex, reflUV_2);
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.xyz = mix (waterColor_8.xyz, vec3(dot (waterColor_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  tmpvar_10.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = tmpvar_27.x;
  tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
  o_26.xy = (tmpvar_28 + tmpvar_27.w);
  o_26.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_25));
  xlv_TEXCOORD5 = o_26;
  xlv_TEXCOORD6 = tmpvar_11;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 finalRGBA_1;
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2DProj (_ReflectionTex, reflUV_2);
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.xyz = mix (waterColor_8.xyz, vec3(dot (waterColor_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_30;
  fogParam_30.w = 0.0;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_32;
  tmpvar_32 = max (0.0, (sqrt(
    dot (tmpvar_31, tmpvar_31)
  ) - _BackFogStart));
  highp float tmpvar_33;
  tmpvar_33 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_32)
    ) * (_BackFogDensity * tmpvar_32))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_32))
   * 
    (_UWFogColorNFIntensity * tmpvar_32)
  )), 0.0, 1.0);
  fogParam_30.x = tmpvar_34;
  fogParam_30.y = (1.0 - tmpvar_33);
  fogParam_30.z = tmpvar_25.y;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_26));
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = fogParam_30.xyz;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
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
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  highp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = _UWFogColorFar.xyz;
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.w = 0.0;
  finalRGBA_1.xyz = waterColor_8.xyz;
  mediump vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = finalRGBA_1.xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_53, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_54;
  finalRGBA_1.w = tmpvar_39;
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_30;
  fogParam_30.w = 0.0;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_32;
  tmpvar_32 = max (0.0, (sqrt(
    dot (tmpvar_31, tmpvar_31)
  ) - _BackFogStart));
  highp float tmpvar_33;
  tmpvar_33 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_32)
    ) * (_BackFogDensity * tmpvar_32))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_32))
   * 
    (_UWFogColorNFIntensity * tmpvar_32)
  )), 0.0, 1.0);
  fogParam_30.x = tmpvar_34;
  fogParam_30.y = (1.0 - tmpvar_33);
  fogParam_30.z = tmpvar_25.y;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_26));
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = fogParam_30.xyz;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
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
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  highp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = _UWFogColorFar.xyz;
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.w = 0.0;
  finalRGBA_1.xyz = waterColor_8.xyz;
  mediump vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = finalRGBA_1.xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_53, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_54;
  finalRGBA_1.w = tmpvar_39;
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_30;
  fogParam_30.w = 0.0;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_32;
  tmpvar_32 = max (0.0, (sqrt(
    dot (tmpvar_31, tmpvar_31)
  ) - _BackFogStart));
  highp float tmpvar_33;
  tmpvar_33 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_32)
    ) * (_BackFogDensity * tmpvar_32))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_32))
   * 
    (_UWFogColorNFIntensity * tmpvar_32)
  )), 0.0, 1.0);
  fogParam_30.x = tmpvar_34;
  fogParam_30.y = (1.0 - tmpvar_33);
  fogParam_30.z = tmpvar_25.y;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_26));
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = fogParam_30.xyz;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
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
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  highp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = _UWFogColorFar.xyz;
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.w = 0.0;
  finalRGBA_1.xyz = waterColor_8.xyz;
  mediump vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = finalRGBA_1.xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_53, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_54;
  finalRGBA_1.w = tmpvar_39;
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_30;
  fogParam_30.w = 0.0;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_32;
  tmpvar_32 = max (0.0, (sqrt(
    dot (tmpvar_31, tmpvar_31)
  ) - _BackFogStart));
  highp float tmpvar_33;
  tmpvar_33 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_32)
    ) * (_BackFogDensity * tmpvar_32))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_32))
   * 
    (_UWFogColorNFIntensity * tmpvar_32)
  )), 0.0, 1.0);
  fogParam_30.x = tmpvar_34;
  fogParam_30.y = (1.0 - tmpvar_33);
  fogParam_30.z = tmpvar_25.y;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_26));
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = fogParam_30.xyz;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
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
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2DProj (_ReflectionTex, reflUV_2);
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.w = 0.0;
  finalRGBA_1.xyz = waterColor_8.xyz;
  mediump vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = finalRGBA_1.xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_53, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_54;
  finalRGBA_1.w = tmpvar_39;
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_30;
  fogParam_30.w = 0.0;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_32;
  tmpvar_32 = max (0.0, (sqrt(
    dot (tmpvar_31, tmpvar_31)
  ) - _BackFogStart));
  highp float tmpvar_33;
  tmpvar_33 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_32)
    ) * (_BackFogDensity * tmpvar_32))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_32))
   * 
    (_UWFogColorNFIntensity * tmpvar_32)
  )), 0.0, 1.0);
  fogParam_30.x = tmpvar_34;
  fogParam_30.y = (1.0 - tmpvar_33);
  fogParam_30.z = tmpvar_25.y;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_26));
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = fogParam_30.xyz;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
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
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2DProj (_ReflectionTex, reflUV_2);
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.w = 0.0;
  finalRGBA_1.xyz = waterColor_8.xyz;
  mediump vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = finalRGBA_1.xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_53, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_54;
  finalRGBA_1.w = tmpvar_39;
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  mediump vec2 largeWaveSpeedTilling_2;
  mediump vec2 largeWaveTilling_3;
  mediump vec2 smallWaveSpeedTilling_4;
  mediump vec2 smallWaveTilling_5;
  mediump vec4 curTime_6;
  mediump vec2 uv_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].x;
  v_14.y = unity_WorldToObject[1].x;
  v_14.z = unity_WorldToObject[2].x;
  v_14.w = unity_WorldToObject[3].x;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].y;
  v_15.y = unity_WorldToObject[1].y;
  v_15.z = unity_WorldToObject[2].y;
  v_15.w = unity_WorldToObject[3].y;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].z;
  v_16.y = unity_WorldToObject[1].z;
  v_16.z = unity_WorldToObject[2].z;
  v_16.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_17;
  tmpvar_17.x = sqrt(dot (v_14.xyz, v_14.xyz));
  tmpvar_17.y = sqrt(dot (v_15.xyz, v_15.xyz));
  tmpvar_17.z = sqrt(dot (v_16.xyz, v_16.xyz));
  highp vec3 tmpvar_18;
  tmpvar_18 = (0.1 / tmpvar_17);
  highp vec2 tmpvar_19;
  tmpvar_19 = tmpvar_1.xy;
  uv_7 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_Time * 0.1);
  curTime_6 = tmpvar_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = (tmpvar_18.xz * _SmallWavesParams.xy);
  smallWaveTilling_5 = tmpvar_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = (_SmallWavesParams.zw * curTime_6.y);
  smallWaveSpeedTilling_4 = tmpvar_22;
  tmpvar_8.xy = ((uv_7 * smallWaveTilling_5) + smallWaveSpeedTilling_4);
  tmpvar_8.zw = (((uv_7 * smallWaveTilling_5) * 2.0) + (smallWaveSpeedTilling_4 * 1.5));
  highp vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_18.xz * _LargeWavesParams.xy);
  largeWaveTilling_3 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (_LargeWavesParams.zw * curTime_6.y);
  largeWaveSpeedTilling_2 = tmpvar_24;
  tmpvar_9.xy = ((uv_7 * largeWaveTilling_3) + largeWaveSpeedTilling_2);
  tmpvar_9.zw = (((uv_7 * largeWaveTilling_3) * 2.0) + (largeWaveSpeedTilling_2 * 1.5));
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10.xyz = tmpvar_25.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_28.x;
  tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
  o_27.xy = (tmpvar_29 + tmpvar_28.w);
  o_27.zw = tmpvar_12.zw;
  tmpvar_11.xyz = (1.0/((_RefractColor.xyz * (10.0 / _BackDensity))));
  tmpvar_11.w = (1.0/(_BackShoreTransparency));
  tmpvar_10.w = (1.0/(_UV_Mix_Range));
  mediump vec4 fogParam_30;
  fogParam_30.w = 0.0;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_25.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_32;
  tmpvar_32 = max (0.0, (sqrt(
    dot (tmpvar_31, tmpvar_31)
  ) - _BackFogStart));
  highp float tmpvar_33;
  tmpvar_33 = min (max ((
    (1.0 - exp((-(
      (_BackFogDensity * tmpvar_32)
    ) * (_BackFogDensity * tmpvar_32))))
   * _BackFogEffectLimit), _BackFogEffectStart), _BackFogEffectLimit);
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_32))
   * 
    (_UWFogColorNFIntensity * tmpvar_32)
  )), 0.0, 1.0);
  fogParam_30.x = tmpvar_34;
  fogParam_30.y = (1.0 - tmpvar_33);
  fogParam_30.z = tmpvar_25.y;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_26));
  xlv_TEXCOORD5 = o_27;
  xlv_TEXCOORD6 = tmpvar_11;
  xlv_TEXCOORD7 = fogParam_30.xyz;
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
uniform highp float _UV_Mix_Start_Distance;
uniform sampler2D _SmallWavesTexture;
uniform sampler2D _LargeWavesTexture;
uniform highp float _BackRefractFade;
uniform highp float _BackFresnelBias;
uniform highp float _BackShoreFade;
uniform highp float _BackRefractDistort;
uniform highp float _BackReflectIntensity;
uniform highp float _BackReflectDistort;
uniform highp float _BackCriticalAngle;
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
  mediump vec4 reflUV_2;
  mediump vec4 ssrRefl_3;
  mediump vec3 reflectColor_4;
  mediump vec3 coff_5;
  highp float fresnel_6;
  mediump float testAngle_7;
  mediump vec4 waterColor_8;
  mediump float mask_9;
  mediump vec3 refraColor_10;
  mediump vec4 distortScreenPos_11;
  mediump vec4 uvDistort_12;
  mediump vec3 normalLocal_13;
  mediump vec3 largeNormal_14;
  mediump vec3 smallNormal_15;
  mediump float refraDistort_16;
  mediump float distFade_17;
  mediump vec3 worldViewDir_18;
  highp float len_19;
  mediump vec3 worldView_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz);
  worldView_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = sqrt(dot (worldView_20, worldView_20));
  len_19 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (worldView_20 / len_19);
  worldViewDir_18 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((len_19 - _UV_Mix_Start_Distance) * xlv_TEXCOORD3.w), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  distFade_17 = (tmpvar_24 * tmpvar_24);
  distFade_17 = (distFade_17 * distFade_17);
  highp float tmpvar_26;
  tmpvar_26 = mix (_BackRefractDistort, (_BackRefractDistort * 0.25), distFade_17);
  refraDistort_16 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0);
  smallNormal_15 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((texture2D (_SmallWavesTexture, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
  smallNormal_15 = (smallNormal_15 + tmpvar_28);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.xy).xyz * 2.0) - 1.0);
  largeNormal_14 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((texture2D (_LargeWavesTexture, xlv_TEXCOORD2.zw).xyz * 2.0) - 1.0);
  largeNormal_14 = (largeNormal_14 + tmpvar_30);
  normalLocal_13.xz = (-(smallNormal_15) - largeNormal_14).xy;
  normalLocal_13.y = 1.0;
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(normalLocal_13);
  normalLocal_13 = tmpvar_31;
  uvDistort_12.zw = vec2(0.0, 0.0);
  distortScreenPos_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_33;
  z_33 = tmpvar_32.x;
  uvDistort_12.xy = (tmpvar_31.xz * refraDistort_16);
  distortScreenPos_11 = (xlv_TEXCOORD5 + uvDistort_12);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_CustomDepthTexture, distortScreenPos_11);
  highp float z_35;
  z_35 = tmpvar_34.x;
  highp float tmpvar_36;
  tmpvar_36 = float(((1.0/(
    ((_ZBufferParams.z * z_35) + _ZBufferParams.w)
  )) >= xlv_TEXCOORD5.z));
  mask_9 = tmpvar_36;
  distortScreenPos_11 = (xlv_TEXCOORD5 + (uvDistort_12 * mask_9));
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_BeforeAlphaTexture, distortScreenPos_11);
  refraColor_10 = tmpvar_37.xyz;
  highp float tmpvar_38;
  tmpvar_38 = ((1.0/((
    (_ZBufferParams.z * z_33)
   + _ZBufferParams.w))) - xlv_TEXCOORD5.z);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (pow ((
    clamp ((tmpvar_38 * xlv_TEXCOORD6.w), 0.0, 1.0)
   + 0.0001), _BackShoreFade), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((tmpvar_38 * 0.05), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  waterColor_8.w = 0.0;
  mediump float tmpvar_43;
  tmpvar_43 = dot (worldViewDir_18, vec3(0.0, -1.0, 0.0));
  testAngle_7 = (((
    (1.570796 - (sign(tmpvar_43) * (1.570796 - (
      sqrt((1.0 - abs(tmpvar_43)))
     * 
      (1.570796 + (abs(tmpvar_43) * (-0.2146018 + (
        abs(tmpvar_43)
       * 
        (0.08656672 + (abs(tmpvar_43) * -0.03102955))
      ))))
    ))))
   / 3.14159) * 180.0) + ((uvDistort_12.x + uvDistort_12.y) * 500.0));
  mediump float tmpvar_44;
  tmpvar_44 = clamp (dot (worldViewDir_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - tmpvar_44);
  highp float tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_45);
  fresnel_6 = (tmpvar_46 * tmpvar_46);
  fresnel_6 = (fresnel_6 * tmpvar_45);
  fresnel_6 = (_BackFresnelBias + ((1.0 - _BackFresnelBias) * fresnel_6));
  highp vec3 tmpvar_47;
  tmpvar_47 = (fresnel_6 * pow ((
    clamp ((1.0 + ((
      -(tmpvar_38)
     * 0.5) * xlv_TEXCOORD6.xyz)), 0.0, 1.0)
   + 0.0001), vec3(_BackRefractFade)));
  coff_5 = tmpvar_47;
  waterColor_8.xyz = _UWFogColorFar.xyz;
  if ((testAngle_7 < _BackCriticalAngle)) {
    highp vec3 tmpvar_48;
    tmpvar_48 = clamp ((_UWFogColorFar.xyz + (refraColor_10 * coff_5)), 0.0, 1.0);
    waterColor_8.xyz = tmpvar_48;
  };
  reflUV_2 = xlv_TEXCOORD5;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((tmpvar_31.xz * _BackReflectDistort) * (
    (reflUV_2.w * tmpvar_41)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_2.xy = (reflUV_2.xy + tmpvar_49);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2DProj (_ReflectionTex, reflUV_2);
  ssrRefl_3 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_UWFogColorFar.xyz, ssrRefl_3.xyz, vec3((1.0 - clamp (
    (len_19 * 0.005)
  , 0.0, 1.0))));
  reflectColor_4 = tmpvar_51;
  if ((testAngle_7 > _BackCriticalAngle)) {
    highp vec3 tmpvar_52;
    tmpvar_52 = mix (waterColor_8.xyz, reflectColor_4, vec3(((_BackReflectIntensity * fresnel_6) * tmpvar_41)));
    waterColor_8.xyz = tmpvar_52;
  };
  finalRGBA_1.w = 0.0;
  finalRGBA_1.xyz = waterColor_8.xyz;
  mediump vec4 tmpvar_53;
  tmpvar_53.w = 0.0;
  tmpvar_53.xyz = finalRGBA_1.xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD7.xxxx), tmpvar_53, xlv_TEXCOORD7.yyyy).xyz;
  finalRGBA_1.xyz = tmpvar_54;
  finalRGBA_1.w = tmpvar_39;
  finalRGBA_1.xyz = mix (finalRGBA_1.xyz, vec3(dot (finalRGBA_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_39, 0.0, 1.0);
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
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
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
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
}
}
}
Fallback "Diffuse"
}