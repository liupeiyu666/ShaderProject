//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/River AQUS Front Clip" {
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
_ClipRadius ("Water Plane Clip Radius", Range(0, 100)) = 20
[Toggle(SPECIAL_STATE)] _SpecialState ("Special State", Float) = 0
_SPTex ("SP Tex", 2D) = "white" { }
_SPNoiseTex ("SP Noise Tex", 2D) = "white" { }
_SPNoiseScaler ("SP Noise Scaler", Range(0, 10)) = 1
_SPIntensity ("SP Intensity", Range(0, 1)) = 0.5
_SPTransition ("SP Transition", Range(0, 10)) = 0
_SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
_SPOpaqueness ("SP Opaqueness", Range(0, 1)) = 1
_SPOutlineColor ("SP Outline Color", Color) = (1,1,1,1)
_SPTransitionEmissionScaler ("SP Transition Emission Scaler", Range(1, 100)) = 1
_SPTransitionBloomFactor ("SP Transition Bloom Factor", Float) = 1
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FRONT"
  LOD 200
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 3762
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
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
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = tmpvar_59.xyz;
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
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
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = tmpvar_59.xyz;
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
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
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = tmpvar_59.xyz;
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = tmpvar_59.xyz;
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = tmpvar_59.xyz;
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = tmpvar_59.xyz;
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = tmpvar_59.xyz;
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = tmpvar_59.xyz;
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = tmpvar_59.xyz;
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = tmpvar_59.xyz;
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = tmpvar_59.xyz;
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = tmpvar_59.xyz;
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, vec3(dot (waterColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, vec3(dot (waterColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, vec3(dot (waterColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, vec3(dot (waterColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, vec3(dot (waterColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, vec3(dot (waterColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, vec3(dot (waterColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, vec3(dot (waterColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, vec3(dot (waterColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, vec3(dot (waterColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, vec3(dot (waterColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
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
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = mix (waterColor_7.xyz, vec3(dot (waterColor_7.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_38, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
uniform mediump float _LumiFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = mix (tmpvar_59.xyz, vec3(dot (tmpvar_59.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
uniform mediump float _LumiFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = mix (tmpvar_59.xyz, vec3(dot (tmpvar_59.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
uniform mediump float _LumiFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = mix (tmpvar_59.xyz, vec3(dot (tmpvar_59.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
uniform mediump float _LumiFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = mix (tmpvar_59.xyz, vec3(dot (tmpvar_59.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
uniform mediump float _LumiFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = mix (tmpvar_59.xyz, vec3(dot (tmpvar_59.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
uniform mediump float _LumiFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = mix (tmpvar_59.xyz, vec3(dot (tmpvar_59.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_UNDERWATER_FOG" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
uniform mediump float _LumiFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = mix (tmpvar_59.xyz, vec3(dot (tmpvar_59.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_UNDERWATER_FOG" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
uniform mediump float _LumiFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = mix (tmpvar_59.xyz, vec3(dot (tmpvar_59.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_UNDERWATER_FOG" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
uniform mediump float _LumiFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = _ReflectColor.xyz;
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = mix (tmpvar_59.xyz, vec3(dot (tmpvar_59.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
uniform mediump float _LumiFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = mix (tmpvar_59.xyz, vec3(dot (tmpvar_59.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
uniform mediump float _LumiFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = mix (tmpvar_59.xyz, vec3(dot (tmpvar_59.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
  gl_FragData[0] = finalRGBA_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
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
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
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
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9.xy = tmpvar_1.xy;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20.x = sqrt(dot (v_17.xyz, v_17.xyz));
  tmpvar_20.y = sqrt(dot (v_18.xyz, v_18.xyz));
  tmpvar_20.z = sqrt(dot (v_19.xyz, v_19.xyz));
  highp vec3 tmpvar_21;
  tmpvar_21 = (0.1 / tmpvar_20);
  highp vec2 tmpvar_22;
  tmpvar_22 = tmpvar_1.xy;
  uv_8 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (_Time * 0.1);
  curTime_7 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_21.xz * _SmallWavesParams.xy);
  smallWaveTilling_6 = tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (_SmallWavesParams.zw * curTime_7.y);
  smallWaveSpeedTilling_5 = tmpvar_25;
  tmpvar_10.xy = ((uv_8 * smallWaveTilling_6) + smallWaveSpeedTilling_5);
  tmpvar_10.zw = (((uv_8 * smallWaveTilling_6) * 2.0) + (smallWaveSpeedTilling_5 * 1.5));
  highp vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_21.xz * _LargeWavesParams.xy);
  largeWaveTilling_4 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27 = (_LargeWavesParams.zw * curTime_7.y);
  largeWaveSpeedTilling_3 = tmpvar_27;
  tmpvar_11.xy = ((uv_8 * largeWaveTilling_4) + largeWaveSpeedTilling_3);
  tmpvar_11.zw = (((uv_8 * largeWaveTilling_4) * 2.0) + (largeWaveSpeedTilling_3 * 1.5));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_8 * _ShoreFoamParams.xy) * tmpvar_21.xz);
  uv_Foam_2 = tmpvar_28;
  uv_Foam_2 = (uv_Foam_2 + (_ShoreFoamParams.zw * curTime_7.y));
  tmpvar_9.zw = uv_Foam_2;
  tmpvar_12.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_29;
  tmpvar_29[0] = unity_WorldToObject[0].xyz;
  tmpvar_29[1] = unity_WorldToObject[1].xyz;
  tmpvar_29[2] = unity_WorldToObject[2].xyz;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_15.zw;
  tmpvar_13.xyz = (1.0/((_RefractColor.xyz * (10.0 / _FrontDensity))));
  tmpvar_13.w = (1.0/(_FrontShoreTransparency));
  tmpvar_14.xyz = (_ShoreFoamColor * _ShoreFoamColorStrength).xyz;
  tmpvar_14.w = (1.0/(_ShoreFoamDepth));
  tmpvar_12.w = (1.0/(_UV_Mix_Range));
  highp vec4 spuvs_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (_glesVertex * 0.5);
  spuvs_33.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_35;
  tmpvar_35.x = (tmpvar_34.x + (tmpvar_34.z * tmpvar_34.z));
  tmpvar_35.y = ((tmpvar_34.y + (0.5 * tmpvar_34.z)) + ((0.5 * tmpvar_34.x) * tmpvar_34.x));
  spuvs_33.zw = ((tmpvar_35 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = normalize((_glesNormal * tmpvar_29));
  xlv_TEXCOORD5 = o_30;
  xlv_TEXCOORD6 = tmpvar_13;
  xlv_TEXCOORD7 = tmpvar_14;
  xlv_TEXCOORD8 = spuvs_33;
  xlv_TEXCOORD9 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform sampler2D _CustomDepthTexture;
uniform sampler2D _RefractionTex;
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
uniform highp float _ClipRadius;
uniform mediump float _LumiFactor;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
varying highp vec4 xlv_TEXCOORD8;
varying highp vec3 xlv_TEXCOORD9;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
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
  tmpvar_36 = texture2DProj (_RefractionTex, distortScreenPos_10);
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
  waterColor_7.w = _WaterColor.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = pow ((clamp (
    (1.0 + ((-(tmpvar_37) * 0.5) * xlv_TEXCOORD6.xyz))
  , 0.0, 1.0) + 0.0001), vec3(_FrontRefractFade));
  coff_6 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp ((_WaterColor.xyz + (refraColor_9 * coff_6)), 0.0, 1.0);
  waterColor_7.xyz = tmpvar_43;
  reflUV_3 = xlv_TEXCOORD5;
  highp vec2 tmpvar_44;
  tmpvar_44 = (((tmpvar_30.xz * _FrontReflectDistort) * (
    (reflUV_3.w * tmpvar_40)
   * 0.5)) * (vec2(1.0, 1.0) - vec2(clamp (
    ((_ProjectionParams.w * xlv_TEXCOORD5.z) * 50.0)
  , 0.0, 1.0))));
  reflUV_3.xy = (reflUV_3.xy + tmpvar_44);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DProj (_ReflectionTex, reflUV_3);
  ssrRefl_4 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 0.0;
  tmpvar_46.xyz = ssrRefl_4.xyz;
  highp vec3 tmpvar_47;
  tmpvar_47 = mix (_ReflectColor, tmpvar_46, vec4((1.0 - clamp (
    (len_18 * 0.005)
  , 0.0, 1.0)))).xyz;
  reflectColor_5 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = clamp (dot (worldViewDir_17, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - tmpvar_48);
  highp float tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_49);
  fresnel_2 = (tmpvar_50 * tmpvar_50);
  fresnel_2 = (fresnel_2 * tmpvar_49);
  fresnel_2 = (_FrontFresnelBias + ((1.0 - _FrontFresnelBias) * fresnel_2));
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (waterColor_7.xyz, reflectColor_5, vec3(((_FrontReflectIntensity * fresnel_2) * tmpvar_40)));
  waterColor_7.xyz = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((tmpvar_37 * xlv_TEXCOORD7.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_ShoreFoam, xlv_TEXCOORD0.zw);
  mediump float tmpvar_55;
  tmpvar_55 = ((tmpvar_54.x * (1.0 - tmpvar_52)) * tmpvar_38);
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (waterColor_7.xyz, xlv_TEXCOORD7.xyz, vec3(tmpvar_55));
  waterColor_7.xyz = tmpvar_56;
  finalRGBA_1.xyz = waterColor_7.xyz;
  finalRGBA_1.w = tmpvar_38;
  mediump vec2 worldXZ_57;
  worldXZ_57 = (xlv_TEXCOORD3.xz - xlv_TEXCOORD9.xz);
  mediump float maxRadius_58;
  maxRadius_58 = _ClipRadius;
  mediump vec4 tmpvar_59;
  mediump vec4 spColor_60;
  mediump float spnoise_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_SPNoiseTex, xlv_TEXCOORD8.zw);
  highp float tmpvar_63;
  tmpvar_63 = (tmpvar_62.x * _SPNoiseScaler);
  spnoise_61 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = sqrt(dot (worldXZ_57, worldXZ_57));
  if (((tmpvar_64 + spnoise_61) > (maxRadius_58 * _SPTransition))) {
    tmpvar_59 = finalRGBA_1;
  } else {
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_SPTex, xlv_TEXCOORD8.xy);
    spColor_60 = tmpvar_65;
    spColor_60.w = (spColor_60.w * _SPOpaqueness);
    mediump float tmpvar_66;
    tmpvar_66 = ((1.99 * spnoise_61) - 1.0);
    xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
    if ((tmpvar_66 >= (1.7 * xlat_mutable_SPTransition))) {
      xlat_mutable_SPIntensity = 0.0;
    } else {
      if ((tmpvar_66 >= (1.5 * xlat_mutable_SPTransition))) {
        highp vec3 tmpvar_67;
        tmpvar_67 = mix (spColor_60.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
          (-(tmpvar_66) + (1.7 * xlat_mutable_SPTransition))
        ), 0.0, 1.0)));
        spColor_60.xyz = tmpvar_67;
      };
    };
    highp vec4 tmpvar_68;
    tmpvar_68 = mix (finalRGBA_1, spColor_60, vec4(xlat_mutable_SPIntensity));
    spColor_60 = tmpvar_68;
    tmpvar_59 = spColor_60;
  };
  finalRGBA_1.xyz = mix (tmpvar_59.xyz, vec3(dot (tmpvar_59.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_1.w = clamp (tmpvar_59.w, 0.0, 1.0);
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
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
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
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "_USE_REFLECTION" "_UNDERWATER_FOG" }
""
}
}
}
}
Fallback "Diffuse"
}