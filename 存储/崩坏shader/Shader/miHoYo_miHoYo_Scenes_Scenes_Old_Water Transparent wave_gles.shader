//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Water Transparent wave" {
Properties {
_RefColor ("Reflection Color", Color) = (1,1,1,1)
_ReflectionTex ("Reflection", 2D) = "white" { }
_WaterColor ("Water Color (used when disable realtime reflection)", Color) = (0,0,0,0)
_NormalMap ("Normal Map", 2D) = "white" { }
_CausticMap ("Caustic Map", 2D) = "white" { }
_Distortion ("Distortion", Float) = 1
_BumpVelocity0 ("Bump Velocity 0", Vector) = (0,0,0,0)
_BumpScale0 ("Bump Scale 0", Float) = 1
_BumpVelocity1 ("Bump Velocity 1", Vector) = (0,0,0,0)
_BumpScale1 ("Bump Scale 1", Float) = 1
_CausticVelocity ("Caustic Velocity", Vector) = (0,0,0,0)
_CausticScale ("Caustic Scale", Float) = 1
_CausticFresnelFactors ("Caustic Fresnel Factors", Vector) = (1,1,0,0)
_RefractionColor ("Fraction Color", Color) = (1,1,1,1)
_ReflectionFresnelFactors ("Reflection Fresnel Factors", Vector) = (1,1,0,0)
_WaveTex ("WaveTex", 2D) = "black" { }
_WaveTexMask ("WaveTex", 2D) = "black" { }
_WaveSpeed ("WaveSpeed", Float) = -12.64
_WaveRange ("WaveRange", Float) = 0.3
_NoiseRange ("NoiseRange", Float) = 6.43
_WaveDelta ("WaveDelta", Float) = 2.43
_WaveZ ("WaveZ", Float) = 0.37
_WaveColorScale ("WaveColorScale", Float) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 56736
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase.xyz + (h_29 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_31 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  tmpvar_20 = tmpvar_23;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase.xyz + (h_29 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_31 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  tmpvar_20 = tmpvar_23;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase.xyz + (h_29 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_31 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  tmpvar_20 = tmpvar_23;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase2.xyz + (h_29 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_31 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams2.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams2.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase2.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor2.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  highp vec4 tmpvar_57;
  mediump float fogFactor_58;
  mediump vec3 fogColor_59;
  mediump vec3 heightFogColor_60;
  highp float HeightFogFactor_61;
  mediump vec3 atomesphereFogColor_62;
  mediump float h_63;
  highp float linearFogDensity_64;
  mediump float len_65;
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((len_65 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_64 = (tmpvar_67 * (2.0 - tmpvar_67));
  if ((len_65 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_64 = (linearFogDensity_64 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_68;
  tmpvar_68 = min (pow (linearFogDensity_64, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_64 = tmpvar_68;
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_21.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  h_63 = (tmpvar_69 * (2.0 - tmpvar_69));
  highp vec3 tmpvar_71;
  tmpvar_71 = (_HeigtFogColBase3.xyz + (h_63 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_62 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = mix (atomesphereFogColor_62, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_65 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_62 = tmpvar_72;
  mediump float tmpvar_73;
  mediump float r_74;
  mediump float f_75;
  mediump float u_76;
  mediump float l_77;
  mediump float fogInt_78;
  fogInt_78 = 1.0;
  highp float tmpvar_79;
  tmpvar_79 = (_HeigtFogParams3.x * tmpvar_22.y);
  highp float tmpvar_80;
  tmpvar_80 = abs(tmpvar_79);
  if ((tmpvar_80 > 0.01)) {
    highp float tmpvar_81;
    tmpvar_81 = exp(-(tmpvar_79));
    fogInt_78 = ((1.0 - tmpvar_81) / tmpvar_79);
  };
  highp float tmpvar_82;
  tmpvar_82 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_77 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = (l_77 * _HeigtFogParams3.y);
  u_76 = tmpvar_83;
  fogInt_78 = (fogInt_78 * u_76);
  mediump float tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = clamp (((l_77 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_84 = tmpvar_85;
  r_74 = (tmpvar_84 * (2.0 - tmpvar_84));
  r_74 = ((r_74 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_75 = ((1.0 - clamp (
    exp2(-(fogInt_78))
  , 0.0, 1.0)) * r_74);
  highp float tmpvar_86;
  tmpvar_86 = min (f_75, _HeigtFogColBase3.w);
  tmpvar_73 = tmpvar_86;
  HeightFogFactor_61 = tmpvar_73;
  highp vec3 tmpvar_87;
  tmpvar_87 = _Mihoyo_FogColor3.xyz;
  heightFogColor_60 = tmpvar_87;
  highp vec3 tmpvar_88;
  tmpvar_88 = ((heightFogColor_60 * HeightFogFactor_61) + ((atomesphereFogColor_62 * tmpvar_68) * (1.0 - HeightFogFactor_61)));
  fogColor_59 = tmpvar_88;
  highp float tmpvar_89;
  tmpvar_89 = ((1.0 - tmpvar_68) * (1.0 - HeightFogFactor_61));
  fogFactor_58 = tmpvar_89;
  mediump vec4 tmpvar_90;
  tmpvar_90.xyz = fogColor_59;
  tmpvar_90.w = fogFactor_58;
  tmpvar_57 = tmpvar_90;
  highp vec4 tmpvar_91;
  tmpvar_91 = mix (tmpvar_23, tmpvar_57, vec4(_LerpFactor));
  tmpvar_20 = tmpvar_91;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase2.xyz + (h_29 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_31 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams2.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams2.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase2.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor2.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  highp vec4 tmpvar_57;
  mediump float fogFactor_58;
  mediump vec3 fogColor_59;
  mediump vec3 heightFogColor_60;
  highp float HeightFogFactor_61;
  mediump vec3 atomesphereFogColor_62;
  mediump float h_63;
  highp float linearFogDensity_64;
  mediump float len_65;
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((len_65 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_64 = (tmpvar_67 * (2.0 - tmpvar_67));
  if ((len_65 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_64 = (linearFogDensity_64 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_68;
  tmpvar_68 = min (pow (linearFogDensity_64, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_64 = tmpvar_68;
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_21.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  h_63 = (tmpvar_69 * (2.0 - tmpvar_69));
  highp vec3 tmpvar_71;
  tmpvar_71 = (_HeigtFogColBase3.xyz + (h_63 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_62 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = mix (atomesphereFogColor_62, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_65 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_62 = tmpvar_72;
  mediump float tmpvar_73;
  mediump float r_74;
  mediump float f_75;
  mediump float u_76;
  mediump float l_77;
  mediump float fogInt_78;
  fogInt_78 = 1.0;
  highp float tmpvar_79;
  tmpvar_79 = (_HeigtFogParams3.x * tmpvar_22.y);
  highp float tmpvar_80;
  tmpvar_80 = abs(tmpvar_79);
  if ((tmpvar_80 > 0.01)) {
    highp float tmpvar_81;
    tmpvar_81 = exp(-(tmpvar_79));
    fogInt_78 = ((1.0 - tmpvar_81) / tmpvar_79);
  };
  highp float tmpvar_82;
  tmpvar_82 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_77 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = (l_77 * _HeigtFogParams3.y);
  u_76 = tmpvar_83;
  fogInt_78 = (fogInt_78 * u_76);
  mediump float tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = clamp (((l_77 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_84 = tmpvar_85;
  r_74 = (tmpvar_84 * (2.0 - tmpvar_84));
  r_74 = ((r_74 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_75 = ((1.0 - clamp (
    exp2(-(fogInt_78))
  , 0.0, 1.0)) * r_74);
  highp float tmpvar_86;
  tmpvar_86 = min (f_75, _HeigtFogColBase3.w);
  tmpvar_73 = tmpvar_86;
  HeightFogFactor_61 = tmpvar_73;
  highp vec3 tmpvar_87;
  tmpvar_87 = _Mihoyo_FogColor3.xyz;
  heightFogColor_60 = tmpvar_87;
  highp vec3 tmpvar_88;
  tmpvar_88 = ((heightFogColor_60 * HeightFogFactor_61) + ((atomesphereFogColor_62 * tmpvar_68) * (1.0 - HeightFogFactor_61)));
  fogColor_59 = tmpvar_88;
  highp float tmpvar_89;
  tmpvar_89 = ((1.0 - tmpvar_68) * (1.0 - HeightFogFactor_61));
  fogFactor_58 = tmpvar_89;
  mediump vec4 tmpvar_90;
  tmpvar_90.xyz = fogColor_59;
  tmpvar_90.w = fogFactor_58;
  tmpvar_57 = tmpvar_90;
  highp vec4 tmpvar_91;
  tmpvar_91 = mix (tmpvar_23, tmpvar_57, vec4(_LerpFactor));
  tmpvar_20 = tmpvar_91;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase2.xyz + (h_29 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_31 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams2.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams2.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase2.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor2.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  highp vec4 tmpvar_57;
  mediump float fogFactor_58;
  mediump vec3 fogColor_59;
  mediump vec3 heightFogColor_60;
  highp float HeightFogFactor_61;
  mediump vec3 atomesphereFogColor_62;
  mediump float h_63;
  highp float linearFogDensity_64;
  mediump float len_65;
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((len_65 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_64 = (tmpvar_67 * (2.0 - tmpvar_67));
  if ((len_65 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_64 = (linearFogDensity_64 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_68;
  tmpvar_68 = min (pow (linearFogDensity_64, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_64 = tmpvar_68;
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_21.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  h_63 = (tmpvar_69 * (2.0 - tmpvar_69));
  highp vec3 tmpvar_71;
  tmpvar_71 = (_HeigtFogColBase3.xyz + (h_63 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_62 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = mix (atomesphereFogColor_62, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_65 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_62 = tmpvar_72;
  mediump float tmpvar_73;
  mediump float r_74;
  mediump float f_75;
  mediump float u_76;
  mediump float l_77;
  mediump float fogInt_78;
  fogInt_78 = 1.0;
  highp float tmpvar_79;
  tmpvar_79 = (_HeigtFogParams3.x * tmpvar_22.y);
  highp float tmpvar_80;
  tmpvar_80 = abs(tmpvar_79);
  if ((tmpvar_80 > 0.01)) {
    highp float tmpvar_81;
    tmpvar_81 = exp(-(tmpvar_79));
    fogInt_78 = ((1.0 - tmpvar_81) / tmpvar_79);
  };
  highp float tmpvar_82;
  tmpvar_82 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_77 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = (l_77 * _HeigtFogParams3.y);
  u_76 = tmpvar_83;
  fogInt_78 = (fogInt_78 * u_76);
  mediump float tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = clamp (((l_77 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_84 = tmpvar_85;
  r_74 = (tmpvar_84 * (2.0 - tmpvar_84));
  r_74 = ((r_74 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_75 = ((1.0 - clamp (
    exp2(-(fogInt_78))
  , 0.0, 1.0)) * r_74);
  highp float tmpvar_86;
  tmpvar_86 = min (f_75, _HeigtFogColBase3.w);
  tmpvar_73 = tmpvar_86;
  HeightFogFactor_61 = tmpvar_73;
  highp vec3 tmpvar_87;
  tmpvar_87 = _Mihoyo_FogColor3.xyz;
  heightFogColor_60 = tmpvar_87;
  highp vec3 tmpvar_88;
  tmpvar_88 = ((heightFogColor_60 * HeightFogFactor_61) + ((atomesphereFogColor_62 * tmpvar_68) * (1.0 - HeightFogFactor_61)));
  fogColor_59 = tmpvar_88;
  highp float tmpvar_89;
  tmpvar_89 = ((1.0 - tmpvar_68) * (1.0 - HeightFogFactor_61));
  fogFactor_58 = tmpvar_89;
  mediump vec4 tmpvar_90;
  tmpvar_90.xyz = fogColor_59;
  tmpvar_90.w = fogFactor_58;
  tmpvar_57 = tmpvar_90;
  highp vec4 tmpvar_91;
  tmpvar_91 = mix (tmpvar_23, tmpvar_57, vec4(_LerpFactor));
  tmpvar_20 = tmpvar_91;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase.xyz + (h_29 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_31 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  tmpvar_20 = tmpvar_23;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase.xyz + (h_29 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_31 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  tmpvar_20 = tmpvar_23;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase.xyz + (h_29 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_31 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  tmpvar_20 = tmpvar_23;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase2.xyz + (h_29 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_31 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams2.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams2.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase2.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor2.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  highp vec4 tmpvar_57;
  mediump float fogFactor_58;
  mediump vec3 fogColor_59;
  mediump vec3 heightFogColor_60;
  highp float HeightFogFactor_61;
  mediump vec3 atomesphereFogColor_62;
  mediump float h_63;
  highp float linearFogDensity_64;
  mediump float len_65;
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((len_65 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_64 = (tmpvar_67 * (2.0 - tmpvar_67));
  if ((len_65 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_64 = (linearFogDensity_64 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_68;
  tmpvar_68 = min (pow (linearFogDensity_64, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_64 = tmpvar_68;
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_21.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  h_63 = (tmpvar_69 * (2.0 - tmpvar_69));
  highp vec3 tmpvar_71;
  tmpvar_71 = (_HeigtFogColBase3.xyz + (h_63 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_62 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = mix (atomesphereFogColor_62, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_65 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_62 = tmpvar_72;
  mediump float tmpvar_73;
  mediump float r_74;
  mediump float f_75;
  mediump float u_76;
  mediump float l_77;
  mediump float fogInt_78;
  fogInt_78 = 1.0;
  highp float tmpvar_79;
  tmpvar_79 = (_HeigtFogParams3.x * tmpvar_22.y);
  highp float tmpvar_80;
  tmpvar_80 = abs(tmpvar_79);
  if ((tmpvar_80 > 0.01)) {
    highp float tmpvar_81;
    tmpvar_81 = exp(-(tmpvar_79));
    fogInt_78 = ((1.0 - tmpvar_81) / tmpvar_79);
  };
  highp float tmpvar_82;
  tmpvar_82 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_77 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = (l_77 * _HeigtFogParams3.y);
  u_76 = tmpvar_83;
  fogInt_78 = (fogInt_78 * u_76);
  mediump float tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = clamp (((l_77 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_84 = tmpvar_85;
  r_74 = (tmpvar_84 * (2.0 - tmpvar_84));
  r_74 = ((r_74 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_75 = ((1.0 - clamp (
    exp2(-(fogInt_78))
  , 0.0, 1.0)) * r_74);
  highp float tmpvar_86;
  tmpvar_86 = min (f_75, _HeigtFogColBase3.w);
  tmpvar_73 = tmpvar_86;
  HeightFogFactor_61 = tmpvar_73;
  highp vec3 tmpvar_87;
  tmpvar_87 = _Mihoyo_FogColor3.xyz;
  heightFogColor_60 = tmpvar_87;
  highp vec3 tmpvar_88;
  tmpvar_88 = ((heightFogColor_60 * HeightFogFactor_61) + ((atomesphereFogColor_62 * tmpvar_68) * (1.0 - HeightFogFactor_61)));
  fogColor_59 = tmpvar_88;
  highp float tmpvar_89;
  tmpvar_89 = ((1.0 - tmpvar_68) * (1.0 - HeightFogFactor_61));
  fogFactor_58 = tmpvar_89;
  mediump vec4 tmpvar_90;
  tmpvar_90.xyz = fogColor_59;
  tmpvar_90.w = fogFactor_58;
  tmpvar_57 = tmpvar_90;
  highp vec4 tmpvar_91;
  tmpvar_91 = mix (tmpvar_23, tmpvar_57, vec4(_LerpFactor));
  tmpvar_20 = tmpvar_91;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase2.xyz + (h_29 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_31 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams2.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams2.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase2.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor2.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  highp vec4 tmpvar_57;
  mediump float fogFactor_58;
  mediump vec3 fogColor_59;
  mediump vec3 heightFogColor_60;
  highp float HeightFogFactor_61;
  mediump vec3 atomesphereFogColor_62;
  mediump float h_63;
  highp float linearFogDensity_64;
  mediump float len_65;
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((len_65 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_64 = (tmpvar_67 * (2.0 - tmpvar_67));
  if ((len_65 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_64 = (linearFogDensity_64 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_68;
  tmpvar_68 = min (pow (linearFogDensity_64, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_64 = tmpvar_68;
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_21.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  h_63 = (tmpvar_69 * (2.0 - tmpvar_69));
  highp vec3 tmpvar_71;
  tmpvar_71 = (_HeigtFogColBase3.xyz + (h_63 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_62 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = mix (atomesphereFogColor_62, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_65 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_62 = tmpvar_72;
  mediump float tmpvar_73;
  mediump float r_74;
  mediump float f_75;
  mediump float u_76;
  mediump float l_77;
  mediump float fogInt_78;
  fogInt_78 = 1.0;
  highp float tmpvar_79;
  tmpvar_79 = (_HeigtFogParams3.x * tmpvar_22.y);
  highp float tmpvar_80;
  tmpvar_80 = abs(tmpvar_79);
  if ((tmpvar_80 > 0.01)) {
    highp float tmpvar_81;
    tmpvar_81 = exp(-(tmpvar_79));
    fogInt_78 = ((1.0 - tmpvar_81) / tmpvar_79);
  };
  highp float tmpvar_82;
  tmpvar_82 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_77 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = (l_77 * _HeigtFogParams3.y);
  u_76 = tmpvar_83;
  fogInt_78 = (fogInt_78 * u_76);
  mediump float tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = clamp (((l_77 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_84 = tmpvar_85;
  r_74 = (tmpvar_84 * (2.0 - tmpvar_84));
  r_74 = ((r_74 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_75 = ((1.0 - clamp (
    exp2(-(fogInt_78))
  , 0.0, 1.0)) * r_74);
  highp float tmpvar_86;
  tmpvar_86 = min (f_75, _HeigtFogColBase3.w);
  tmpvar_73 = tmpvar_86;
  HeightFogFactor_61 = tmpvar_73;
  highp vec3 tmpvar_87;
  tmpvar_87 = _Mihoyo_FogColor3.xyz;
  heightFogColor_60 = tmpvar_87;
  highp vec3 tmpvar_88;
  tmpvar_88 = ((heightFogColor_60 * HeightFogFactor_61) + ((atomesphereFogColor_62 * tmpvar_68) * (1.0 - HeightFogFactor_61)));
  fogColor_59 = tmpvar_88;
  highp float tmpvar_89;
  tmpvar_89 = ((1.0 - tmpvar_68) * (1.0 - HeightFogFactor_61));
  fogFactor_58 = tmpvar_89;
  mediump vec4 tmpvar_90;
  tmpvar_90.xyz = fogColor_59;
  tmpvar_90.w = fogFactor_58;
  tmpvar_57 = tmpvar_90;
  highp vec4 tmpvar_91;
  tmpvar_91 = mix (tmpvar_23, tmpvar_57, vec4(_LerpFactor));
  tmpvar_20 = tmpvar_91;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase2.xyz + (h_29 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_31 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams2.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams2.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase2.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor2.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  highp vec4 tmpvar_57;
  mediump float fogFactor_58;
  mediump vec3 fogColor_59;
  mediump vec3 heightFogColor_60;
  highp float HeightFogFactor_61;
  mediump vec3 atomesphereFogColor_62;
  mediump float h_63;
  highp float linearFogDensity_64;
  mediump float len_65;
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((len_65 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_64 = (tmpvar_67 * (2.0 - tmpvar_67));
  if ((len_65 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_64 = (linearFogDensity_64 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_68;
  tmpvar_68 = min (pow (linearFogDensity_64, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_64 = tmpvar_68;
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_21.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  h_63 = (tmpvar_69 * (2.0 - tmpvar_69));
  highp vec3 tmpvar_71;
  tmpvar_71 = (_HeigtFogColBase3.xyz + (h_63 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_62 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = mix (atomesphereFogColor_62, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_65 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_62 = tmpvar_72;
  mediump float tmpvar_73;
  mediump float r_74;
  mediump float f_75;
  mediump float u_76;
  mediump float l_77;
  mediump float fogInt_78;
  fogInt_78 = 1.0;
  highp float tmpvar_79;
  tmpvar_79 = (_HeigtFogParams3.x * tmpvar_22.y);
  highp float tmpvar_80;
  tmpvar_80 = abs(tmpvar_79);
  if ((tmpvar_80 > 0.01)) {
    highp float tmpvar_81;
    tmpvar_81 = exp(-(tmpvar_79));
    fogInt_78 = ((1.0 - tmpvar_81) / tmpvar_79);
  };
  highp float tmpvar_82;
  tmpvar_82 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_77 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = (l_77 * _HeigtFogParams3.y);
  u_76 = tmpvar_83;
  fogInt_78 = (fogInt_78 * u_76);
  mediump float tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = clamp (((l_77 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_84 = tmpvar_85;
  r_74 = (tmpvar_84 * (2.0 - tmpvar_84));
  r_74 = ((r_74 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_75 = ((1.0 - clamp (
    exp2(-(fogInt_78))
  , 0.0, 1.0)) * r_74);
  highp float tmpvar_86;
  tmpvar_86 = min (f_75, _HeigtFogColBase3.w);
  tmpvar_73 = tmpvar_86;
  HeightFogFactor_61 = tmpvar_73;
  highp vec3 tmpvar_87;
  tmpvar_87 = _Mihoyo_FogColor3.xyz;
  heightFogColor_60 = tmpvar_87;
  highp vec3 tmpvar_88;
  tmpvar_88 = ((heightFogColor_60 * HeightFogFactor_61) + ((atomesphereFogColor_62 * tmpvar_68) * (1.0 - HeightFogFactor_61)));
  fogColor_59 = tmpvar_88;
  highp float tmpvar_89;
  tmpvar_89 = ((1.0 - tmpvar_68) * (1.0 - HeightFogFactor_61));
  fogFactor_58 = tmpvar_89;
  mediump vec4 tmpvar_90;
  tmpvar_90.xyz = fogColor_59;
  tmpvar_90.w = fogFactor_58;
  tmpvar_57 = tmpvar_90;
  highp vec4 tmpvar_91;
  tmpvar_91 = mix (tmpvar_23, tmpvar_57, vec4(_LerpFactor));
  tmpvar_20 = tmpvar_91;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase.xyz + (h_29 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_31 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  tmpvar_20 = tmpvar_23;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase.xyz + (h_29 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_31 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  tmpvar_20 = tmpvar_23;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase.xyz + (h_29 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_31 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  tmpvar_20 = tmpvar_23;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase2.xyz + (h_29 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_31 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams2.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams2.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase2.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor2.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  highp vec4 tmpvar_57;
  mediump float fogFactor_58;
  mediump vec3 fogColor_59;
  mediump vec3 heightFogColor_60;
  highp float HeightFogFactor_61;
  mediump vec3 atomesphereFogColor_62;
  mediump float h_63;
  highp float linearFogDensity_64;
  mediump float len_65;
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((len_65 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_64 = (tmpvar_67 * (2.0 - tmpvar_67));
  if ((len_65 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_64 = (linearFogDensity_64 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_68;
  tmpvar_68 = min (pow (linearFogDensity_64, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_64 = tmpvar_68;
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_21.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  h_63 = (tmpvar_69 * (2.0 - tmpvar_69));
  highp vec3 tmpvar_71;
  tmpvar_71 = (_HeigtFogColBase3.xyz + (h_63 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_62 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = mix (atomesphereFogColor_62, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_65 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_62 = tmpvar_72;
  mediump float tmpvar_73;
  mediump float r_74;
  mediump float f_75;
  mediump float u_76;
  mediump float l_77;
  mediump float fogInt_78;
  fogInt_78 = 1.0;
  highp float tmpvar_79;
  tmpvar_79 = (_HeigtFogParams3.x * tmpvar_22.y);
  highp float tmpvar_80;
  tmpvar_80 = abs(tmpvar_79);
  if ((tmpvar_80 > 0.01)) {
    highp float tmpvar_81;
    tmpvar_81 = exp(-(tmpvar_79));
    fogInt_78 = ((1.0 - tmpvar_81) / tmpvar_79);
  };
  highp float tmpvar_82;
  tmpvar_82 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_77 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = (l_77 * _HeigtFogParams3.y);
  u_76 = tmpvar_83;
  fogInt_78 = (fogInt_78 * u_76);
  mediump float tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = clamp (((l_77 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_84 = tmpvar_85;
  r_74 = (tmpvar_84 * (2.0 - tmpvar_84));
  r_74 = ((r_74 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_75 = ((1.0 - clamp (
    exp2(-(fogInt_78))
  , 0.0, 1.0)) * r_74);
  highp float tmpvar_86;
  tmpvar_86 = min (f_75, _HeigtFogColBase3.w);
  tmpvar_73 = tmpvar_86;
  HeightFogFactor_61 = tmpvar_73;
  highp vec3 tmpvar_87;
  tmpvar_87 = _Mihoyo_FogColor3.xyz;
  heightFogColor_60 = tmpvar_87;
  highp vec3 tmpvar_88;
  tmpvar_88 = ((heightFogColor_60 * HeightFogFactor_61) + ((atomesphereFogColor_62 * tmpvar_68) * (1.0 - HeightFogFactor_61)));
  fogColor_59 = tmpvar_88;
  highp float tmpvar_89;
  tmpvar_89 = ((1.0 - tmpvar_68) * (1.0 - HeightFogFactor_61));
  fogFactor_58 = tmpvar_89;
  mediump vec4 tmpvar_90;
  tmpvar_90.xyz = fogColor_59;
  tmpvar_90.w = fogFactor_58;
  tmpvar_57 = tmpvar_90;
  highp vec4 tmpvar_91;
  tmpvar_91 = mix (tmpvar_23, tmpvar_57, vec4(_LerpFactor));
  tmpvar_20 = tmpvar_91;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase2.xyz + (h_29 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_31 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams2.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams2.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase2.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor2.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  highp vec4 tmpvar_57;
  mediump float fogFactor_58;
  mediump vec3 fogColor_59;
  mediump vec3 heightFogColor_60;
  highp float HeightFogFactor_61;
  mediump vec3 atomesphereFogColor_62;
  mediump float h_63;
  highp float linearFogDensity_64;
  mediump float len_65;
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((len_65 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_64 = (tmpvar_67 * (2.0 - tmpvar_67));
  if ((len_65 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_64 = (linearFogDensity_64 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_68;
  tmpvar_68 = min (pow (linearFogDensity_64, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_64 = tmpvar_68;
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_21.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  h_63 = (tmpvar_69 * (2.0 - tmpvar_69));
  highp vec3 tmpvar_71;
  tmpvar_71 = (_HeigtFogColBase3.xyz + (h_63 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_62 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = mix (atomesphereFogColor_62, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_65 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_62 = tmpvar_72;
  mediump float tmpvar_73;
  mediump float r_74;
  mediump float f_75;
  mediump float u_76;
  mediump float l_77;
  mediump float fogInt_78;
  fogInt_78 = 1.0;
  highp float tmpvar_79;
  tmpvar_79 = (_HeigtFogParams3.x * tmpvar_22.y);
  highp float tmpvar_80;
  tmpvar_80 = abs(tmpvar_79);
  if ((tmpvar_80 > 0.01)) {
    highp float tmpvar_81;
    tmpvar_81 = exp(-(tmpvar_79));
    fogInt_78 = ((1.0 - tmpvar_81) / tmpvar_79);
  };
  highp float tmpvar_82;
  tmpvar_82 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_77 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = (l_77 * _HeigtFogParams3.y);
  u_76 = tmpvar_83;
  fogInt_78 = (fogInt_78 * u_76);
  mediump float tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = clamp (((l_77 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_84 = tmpvar_85;
  r_74 = (tmpvar_84 * (2.0 - tmpvar_84));
  r_74 = ((r_74 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_75 = ((1.0 - clamp (
    exp2(-(fogInt_78))
  , 0.0, 1.0)) * r_74);
  highp float tmpvar_86;
  tmpvar_86 = min (f_75, _HeigtFogColBase3.w);
  tmpvar_73 = tmpvar_86;
  HeightFogFactor_61 = tmpvar_73;
  highp vec3 tmpvar_87;
  tmpvar_87 = _Mihoyo_FogColor3.xyz;
  heightFogColor_60 = tmpvar_87;
  highp vec3 tmpvar_88;
  tmpvar_88 = ((heightFogColor_60 * HeightFogFactor_61) + ((atomesphereFogColor_62 * tmpvar_68) * (1.0 - HeightFogFactor_61)));
  fogColor_59 = tmpvar_88;
  highp float tmpvar_89;
  tmpvar_89 = ((1.0 - tmpvar_68) * (1.0 - HeightFogFactor_61));
  fogFactor_58 = tmpvar_89;
  mediump vec4 tmpvar_90;
  tmpvar_90.xyz = fogColor_59;
  tmpvar_90.w = fogFactor_58;
  tmpvar_57 = tmpvar_90;
  highp vec4 tmpvar_91;
  tmpvar_91 = mix (tmpvar_23, tmpvar_57, vec4(_LerpFactor));
  tmpvar_20 = tmpvar_91;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase2.xyz + (h_29 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_31 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams2.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams2.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase2.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor2.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  highp vec4 tmpvar_57;
  mediump float fogFactor_58;
  mediump vec3 fogColor_59;
  mediump vec3 heightFogColor_60;
  highp float HeightFogFactor_61;
  mediump vec3 atomesphereFogColor_62;
  mediump float h_63;
  highp float linearFogDensity_64;
  mediump float len_65;
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((len_65 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_64 = (tmpvar_67 * (2.0 - tmpvar_67));
  if ((len_65 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_64 = (linearFogDensity_64 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_68;
  tmpvar_68 = min (pow (linearFogDensity_64, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_64 = tmpvar_68;
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_21.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  h_63 = (tmpvar_69 * (2.0 - tmpvar_69));
  highp vec3 tmpvar_71;
  tmpvar_71 = (_HeigtFogColBase3.xyz + (h_63 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_62 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = mix (atomesphereFogColor_62, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_65 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_62 = tmpvar_72;
  mediump float tmpvar_73;
  mediump float r_74;
  mediump float f_75;
  mediump float u_76;
  mediump float l_77;
  mediump float fogInt_78;
  fogInt_78 = 1.0;
  highp float tmpvar_79;
  tmpvar_79 = (_HeigtFogParams3.x * tmpvar_22.y);
  highp float tmpvar_80;
  tmpvar_80 = abs(tmpvar_79);
  if ((tmpvar_80 > 0.01)) {
    highp float tmpvar_81;
    tmpvar_81 = exp(-(tmpvar_79));
    fogInt_78 = ((1.0 - tmpvar_81) / tmpvar_79);
  };
  highp float tmpvar_82;
  tmpvar_82 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_77 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = (l_77 * _HeigtFogParams3.y);
  u_76 = tmpvar_83;
  fogInt_78 = (fogInt_78 * u_76);
  mediump float tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = clamp (((l_77 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_84 = tmpvar_85;
  r_74 = (tmpvar_84 * (2.0 - tmpvar_84));
  r_74 = ((r_74 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_75 = ((1.0 - clamp (
    exp2(-(fogInt_78))
  , 0.0, 1.0)) * r_74);
  highp float tmpvar_86;
  tmpvar_86 = min (f_75, _HeigtFogColBase3.w);
  tmpvar_73 = tmpvar_86;
  HeightFogFactor_61 = tmpvar_73;
  highp vec3 tmpvar_87;
  tmpvar_87 = _Mihoyo_FogColor3.xyz;
  heightFogColor_60 = tmpvar_87;
  highp vec3 tmpvar_88;
  tmpvar_88 = ((heightFogColor_60 * HeightFogFactor_61) + ((atomesphereFogColor_62 * tmpvar_68) * (1.0 - HeightFogFactor_61)));
  fogColor_59 = tmpvar_88;
  highp float tmpvar_89;
  tmpvar_89 = ((1.0 - tmpvar_68) * (1.0 - HeightFogFactor_61));
  fogFactor_58 = tmpvar_89;
  mediump vec4 tmpvar_90;
  tmpvar_90.xyz = fogColor_59;
  tmpvar_90.w = fogFactor_58;
  tmpvar_57 = tmpvar_90;
  highp vec4 tmpvar_91;
  tmpvar_91 = mix (tmpvar_23, tmpvar_57, vec4(_LerpFactor));
  tmpvar_20 = tmpvar_91;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec2 texoffset_5;
  mediump vec3 accNormal_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_6 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((accNormal_6.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_5 = tmpvar_8;
  outcolor_4.w = _RefractionColor.w;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD2 - (texoffset_5 * 5.0));
  tmpvar_9 = texture2D (_CausticMap, P_10);
  outcolor_4.xyz = (_RefractionColor.xyz + (tmpvar_9.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  highp float tmpvar_14;
  tmpvar_14 = (_Time.x * _WaveSpeed);
  tmpvar_13.x = ((1.0 - (tmpvar_12 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_14 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_WaveTex, tmpvar_13);
  waveColor_2 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sin((tmpvar_14 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_16 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_WaveTex, tmpvar_18);
  waveColor2_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = sin(((tmpvar_14 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_20 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_5.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_5.w = tmpvar_18;
  tmpvar_5.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_23;
    tmpvar_23 = max (0.0, (sqrt(
      dot (tmpvar_22, tmpvar_22)
    ) - _FogStartDistance));
    highp float tmpvar_24;
    tmpvar_24 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_23)
      ) * (_FogIntensity * tmpvar_23))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_23)) * (_FogColorIntensity * tmpvar_23))
    ), 0.0, 1.0)));
    fogColor_21.xyz = tmpvar_25;
    fogColor_21.w = tmpvar_24;
    tmpvar_20 = fogColor_21;
  } else {
    mediump vec4 fogColor_26;
    highp vec3 tmpvar_27;
    tmpvar_27 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_28;
    tmpvar_28 = max (0.0, (sqrt(
      dot (tmpvar_27, tmpvar_27)
    ) - _FogStartDistance));
    highp float tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = (_FogEndDistance - _FogStartDistance);
    tmpvar_29 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_28) / max (0.1, tmpvar_30))
    , 0.0, 1.0))));
    fogColor_26.xyz = tmpvar_31;
    fogColor_26.w = tmpvar_29;
    tmpvar_20 = fogColor_26;
  };
  tmpvar_5.z = tmpvar_1.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase.xyz + (h_29 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_31 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  tmpvar_20 = tmpvar_23;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase.xyz + (h_29 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_31 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  tmpvar_20 = tmpvar_23;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase.xyz + (h_29 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_31 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  tmpvar_20 = tmpvar_23;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase2.xyz + (h_29 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_31 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams2.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams2.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase2.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor2.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  highp vec4 tmpvar_57;
  mediump float fogFactor_58;
  mediump vec3 fogColor_59;
  mediump vec3 heightFogColor_60;
  highp float HeightFogFactor_61;
  mediump vec3 atomesphereFogColor_62;
  mediump float h_63;
  highp float linearFogDensity_64;
  mediump float len_65;
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((len_65 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_64 = (tmpvar_67 * (2.0 - tmpvar_67));
  if ((len_65 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_64 = (linearFogDensity_64 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_68;
  tmpvar_68 = min (pow (linearFogDensity_64, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_64 = tmpvar_68;
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_21.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  h_63 = (tmpvar_69 * (2.0 - tmpvar_69));
  highp vec3 tmpvar_71;
  tmpvar_71 = (_HeigtFogColBase3.xyz + (h_63 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_62 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = mix (atomesphereFogColor_62, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_65 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_62 = tmpvar_72;
  mediump float tmpvar_73;
  mediump float r_74;
  mediump float f_75;
  mediump float u_76;
  mediump float l_77;
  mediump float fogInt_78;
  fogInt_78 = 1.0;
  highp float tmpvar_79;
  tmpvar_79 = (_HeigtFogParams3.x * tmpvar_22.y);
  highp float tmpvar_80;
  tmpvar_80 = abs(tmpvar_79);
  if ((tmpvar_80 > 0.01)) {
    highp float tmpvar_81;
    tmpvar_81 = exp(-(tmpvar_79));
    fogInt_78 = ((1.0 - tmpvar_81) / tmpvar_79);
  };
  highp float tmpvar_82;
  tmpvar_82 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_77 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = (l_77 * _HeigtFogParams3.y);
  u_76 = tmpvar_83;
  fogInt_78 = (fogInt_78 * u_76);
  mediump float tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = clamp (((l_77 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_84 = tmpvar_85;
  r_74 = (tmpvar_84 * (2.0 - tmpvar_84));
  r_74 = ((r_74 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_75 = ((1.0 - clamp (
    exp2(-(fogInt_78))
  , 0.0, 1.0)) * r_74);
  highp float tmpvar_86;
  tmpvar_86 = min (f_75, _HeigtFogColBase3.w);
  tmpvar_73 = tmpvar_86;
  HeightFogFactor_61 = tmpvar_73;
  highp vec3 tmpvar_87;
  tmpvar_87 = _Mihoyo_FogColor3.xyz;
  heightFogColor_60 = tmpvar_87;
  highp vec3 tmpvar_88;
  tmpvar_88 = ((heightFogColor_60 * HeightFogFactor_61) + ((atomesphereFogColor_62 * tmpvar_68) * (1.0 - HeightFogFactor_61)));
  fogColor_59 = tmpvar_88;
  highp float tmpvar_89;
  tmpvar_89 = ((1.0 - tmpvar_68) * (1.0 - HeightFogFactor_61));
  fogFactor_58 = tmpvar_89;
  mediump vec4 tmpvar_90;
  tmpvar_90.xyz = fogColor_59;
  tmpvar_90.w = fogFactor_58;
  tmpvar_57 = tmpvar_90;
  highp vec4 tmpvar_91;
  tmpvar_91 = mix (tmpvar_23, tmpvar_57, vec4(_LerpFactor));
  tmpvar_20 = tmpvar_91;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase2.xyz + (h_29 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_31 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams2.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams2.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase2.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor2.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  highp vec4 tmpvar_57;
  mediump float fogFactor_58;
  mediump vec3 fogColor_59;
  mediump vec3 heightFogColor_60;
  highp float HeightFogFactor_61;
  mediump vec3 atomesphereFogColor_62;
  mediump float h_63;
  highp float linearFogDensity_64;
  mediump float len_65;
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((len_65 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_64 = (tmpvar_67 * (2.0 - tmpvar_67));
  if ((len_65 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_64 = (linearFogDensity_64 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_68;
  tmpvar_68 = min (pow (linearFogDensity_64, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_64 = tmpvar_68;
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_21.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  h_63 = (tmpvar_69 * (2.0 - tmpvar_69));
  highp vec3 tmpvar_71;
  tmpvar_71 = (_HeigtFogColBase3.xyz + (h_63 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_62 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = mix (atomesphereFogColor_62, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_65 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_62 = tmpvar_72;
  mediump float tmpvar_73;
  mediump float r_74;
  mediump float f_75;
  mediump float u_76;
  mediump float l_77;
  mediump float fogInt_78;
  fogInt_78 = 1.0;
  highp float tmpvar_79;
  tmpvar_79 = (_HeigtFogParams3.x * tmpvar_22.y);
  highp float tmpvar_80;
  tmpvar_80 = abs(tmpvar_79);
  if ((tmpvar_80 > 0.01)) {
    highp float tmpvar_81;
    tmpvar_81 = exp(-(tmpvar_79));
    fogInt_78 = ((1.0 - tmpvar_81) / tmpvar_79);
  };
  highp float tmpvar_82;
  tmpvar_82 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_77 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = (l_77 * _HeigtFogParams3.y);
  u_76 = tmpvar_83;
  fogInt_78 = (fogInt_78 * u_76);
  mediump float tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = clamp (((l_77 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_84 = tmpvar_85;
  r_74 = (tmpvar_84 * (2.0 - tmpvar_84));
  r_74 = ((r_74 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_75 = ((1.0 - clamp (
    exp2(-(fogInt_78))
  , 0.0, 1.0)) * r_74);
  highp float tmpvar_86;
  tmpvar_86 = min (f_75, _HeigtFogColBase3.w);
  tmpvar_73 = tmpvar_86;
  HeightFogFactor_61 = tmpvar_73;
  highp vec3 tmpvar_87;
  tmpvar_87 = _Mihoyo_FogColor3.xyz;
  heightFogColor_60 = tmpvar_87;
  highp vec3 tmpvar_88;
  tmpvar_88 = ((heightFogColor_60 * HeightFogFactor_61) + ((atomesphereFogColor_62 * tmpvar_68) * (1.0 - HeightFogFactor_61)));
  fogColor_59 = tmpvar_88;
  highp float tmpvar_89;
  tmpvar_89 = ((1.0 - tmpvar_68) * (1.0 - HeightFogFactor_61));
  fogFactor_58 = tmpvar_89;
  mediump vec4 tmpvar_90;
  tmpvar_90.xyz = fogColor_59;
  tmpvar_90.w = fogFactor_58;
  tmpvar_57 = tmpvar_90;
  highp vec4 tmpvar_91;
  tmpvar_91 = mix (tmpvar_23, tmpvar_57, vec4(_LerpFactor));
  tmpvar_20 = tmpvar_91;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform mediump vec4 _ReflectionFresnelFactors;
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
uniform mediump vec2 _CausticVelocity;
uniform mediump float _CausticScale;
uniform mediump vec4 _CausticFresnelFactors;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _CausticScale) + (_CausticVelocity * _Time.y));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec3 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  tmpvar_12 = ((unity_WorldToObject * tmpvar_13).xyz - _glesVertex.xyz);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_12);
  mediump float tmpvar_15;
  mediump vec3 I_16;
  I_16 = tmpvar_14;
  tmpvar_15 = (_ReflectionFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_16.y), 0.001, 1.0), _ReflectionFresnelFactors.x)
   * _ReflectionFresnelFactors.y)));
  tmpvar_6.x = tmpvar_15;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_12);
  mediump float tmpvar_18;
  mediump vec3 I_19;
  I_19 = tmpvar_17;
  tmpvar_18 = (_CausticFresnelFactors.z + max (0.0, (
    pow (clamp ((1.0 - I_19.y), 0.001, 1.0), _CausticFresnelFactors.x)
   * _CausticFresnelFactors.y)));
  tmpvar_6.w = tmpvar_18;
  tmpvar_6.y = pow (sqrt(dot (tmpvar_12, tmpvar_12)), 0.5);
  mediump vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_23;
  mediump float fogFactor_24;
  mediump vec3 fogColor_25;
  mediump vec3 heightFogColor_26;
  highp float HeightFogFactor_27;
  mediump vec3 atomesphereFogColor_28;
  mediump float h_29;
  highp float linearFogDensity_30;
  mediump float len_31;
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((len_31 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_30 = (tmpvar_33 * (2.0 - tmpvar_33));
  if ((len_31 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_30 = (linearFogDensity_30 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_34;
  tmpvar_34 = min (pow (linearFogDensity_30, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_30 = tmpvar_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((tmpvar_21.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  h_29 = (tmpvar_35 * (2.0 - tmpvar_35));
  highp vec3 tmpvar_37;
  tmpvar_37 = (_HeigtFogColBase2.xyz + (h_29 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_28 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (atomesphereFogColor_28, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_31 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_28 = tmpvar_38;
  mediump float tmpvar_39;
  mediump float r_40;
  mediump float f_41;
  mediump float u_42;
  mediump float l_43;
  mediump float fogInt_44;
  fogInt_44 = 1.0;
  highp float tmpvar_45;
  tmpvar_45 = (_HeigtFogParams2.x * tmpvar_22.y);
  highp float tmpvar_46;
  tmpvar_46 = abs(tmpvar_45);
  if ((tmpvar_46 > 0.01)) {
    highp float tmpvar_47;
    tmpvar_47 = exp(-(tmpvar_45));
    fogInt_44 = ((1.0 - tmpvar_47) / tmpvar_45);
  };
  highp float tmpvar_48;
  tmpvar_48 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_43 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (l_43 * _HeigtFogParams2.y);
  u_42 = tmpvar_49;
  fogInt_44 = (fogInt_44 * u_42);
  mediump float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((l_43 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_50 = tmpvar_51;
  r_40 = (tmpvar_50 * (2.0 - tmpvar_50));
  r_40 = ((r_40 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_41 = ((1.0 - clamp (
    exp2(-(fogInt_44))
  , 0.0, 1.0)) * r_40);
  highp float tmpvar_52;
  tmpvar_52 = min (f_41, _HeigtFogColBase2.w);
  tmpvar_39 = tmpvar_52;
  HeightFogFactor_27 = tmpvar_39;
  highp vec3 tmpvar_53;
  tmpvar_53 = _Mihoyo_FogColor2.xyz;
  heightFogColor_26 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = ((heightFogColor_26 * HeightFogFactor_27) + ((atomesphereFogColor_28 * tmpvar_34) * (1.0 - HeightFogFactor_27)));
  fogColor_25 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = ((1.0 - tmpvar_34) * (1.0 - HeightFogFactor_27));
  fogFactor_24 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56.xyz = fogColor_25;
  tmpvar_56.w = fogFactor_24;
  tmpvar_23 = tmpvar_56;
  highp vec4 tmpvar_57;
  mediump float fogFactor_58;
  mediump vec3 fogColor_59;
  mediump vec3 heightFogColor_60;
  highp float HeightFogFactor_61;
  mediump vec3 atomesphereFogColor_62;
  mediump float h_63;
  highp float linearFogDensity_64;
  mediump float len_65;
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_22, tmpvar_22));
  len_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((len_65 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_64 = (tmpvar_67 * (2.0 - tmpvar_67));
  if ((len_65 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_64 = (linearFogDensity_64 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_68;
  tmpvar_68 = min (pow (linearFogDensity_64, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_64 = tmpvar_68;
  mediump float tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_21.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  h_63 = (tmpvar_69 * (2.0 - tmpvar_69));
  highp vec3 tmpvar_71;
  tmpvar_71 = (_HeigtFogColBase3.xyz + (h_63 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_62 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = mix (atomesphereFogColor_62, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_65 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_62 = tmpvar_72;
  mediump float tmpvar_73;
  mediump float r_74;
  mediump float f_75;
  mediump float u_76;
  mediump float l_77;
  mediump float fogInt_78;
  fogInt_78 = 1.0;
  highp float tmpvar_79;
  tmpvar_79 = (_HeigtFogParams3.x * tmpvar_22.y);
  highp float tmpvar_80;
  tmpvar_80 = abs(tmpvar_79);
  if ((tmpvar_80 > 0.01)) {
    highp float tmpvar_81;
    tmpvar_81 = exp(-(tmpvar_79));
    fogInt_78 = ((1.0 - tmpvar_81) / tmpvar_79);
  };
  highp float tmpvar_82;
  tmpvar_82 = sqrt(dot (tmpvar_22, tmpvar_22));
  l_77 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = (l_77 * _HeigtFogParams3.y);
  u_76 = tmpvar_83;
  fogInt_78 = (fogInt_78 * u_76);
  mediump float tmpvar_84;
  highp float tmpvar_85;
  tmpvar_85 = clamp (((l_77 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_84 = tmpvar_85;
  r_74 = (tmpvar_84 * (2.0 - tmpvar_84));
  r_74 = ((r_74 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_75 = ((1.0 - clamp (
    exp2(-(fogInt_78))
  , 0.0, 1.0)) * r_74);
  highp float tmpvar_86;
  tmpvar_86 = min (f_75, _HeigtFogColBase3.w);
  tmpvar_73 = tmpvar_86;
  HeightFogFactor_61 = tmpvar_73;
  highp vec3 tmpvar_87;
  tmpvar_87 = _Mihoyo_FogColor3.xyz;
  heightFogColor_60 = tmpvar_87;
  highp vec3 tmpvar_88;
  tmpvar_88 = ((heightFogColor_60 * HeightFogFactor_61) + ((atomesphereFogColor_62 * tmpvar_68) * (1.0 - HeightFogFactor_61)));
  fogColor_59 = tmpvar_88;
  highp float tmpvar_89;
  tmpvar_89 = ((1.0 - tmpvar_68) * (1.0 - HeightFogFactor_61));
  fogFactor_58 = tmpvar_89;
  mediump vec4 tmpvar_90;
  tmpvar_90.xyz = fogColor_59;
  tmpvar_90.w = fogFactor_58;
  tmpvar_57 = tmpvar_90;
  highp vec4 tmpvar_91;
  tmpvar_91 = mix (tmpvar_23, tmpvar_57, vec4(_LerpFactor));
  tmpvar_20 = tmpvar_91;
  tmpvar_6.z = tmpvar_2.w;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_9;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_COLOR1 = tmpvar_20;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RefColor;
uniform sampler2D _ReflectionTex;
uniform mediump vec4 _RefractionColor;
uniform sampler2D _NormalMap;
uniform sampler2D _CausticMap;
uniform mediump float _Distortion;
uniform sampler2D _WaveTex;
uniform sampler2D _WaveTexMask;
uniform mediump float _WaveSpeed;
uniform mediump float _WaveDelta;
uniform mediump float _WaveRange;
uniform mediump float _NoiseRange;
uniform mediump float _WaveZ;
uniform mediump float _WaveColorScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 waveColor2_1;
  mediump vec4 waveColor_2;
  mediump vec3 waveTex_3;
  mediump vec4 outcolor_4;
  mediump vec4 reflectionColor_5;
  mediump vec2 texoffset_6;
  mediump vec3 accNormal_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((accNormal_7.xy * _Distortion) / xlv_TEXCOORD4.y);
  texoffset_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) - texoffset_6);
  tmpvar_10 = texture2D (_ReflectionTex, P_11);
  reflectionColor_5.xyz = (tmpvar_10 * _RefColor).xyz;
  reflectionColor_5.w = 1.0;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((xlv_TEXCOORD4.x * xlv_TEXCOORD4.z), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_RefractionColor, reflectionColor_5, vec4(tmpvar_12));
  outcolor_4.w = tmpvar_13.w;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD2 - (texoffset_6 * 5.0));
  tmpvar_14 = texture2D (_CausticMap, P_15);
  outcolor_4.xyz = (tmpvar_13.xyz + (tmpvar_14.xyz * xlv_TEXCOORD4.w));
  lowp vec3 tmpvar_16;
  tmpvar_16 = texture2D (_WaveTexMask, xlv_TEXCOORD5).xyz;
  waveTex_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  highp float tmpvar_19;
  tmpvar_19 = (_Time.x * _WaveSpeed);
  tmpvar_18.x = ((1.0 - (tmpvar_17 / _WaveZ)) + (_WaveRange * sin(
    (tmpvar_19 + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_WaveTex, tmpvar_18);
  waveColor_2 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = sin((tmpvar_19 + (waveTex_3.z * _NoiseRange)));
  waveColor_2.xyz = (waveColor_2.xyz * ((1.0 - 
    ((tmpvar_21 + 1.0) / 2.0)
  ) * waveTex_3.z));
  mediump float tmpvar_22;
  tmpvar_22 = min (_WaveZ, waveTex_3.x);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = ((1.0 - (tmpvar_22 / _WaveZ)) + (_WaveRange * sin(
    ((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_WaveTex, tmpvar_23);
  waveColor2_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = sin(((tmpvar_19 + _WaveDelta) + (waveTex_3.z * _NoiseRange)));
  waveColor2_1.xyz = (waveColor2_1.xyz * ((1.0 - 
    ((tmpvar_25 + 1.0) / 2.0)
  ) * waveTex_3.z));
  outcolor_4.xyz = (outcolor_4.xyz + ((
    (waveColor_2.xyz + waveColor2_1.xyz)
   * 
    (1.0 - waveTex_3.y)
  ) * _WaveColorScale));
  gl_FragData[0] = outcolor_4;
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
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_USE_REFLECTION" }
""
}
}
}
}
}