//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/AirEffect_LightMap_Flag" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_ObjectHeight ("Object Height", Float) = 1
_ObjectMoveScale ("Object MoveScale", Range(0, 1)) = 0.4
_ObjectPivot ("Object MoveScale", Vector) = (0,0,0,0)
_Frequency ("Frequency", Float) = 1
_AmplitudeStrength ("Amplitude Strength", Float) = 1
_InvWaveLength ("Inverse Wave Length", Float) = 1
_Fold ("Fold", Range(0, 2)) = 0.5
_FogTune ("Fog Tune", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 616
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 v_before_1;
  mediump vec4 waveOffset_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  waveOffset_2.yzw = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  v_before_1 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = sin(((_Frequency * _Time.y) + (
    (v_before_1.y + (v_before_1.x * _Fold))
   * _InvWaveLength)));
  waveOffset_2.x = ((_glesColor.x * _AmplitudeStrength) * (tmpvar_7 * _glesMultiTexCoord0.x));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_9;
  tmpvar_9 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_8.x)
   + 
    (tmpvar_8.y + tmpvar_8.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_10;
  highp vec3 pivot_11;
  pivot_11 = _ObjPivot.xyz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt((1.0 - (tmpvar_9 * tmpvar_9)));
  vert_10 = (_glesVertex.xyz - pivot_11);
  highp float tmpvar_13;
  tmpvar_13 = ((-(tmpvar_9) * vert_10.x) + (tmpvar_12 * vert_10.y));
  vert_10.x = ((tmpvar_12 * vert_10.x) + (tmpvar_9 * vert_10.y));
  vert_10.y = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = ((vert_10 + pivot_11) + waveOffset_2.xyz);
  tmpvar_14.w = _glesVertex.w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_16;
  fogTune_16 = _FogTune;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_20))
       * 
        (_FogIntensity * tmpvar_20)
      ) * fogTune_16)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_5;
  colorBlendLightMap_1 = (((tmpvar_4 * _Color).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_3.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = _BloomFactor;
  gl_FragData[0] = outColor_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 v_before_1;
  mediump vec4 waveOffset_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  waveOffset_2.yzw = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  v_before_1 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = sin(((_Frequency * _Time.y) + (
    (v_before_1.y + (v_before_1.x * _Fold))
   * _InvWaveLength)));
  waveOffset_2.x = ((_glesColor.x * _AmplitudeStrength) * (tmpvar_7 * _glesMultiTexCoord0.x));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_9;
  tmpvar_9 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_8.x)
   + 
    (tmpvar_8.y + tmpvar_8.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_10;
  highp vec3 pivot_11;
  pivot_11 = _ObjPivot.xyz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt((1.0 - (tmpvar_9 * tmpvar_9)));
  vert_10 = (_glesVertex.xyz - pivot_11);
  highp float tmpvar_13;
  tmpvar_13 = ((-(tmpvar_9) * vert_10.x) + (tmpvar_12 * vert_10.y));
  vert_10.x = ((tmpvar_12 * vert_10.x) + (tmpvar_9 * vert_10.y));
  vert_10.y = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = ((vert_10 + pivot_11) + waveOffset_2.xyz);
  tmpvar_14.w = _glesVertex.w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_16;
  fogTune_16 = _FogTune;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_20))
       * 
        (_FogIntensity * tmpvar_20)
      ) * fogTune_16)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_5;
  colorBlendLightMap_1 = (((tmpvar_4 * _Color).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_3.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = _BloomFactor;
  gl_FragData[0] = outColor_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 v_before_1;
  mediump vec4 waveOffset_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  waveOffset_2.yzw = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  v_before_1 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = sin(((_Frequency * _Time.y) + (
    (v_before_1.y + (v_before_1.x * _Fold))
   * _InvWaveLength)));
  waveOffset_2.x = ((_glesColor.x * _AmplitudeStrength) * (tmpvar_7 * _glesMultiTexCoord0.x));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_9;
  tmpvar_9 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_8.x)
   + 
    (tmpvar_8.y + tmpvar_8.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_10;
  highp vec3 pivot_11;
  pivot_11 = _ObjPivot.xyz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt((1.0 - (tmpvar_9 * tmpvar_9)));
  vert_10 = (_glesVertex.xyz - pivot_11);
  highp float tmpvar_13;
  tmpvar_13 = ((-(tmpvar_9) * vert_10.x) + (tmpvar_12 * vert_10.y));
  vert_10.x = ((tmpvar_12 * vert_10.x) + (tmpvar_9 * vert_10.y));
  vert_10.y = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = ((vert_10 + pivot_11) + waveOffset_2.xyz);
  tmpvar_14.w = _glesVertex.w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_16;
  fogTune_16 = _FogTune;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_20))
       * 
        (_FogIntensity * tmpvar_20)
      ) * fogTune_16)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_5;
  colorBlendLightMap_1 = (((tmpvar_4 * _Color).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_3.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = _BloomFactor;
  gl_FragData[0] = outColor_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 v_before_1;
  mediump vec4 waveOffset_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  waveOffset_2.yzw = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  v_before_1 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = sin(((_Frequency * _Time.y) + (
    (v_before_1.y + (v_before_1.x * _Fold))
   * _InvWaveLength)));
  waveOffset_2.x = ((_glesColor.x * _AmplitudeStrength) * (tmpvar_7 * _glesMultiTexCoord0.x));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_9;
  tmpvar_9 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_8.x)
   + 
    (tmpvar_8.y + tmpvar_8.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_10;
  highp vec3 pivot_11;
  pivot_11 = _ObjPivot.xyz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt((1.0 - (tmpvar_9 * tmpvar_9)));
  vert_10 = (_glesVertex.xyz - pivot_11);
  highp float tmpvar_13;
  tmpvar_13 = ((-(tmpvar_9) * vert_10.x) + (tmpvar_12 * vert_10.y));
  vert_10.x = ((tmpvar_12 * vert_10.x) + (tmpvar_9 * vert_10.y));
  vert_10.y = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = ((vert_10 + pivot_11) + waveOffset_2.xyz);
  tmpvar_14.w = _glesVertex.w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_16;
  fogTune_16 = _FogTune;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_20))
       * 
        (_FogIntensity * tmpvar_20)
      ) * fogTune_16)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_5;
  colorBlendLightMap_1 = (((tmpvar_4 * _Color).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_3.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = _BloomFactor;
  gl_FragData[0] = outColor_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 v_before_1;
  mediump vec4 waveOffset_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  waveOffset_2.yzw = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  v_before_1 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = sin(((_Frequency * _Time.y) + (
    (v_before_1.y + (v_before_1.x * _Fold))
   * _InvWaveLength)));
  waveOffset_2.x = ((_glesColor.x * _AmplitudeStrength) * (tmpvar_7 * _glesMultiTexCoord0.x));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_9;
  tmpvar_9 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_8.x)
   + 
    (tmpvar_8.y + tmpvar_8.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_10;
  highp vec3 pivot_11;
  pivot_11 = _ObjPivot.xyz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt((1.0 - (tmpvar_9 * tmpvar_9)));
  vert_10 = (_glesVertex.xyz - pivot_11);
  highp float tmpvar_13;
  tmpvar_13 = ((-(tmpvar_9) * vert_10.x) + (tmpvar_12 * vert_10.y));
  vert_10.x = ((tmpvar_12 * vert_10.x) + (tmpvar_9 * vert_10.y));
  vert_10.y = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = ((vert_10 + pivot_11) + waveOffset_2.xyz);
  tmpvar_14.w = _glesVertex.w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_16;
  fogTune_16 = _FogTune;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_20))
       * 
        (_FogIntensity * tmpvar_20)
      ) * fogTune_16)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_5;
  colorBlendLightMap_1 = (((tmpvar_4 * _Color).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_3.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = _BloomFactor;
  gl_FragData[0] = outColor_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 v_before_1;
  mediump vec4 waveOffset_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  waveOffset_2.yzw = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  v_before_1 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = sin(((_Frequency * _Time.y) + (
    (v_before_1.y + (v_before_1.x * _Fold))
   * _InvWaveLength)));
  waveOffset_2.x = ((_glesColor.x * _AmplitudeStrength) * (tmpvar_7 * _glesMultiTexCoord0.x));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_9;
  tmpvar_9 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_8.x)
   + 
    (tmpvar_8.y + tmpvar_8.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_10;
  highp vec3 pivot_11;
  pivot_11 = _ObjPivot.xyz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt((1.0 - (tmpvar_9 * tmpvar_9)));
  vert_10 = (_glesVertex.xyz - pivot_11);
  highp float tmpvar_13;
  tmpvar_13 = ((-(tmpvar_9) * vert_10.x) + (tmpvar_12 * vert_10.y));
  vert_10.x = ((tmpvar_12 * vert_10.x) + (tmpvar_9 * vert_10.y));
  vert_10.y = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = ((vert_10 + pivot_11) + waveOffset_2.xyz);
  tmpvar_14.w = _glesVertex.w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_16;
  fogTune_16 = _FogTune;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_20))
       * 
        (_FogIntensity * tmpvar_20)
      ) * fogTune_16)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_5;
  colorBlendLightMap_1 = (((tmpvar_4 * _Color).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_3.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = _BloomFactor;
  gl_FragData[0] = outColor_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 v_before_1;
  mediump vec4 waveOffset_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  waveOffset_2.yzw = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  v_before_1 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = sin(((_Frequency * _Time.y) + (
    (v_before_1.y + (v_before_1.x * _Fold))
   * _InvWaveLength)));
  waveOffset_2.x = ((_glesColor.x * _AmplitudeStrength) * (tmpvar_7 * _glesMultiTexCoord0.x));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_9;
  tmpvar_9 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_8.x)
   + 
    (tmpvar_8.y + tmpvar_8.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_10;
  highp vec3 pivot_11;
  pivot_11 = _ObjPivot.xyz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt((1.0 - (tmpvar_9 * tmpvar_9)));
  vert_10 = (_glesVertex.xyz - pivot_11);
  highp float tmpvar_13;
  tmpvar_13 = ((-(tmpvar_9) * vert_10.x) + (tmpvar_12 * vert_10.y));
  vert_10.x = ((tmpvar_12 * vert_10.x) + (tmpvar_9 * vert_10.y));
  vert_10.y = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = ((vert_10 + pivot_11) + waveOffset_2.xyz);
  tmpvar_14.w = _glesVertex.w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_16;
  fogTune_16 = _FogTune;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_20))
       * 
        (_FogIntensity * tmpvar_20)
      ) * fogTune_16)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_5;
  colorBlendLightMap_1 = (((tmpvar_4 * _Color).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_3.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = _BloomFactor;
  outColor_3.xyz = mix (outColor_3.xyz, vec3(dot (outColor_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 v_before_1;
  mediump vec4 waveOffset_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  waveOffset_2.yzw = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  v_before_1 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = sin(((_Frequency * _Time.y) + (
    (v_before_1.y + (v_before_1.x * _Fold))
   * _InvWaveLength)));
  waveOffset_2.x = ((_glesColor.x * _AmplitudeStrength) * (tmpvar_7 * _glesMultiTexCoord0.x));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_9;
  tmpvar_9 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_8.x)
   + 
    (tmpvar_8.y + tmpvar_8.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_10;
  highp vec3 pivot_11;
  pivot_11 = _ObjPivot.xyz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt((1.0 - (tmpvar_9 * tmpvar_9)));
  vert_10 = (_glesVertex.xyz - pivot_11);
  highp float tmpvar_13;
  tmpvar_13 = ((-(tmpvar_9) * vert_10.x) + (tmpvar_12 * vert_10.y));
  vert_10.x = ((tmpvar_12 * vert_10.x) + (tmpvar_9 * vert_10.y));
  vert_10.y = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = ((vert_10 + pivot_11) + waveOffset_2.xyz);
  tmpvar_14.w = _glesVertex.w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_16;
  fogTune_16 = _FogTune;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_20))
       * 
        (_FogIntensity * tmpvar_20)
      ) * fogTune_16)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_5;
  colorBlendLightMap_1 = (((tmpvar_4 * _Color).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_3.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = _BloomFactor;
  outColor_3.xyz = mix (outColor_3.xyz, vec3(dot (outColor_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 v_before_1;
  mediump vec4 waveOffset_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  waveOffset_2.yzw = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  v_before_1 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = sin(((_Frequency * _Time.y) + (
    (v_before_1.y + (v_before_1.x * _Fold))
   * _InvWaveLength)));
  waveOffset_2.x = ((_glesColor.x * _AmplitudeStrength) * (tmpvar_7 * _glesMultiTexCoord0.x));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_9;
  tmpvar_9 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_8.x)
   + 
    (tmpvar_8.y + tmpvar_8.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_10;
  highp vec3 pivot_11;
  pivot_11 = _ObjPivot.xyz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt((1.0 - (tmpvar_9 * tmpvar_9)));
  vert_10 = (_glesVertex.xyz - pivot_11);
  highp float tmpvar_13;
  tmpvar_13 = ((-(tmpvar_9) * vert_10.x) + (tmpvar_12 * vert_10.y));
  vert_10.x = ((tmpvar_12 * vert_10.x) + (tmpvar_9 * vert_10.y));
  vert_10.y = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = ((vert_10 + pivot_11) + waveOffset_2.xyz);
  tmpvar_14.w = _glesVertex.w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_16;
  fogTune_16 = _FogTune;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_20))
       * 
        (_FogIntensity * tmpvar_20)
      ) * fogTune_16)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_5;
  colorBlendLightMap_1 = (((tmpvar_4 * _Color).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_3.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = _BloomFactor;
  outColor_3.xyz = mix (outColor_3.xyz, vec3(dot (outColor_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 v_before_1;
  mediump vec4 waveOffset_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  waveOffset_2.yzw = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  v_before_1 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = sin(((_Frequency * _Time.y) + (
    (v_before_1.y + (v_before_1.x * _Fold))
   * _InvWaveLength)));
  waveOffset_2.x = ((_glesColor.x * _AmplitudeStrength) * (tmpvar_7 * _glesMultiTexCoord0.x));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_9;
  tmpvar_9 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_8.x)
   + 
    (tmpvar_8.y + tmpvar_8.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_10;
  highp vec3 pivot_11;
  pivot_11 = _ObjPivot.xyz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt((1.0 - (tmpvar_9 * tmpvar_9)));
  vert_10 = (_glesVertex.xyz - pivot_11);
  highp float tmpvar_13;
  tmpvar_13 = ((-(tmpvar_9) * vert_10.x) + (tmpvar_12 * vert_10.y));
  vert_10.x = ((tmpvar_12 * vert_10.x) + (tmpvar_9 * vert_10.y));
  vert_10.y = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = ((vert_10 + pivot_11) + waveOffset_2.xyz);
  tmpvar_14.w = _glesVertex.w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_16;
  fogTune_16 = _FogTune;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_20))
       * 
        (_FogIntensity * tmpvar_20)
      ) * fogTune_16)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_5;
  colorBlendLightMap_1 = (((tmpvar_4 * _Color).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_3.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = _BloomFactor;
  outColor_3.xyz = mix (outColor_3.xyz, vec3(dot (outColor_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 v_before_1;
  mediump vec4 waveOffset_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  waveOffset_2.yzw = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  v_before_1 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = sin(((_Frequency * _Time.y) + (
    (v_before_1.y + (v_before_1.x * _Fold))
   * _InvWaveLength)));
  waveOffset_2.x = ((_glesColor.x * _AmplitudeStrength) * (tmpvar_7 * _glesMultiTexCoord0.x));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_9;
  tmpvar_9 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_8.x)
   + 
    (tmpvar_8.y + tmpvar_8.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_10;
  highp vec3 pivot_11;
  pivot_11 = _ObjPivot.xyz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt((1.0 - (tmpvar_9 * tmpvar_9)));
  vert_10 = (_glesVertex.xyz - pivot_11);
  highp float tmpvar_13;
  tmpvar_13 = ((-(tmpvar_9) * vert_10.x) + (tmpvar_12 * vert_10.y));
  vert_10.x = ((tmpvar_12 * vert_10.x) + (tmpvar_9 * vert_10.y));
  vert_10.y = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = ((vert_10 + pivot_11) + waveOffset_2.xyz);
  tmpvar_14.w = _glesVertex.w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_16;
  fogTune_16 = _FogTune;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_20))
       * 
        (_FogIntensity * tmpvar_20)
      ) * fogTune_16)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_5;
  colorBlendLightMap_1 = (((tmpvar_4 * _Color).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_3.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = _BloomFactor;
  outColor_3.xyz = mix (outColor_3.xyz, vec3(dot (outColor_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _Frequency;
uniform highp float _AmplitudeStrength;
uniform highp float _InvWaveLength;
uniform highp float _Fold;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 v_before_1;
  mediump vec4 waveOffset_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  waveOffset_2.yzw = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  v_before_1 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = sin(((_Frequency * _Time.y) + (
    (v_before_1.y + (v_before_1.x * _Fold))
   * _InvWaveLength)));
  waveOffset_2.x = ((_glesColor.x * _AmplitudeStrength) * (tmpvar_7 * _glesMultiTexCoord0.x));
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_9;
  tmpvar_9 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_8.x)
   + 
    (tmpvar_8.y + tmpvar_8.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_10;
  highp vec3 pivot_11;
  pivot_11 = _ObjPivot.xyz;
  highp float tmpvar_12;
  tmpvar_12 = sqrt((1.0 - (tmpvar_9 * tmpvar_9)));
  vert_10 = (_glesVertex.xyz - pivot_11);
  highp float tmpvar_13;
  tmpvar_13 = ((-(tmpvar_9) * vert_10.x) + (tmpvar_12 * vert_10.y));
  vert_10.x = ((tmpvar_12 * vert_10.x) + (tmpvar_9 * vert_10.y));
  vert_10.y = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = ((vert_10 + pivot_11) + waveOffset_2.xyz);
  tmpvar_14.w = _glesVertex.w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_15));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_16;
  fogTune_16 = _FogTune;
  mediump vec4 tmpvar_17;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    tmpvar_21 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_20))
       * 
        (_FogIntensity * tmpvar_20)
      ) * fogTune_16)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_22;
    tmpvar_22 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_20)) * (_FogColorIntensity * tmpvar_20))
    ), 0.0, 1.0)));
    fogColor_18.xyz = tmpvar_22;
    fogColor_18.w = tmpvar_21;
    tmpvar_17 = fogColor_18;
  } else {
    mediump vec4 fogColor_23;
    highp vec3 tmpvar_24;
    tmpvar_24 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, (sqrt(
      dot (tmpvar_24, tmpvar_24)
    ) - _FogStartDistance));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_16)), _FogEffectLimit);
    highp vec3 tmpvar_27;
    tmpvar_27 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, ((_FogEndDistance * fogTune_16) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_27;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = tmpvar_17;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 outColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_5;
  colorBlendLightMap_1 = (((tmpvar_4 * _Color).xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_3.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = _BloomFactor;
  outColor_3.xyz = mix (outColor_3.xyz, vec3(dot (outColor_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_3;
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
Fallback "Diffuse"
}